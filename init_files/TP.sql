CREATE TABLE "asset" (
    "id" character varying(36) NOT NULL,
    "additional_info" text,
    "customer_id" character varying(36),
    "name" character varying(255),
    "label" character varying(255),
    "search_text" character varying(255),
    "type" character varying(255),
    "parent_id" character varying(36),
    "tier" integer NOT NULL,
    "business_id" character varying(36),
    CONSTRAINT "asset_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "asset"."customer_id" IS '客户ID';
COMMENT ON COLUMN "asset"."name" IS '名称';
COMMENT ON COLUMN "asset"."label" IS '标签';
COMMENT ON COLUMN "asset"."type" IS '类型';
COMMENT ON COLUMN "asset"."parent_id" IS '父级ID';
COMMENT ON COLUMN "asset"."tier" IS '层级';
COMMENT ON COLUMN "asset"."business_id" IS '业务ID';
CREATE TABLE "business" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "created_at" bigint,
    "app_type" character varying(255) DEFAULT '' NOT NULL,
    "app_id" character varying(255) DEFAULT '' NOT NULL,
    "app_secret" character varying(255) DEFAULT '' NOT NULL,
    CONSTRAINT "business_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "business"."app_type" IS '应用类型';
COMMENT ON COLUMN "business"."app_id" IS 'app id';
COMMENT ON COLUMN "business"."app_secret" IS '密钥';
CREATE TABLE "conditions" (
    "id" character varying(36) NOT NULL,
    "business_id" character varying(36),
    "name" character varying(255),
    "describe" character varying(255),
    "status" character varying(255),
    "config" text,
    "sort" bigint,
    "type" bigint,
    "issued" character varying(20),
    "customer_id" character varying(36),
    CONSTRAINT "conditions_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "conditions"."business_id" IS '业务ID';
COMMENT ON COLUMN "conditions"."name" IS '策略名称';
COMMENT ON COLUMN "conditions"."describe" IS '策略描述';
COMMENT ON COLUMN "conditions"."status" IS '策略状态';
COMMENT ON COLUMN "conditions"."config" IS '配置';
CREATE TABLE "customers" (
    "id" character varying(36) NOT NULL,
    "additional_info" text,
    "address" text,
    "address2" text,
    "city" character varying(255),
    "country" character varying(255),
    "email" character varying(255),
    "phone" character varying(255),
    "search_text" character varying(255),
    "state" character varying(255),
    "title" character varying(255),
    "zip" character varying(255),
    CONSTRAINT "customers_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
CREATE TABLE "dashboard" (
    "id" character varying(36) NOT NULL,
    "configuration" text,
    "assigned_customers" text,
    "search_text" character varying(255),
    "title" character varying(255),
    "business_id" character varying(36),
    CONSTRAINT "dashboard_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "dashboard"."business_id" IS '业务id';
CREATE TABLE "device" (
    "id" character varying(36) NOT NULL,
    "asset_id" character varying(36),
    "token" character varying(255),
    "additional_info" text,
    "customer_id" character varying(36),
    "type" character varying(255),
    "name" character varying(255),
    "label" character varying(255),
    "search_text" character varying(255),
    "extension" character varying(50),
    "protocol" character varying(50),
    "port" character varying(50),
    "publish" character varying(255),
    "subscribe" character varying(255),
    "username" character varying(255),
    "password" character varying(255),
    CONSTRAINT "device_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "device"."asset_id" IS '资产id';
COMMENT ON COLUMN "device"."token" IS '安全key';
COMMENT ON COLUMN "device"."additional_info" IS '存储基本配置';
COMMENT ON COLUMN "device"."type" IS '插件类型';
COMMENT ON COLUMN "device"."name" IS '插件名';
COMMENT ON COLUMN "device"."extension" IS '插件( 目录名)';
COMMENT ON COLUMN "device"."protocol" IS '协议';
COMMENT ON COLUMN "device"."port" IS '端口';
COMMENT ON COLUMN "device"."publish" IS '发布主题';
COMMENT ON COLUMN "device"."subscribe" IS '订阅主题';
COMMENT ON COLUMN "device"."username" IS '账户';
COMMENT ON COLUMN "device"."password" IS '密码';
CREATE TABLE "field_mapping" (
    "id" character varying(36) NOT NULL,
    "device_id" character varying(36),
    "field_from" character varying(255),
    "field_to" character varying(255),
    "symbol" character varying(255),
    CONSTRAINT "field_mapping_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
CREATE TABLE "navigation" (
    "id" character varying(36) NOT NULL,
    "type" integer,
    "name" character varying(255),
    "data" character varying(255),
    "count" integer,
    CONSTRAINT "navigation_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "navigation"."type" IS '1:业务  2：自动化-控制策略 3：自动化-告警策略  4：可视化';
COMMENT ON COLUMN "navigation"."count" IS '数量';
CREATE TABLE "operation_log" (
    "id" character varying(36) NOT NULL,
    "type" character varying(36),
    "describe" text,
    "data_id" character varying(36),
    "created_at" bigint,
    "detailed" json,
    CONSTRAINT "operation_log_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
CREATE TABLE "password_resets" (
    "email" character varying(255) NOT NULL,
    "token" character varying(255) NOT NULL,
    "created_at" timestamp(0)
) WITH (oids = false);
CREATE TABLE "resources" (
    "id" character varying(36) NOT NULL,
    "cpu" character varying(36),
    "mem" character varying(36),
    "created_at" character varying(36),
    CONSTRAINT "resources_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
CREATE TABLE "ts_kv" (
    "entity_type" character varying(255) NOT NULL,
    "entity_id" character varying(36) NOT NULL,
    "key" character varying(255) NOT NULL,
    "ts" bigint,
    "bool_v" character varying(5),
    "str_v" text,
    "long_v" bigint,
    "dbl_v" double precision,
    CONSTRAINT "ts_kv_pkey" PRIMARY KEY ("entity_type", "entity_id", "key", "ts")
) WITH (oids = false);
SELECT create_hypertable('ts_kv', 'ts',chunk_time_interval => 86400000000);
-- CREATE INDEX "ts_kv_ts_idx" ON "ts_kv" USING btree ("ts" DESC);
COMMENT ON COLUMN "ts_kv"."entity_type" IS '类型：DEVICE';
COMMENT ON COLUMN "ts_kv"."entity_id" IS '设备id';
COMMENT ON COLUMN "ts_kv"."key" IS '字段';
COMMENT ON COLUMN "ts_kv"."ts" IS '毫秒时间戳';
COMMENT ON COLUMN "ts_kv"."dbl_v" IS '数值';
-- CREATE TRIGGER "ts_insert_blocker" BEFORE INSERT ON "ts_kv" FOR EACH ROW EXECUTE FUNCTION _timescaledb_internal.insert_blocker();
CREATE TABLE "ts_kv_latest" (
    "entity_type" character varying(255) NOT NULL,
    "entity_id" character varying(36) NOT NULL,
    "key" character varying(255) NOT NULL,
    "ts" TIMESTAMPTZ NOT NULL,
    "bool_v" character varying(5),
    "str_v" text,
    "long_v" bigint,
    "dbl_v" double precision,
    CONSTRAINT "ts_kv_latest_pkey" PRIMARY KEY ("entity_type", "entity_id", "key")
) WITH (oids = false);
CREATE TABLE "users" (
    "id" character varying(36) NOT NULL,
    "created_at" bigint NOT NULL,
    "updated_at" bigint NOT NULL,
    "enabled" character varying(5),
    "additional_info" text,
    "authority" character varying(255),
    "customer_id" character varying(36),
    "email" character varying(255),
    "password" character varying(255),
    "name" character varying(255),
    "first_name" character varying(255),
    "last_name" character varying(255),
    "search_text" character varying(255),
    "email_verified_at" bigint NOT NULL,
    "remember_token" character varying(100),
    "mobile" character varying(20),
    "remark" character varying(100),
    "is_admin" bigint,
    "business_id" character varying(36),
    "wx_openid" character varying(50),
    "wx_unionid" character varying(50),
    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "users"."business_id" IS '业务id';
COMMENT ON COLUMN "users"."wx_openid" IS '微信openid';
COMMENT ON COLUMN "users"."wx_unionid" IS '微信unionid';
INSERT INTO "users" ("id", "created_at", "updated_at", "enabled", "additional_info", "authority", "customer_id", "email", "password", "name", "first_name", "last_name", "search_text", "email_verified_at", "remember_token", "mobile", "remark", "is_admin", "business_id", "wx_openid", "wx_unionid") VALUES
('9212e9fb-a89c-4e35-9509-0a15df64f45a',	1606099326,	1623490224,	't',	NULL,	NULL,	NULL,	'admin@thingspanel.cn',	'$2a$04$aGFaew.rkRmOUiOZ/3ZncO/HN1BuJc8Dcm1MNuU3HhbUVUgKIx7jG',	'Admin',	NULL,	NULL,	NULL,	0,	NULL,	'18618000000',	NULL,	0,	'',	'',	'');
CREATE TABLE "warning_config" (
    "id" character varying(36) NOT NULL,
    "wid" character varying(255) NOT NULL,
    "name" character varying(255),
    "describe" character varying(255),
    "config" text,
    "message" text,
    "bid" character varying(255),
    "sensor" character varying(100),
    "customer_id" character varying(36),
    CONSTRAINT "warning_config_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "warning_config"."wid" IS '业务ID';
COMMENT ON COLUMN "warning_config"."name" IS '预警名称';
COMMENT ON COLUMN "warning_config"."describe" IS '预警描述';
COMMENT ON COLUMN "warning_config"."config" IS '配置';
COMMENT ON COLUMN "warning_config"."message" IS '消息模板';
COMMENT ON COLUMN "warning_config"."bid" IS '设备ID';
CREATE TABLE "warning_log" (
    "id" character varying(36) NOT NULL,
    "type" character varying(36),
    "describe" character varying(255),
    "data_id" character varying(36),
    "created_at" bigint,
    CONSTRAINT "warning_log_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
CREATE TABLE "widget" (
    "id" character varying(36) NOT NULL,
    "dashboard_id" character varying(36),
    "config" text,
    "type" character varying(255),
    "action" text,
    "updated_at" timestamp(0),
    "device_id" character varying(36),
    "widget_identifier" character varying(255),
    "asset_id" character varying(36),
    CONSTRAINT "widget_pkey" PRIMARY KEY ("id")
) WITH (oids = false);
COMMENT ON COLUMN "widget"."device_id" IS '设备id';
COMMENT ON COLUMN "widget"."widget_identifier" IS '图表标识符如: environmentpanel:normal';
ALTER TABLE public.asset ADD CONSTRAINT asset_fk FOREIGN KEY (business_id) REFERENCES public.business(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE public.device ADD CONSTRAINT device_fk FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE public.field_mapping ADD CONSTRAINT field_mapping_fk FOREIGN KEY (device_id) REFERENCES public.device(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE public.dashboard ADD CONSTRAINT dashboard_fk FOREIGN KEY (business_id) REFERENCES public.business(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE public.widget ADD CONSTRAINT widget_fk FOREIGN KEY (dashboard_id) REFERENCES public.dashboard(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE public.widget ADD CONSTRAINT widget_fk_asset FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE public.conditions ADD CONSTRAINT conditions_fk FOREIGN KEY (business_id) REFERENCES public.business(id) ON DELETE RESTRICT ON UPDATE CASCADE;
