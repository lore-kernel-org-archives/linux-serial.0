Return-Path: <SRS0=QEsI=ZE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F32AC17441
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26600206BA
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLKpM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:45:12 -0500
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:65283
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbfKLKpL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Nov 2019 05:45:11 -0500
Received: from BN6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:404:5f::26)
 by SN6PR02MB5184.namprd02.prod.outlook.com (2603:10b6:805:69::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Tue, 12 Nov
 2019 10:45:07 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR02CA0040.outlook.office365.com
 (2603:10b6:404:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 10:45:07 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 10:45:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTby-00023C-8Q; Tue, 12 Nov 2019 02:41:26 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbt-0008C5-4s; Tue, 12 Nov 2019 02:41:21 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACAfKpG018061;
        Tue, 12 Nov 2019 02:41:20 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbs-00089t-17; Tue, 12 Nov 2019 02:41:20 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCHv4 3/4] serial-uartlite: Remove ULITE_NR_PORTS macro
Date:   Tue, 12 Nov 2019 16:11:10 +0530
Message-Id: <1573555271-2579-3-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.112-7.0-31-1
X-imss-scan-details: No--3.112-7.0-31-1;No--3.112-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132180291072591545;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(2361001)(70206006)(82202003)(4326008)(70586007)(6916009)(9686003)(54906003)(16586007)(316002)(107886003)(26005)(2351001)(14444005)(9786002)(30864003)(5660300002)(55446002)(61266001)(47776003)(50466002)(498600001)(48376002)(356004)(76482006)(6666004)(426003)(305945005)(76176011)(36756003)(2616005)(51416003)(2906002)(8936002)(126002)(476003)(446003)(11346002)(486006)(50226002)(73392003)(8676002)(81156014)(81166006)(86362001)(336012)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5184;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f007b5-0f8f-4736-5589-08d7675d6222
X-MS-TrafficTypeDiagnostic: SN6PR02MB5184:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5184A119ABBD1FECEBB0563687770@SN6PR02MB5184.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPfhAcJuIE8pbC6xGHHZ2KUpgq/PGSJSmCtIwhVkvpSoovWV1UiyvBQ1OhQTv86zdOL6+bqJ4PBv/NupfRzXhl3tDtR5M8caEPoAXDZPw+qxQddzoMJM8Pev7VpZtjaV9a7pNNMx2aKsJNpRv7dEzS/CWxUPHgDd265aryNQo+9trSrebTuwn8JrPUVyrM/Rca6CueaNRCp1bujHYTc9tdC1+edF9FtLQ3krnLBvAh7zBG9H7mSHnUp1McnRpm8KqYrfcsBRyW05lB3WPlPsXd8JXEtIewStHSNGyXpl1AAQVnWgx+KSm7vfpBDBUhr6uJaH7dyZi42T5cWGXZOzO/Xns79iPMhSbj7sSI62O5r3nHQstslatdebVe2ZUd0vjNO8GzpEZjter2PYWOpyyFIsP5N02jWuqfbR8a8Y66ioohkd/rj2UkTiVj/GAiCd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:45:07.0079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f007b5-0f8f-4736-5589-08d7675d6222
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5184
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
 drivers/tty/serial/uartlite.c | 251 ++++++++++++++++++++++++++++++------------
 1 file changed, 180 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 4d431a2..1bc3e59 100644
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
@@ -796,39 +768,158 @@ static int ulite_probe(struct platform_device *pdev)
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
+		ret = of_alias_get_alias_list(ulite_of_match, "serial",
+					      alias_bitmap, MAX_UART_INSTANCES);
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
@@ -837,11 +928,10 @@ static int ulite_probe(struct platform_device *pdev)
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
@@ -849,11 +939,27 @@ static int ulite_probe(struct platform_device *pdev)
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
 
@@ -865,11 +971,16 @@ static int ulite_remove(struct platform_device *pdev)
 
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
@@ -903,8 +1014,6 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	if (ulite_uart_driver.state)
-		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
2.1.1

