Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D4C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4FF60F23
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhGWVvp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:51:45 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232226AbhGWVvo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzjV6G1Mmp5NnvmWHJBuiYVE6nDBJeZSHvhG/i2nidYfriw8EwImzBW9RoWpPUC3skVTKX3l18mkQd7x/MLQkkzGAF8LKahFDhhucWCMv5++oV/B26yCEVvpqBnkiul8/3kqzSwVzTOPhXtOsY6OxM+NE6xb0qtTqJO6fEdFGPqOUjkbM/rDX9kBLFQpklRZmd6xtij7eK8lqJbenaF7j7LkAaweY4LjnbKGzmyf010Q7dv9h29MCtbWd49Uzy275s0/vi4njAodO1GFLYlAHFZORVP2lDNc4QQWSumWcJsebdZuxxMXkbZj4xKBXU87g39oai4L6Ka0bth1Fmw+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNFvKMBCv+YGQGZYX8BGVhpzTXsTcFW0MbLi0AEGLAI=;
 b=jyQ3kf4gMyVi1LFxWg0j36z1Wuw7m4JMJBpOFa5uHd2ObcYi/6XWN1rBh960+HcKXZ0/lBTMajTa0KkITj/rUkqGpzqXmwc0dnAJR5RifUmU0vjDdBMdYQ995qkRAwt5H3M4eeIErNSFnNge43AoVPPsCOfzDYyJFHRS8Ei1KbPuxhMj94glrEFQx/rTNIdsIai0pwvLnWwu6exkP5jMps/hptaVHflR48SyCzrA2aurhx5BfWnGWxCnydvxD9iRvs3YBrXOM0ehkCATcAoyXB2Pr6MrQMtzHISkbya0yev/d3ENTcb7f96kpAT7U29l7qIaGGUmUuOLW7RuIU66pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNFvKMBCv+YGQGZYX8BGVhpzTXsTcFW0MbLi0AEGLAI=;
 b=mtSIPiIirA1FGm9PT2HO1j8Vk2A48BN1YuKsXofT1s7pBdd9lZZkaZvM7gbsuatIpeuifEW9pZ6ObXVl9L1iXnYiRsmKGUfOyqmwLCkz+MHcLdVh6kVEpVXvoV08HnkiIsrRhq0oWVxMn89XAL7t0A0LFJPwgW4ihUYmvrDsoYI=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7068.eurprd03.prod.outlook.com (2603:10a6:10:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 22:32:07 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 22:32:07 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 4/5] tty: serial: uartlite: Initialize termios with fixed synthesis parameters
Date:   Fri, 23 Jul 2021 18:31:50 -0400
Message-Id: <20210723223152.648326-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723223152.648326-1-sean.anderson@seco.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 22:32:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f916e65-8313-427c-d66f-08d94e29b40c
X-MS-TrafficTypeDiagnostic: DBBPR03MB7068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB70680C8771B8BDD883ED3DB096E59@DBBPR03MB7068.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPqI02X2NtBcC5H6LYKBaRJ8Us3F/3L5JJuSP2RxgYky94/Hkp47MqQKtVo57iBJGB/+6kSTeKBA48eMvpXx8T0s67Sa9WEp9ncdXs62jJuUKu1MCUeWwSaLV8rCSm7J4eKrKz+6pQpNSOJdcR5hY7Il0DpOWyqy5qPEGbtsjcAAX/GBJ28Mj6ZvoIJrK6qlQl8HaGSQf9mgHTysFKUEDULRDWmp3cHbqOY9WfASa1JfcizA0mTTpETaTY7XqQdj9+AeMVnmhfmd5pwsG91YcZMxbTn4NBFmR3dLuQpQxq3FQu/o/DoDUeM3QA/dNP7kYV5F/s4ZcSuGK5X3deAuGLg4u0FYQAs/yLutintSJ+DprOzyAmjQh0zyLh/5fr+nne/wHJPiVcdhGpqfM/BzQYICc9M3nudMBaztD6Hf5RcqNSIa4XMcqNMbGPHhFgCj9K+30tqCVQiXh6tCttEJ+aSdr+C8In9cLm5V9WSskqvL0YK8wGa+MnHAJlnlNck01GPQqgpPLgJFkyXUT8zI1JDalWab1CqmshELzEvezIK7/iyyeXCGyHzCNZ0YjthG2638lRC73TKrZ96ZPCyNzHwg0zSEuT1evvK3sbBPnPXxuMW0LhOqF1/RTTn86JM+5dVRO3AG7SVPWiw46roBJgWoMMApyerUOeJomuq1Va42ZK6E9wYjMTcT18/WwokBOJJOkoRQz3AoWNo7n5wRPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39840400004)(52116002)(478600001)(2906002)(2616005)(6512007)(6666004)(186003)(26005)(1076003)(956004)(107886003)(44832011)(5660300002)(36756003)(38350700002)(38100700002)(316002)(8676002)(110136005)(4326008)(86362001)(6486002)(8936002)(83380400001)(66556008)(66476007)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NcIvNBIx33rIggKb1su1uqBuq0OKeoZUh2C6ntotWKwK+PneR8YpbfQZAx/4?=
 =?us-ascii?Q?4UiSKuHCawsG6bT1DloozZcLSRsBNCdNFek6a46ZftoHzqMpMAmeuvIhDGl+?=
 =?us-ascii?Q?OJWjoiF2tzqMI3tqwsljOkNAmvayoBhjJofdsDKi1NAgKA68NGuZlrkFV6SA?=
 =?us-ascii?Q?G0ejxMkCZ2usMKpUnNg4sTpQUK3T3U75e3dtx0S9iP79WUkBijWqsjEb9i54?=
 =?us-ascii?Q?Tf49sWs633ubw6p+Z6evphJw+ZclWOwcBQfV1GDfI1xB7ZehlNf3gZjitu0Q?=
 =?us-ascii?Q?AhP/QEROIgsvKUctuH1xSRUhZ4o6bgifUGDoffXo6zo98m7IkfIf/16UUy4q?=
 =?us-ascii?Q?waE/5VakTxxiOSyXFeWkZjLO1d10sm1KUlgnOEilbbEWHApff9IDyHxnuWy7?=
 =?us-ascii?Q?KW0MAKppnMKhSbSUreH033VHPV6IBYHImTJTHHklEqVlDwfwPAY6NVSZNhq9?=
 =?us-ascii?Q?JJcPtRB8adQP8IBoVaPrCDWFZYbiSdxaKV/mTGFIJr6ItoAarDFjUgUhhvNo?=
 =?us-ascii?Q?WPfuvuYlAQhnvJ48WesccT87E7ft600FB+TXvp5Gzs7c2bHgxooMuFaIVECy?=
 =?us-ascii?Q?eeMBW3mr9mXgMgocwj0ZklWDDX19PDf5PwNFOidiyZdAAko5hnIdf6AkYWLt?=
 =?us-ascii?Q?lufssCUbEwGzQTSmCGfQvr486x/YLXK5TTQP2fh3a8TxZyuhS9YALUIRPlJe?=
 =?us-ascii?Q?bIby6h/laIvCw4tAqkrV75HVCfnMbPpnFYvI9cE4ODTI8g7Hbdy6X3Oah/KA?=
 =?us-ascii?Q?7BYwp8yM91Stbo9+7SD9LtylK2FxochaufvJ2+djUvyMO5KXsjl/9hQDsE6a?=
 =?us-ascii?Q?jzBJgpyKDT2jn5pOwQ51znu0hoyzoGRLrjECnCUm7u5B+MCBs+q5OHoedwcz?=
 =?us-ascii?Q?isysTWOt9UYuiE49RPaKpx0xGaRjpycydfSR2z0rAb1qlJngYVA3tE+xiuLu?=
 =?us-ascii?Q?Mb4pKevfYveNGMMMZtVTSn47e171h/3E73+yOSKqrwl5XUwTXCITLM5vJqo/?=
 =?us-ascii?Q?PP2pfkvUx9njcrfaAnU/ZopW/UAEKsOTYZUoKFsevLiTrSRFhYh5twyBBnj6?=
 =?us-ascii?Q?Rxb0/dO0M0tVroojcXKaarX061f7pC8d0kHUnEese7kSC1Swp+D+0uQumeMO?=
 =?us-ascii?Q?FwSxW7E9eLstAluH1MJp6sFI/ayv1U6GqN1a/7UbaiRd7rQhCcUb2DxTeUaj?=
 =?us-ascii?Q?T2zoCIUnAZHwNToHuOoflY3PigV9yszhPoy3OGq4Y7luuNrpJn9f+0ER9FyL?=
 =?us-ascii?Q?Uhy/2YDCWIG7DcmjVvuZ5srVCrX0LhkovES+OOwPoc72W2YdIbG2Js3JWC+w?=
 =?us-ascii?Q?WCG7GoX+C/YNJtI8L+VheVNQ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f916e65-8313-427c-d66f-08d94e29b40c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:32:07.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1mFzwpp2Q64SHPzeTR8LrvFQQdSw5EaEQP/7Z/gz1mXUQe5U6fdleFKggGy58WAhnyLtgz0apCxfUcI1FWeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7068
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reads the various new devicetree parameters to discover how the
uart was configured when it was synthesized. Note that these properties
are fixed and undiscoverable. Once we have determined how the uart is
configured, we set the termios to let users know, and to initialize the
timeout to the correct value.

The defaults match ulite_console_setup. xlnx,use-parity,
xlnx,odd-parity, and xlnx,data-bits are optional since there were
in-tree users (and presumably out-of-tree users) who did not set them.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/tty/serial/uartlite.c | 66 +++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..39c17ab206ca 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -60,9 +60,20 @@
 static struct uart_port *console_port;
 #endif
 
+/**
+ * struct uartlite_data: Driver private data
+ * reg_ops: Functions to read/write registers
+ * clk: Our parent clock, if present
+ * baud: The baud rate configured when this device was synthesized
+ * parity: The parity settings, like for uart_set_options()
+ * bits: The number of data bits
+ */
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
 	struct clk *clk;
+	int baud;
+	int parity;
+	int bits;
 };
 
 struct uartlite_reg_ops {
@@ -652,6 +663,9 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	port->type = PORT_UNKNOWN;
 	port->line = id;
 	port->private_data = pdata;
+	/* Initialize the termios to what was configured at synthesis-time */
+	uart_set_options(port, NULL, pdata->baud, pdata->parity, pdata->bits,
+			 'n');
 
 	dev_set_drvdata(dev, port);
 
@@ -756,18 +770,58 @@ static int ulite_probe(struct platform_device *pdev)
 	struct uartlite_data *pdata;
 	int irq, ret;
 	int id = pdev->id;
-#ifdef CONFIG_OF
-	const __be32 *prop;
 
-	prop = of_get_property(pdev->dev.of_node, "port-number", NULL);
-	if (prop)
-		id = be32_to_cpup(prop);
-#endif
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		const char *prop;
+		struct device_node *np = pdev->dev.of_node;
+		u32 val;
+
+		prop = "port-number";
+		ret = of_property_read_u32(np, prop, &id);
+		if (ret && ret != -EINVAL)
+of_err:
+			return dev_err_probe(&pdev->dev, ret,
+					     "could not read %s\n", prop);
+
+		prop = "current-speed";
+		ret = of_property_read_u32(np, prop, &pdata->baud);
+		if (ret)
+			goto of_err;
+
+		prop = "xlnx,use-parity";
+		ret = of_property_read_u32(np, prop, &val);
+		if (ret && ret != -EINVAL)
+			goto of_err;
+
+		if (val) {
+			prop = "xlnx,odd-parity";
+			ret = of_property_read_u32(np, prop, &val);
+			if (ret)
+				goto of_err;
+
+			if (val)
+				pdata->parity = 'o';
+			else
+				pdata->parity = 'e';
+		} else {
+			pdata->parity = 'n';
+		}
+
+		prop = "xlnx,data-bits";
+		ret = of_property_read_u32(np, prop, &pdata->bits);
+		if (ret && ret != -EINVAL)
+			goto of_err;
+	} else {
+		pdata->baud = 9600;
+		pdata->parity = 'n';
+		pdata->bits = 8;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
-- 
2.25.1

