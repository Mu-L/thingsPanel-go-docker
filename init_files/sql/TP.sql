-- public.business definition

-- Drop table

-- DROP TABLE business;

CREATE TABLE business (
	id varchar(36) NOT NULL,
	"name" varchar(255) NULL,
	created_at int8 NULL,
	app_type varchar(255) NOT NULL DEFAULT ''::character varying, -- 应用类型
	app_id varchar(255) NOT NULL DEFAULT ''::character varying, -- app id
	app_secret varchar(255) NOT NULL DEFAULT ''::character varying, -- 密钥
	CONSTRAINT business_pkey PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.business.app_type IS '应用类型';
COMMENT ON COLUMN public.business.app_id IS 'app id';
COMMENT ON COLUMN public.business.app_secret IS '密钥';


-- public.casbin_rule definition

-- Drop table

-- DROP TABLE casbin_rule;

CREATE TABLE casbin_rule (
	id bigserial NOT NULL,
	ptype varchar(100) NULL,
	v0 varchar(100) NULL,
	v1 varchar(100) NULL,
	v2 varchar(100) NULL,
	v3 varchar(100) NULL,
	v4 varchar(100) NULL,
	v5 varchar(100) NULL,
	v6 varchar(25) NULL,
	v7 varchar(25) NULL,
	CONSTRAINT casbin_rule_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX idx_casbin_rule ON public.casbin_rule USING btree (ptype, v0, v1, v2, v3, v4, v5, v6, v7);


-- public.conditions_log definition

-- Drop table

-- DROP TABLE conditions_log;

CREATE TABLE conditions_log (
	id varchar(36) NOT NULL,
	device_id varchar(36) NOT NULL,
	operation_type varchar(2) NULL, -- 操作类型1-定时触发 2-手动控制
	instruct varchar(255) NULL, -- 指令
	sender varchar(99) NULL, -- 发送者
	send_result varchar(2) NULL, -- 发送结果1-成功 2-失败
	respond varchar(255) NULL, -- 设备反馈
	cteate_time varchar(50) NULL,
	remark varchar(255) NULL,
	protocol_type varchar(50) NULL, -- mqtt,tcp
	CONSTRAINT conditions_log_pk PRIMARY KEY (id)
);
CREATE INDEX conditions_log_cteate_time_idx_desc ON public.conditions_log USING btree (cteate_time DESC);

-- Column comments

COMMENT ON COLUMN public.conditions_log.operation_type IS '操作类型1-定时触发 2-手动控制';
COMMENT ON COLUMN public.conditions_log.instruct IS '指令';
COMMENT ON COLUMN public.conditions_log.sender IS '发送者';
COMMENT ON COLUMN public.conditions_log.send_result IS '发送结果1-成功 2-失败';
COMMENT ON COLUMN public.conditions_log.respond IS '设备反馈';
COMMENT ON COLUMN public.conditions_log.protocol_type IS 'mqtt,tcp';


-- public.customers definition

-- Drop table

-- DROP TABLE customers;

CREATE TABLE customers (
	id varchar(36) NOT NULL,
	additional_info varchar NULL,
	address varchar NULL,
	address2 varchar NULL,
	city varchar(255) NULL DEFAULT ''::character varying,
	country varchar(255) NULL DEFAULT ''::character varying,
	email varchar(255) NULL DEFAULT ''::character varying,
	phone varchar(255) NULL DEFAULT ''::character varying,
	search_text varchar(255) NULL DEFAULT ''::character varying,
	state varchar(255) NULL DEFAULT ''::character varying,
	title varchar(255) NULL DEFAULT ''::character varying,
	zip varchar(255) NULL DEFAULT ''::character varying,
	CONSTRAINT customer_pkey PRIMARY KEY (id)
);


-- public.data_transpond definition

-- Drop table

-- DROP TABLE data_transpond;

CREATE TABLE data_transpond (
	id varchar(36) NOT NULL,
	process_id varchar(36) NULL, -- 流程id
	process_type varchar(36) NULL, -- 流程类型
	"label" varchar(255) NULL, -- 标签
	disabled varchar(10) NULL, -- 状态
	info varchar(255) NULL,
	env varchar(999) NULL,
	customer_id varchar(36) NULL,
	created_at int8 NULL,
	role_type varchar(2) NULL,
	CONSTRAINT data_transpond_pk PRIMARY KEY (id)
);



-- Column comments

COMMENT ON COLUMN public.data_transpond.process_id IS '流程id';
COMMENT ON COLUMN public.data_transpond.process_type IS '流程类型';
COMMENT ON COLUMN public.data_transpond."label" IS '标签';
COMMENT ON COLUMN public.data_transpond.disabled IS '状态';
COMMENT ON COLUMN public.data_transpond.role_type IS '1-接入引擎 2-数据转发';


-- public.logo definition

-- Drop table

-- DROP TABLE logo;

CREATE TABLE logo (
	id varchar(36) NOT NULL,
	system_name varchar(255) NULL, -- 系统名称
	theme varchar(99) NULL, -- 主题
	logo_one varchar(255) NULL, -- 首页logo
	logo_two varchar(255) NULL, -- 缓冲logo
	logo_three varchar(255) NULL,
	custom_id varchar(99) NULL,
	remark varchar(255) NULL,
	CONSTRAINT logo_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.logo.system_name IS '系统名称';
COMMENT ON COLUMN public.logo.theme IS '主题';
COMMENT ON COLUMN public.logo.logo_one IS '首页logo';
COMMENT ON COLUMN public.logo.logo_two IS '缓冲logo';


-- public.migrations definition

-- Drop table

-- DROP TABLE migrations;

CREATE TABLE migrations (
	id serial4 NOT NULL,
	migration varchar(255) NOT NULL,
	batch int4 NOT NULL,
	CONSTRAINT migrations_pkey PRIMARY KEY (id)
);


-- public.navigation definition

-- Drop table

-- DROP TABLE navigation;

CREATE TABLE navigation (
	id varchar(36) NOT NULL,
	"type" int4 NULL, -- 1:业务  2：自动化-控制策略 3：自动化-告警策略  4：可视化
	"name" varchar(255) NULL,
	"data" varchar(255) NULL,
	count int4 NULL DEFAULT 1, -- 数量
	CONSTRAINT navigation_pkey PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.navigation."type" IS '1:业务  2：自动化-控制策略 3：自动化-告警策略  4：可视化';
COMMENT ON COLUMN public.navigation.count IS '数量';


-- public.operation_log definition

-- Drop table

-- DROP TABLE operation_log;

CREATE TABLE operation_log (
	id varchar(36) NOT NULL,
	"type" varchar(36) NULL,
	"describe" varchar(10000000) NULL,
	data_id varchar(36) NULL,
	created_at int8 NULL,
	detailed json NULL,
	CONSTRAINT operation_log_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE public.operation_log IS '操作日志';


-- public.password_resets definition

-- Drop table

-- DROP TABLE password_resets;

CREATE TABLE password_resets (
	email varchar(255) NOT NULL,
	"token" varchar(255) NOT NULL,
	created_at timestamp(0) NULL
);


-- public.production definition

-- Drop table

-- DROP TABLE production;

CREATE TABLE production (
	id varchar(36) NOT NULL,
	"type" int4 NULL, -- 种植｜用药｜收获
	"name" varchar(255) NULL, -- 字段名
	value varchar(255) NULL, -- 值
	created_at int8 NULL,
	remark varchar(255) NULL, -- 备注
	insert_at int8 NULL,
	CONSTRAINT production_pkey PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.production."type" IS '种植｜用药｜收获';
COMMENT ON COLUMN public.production."name" IS '字段名';
COMMENT ON COLUMN public.production.value IS '值';
COMMENT ON COLUMN public.production.remark IS '备注';


-- public.resources definition

-- Drop table

-- DROP TABLE resources;

CREATE TABLE resources (
	id varchar(36) NOT NULL,
	cpu varchar(36) NULL,
	mem varchar(36) NULL,
	created_at varchar(36) NULL,
	CONSTRAINT "Resources_pkey" PRIMARY KEY (id)
);
CREATE INDEX resources_created_at_idx ON public.resources USING btree (created_at DESC);


-- public.tp_function definition

-- Drop table

-- DROP TABLE tp_function;

CREATE TABLE tp_function (
	id varchar(36) NOT NULL,
	function_name varchar(99) NOT NULL,
	menu_id varchar(36) NULL,
	CONSTRAINT tp_function_un UNIQUE (function_name)
);


-- public.tp_menu definition

-- Drop table

-- DROP TABLE tp_menu;

CREATE TABLE tp_menu (
	id varchar(36) NOT NULL,
	menu_name varchar(99) NOT NULL,
	parent_id varchar(36) NOT NULL DEFAULT 0,
	remark varchar(255) NULL,
	CONSTRAINT tp_menu_pk PRIMARY KEY (id)
);


-- public.tp_role definition

-- Drop table

-- DROP TABLE tp_role;

CREATE TABLE tp_role (
	id varchar(36) NOT NULL,
	role_name varchar(99) NOT NULL,
	parent_id varchar(36) NULL DEFAULT 0,
	role_describe varchar(255) NULL,
	CONSTRAINT tp_role_pk PRIMARY KEY (id),
	CONSTRAINT tp_role_un UNIQUE (role_name)
);


-- public.tp_role_menu definition

-- Drop table

-- DROP TABLE tp_role_menu;

CREATE TABLE tp_role_menu (
	role_id varchar(36) NOT NULL,
	menu_id varchar(30) NOT NULL,
	CONSTRAINT tp_role_menu_pk PRIMARY KEY (role_id, menu_id)
);


-- public.ts_kv definition

-- Drop table

-- DROP TABLE ts_kv;

CREATE TABLE ts_kv (
	entity_type varchar(255) NOT NULL,
	entity_id varchar(36) NOT NULL,
	"key" varchar(255) NOT NULL,
	ts int8 NOT NULL,
	bool_v varchar(5) NULL,
	str_v text NULL,
	long_v int8 NULL,
	dbl_v float8 NULL,
	CONSTRAINT ts_kv_pkey PRIMARY KEY (entity_type, entity_id, key, ts)
);
CREATE INDEX ts_kv_ts_idx ON public.ts_kv USING btree (ts);
COMMENT ON TABLE public.ts_kv IS '数据管理表';


-- public.ts_kv_latest definition

-- Drop table

-- DROP TABLE ts_kv_latest;

CREATE TABLE ts_kv_latest (
	entity_type varchar(255) NOT NULL,
	entity_id varchar(36) NOT NULL,
	"key" varchar(255) NOT NULL,
	ts int8 NOT NULL,
	bool_v varchar(5) NULL,
	str_v varchar(10000000) NULL,
	long_v int8 NULL,
	dbl_v float8 NULL,
	CONSTRAINT ts_kv_latest_pkey PRIMARY KEY (entity_type, entity_id, key)
);
CREATE UNIQUE INDEX "INDEX_KEY" ON public.ts_kv_latest USING btree (entity_type, entity_id, key);
COMMENT ON TABLE public.ts_kv_latest IS '最新数据';


-- public.ts_kv_test definition

-- Drop table

-- DROP TABLE ts_kv_test;

CREATE TABLE ts_kv_test (
	entity_type varchar(255) NOT NULL,
	entity_id varchar(36) NOT NULL,
	"key" varchar(255) NOT NULL,
	ts int8 NOT NULL,
	bool_v varchar(5) NULL,
	str_v text NULL,
	long_v int8 NULL,
	dbl_v float8 NULL,
	CONSTRAINT ts_kv_pkey2 PRIMARY KEY (entity_type, entity_id, key, ts)
);


-- public.users definition

-- Drop table

-- DROP TABLE users;

CREATE TABLE users (
	id varchar(36) NOT NULL,
	created_at int8 NOT NULL DEFAULT 0,
	updated_at int8 NOT NULL DEFAULT 0,
	enabled varchar(5) NULL,
	additional_info varchar NULL,
	authority varchar(255) NULL,
	customer_id varchar(36) NULL,
	email varchar(255) NULL,
	"password" varchar(255) NULL,
	"name" varchar(255) NULL,
	first_name varchar(255) NULL,
	last_name varchar(255) NULL,
	search_text varchar(255) NULL,
	email_verified_at int8 NOT NULL DEFAULT 0,
	remember_token varchar(100) NULL,
	mobile varchar(20) NULL,
	remark varchar(100) NULL,
	is_admin int8 NULL DEFAULT 0,
	business_id varchar(36) NULL DEFAULT 0, -- 业务id
	wx_openid varchar(50) NULL DEFAULT ''::character varying, -- 微信openid
	wx_unionid varchar(50) NULL DEFAULT ''::character varying, -- 微信unionid
	CONSTRAINT users_pkey PRIMARY KEY (id)
);
CREATE INDEX "INDEX_WX_OPENID" ON public.users USING btree (wx_openid);
COMMENT ON TABLE public.users IS '后台用户';

-- Column comments

COMMENT ON COLUMN public.users.business_id IS '业务id';
COMMENT ON COLUMN public.users.wx_openid IS '微信openid';
COMMENT ON COLUMN public.users.wx_unionid IS '微信unionid';


-- public.warning_config definition

-- Drop table

-- DROP TABLE warning_config;

CREATE TABLE warning_config (
	id varchar(36) NOT NULL,
	wid varchar(255) NOT NULL, -- 业务ID
	"name" varchar(255) NULL, -- 预警名称
	"describe" varchar(255) NULL, -- 预警描述
	config varchar(10000) NULL, -- 配置
	message varchar(1000) NULL, -- 消息模板
	bid varchar(255) NULL, -- 设备ID
	sensor varchar(100) NULL,
	customer_id varchar(36) NULL,
	other_message varchar(255) NULL, -- 其他信息
	CONSTRAINT warning_config_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE public.warning_config IS '报警配置';



-- Column comments

COMMENT ON COLUMN public.warning_config.wid IS '业务ID';
COMMENT ON COLUMN public.warning_config."name" IS '预警名称';
COMMENT ON COLUMN public.warning_config."describe" IS '预警描述';
COMMENT ON COLUMN public.warning_config.config IS '配置';
COMMENT ON COLUMN public.warning_config.message IS '消息模板';
COMMENT ON COLUMN public.warning_config.bid IS '设备ID';
COMMENT ON COLUMN public.warning_config.other_message IS '其他信息';


-- public.warning_log definition

-- Drop table

-- DROP TABLE warning_log;

CREATE TABLE warning_log (
	id varchar(36) NOT NULL,
	"type" varchar(36) NULL,
	"describe" varchar(255) NULL,
	data_id varchar(36) NULL,
	created_at int8 NULL,
	CONSTRAINT warning_log_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE public.warning_log IS '报警日志';
CREATE INDEX warning_log_created_at_idx ON public.warning_log (created_at DESC);

-- public.asset definition

-- Drop table

-- DROP TABLE asset;

CREATE TABLE asset (
	id varchar(36) NOT NULL,
	additional_info varchar NULL,
	customer_id varchar(36) NULL, -- 客户ID
	"name" varchar(255) NULL, -- 名称
	"label" varchar(255) NULL, -- 标签
	search_text varchar(255) NULL,
	"type" varchar(255) NULL, -- 类型
	parent_id varchar(36) NULL, -- 父级ID
	tier int4 NOT NULL DEFAULT 1, -- 层级
	business_id varchar(36) NULL, -- 业务ID
	CONSTRAINT asset_pkey PRIMARY KEY (id),
	CONSTRAINT asset_fk FOREIGN KEY (business_id) REFERENCES business(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX asset_parent_id_idx ON public.asset USING btree (parent_id);
COMMENT ON TABLE public.asset IS '资产';

-- Column comments

COMMENT ON COLUMN public.asset.customer_id IS '客户ID';
COMMENT ON COLUMN public.asset."name" IS '名称';
COMMENT ON COLUMN public.asset."label" IS '标签';
COMMENT ON COLUMN public.asset."type" IS '类型';
COMMENT ON COLUMN public.asset.parent_id IS '父级ID';
COMMENT ON COLUMN public.asset.tier IS '层级';
COMMENT ON COLUMN public.asset.business_id IS '业务ID';


-- public.conditions definition

-- Drop table

-- DROP TABLE conditions;

CREATE TABLE conditions (
	id varchar(36) NOT NULL,
	business_id varchar(36) NULL, -- 业务ID
	"name" varchar(255) NULL, -- 策略名称
	"describe" varchar(255) NULL, -- 策略描述
	status varchar(255) NULL, -- 策略状态
	config varchar(10000) NULL, -- 配置
	sort int8 NULL DEFAULT 100,
	"type" int8 NULL,
	issued varchar(20) NULL DEFAULT 0,
	customer_id varchar(36) NULL,
	CONSTRAINT conditions_pkey PRIMARY KEY (id),
	CONSTRAINT conditions_fk FOREIGN KEY (business_id) REFERENCES business(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
COMMENT ON TABLE public.conditions IS '自动化规则';

-- Column comments

COMMENT ON COLUMN public.conditions.business_id IS '业务ID';
COMMENT ON COLUMN public.conditions."name" IS '策略名称';
COMMENT ON COLUMN public.conditions."describe" IS '策略描述';
COMMENT ON COLUMN public.conditions.status IS '策略状态';
COMMENT ON COLUMN public.conditions.config IS '配置';


-- public.dashboard definition

-- Drop table

-- DROP TABLE dashboard;

CREATE TABLE dashboard (
	id varchar(36) NOT NULL,
	"configuration" varchar(10000000) NULL,
	assigned_customers varchar(1000000) NULL,
	search_text varchar(255) NULL,
	title varchar(255) NULL,
	business_id varchar(36) NULL, -- 业务id
	CONSTRAINT dashboard_pkey PRIMARY KEY (id),
	CONSTRAINT dashboard_fk FOREIGN KEY (business_id) REFERENCES business(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
COMMENT ON TABLE public.dashboard IS '仪表盘';

-- Column comments

COMMENT ON COLUMN public.dashboard.business_id IS '业务id';


-- public.device definition

-- Drop table

-- DROP TABLE device;

CREATE TABLE device (
	id varchar(36) NOT NULL,
	asset_id varchar(36) NULL, -- 资产id
	"token" varchar(255) NULL, -- 安全key
	additional_info varchar NULL, -- 存储基本配置
	customer_id varchar(36) NULL, -- 所属客户
	"type" varchar(255) NULL, -- 插件类型
	"name" varchar(255) NULL, -- 插件名
	"label" varchar(255) NULL,
	search_text varchar(255) NULL,
	"extension" varchar(50) NULL, -- 插件( 目录名)
	protocol varchar(50) NULL,
	port varchar(50) NULL,
	publish varchar(255) NULL,
	subscribe varchar(255) NULL,
	username varchar(255) NULL,
	"password" varchar(255) NULL,
	"location" varchar(255) NULL, -- 设备位置
	d_id varchar(255) NULL, -- 设备唯一标志
	CONSTRAINT device_pkey PRIMARY KEY (id),
	CONSTRAINT device_fk FOREIGN KEY (asset_id) REFERENCES asset(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX device_token_idx ON public.device USING btree (token);
COMMENT ON TABLE public.device IS '设备';

-- Column comments

COMMENT ON COLUMN public.device.asset_id IS '资产id';
COMMENT ON COLUMN public.device."token" IS '安全key';
COMMENT ON COLUMN public.device.additional_info IS '存储基本配置';
COMMENT ON COLUMN public.device.customer_id IS '所属客户';
COMMENT ON COLUMN public.device."type" IS '插件类型';
COMMENT ON COLUMN public.device."name" IS '插件名';
COMMENT ON COLUMN public.device."extension" IS '插件( 目录名)';
COMMENT ON COLUMN public.device."location" IS '设备位置';
COMMENT ON COLUMN public.device.d_id IS '设备唯一标志';


-- public.field_mapping definition

-- Drop table

-- DROP TABLE field_mapping;

CREATE TABLE field_mapping (
	id varchar(36) NOT NULL,
	device_id varchar(36) NULL,
	field_from varchar(255) NULL,
	field_to varchar(255) NULL,
	symbol varchar(255) NULL,
	CONSTRAINT field_mapping_pkey PRIMARY KEY (id),
	CONSTRAINT field_mapping_fk FOREIGN KEY (device_id) REFERENCES device(id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- public.widget definition

-- Drop table

-- DROP TABLE widget;

CREATE TABLE widget (
	id varchar(36) NOT NULL,
	dashboard_id varchar(36) NULL,
	config varchar NULL,
	"type" varchar(255) NULL,
	"action" varchar(1000) NULL,
	updated_at timestamp(6) NULL,
	device_id varchar(36) NULL, -- 设备id
	widget_identifier varchar(255) NULL, -- 图表标识符如: environmentpanel:normal
	asset_id varchar(36) NULL,
	extend varchar(999) NULL, -- 扩展功能
	CONSTRAINT widget_pkey PRIMARY KEY (id),
	CONSTRAINT widget_fk FOREIGN KEY (dashboard_id) REFERENCES dashboard(id) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMENT ON TABLE public.widget IS '图表';

-- Column comments

COMMENT ON COLUMN public.widget.device_id IS '设备id';
COMMENT ON COLUMN public.widget.widget_identifier IS '图表标识符如: environmentpanel:normal';
COMMENT ON COLUMN public.widget.extend IS '扩展功能';







-- init sql
--24小时分区
SELECT create_hypertable('ts_kv', 'ts',chunk_time_interval => 86400000000);

INSERT INTO "users" ("id", "created_at", "updated_at", "enabled", "additional_info", "authority", "customer_id", "email", "password", "name", "first_name", "last_name", "search_text", "email_verified_at", "remember_token", "mobile", "remark", "is_admin", "business_id", "wx_openid", "wx_unionid") VALUES
('9212e9fb-a89c-4e35-9509-0a15df64f45a',	1606099326,	1623490224,	't',	NULL,	NULL,	NULL,	'admin@thingspanel.cn',	'$2a$04$aGFaew.rkRmOUiOZ/3ZncO/HN1BuJc8Dcm1MNuU3HhbUVUgKIx7jG',	'Admin',	NULL,	NULL,	NULL,	0,	NULL,	'18618000000',	NULL,	0,	'',	'',	'');

INSERT INTO logo
(id, system_name, theme, logo_one, logo_two, logo_three, custom_id, remark)
VALUES('1d625cec-bf5b-2ad1-b135-a23b5fad05bf', 'ThingsPanel', 'blue', './files/logo/logo-one.svg', './files/logo/logo-two.gif', './files/logo/logo-three.png', '', '');
INSERT INTO tp_menu (id,menu_name,parent_id,remark) VALUES
	 ('1','homepage','0',NULL),
	 ('2','buisness','0',NULL),
	 ('3','dashboard','0',NULL),
	 ('4','automation','0',NULL),
	 ('5','alert_message','0',NULL),
	 ('6','system_log','0',NULL),
	 ('7','product_management','0',NULL),
	 ('9','data_management','0',NULL),
	 ('10','application_management','0',NULL),
	 ('11','user_management','0',NULL),
	 ('12','system_setup','0',NULL),
	 ('13','logs','6',NULL),
	 ('14','equipment_log','6',NULL),
	 ('15','firmware_upgrade','7',NULL),
	 ('8','data_switching','0',NULL);

ALTER TABLE public.tp_function ADD "path" varchar(255) NULL;
COMMENT ON COLUMN public.tp_function."path" IS '页面路径';
ALTER TABLE public.tp_function ADD name varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.name IS '页面名称';
ALTER TABLE public.tp_function ADD component varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.component IS '组件路径';
ALTER TABLE public.tp_function ADD title varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.title IS '页面标题';
ALTER TABLE public.tp_function ADD icon varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.icon IS '页面标题';
ALTER TABLE public.tp_function ADD "type" varchar(2) NULL;
COMMENT ON COLUMN public.tp_function."type" IS '类型0-目录 1-菜单 2-页面 3-按钮';
ALTER TABLE public.tp_function ADD function_code varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.function_code IS '编码';
ALTER TABLE public.tp_function ADD parent_id varchar(36) NULL;

COMMENT ON COLUMN public.tp_function.icon IS '页面图表';
ALTER TABLE public.tp_function DROP CONSTRAINT tp_function_un;
ALTER TABLE public.tp_function ADD CONSTRAINT tp_function_pk PRIMARY KEY (id);
ALTER TABLE public.tp_function ADD sort int4 NULL;

INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', '', NULL, '/list', 'BusinessList', '/pages/business/BusinessIndex.vue', 'COMMON.BUSINESS', 'flaticon2-rhombus', '1', '', '0', 999);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('6dab000b-7ced-a5ce-5fb0-5427f3bb8073', '', NULL, '/chart/list', 'ChartList', '/pages/chart/List.vue', 'COMMON.VISUALIZATION', 'flaticon2-laptop', '1', '', '0', 997);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('dce69d1d-8297-c5a4-1502-ace84dfe0209', '', NULL, '/strategy/list', 'StrategyList', '/pages/automation/AutomationIndex.vue', 'COMMON.AUTOMATION', 'flaticon2-hourglass', '1', '', '0', 996);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('c17a3b9e-bd1f-2f10-4c65-d2ae7030087b', '', NULL, '/alarm/list', 'Alarm', '/pages/alarm/AlarmIndex.vue', 'COMMON.WARNINFO', 'flaticon2-warning', '1', '', '0', 995);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('a59eefbf-de02-a348-30af-d7f16053f884', '', NULL, '', 'system_log', '', 'COMMON.SYSTEMLOG', 'flaticon-open-box', '0', '', '0', 994);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('c41bc15c-17d0-89d2-8f7d-5d32d7f2fc64', '', NULL, '/chart/chart', 'chart', '/pages/chart/Chart.vue', 'COMMON.VISUALIZATIONCHART', '', '2', '', '6dab000b-7ced-a5ce-5fb0-5427f3bb8073', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7c0c8fbb-6ba1-2323-511d-859c7923f954', '', NULL, '/log/list', 'LogList', '/pages/log/LogIndex.vue', 'COMMON.OPERATIONLOG', 'flaticon2-paper', '1', '', 'a59eefbf-de02-a348-30af-d7f16053f884', 999);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('52a23456-775c-b731-7adf-a0fd3cddf649', '', NULL, '', 'BusinessAddButton', '', 'COMMON.NEWBUSINESS', '', '3', 'business:add', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 999);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('77d7133a-6434-bd51-232b-6b7fd862e50f', '', NULL, '', 'BusinessEdit', '', 'COMMON.EDITASSETSNAME', '', '3', 'business:edit', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 998);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('fd332720-1d06-9ba2-cf32-226cb2f54461', '', NULL, '', 'BusinessDel', '', 'COMMON.DELETE', '', '3', 'business:del', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 997);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b143ccd9-eb65-655a-a41f-4311da5ed8c0', '', NULL, '/equipment/index', 'Equipment', '/pages/equipment/EquipmentIndex.vue', 'COMMON.EQUIPMENTLOG', 'flaticon-interface-3', '1', '', 'a59eefbf-de02-a348-30af-d7f16053f884', 998);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('31bbc554-7c2f-eed1-1c05-30fd4f8d319d', '', NULL, '', 'ProductManagement', '', 'COMMON.PRODUCTMANAGEMENT', 'flaticon2-gift-1', '0', '', '0', 993);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('0e4105f8-8e8e-e985-ee27-32c0a0a458b6', '', NULL, '/firmware/index', 'firmware', '/pages/firmware/FirmwareIndex.vue', 'COMMON.FIRMWAREUPGRADE', 'flaticon-upload-1', '1', '', '31bbc554-7c2f-eed1-1c05-30fd4f8d319d', 999);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7cac14a0-0ff2-57d9-5465-597760bd2cb1', '', NULL, '', 'RuleEngine', '', 'COMMON.RULEENGINE', 'flaticon2-gift-1', '0', '', '0', 992);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('3f4348b0-f39d-ec42-14b4-623cbeadb12f', '', NULL, '/transpond/index', 'Transpond', '/pages/transpond/TranspondIndex.vue', 'COMMON.TRANSPOND', 'flaticon-upload-1', '1', '', '7cac14a0-0ff2-57d9-5465-597760bd2cb1', 998);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('ec7a22ed-919d-7959-6737-145198f6172f', '', NULL, '/market', 'Market', '/pages/Market.vue', 'COMMON.MARKET', 'flaticon2-supermarket', '1', '', '0', 991);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('4f2791e5-3c13-7249-c25f-77f6f787f574', '', NULL, '', 'SystemManagement', '', 'COMMON.SYSTEMMANAGEMENT', 'flaticon2-gear', '0', '', '0', 990);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('3786391a-6e8f-659d-1500-d2c3f82d6933', '', NULL, '/system/index', 'SystemSetup', '/pages/system/index.vue', 'COMMON.SYSTEMSETUP', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 999);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('2a1744d7-8440-c0a5-940a-9386ddfb1d0b', '', NULL, '/users/user', 'User', '/pages/users/UserIndex.vue', 'COMMON.USERS', 'flaticon2-user', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 998);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7ce628ae-d494-d71c-9eb0-148e6bf47665', '', NULL, '/management/index', 'Management', '/pages/management/index.vue', 'COMMON.MANAGEMENT', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 997);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('a53dba0c-3388-0f49-35f3-6e56ff9acc68', '', NULL, '', 'DeviceManagment', '', 'COMMON.DEVICE', '', '3', 'business:device', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 996);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('1bc93bad-41d3-ca37-638b-f79a29c1388b', '', NULL, '/data/index', 'Datas', '/pages/datas/DataIndex.vue', 'COMMON.DATAS', 'menu-icon flaticon2-list', '1', '', '0', 998);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('539b8e97-b791-3260-8b23-1beca9497b19', '', NULL, '', 'AddPermission', '', 'COMMON.PERMISSIONADD', '', '3', 'sys:permission:add', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('17f776f0-be0c-a216-a03a-00944865e8d7', '', NULL, '', 'EditPermission', '', 'COMMON.EDIT', '', '3', 'sys:permission:edit', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('4231ea2c-a2fb-bd9c-8966-c7d654289deb', '', NULL, '/permission/index', 'PermissionManagement', '/pages/system/permissions/Index.vue', 'COMMON.PERMISSIONMANAGEMENT', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 996);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('363116a3-1c00-b875-1386-415ea0839849', '', NULL, '/list/device', 'device', '/pages/device/DeviceIndex.vue', 'COMMON.DEVICE', '', '2', '', 'a53dba0c-3388-0f49-35f3-6e56ff9acc68', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('67b97839-919f-0976-2c79-c921adbec66e', '', NULL, '/strategy/alarmlist', 'AlarmStrategy', '/pages/automation/AlarmStrategy.vue', 'COMMON.ALARMSTRATEGY', '', '2', '', 'dce69d1d-8297-c5a4-1502-ace84dfe0209', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('8508677d-27ea-1158-c382-2bcf2b630346', '', NULL, '/strategy/strlist', 'ControlStrategy', '/pages/automation/ControlStrategy.vue', 'COMMON.CONTROLSTRATRGY', '', '2', '', 'dce69d1d-8297-c5a4-1502-ace84dfe0209', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('d8613453-278c-289c-6e18-ee58f6eb540b', '', NULL, '', 'DeletePermission', '', 'COMMON.DELETE', '', '3', 'sys:permission:del', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('1988db79-dcb6-f8e5-4984-90e131efa526', '', NULL, '', 'SearchPermission', '', 'COMMON.SEARCH', '', '3', 'sys:permission:search', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('a8ebb8af-adab-90fa-a553-49667370fc5f', '', NULL, '/access_engine/index', 'AccessEngine', '/pages/access-engine/AccessEngineIndex.vue', 'COMMON.NETWORKCOMPONENTS', 'flaticon-upload-1', '1', '', '7cac14a0-0ff2-57d9-5465-597760bd2cb1', 999);
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('9c4d044d-19c4-1b6c-c9d3-4d78e01ecb58', '', NULL, '/editpassword', 'EditPassword', '/pages/users/EditPassword.vue', 'COMMON.CHANGEPASSWORD', '', '3', 'sys:user:editpassword', '2a1744d7-8440-c0a5-940a-9386ddfb1d0b', 0);
