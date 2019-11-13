Return-Path: <SRS0=6WdS=ZF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AD9C43331
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 12:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E872245B
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKMMFK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:05:10 -0500
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:5539
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbfKMMFK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Nov 2019 07:05:10 -0500
Received: from SN4PR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:803:2b::34) by SN4PR0201MB3631.namprd02.prod.outlook.com
 (2603:10b6:803:47::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Wed, 13 Nov
 2019 12:05:05 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0024.outlook.office365.com
 (2603:10b6:803:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Wed, 13 Nov 2019 12:05:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Wed, 13 Nov 2019 12:05:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUrKF-0003E8-Gk; Wed, 13 Nov 2019 04:00:43 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUrK9-0000Rh-JA; Wed, 13 Nov 2019 04:00:37 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xADC0V2C027957;
        Wed, 13 Nov 2019 04:00:31 -0800
Received: from [10.140.6.29] (helo=xhdraghukum42.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUrK3-0000NA-2x; Wed, 13 Nov 2019 04:00:31 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
Date:   Wed, 13 Nov 2019 12:00:08 +0000
Message-Id: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.112-7.0-31-1
X-imss-scan-details: No--3.112-7.0-31-1;No--3.112-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132181203057798776;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(199004)(189003)(5660300002)(16586007)(50226002)(2906002)(126002)(336012)(486006)(14444005)(70586007)(26005)(76482006)(51416003)(73392003)(50466002)(48376002)(426003)(476003)(6916009)(54906003)(30864003)(9786002)(305945005)(55446002)(2616005)(8936002)(81156014)(81166006)(8676002)(508600001)(86362001)(2351001)(107886003)(2361001)(47776003)(61266001)(70206006)(82202003)(356004)(6666004)(36756003)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3631;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f6669a-9666-4b11-a4bd-08d76831b8ad
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3631:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB36319303FF27D7313E3F785F87760@SN4PR0201MB3631.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 0220D4B98D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqon24A4yUZzJ3Hkrkauu/GU5Ye+/SHus1Rnfnr6/iXGChgz1yJcwarqxaZ2IS6qQYoH6BIyHnuvO8iuW2Y70/cXsOh7DCNL/gc9Tt7t0AwbjPaQd9htYn8wqqww8ah2mypaI71QiBE+Oi/aLeMsNH+znX1ug7Zx+6Ei25bBBiNl6vRlFcHDN2qLsapAADKhCfpubYH69ME5dldpq+hGyEuStK9k/8v4YLXJPg2rIg4qJeexT3nJFxomQwXGoHmqb0xidmo6UyqDTxOQ7S8XvzLijBnQcg2ijyI2l5Q0AH9A4fqjKXGsr+eY5GFfoTdXzqpevWn+2tYhotK3n9m/4KOh2OteSK0gi+NZca6I36szIBB7Dee43xjH4aL7rDbjAGBRJYYMAW9IlrM8K2gUl6fkyOw3GnAO67N03UtdBKwluQR3IZYoQHRL6tLKpz3T
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 12:05:05.5446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f6669a-9666-4b11-a4bd-08d76831b8ad
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3631
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

This patch is removing ULITE_NR_PORTS macro which limits number of
ports which can be used. Every instance is registering own struct
uart_driver with minor number which corresponds to alias ID (or 0 now).
and with 1 uart port. The same alias ID is saved to
tty_driver->name_base which is key field for creating ttyULX name.

Because name_base and minor number are setup already there is no need to
setup any port->line number because 0 is the right value.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v4: patch addition
v5: Merge the patch so that all the patches compile

 drivers/tty/serial/uartlite.c | 252 ++++++++++++++++++++++++++++++------------
 1 file changed, 181 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 4d431a2..19f68f3 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -27,7 +27,6 @@
 #define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
 #define ULITE_MINOR		187
-#define ULITE_NR_UARTS		CONFIG_SERIAL_UARTLITE_NR_UARTS
 
 /* ---------------------------------------------------------------------
  * Register definitions
@@ -65,6 +64,7 @@ static struct uart_port *console_port;
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
 	struct clk *clk;
+	int id;
 	struct uart_driver *ulite_uart_driver;
 };
 
@@ -117,7 +117,6 @@ static inline void uart_out32(u32 val, u32 offset, struct uart_port *port)
 	pdata->reg_ops->out(val, port->membase + offset);
 }
 
-static struct uart_port ulite_ports[ULITE_NR_UARTS];
 
 /* ---------------------------------------------------------------------
  * Core UART driver operations
@@ -535,18 +534,6 @@ static int ulite_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver ulite_uart_driver;
-
-static struct console ulite_console = {
-	.name	= ULITE_NAME,
-	.write	= ulite_console_write,
-	.device	= uart_console_device,
-	.setup	= ulite_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1, /* Specified on the cmdline (e.g. console=ttyUL0 ) */
-	.data	= &ulite_uart_driver,
-};
-
 static void early_uartlite_putc(struct uart_port *port, int c)
 {
 	/*
@@ -590,18 +577,6 @@ OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a", early_uartlite_setup
 
 #endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
 
-static struct uart_driver ulite_uart_driver = {
-	.owner		= THIS_MODULE,
-	.driver_name	= "uartlite",
-	.dev_name	= ULITE_NAME,
-	.major		= ULITE_MAJOR,
-	.minor		= ULITE_MINOR,
-	.nr		= ULITE_NR_UARTS,
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-	.cons		= &ulite_console,
-#endif
-};
-
 /* ---------------------------------------------------------------------
  * Port assignment functions (mapping devices to uart_port structures)
  */
@@ -622,24 +597,9 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	struct uart_port *port;
 	int rc;
 
-	/* if id = -1; then scan for a free id and use that */
-	if (id < 0) {
-		for (id = 0; id < ULITE_NR_UARTS; id++)
-			if (ulite_ports[id].mapbase == 0)
-				break;
-	}
-	if (id < 0 || id >= ULITE_NR_UARTS) {
-		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
-		return -EINVAL;
-	}
-
-	if ((ulite_ports[id].mapbase) && (ulite_ports[id].mapbase != base)) {
-		dev_err(dev, "cannot assign to %s%i; it is already in use\n",
-			ULITE_NAME, id);
-		return -EBUSY;
-	}
-
-	port = &ulite_ports[id];
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
 
 	spin_lock_init(&port->lock);
 	port->fifosize = 16;
@@ -653,7 +613,6 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = dev;
 	port->type = PORT_UNKNOWN;
-	port->line = id;
 	port->private_data = pdata;
 
 	dev_set_drvdata(dev, port);
@@ -783,11 +742,24 @@ static const struct of_device_id ulite_of_match[] = {
 MODULE_DEVICE_TABLE(of, ulite_of_match);
 #endif /* CONFIG_OF */
 
-static int ulite_probe(struct platform_device *pdev)
+/*
+ * Maximum number of instances without alias IDs but if there is alias
+ * which target "< MAX_UART_INSTANCES" range this ID can't be used.
+ */
+#define MAX_UART_INSTANCES	256
+
+/* Stores static aliases list */
+static DECLARE_BITMAP(alias_bitmap, MAX_UART_INSTANCES);
+static int alias_bitmap_initialized;
+
+/* Stores actual bitmap of allocated IDs with alias IDs together */
+static DECLARE_BITMAP(bitmap, MAX_UART_INSTANCES);
+/* Protect bitmap operations to have unique IDs */
+static DEFINE_MUTEX(bitmap_lock);
+
+static int ulite_get_id(struct platform_device *pdev)
 {
-	struct resource *res;
-	struct uartlite_data *pdata;
-	int irq, ret;
+	int ret;
 	int id = pdev->id;
 #ifdef CONFIG_OF
 	const __be32 *prop;
@@ -796,39 +768,159 @@ static int ulite_probe(struct platform_device *pdev)
 	if (prop)
 		id = be32_to_cpup(prop);
 #endif
-	if (id < 0) {
-		/* Look for a serialN alias */
-		id = of_alias_get_id(pdev->dev.of_node, "serial");
-		if (id < 0)
-			id = 0;
-	}
 
-	if (!ulite_uart_driver.state) {
-		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
-		ret = uart_register_driver(&ulite_uart_driver);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
+	mutex_lock(&bitmap_lock);
+
+	/* Alias list is stable that's why get alias bitmap only once */
+	if (!alias_bitmap_initialized) {
+		ret = of_alias_get_alias_list(of_match_ptr(ulite_of_match),
+					      "serial", alias_bitmap,
+					      MAX_UART_INSTANCES);
+		if (ret) {
+			mutex_unlock(&bitmap_lock);
 			return ret;
 		}
+
+		alias_bitmap_initialized++;
 	}
 
+	/* Make sure that alias ID is not taken by instance without alias */
+	bitmap_or(bitmap, bitmap, alias_bitmap, MAX_UART_INSTANCES);
+
+	dev_dbg(&pdev->dev, "Alias bitmap: %*pb\n",
+		MAX_UART_INSTANCES, bitmap);
+
+	/* Look for a serialN alias */
+	if (id < 0)
+		id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+	if (id < 0) {
+		dev_warn(&pdev->dev,
+			 "No serial alias passed. Using the first free id\n");
+
+		/*
+		 * Start with id 0 and check if there is no serial0 alias
+		 * which points to device which is compatible with this driver.
+		 * If alias exists then try next free position.
+		 */
+		id = 0;
+
+		for (;;) {
+			dev_info(&pdev->dev, "Checking id %d\n", id);
+			id = find_next_zero_bit(bitmap, MAX_UART_INSTANCES, id);
+
+			/* No free empty instance */
+			if (id == MAX_UART_INSTANCES) {
+				dev_err(&pdev->dev, "No free ID\n");
+				mutex_unlock(&bitmap_lock);
+				return -EINVAL;
+			}
+
+			dev_dbg(&pdev->dev, "The empty id is %d\n", id);
+			/* Check if ID is empty */
+			if (!test_and_set_bit(id, bitmap)) {
+				/* Break the loop if bit is taken */
+				dev_dbg(&pdev->dev,
+					"Selected ID %d allocation passed\n",
+					id);
+				break;
+			}
+			dev_dbg(&pdev->dev,
+				"Selected ID %d allocation failed\n", id);
+			/* if taking bit fails then try next one */
+			id++;
+		}
+	}
+
+	mutex_unlock(&bitmap_lock);
+
+	return id;
+}
+
+static int ulite_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct uartlite_data *pdata;
+	int irq, ret;
+	struct uart_driver *ulite_uart_driver;
+	char *driver_name;
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	struct console *ulite_console;
+#endif
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
+	ulite_uart_driver = devm_kzalloc(&pdev->dev,
+					 sizeof(*ulite_uart_driver),
+					 GFP_KERNEL);
+	if (!ulite_uart_driver)
+		return -ENOMEM;
+
+	pdata->id = ulite_get_id(pdev);
+	if (pdata->id < 0)
+		return pdata->id;
+
+	/* There is a need to use unique driver name */
+	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
+				     ULITE_NAME, pdata->id);
+	if (!driver_name) {
+		ret = -ENOMEM;
+		goto err_out_id;
+	}
+
+	ulite_uart_driver->owner = THIS_MODULE;
+	ulite_uart_driver->driver_name = driver_name;
+	ulite_uart_driver->dev_name = ULITE_NAME;
+	ulite_uart_driver->major = ULITE_MAJOR;
+	ulite_uart_driver->minor = pdata->id;
+	ulite_uart_driver->nr = 1;
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	ulite_console = devm_kzalloc(&pdev->dev, sizeof(*ulite_console),
+				     GFP_KERNEL);
+	if (!ulite_console) {
+		ret = -ENOMEM;
+		goto err_out_id;
+	}
+
+	strncpy(ulite_console->name, ULITE_NAME,
+		sizeof(ulite_console->name));
+	ulite_console->index = pdata->id;
+	ulite_console->write = ulite_console_write;
+	ulite_console->device = uart_console_device;
+	ulite_console->setup = ulite_console_setup;
+	ulite_console->flags = CON_PRINTBUFFER;
+	ulite_uart_driver->cons = ulite_console;
+	ulite_console->data = ulite_uart_driver;
+#endif
+
+	dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
+	ret = uart_register_driver(ulite_uart_driver);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register driver\n");
+		goto err_out_id;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_out_unregister_driver;
+	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq <= 0) {
+		ret = -ENXIO;
+		goto err_out_unregister_driver;
+	}
 
 	pdata->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(pdata->clk)) {
-		if (PTR_ERR(pdata->clk) != -ENOENT)
-			return PTR_ERR(pdata->clk);
+		if (PTR_ERR(pdata->clk) != -ENOENT) {
+			ret = PTR_ERR(pdata->clk);
+			goto err_out_unregister_driver;
+		}
 
 		/*
 		 * Clock framework support is optional, continue on
@@ -837,11 +929,10 @@ static int ulite_probe(struct platform_device *pdev)
 		pdata->clk = NULL;
 	}
 
-	pdata->ulite_uart_driver = &ulite_uart_driver;
 	ret = clk_prepare_enable(pdata->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clock\n");
-		return ret;
+		goto err_out_unregister_driver;
 	}
 
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -849,11 +940,27 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
+	ulite_uart_driver->tty_driver->name_base = pdata->id;
+	pdata->ulite_uart_driver = ulite_uart_driver;
+	ret = ulite_assign(&pdev->dev, pdata->id, res->start, irq, pdata);
+	if (ret < 0)
+		goto err_out_clk_disable;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
+	return 0;
 
+err_out_clk_disable:
+	clk_disable_unprepare(pdata->clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_unregister_driver:
+	uart_unregister_driver(ulite_uart_driver);
+err_out_id:
+	mutex_lock(&bitmap_lock);
+	clear_bit(pdata->id, bitmap);
+	mutex_unlock(&bitmap_lock);
 	return ret;
 }
 
@@ -865,11 +972,16 @@ static int ulite_remove(struct platform_device *pdev)
 
 	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
+	mutex_lock(&bitmap_lock);
+	clear_bit(pdata->id, bitmap);
+	mutex_unlock(&bitmap_lock);
+
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	if (console_port == port)
 		console_port = NULL;
 #endif
 
+	uart_unregister_driver(pdata->ulite_uart_driver);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
@@ -903,8 +1015,6 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	if (ulite_uart_driver.state)
-		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
2.1.1

