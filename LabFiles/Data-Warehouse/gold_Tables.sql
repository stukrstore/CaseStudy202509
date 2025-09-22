CREATE TABLE [dbo].[dim_customer]
(
	[customer_id] [int] NULL,
	[customer_name] [varchar](100) NULL,
	[customer_phone] [varchar](100) NULL,
	[customer_email] [varchar](100) NULL,
	[customer_since] [datetime2](6) NULL,
	[last_login] [datetime2](6) NULL
)
GO

CREATE TABLE [dbo].[dim_dates]
(
	[date_id] [int] NULL,
	[calendar_date] [date] NULL,
	[calendar_year] [int] NULL,
	[calendar_month] [varchar](10) NULL,
	[month_of_year] [int] NULL,
	[calendar_day] [varchar](8000) NULL,
	[day_of_week] [int] NULL,
	[day_of_week_start_monday] [int] NULL,
	[is_week_day] [varchar](10) NULL,
	[day_of_month] [int] NULL,
	[is_last_day_of_month] [varchar](10) NULL,
	[day_of_year] [int] NULL,
	[week_of_year_iso] [int] NULL,
	[quarter_of_year] [int] NULL,
	[fiscal_year_oct_sept] [int] NULL,
	[fiscal_month_oct_sept] [int] NULL,
	[fiscal_year_jun_jul] [int] NULL,
	[fiscal_month_jun_jul] [int] NULL
)
GO

CREATE TABLE [dbo].[dim_promotions]
(
	[promotion_id] [int] NULL,
	[promotion_code] [varchar](100) NULL,
	[web_discount] [float] NULL,
	[phone_discount] [float] NULL,
	[mobile_discount] [float] NULL,
	[promotion_start_date] [date] NULL,
	[promotion_end_date] [date] NULL,
	[campaign_code] [varchar](100) NULL
)
GO

CREATE TABLE [dbo].[dim_purchase]
(
	[purchase_id] [int] NULL,
	[channel] [varchar](100) NULL,
	[payment_instrument_type] [varchar](100) NULL,
	[purchase_amount] [float] NULL,
	[purchase_date] [datetime2](6) NULL
)
GO

CREATE TABLE [dbo].[dim_supplier]
(
	[supplier_id] [int] NULL,
	[supplier_name] [varchar](100) NULL,
	[supplier_phone] [varchar](100) NULL,
	[supplier_email] [varchar](100) NULL,
	[supplier_since] [datetime2](6) NULL,
	[supplier_service] [varchar](100) NULL
)
GO

CREATE TABLE [dbo].[fact_sale]
(
	[id] [int] NULL,
	[purchase_id] [int] NULL,
	[customer_id] [int] NULL,
	[supplier_id] [int] NULL,
	[promotion_id] [int] NULL,
	[purchase_amount] [float] NULL,
	[date_id] [int] NULL
)
GO