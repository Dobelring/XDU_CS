import ply.lex as lex
import ply.yacc as yacc
import os
import shutil
import itertools  # 用于生成多表联查的笛卡尔积


CURRENT_DB = None


# 词法分析器 (Lex)

reserved = {
    'create': 'CREATE', 'table': 'TABLE', 'int': 'INT', 'char': 'CHAR',
    'insert': 'INSERT', 'into': 'INTO', 'values': 'VALUES',
    'select': 'SELECT', 'from': 'FROM', 'where': 'WHERE',
    'update': 'UPDATE', 'set': 'SET',
    'delete': 'DELETE',
    'database': 'DATABASE', 'databases': 'DATABASES',
    'use': 'USE', 'show': 'SHOW',
    'tables': 'TABLES', 'drop': 'DROP', 'exit': 'EXIT',
    'and': 'AND', 'or': 'OR'
}

tokens = [
             'ID', 'NUMBER', 'STRING',
             'LPAREN', 'RPAREN', 'COMMA', 'SEMI',
             'STAR', 'EQ', 'GT', 'LT', 'NEQ'
         ] + list(reserved.values())

t_LPAREN = r'\('
t_RPAREN = r'\)'
t_COMMA = r','
t_SEMI = r';'
t_STAR = r'\*'
t_EQ = r'='
t_GT = r'>'
t_LT = r'<'
t_NEQ = r'!=|<>'
t_ignore = ' \t\n'


def t_ID(t):
    r"""[A-Za-z_][A-Za-z0-9_]*"""
    t.type = reserved.get(t.value.lower(), 'ID')
    return t


def t_NUMBER(t):
    r"""\d+"""
    t.value = int(t.value)
    return t


def t_STRING(t):
    r"""'[^']*'"""
    t.value = t.value[1:-1]
    return t


def t_error(t):
    print(f"词法错误: 无法识别的字符 '{t.value[0]}'")
    t.lexer.skip(1)


lexer = lex.lex()



# 物理文件操作


def get_sys_dat_path():
    if not CURRENT_DB: return None
    return os.path.join(CURRENT_DB, 'sys.dat')


def get_table_path(table_name):
    if not CURRENT_DB: return None
    return os.path.join(CURRENT_DB, f"{table_name}.txt")


def get_schema(table_name):
    schema = []
    sys_path = get_sys_dat_path()
    if not sys_path or not os.path.exists(sys_path): return schema
    with open(sys_path, 'r', encoding='utf-8') as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) >= 5 and parts[0].lower() == table_name.lower():
                schema.append({'index': int(parts[1]) - 1, 'name': parts[2]})
    return schema


def check_condition(row, schema, condition):
    if not condition: return True
    if condition['type'] == 'logic':
        left_res = check_condition(row, schema, condition['left'])
        right_res = check_condition(row, schema, condition['right'])
        if condition['op'] == 'AND':
            return left_res and right_res
        elif condition['op'] == 'OR':
            return left_res or right_res
    elif condition['type'] == 'cmp':
        cond_col, cond_op, cond_val = condition['col'], condition['op'], str(condition['val'])
        # 在联合 Schema 中找到对应的列索引
        cond_idx = next((col['index'] for col in schema if col['name'].lower() == cond_col.lower()), -1)
        if cond_idx != -1 and cond_idx < len(row):
            row_val = row[cond_idx]
            try:
                if cond_op == 'EQ': return row_val == cond_val
                if cond_op == 'NEQ': return row_val != cond_val
                if cond_op == 'GT': return int(row_val) > int(cond_val)
                if cond_op == 'LT': return int(row_val) < int(cond_val)
            except ValueError:
                return False
        return False
    return False


# DDL 操作

def execute_create_database(ast):
    db_name = ast['db_name']
    if os.path.exists(db_name):
        print(f"[报错] 数据库 '{db_name}' 已存在！")
        return
    os.makedirs(db_name)
    with open('sys.dat', 'a', encoding='utf-8') as f: f.write(f"{db_name}\n")
    with open(os.path.join(db_name, 'sys.dat'), 'w', encoding='utf-8') as f: pass
    print(f"[执行成功] 数据库 '{db_name}' 创建完毕！")


def execute_show_databases(ast):
    print("-" * 30);
    print("Databases");
    print("-" * 30)
    count = 0
    if os.path.exists('sys.dat'):
        with open('sys.dat', 'r', encoding='utf-8') as f:
            for line in f:
                db = line.strip()
                if db and os.path.isdir(db): print(db); count += 1
    if count == 0: print("(No databases found)")
    print("-" * 30)


def execute_use_database(ast):
    global CURRENT_DB
    db_name = ast['db_name']
    if not os.path.exists(db_name) or not os.path.isdir(db_name):
        print(f"[报错] 数据库 '{db_name}' 不存在！")
        return
    CURRENT_DB = db_name
    print(f"[执行成功] 当前数据库已切换至 '{db_name}'。")


def execute_show_tables(ast):
    if not CURRENT_DB: return
    sys_path = get_sys_dat_path()
    tables = set()
    if os.path.exists(sys_path):
        with open(sys_path, 'r', encoding='utf-8') as f:
            for line in f:
                parts = line.strip().split()
                if parts: tables.add(parts[0])
    print("-" * 30);
    print(f"Tables in {CURRENT_DB}");
    print("-" * 30)
    if not tables:
        print("(Empty)")
    else:
        for t in tables: print(t)
    print("-" * 30)


def execute_drop_database(ast):
    global CURRENT_DB
    db_name = ast['db_name']
    if not os.path.exists(db_name): return
    if CURRENT_DB == db_name: CURRENT_DB = None
    shutil.rmtree(db_name)
    if os.path.exists('sys.dat'):
        with open('sys.dat', 'r', encoding='utf-8') as f:
            lines = f.readlines()
        with open('sys.dat', 'w', encoding='utf-8') as f:
            for line in lines:
                if line.strip() != db_name: f.write(line)
    print(f"[执行成功] 数据库 '{db_name}' 已删除。")


def execute_create_table(ast):
    if not CURRENT_DB:
        print("[报错] 请先使用 USE <database_name>; 选择一个数据库！")
        return

    table_name, fields = ast['table_name'], ast['fields']

    # 【重点在这里】：建表前先去查字典 (sys.dat)
    if get_schema(table_name):
        print(f"[报错] 表 '{table_name}' 已经存在！")
        return

    # 如果不存在，才继续往下执行建表写入文件的操作
    with open(get_sys_dat_path(), 'a', encoding='utf-8') as f:
        for i, field in enumerate(fields, 1):
            f.write(f"{table_name} {i} {field['name']} {field['type']} {field['length']}\n")
    with open(get_table_path(table_name), 'w', encoding='utf-8') as f:
        pass
    print(f"[执行成功] 表 '{table_name}' 创建完毕！")


def execute_drop_table(ast):
    if not CURRENT_DB: return
    table_name = ast['table_name']
    data_path = get_table_path(table_name)
    sys_path = get_sys_dat_path()
    if os.path.exists(data_path): os.remove(data_path)
    if os.path.exists(sys_path):
        with open(sys_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        with open(sys_path, 'w', encoding='utf-8') as f:
            for line in lines:
                if not line.strip().lower().startswith(table_name.lower() + " "): f.write(line)
    print(f"[执行成功] 表 '{table_name}' 已删除。")


# DML 操作

def execute_insert(ast):
    if not CURRENT_DB: return
    table_name, values, insert_fields = ast['table_name'], ast['values'], ast.get('insert_fields')
    schema = get_schema(table_name)
    filename = get_table_path(table_name)
    if not schema or not os.path.exists(filename): return

    row_data_list = ["NULL"] * len(schema)
    if insert_fields:
        for field, val in zip(insert_fields, values):
            idx = next((col['index'] for col in schema if col['name'].lower() == field.lower()), -1)
            if idx != -1: row_data_list[idx] = str(val)
    else:
        for i, val in enumerate(values): row_data_list[i] = str(val)

    row_data_str = " ".join(row_data_list)
    with open(filename, 'a', encoding='utf-8') as f:
        f.write(row_data_str + "\n")
    print(f"[执行成功] 插入记录 -> {row_data_str}")


# 多表联查与笛卡尔积
def execute_select(ast):
    if not CURRENT_DB: return
    tables = ast['tables']

    combined_schema = []
    table_data = []

    # 组合 Schema 并加载所有表的数据
    offset = 0
    for t_name in tables:
        schema = get_schema(t_name)
        filename = get_table_path(t_name)
        if not schema or not os.path.exists(filename):
            print(f"[报错] 表 '{t_name}' 不存在！")
            return

        # 将字段索引重映射
        for col in schema:
            combined_schema.append({
                'index': offset + col['index'],
                'name': col['name'],
                'table': t_name
            })
        offset += len(schema)

        # 加载这块表的所有行
        rows = []
        with open(filename, 'r', encoding='utf-8') as f:
            for line in f:
                row = line.strip().split()
                if row: rows.append(row)
        table_data.append(rows)

    # 笛卡尔积
    cartesian_rows = []
    for combo in itertools.product(*table_data):
        combined_row = []
        for r in combo: combined_row.extend(r)
        cartesian_rows.append(combined_row)

    # 确定需要打印的列
    selected_fields = ast['fields']
    if selected_fields == '*':
        col_indices = [col['index'] for col in combined_schema]
        # 为了区分同名字段，给多表打印加上表名前缀
        if len(tables) > 1:
            col_names = [f"{col['table'][:3]}.{col['name']}" for col in combined_schema]
        else:
            col_names = [col['name'] for col in combined_schema]
    else:
        col_indices, col_names = [], []
        for sf in selected_fields:
            for col in combined_schema:
                if col['name'].lower() == sf.lower():
                    col_indices.append(col['index'])
                    col_names.append(col['name'])
                    break  # 找到第一个匹配列名即跳出

    # 打印表头
    print("-" * 15 * len(col_names))
    print(" | ".join(f"{name:<12}" for name in col_names))
    print("-" * 15 * len(col_names))

    # 过滤并输出
    count = 0
    for row in cartesian_rows:
        if check_condition(row, combined_schema, ast.get('where')):
            print(" | ".join(f"{row[i] if i < len(row) else 'NULL':<12}" for i in col_indices))
            count += 1

    print("-" * 15 * len(col_names))
    print(f"共查询到 {count} 条记录。")


# 多字段更新
def execute_update(ast):
    if not CURRENT_DB: return
    table_name = ast['table_name']
    schema = get_schema(table_name)
    filename = get_table_path(table_name)
    if not schema or not os.path.exists(filename): return

    # 解析出所有要更新的列索引和新值
    set_list = ast['set_list']
    updates = []
    for item in set_list:
        idx = next((col['index'] for col in schema if col['name'].lower() == item['col'].lower()), -1)
        if idx != -1:
            updates.append((idx, str(item['val'])))
        else:
            print(f"[报错] 找不到列 '{item['col']}'")
            return

    lines = []
    update_count = 0
    with open(filename, 'r', encoding='utf-8') as f:
        for line in f:
            row = line.strip().split()
            if not row: continue
            if check_condition(row, schema, ast['where']):
                for idx, val in updates:
                    row[idx] = val  # 批量更新
                update_count += 1
            lines.append(" ".join(row))

    with open(filename, 'w', encoding='utf-8') as f:
        if lines: f.write("\n".join(lines) + "\n")
    print(f"[执行成功] UPDATE 影响了 {update_count} 行记录。")


def execute_delete(ast):
    if not CURRENT_DB: return
    table_name, schema, filename = ast['table_name'], get_schema(ast['table_name']), get_table_path(ast['table_name'])
    if not schema or not os.path.exists(filename): return
    lines = []
    delete_count = 0
    with open(filename, 'r', encoding='utf-8') as f:
        for line in f:
            row = line.strip().split()
            if not row: continue
            if check_condition(row, schema, ast['where']):
                delete_count += 1;
                continue
            lines.append(" ".join(row))
    with open(filename, 'w', encoding='utf-8') as f:
        if lines: f.write("\n".join(lines) + "\n")
    print(f"[执行成功] DELETE 删除了 {delete_count} 行记录。")


def execute_exit(ast):
    print("收到 EXIT 命令，正在安全退出 system...")
    os._exit(0)



# 语法分析器 (Yacc)


precedence = (
    ('left', 'OR'),
    ('left', 'AND'),
)


def p_statements(p):
    """statements : statement
                  | statements statement"""
    pass


def p_statement(p):
    """statement : createsql
                 | insertsql
                 | selectsql
                 | updatesql
                 | deletesql
                 | createdbsql
                 | showdatabasessql
                 | usedbsql
                 | showtablessql
                 | droptablesql
                 | dropdbsql
                 | exitsql"""
    pass


def p_createdbsql(p):
    """createdbsql : CREATE DATABASE ID SEMI"""
    execute_create_database({'db_name': p[3]})


def p_showdatabasessql(p):
    """showdatabasessql : SHOW DATABASES SEMI"""
    execute_show_databases({})


def p_usedbsql(p):
    """usedbsql : USE ID SEMI"""
    execute_use_database({'db_name': p[2]})


def p_showtablessql(p):
    """showtablessql : SHOW TABLES SEMI"""
    execute_show_tables({})


def p_droptablesql(p):
    """droptablesql : DROP TABLE ID SEMI"""
    execute_drop_table({'table_name': p[3]})


def p_dropdbsql(p):
    """dropdbsql : DROP DATABASE ID SEMI"""
    execute_drop_database({'db_name': p[3]})


def p_exitsql(p):
    """exitsql : EXIT SEMI"""
    execute_exit({})


def p_createsql(p):
    """createsql : CREATE TABLE ID LPAREN fieldsdefinition RPAREN SEMI"""
    execute_create_table({'table_name': p[3], 'fields': p[5]})


def p_fieldsdefinition_single(p):
    """fieldsdefinition : field_type"""
    p[0] = [p[1]]


def p_fieldsdefinition_list(p):
    """fieldsdefinition : fieldsdefinition COMMA field_type"""
    p[1].append(p[3]);
    p[0] = p[1]


def p_field_type_char(p):
    """field_type : ID CHAR LPAREN NUMBER RPAREN"""
    p[0] = {'name': p[1], 'type': 'char', 'length': p[4]}


def p_field_type_int(p):
    """field_type : ID INT"""
    p[0] = {'name': p[1], 'type': 'int', 'length': 4}


def p_insertsql_with_fields(p):
    """insertsql : INSERT INTO ID LPAREN fields_list RPAREN VALUES LPAREN values_list RPAREN SEMI"""
    execute_insert({'table_name': p[3], 'insert_fields': p[5], 'values': p[9]})


def p_insertsql_without_fields(p):
    """insertsql : INSERT INTO ID VALUES LPAREN values_list RPAREN SEMI"""
    execute_insert({'table_name': p[3], 'insert_fields': None, 'values': p[6]})


def p_values_list_single(p):
    """values_list : value"""
    p[0] = [p[1]]


def p_values_list_multi(p):
    """values_list : values_list COMMA value"""
    p[1].append(p[3]);
    p[0] = p[1]


def p_value(p):
    """value : NUMBER
             | STRING"""
    p[0] = p[1]


# 从 tables_list 解析多表
def p_selectsql_simple(p):
    """selectsql : SELECT select_fields FROM tables_list SEMI"""
    execute_select({'fields': p[2], 'tables': p[4], 'where': None})


def p_selectsql_where(p):
    """selectsql : SELECT select_fields FROM tables_list WHERE condition SEMI"""
    execute_select({'fields': p[2], 'tables': p[4], 'where': p[6]})


def p_select_fields_star(p):
    """select_fields : STAR"""
    p[0] = '*'


def p_select_fields_list(p):
    """select_fields : fields_list"""
    p[0] = p[1]


# 多表列表解析
def p_tables_list_single(p):
    """tables_list : ID"""
    p[0] = [p[1]]


def p_tables_list_multi(p):
    """tables_list : tables_list COMMA ID"""
    p[1].append(p[3]);
    p[0] = p[1]


def p_fields_list_single(p):
    """fields_list : ID"""
    p[0] = [p[1]]


def p_fields_list_multi(p):
    """fields_list : fields_list COMMA ID"""
    p[1].append(p[3]);
    p[0] = p[1]


def p_condition_logic(p):
    """condition : condition AND condition
                 | condition OR condition"""
    p[0] = {'type': 'logic', 'op': p[2].upper(), 'left': p[1], 'right': p[3]}


def p_condition_group(p):
    """condition : LPAREN condition RPAREN"""
    p[0] = p[2]


def p_condition_cmp(p):
    """condition : ID op value"""
    p[0] = {'type': 'cmp', 'col': p[1], 'op': p[2], 'val': p[3]}


def p_op(p):
    """op : EQ
          | GT
          | LT
          | NEQ"""
    if p[1] == '=':
        p[0] = 'EQ'
    elif p[1] == '>':
        p[0] = 'GT'
    elif p[1] == '<':
        p[0] = 'LT'
    elif p[1] in ('!=', '<>'):
        p[0] = 'NEQ'


# 多字段更新
def p_updatesql(p):
    """updatesql : UPDATE ID SET set_list WHERE condition SEMI"""
    execute_update({'table_name': p[2], 'set_list': p[4], 'where': p[6]})


def p_set_list_single(p):
    """set_list : set_item"""
    p[0] = [p[1]]


def p_set_list_multi(p):
    """set_list : set_list COMMA set_item"""
    p[1].append(p[3]);
    p[0] = p[1]


def p_set_item(p):
    """set_item : ID EQ value"""
    p[0] = {'col': p[1], 'val': p[3]}


def p_deletesql(p):
    """deletesql : DELETE FROM ID WHERE condition SEMI"""
    execute_delete({'table_name': p[3], 'where': p[5]})


def p_error(p):
    if p:
        print(f"语法错误: 在 '{p.value}' 附近")
    else:
        print("语法错误: 语句不完整或格式有误")


parser = yacc.yacc()


# 主程序测试 (REPL 交互式命令行)


if __name__ == '__main__':
    print("==========================================")
    print("   DBMS 系统   ")
    print("==========================================")
    while True:
        try:
            prompt = f"SQL [{CURRENT_DB}]> " if CURRENT_DB else "SQL> "
            user_input = input(prompt)
            if not user_input.strip(): continue
            statement = user_input
            while not statement.strip().endswith(';'):
                statement += " " + input("  -> ")
            parser.parse(statement)
        except KeyboardInterrupt:
            print("\n请使用 'EXIT;' 退出。")
        except Exception as e:
            print(f"[系统异常] 执行时发生错误: {e}")