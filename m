Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013061.outbound.protection.outlook.com [52.101.127.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AFD369D74;
	Wed,  1 Jul 2026 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877500; cv=fail; b=J2YH6lNuuDT6SQ6FNyj4hmiAqYRAqLCkca0RhDRBMHjEViJDrDwhn4Bgitb03cF2t3BiuUK/UaVsCH13HrFIGCZFt8oWD/cjMfzXpLzQY5QBasIiXkiusnfMASNotvsdTJTc/76IeKya2VPRldssFC9olPlFDHsBeYgaCBd3kA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877500; c=relaxed/simple;
	bh=0wbijmNj9fxQglf5WTLkHgJ96xIGes/UvtaMYm3+hfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTmJxwqmaw5hBlK95kULe2wwqdSyt/6SAbDjz/vrGBWQBKF4dSDK8oV5mT2kZS/QyjZp9oXbeduOHFa/q/Ra2vkn/fqTHnnjxtQd5sSoF+Rha4nedF9JFjr23Is8oKNISzgGP7sXo5J3RwMkDFh7cjYRYD4yycJKfc4euHo557s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=N6tnUA3P; arc=fail smtp.client-ip=52.101.127.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="N6tnUA3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7Yw0jxCzi4k2mKI90GoqDE4QHQFuIiT2YnSQo49QCgfz+dvOEUZbC/s4SXQGsQfle7XiwEW3LHwEc2u4d9nkOZofQdBwXu4fhCzwaGYk8kOaHm8ajd70P76Nmc1cOn9dTJLzbxJlguItw2q8xL68PYGMTnm3nsFs39CcVYtNEGLzicqLbCiNyfeCilRBJegLlizVz6mFonC09NLwoUhfxYdY6czA/O9+HZUxp8rX76lBb07bTllrSpmmkrima4z6e3NbGjKGAvoJXk23Avtr9p7aFLmkmT8rh6+suV8qAQFn+pKzR9xlHsynTe3B6wavO+XOtAr+4eEwrjELprSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=709bfP96hveDRvelDlD5zCs0VH0wK6ovXj6ygzK5pLU=;
 b=pnn7266M5+YolOW2uFsO0Beb7ZbPbJadkOoR7p69hjKqeKo57s+FKZwuUJ5TSq5+/TdMv1rJHklBLLBbOZ3mZLbrmHU3BVul5n4sS7/hJwn5CVjPYTL2hNWCIa7Mm1uzKkzYR3OzwkUW8IbnGjEpScml79Rxlf1N4iN0Yjv69RUxN8c3Q4hFZy3+beu9LvHjtYGdjz1Tlw31qmVXur13sHQT8dgviUAXkuL9/tIYUBiSuS2bKi4J6AVg73LitW/qzA2E90lpZb5gXdT5OjUUdeoZQWq/39zZcXJwdXwcIXmHbSw3VOMT3tXMkBmxPSFqY9IQk64zak03D14edX/OrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=709bfP96hveDRvelDlD5zCs0VH0wK6ovXj6ygzK5pLU=;
 b=N6tnUA3P9VWpOKy1BVi0yVi9HRxYUBEtnwzLEV1ZQ5XrrAneavDDmdzPd6AGfMloD8vMb5GGc4d4twOa5SYmeGH5Rr8RWtVMlFoH7ET2HmeMvd84OVGISI/FEoXXgtIcgchS3TpykahOalR4aJyKo+UA6AoPiDuH4C1nAeuA5jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB5417.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:56 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:56 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 15/15] serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL
Date: Wed,  1 Jul 2026 11:41:28 +0800
Message-ID: <20260701034128.218569-16-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d29127-a63d-423a-ea78-08ded7231e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|376014|1800799024|38350700014|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	27C0uKapI/E3bqCiE5wbPTJ9dVt2EXGV+fxwX6zsFFY2zSeV1EYeQcmRqdka7ibmW7AQZ++mm2GOCKYqc5kx6DJG2DBmiGNpwS1g/tRo0ns/aYiumsJXFEO1un3KhHhj/WMRUBz1SyhFjc46zeiqXhlBYUtx1Z+n27wKVPj0P8EdavQuH9ePieGsz6BPlEqsKG+74gSQ1Yj0ySxNc+5z6+OTMYykjuIRNzftDwUpgXyGhgGh0oO7mSxAKTIBYbYrBHG5PTSsuAFj40G/5I3gCH6B3uer8j6PoCE5Kih7GOpZhplEFqDJCwsBcdrAE5xy2I2VyA7tgYnp5c+2ymCePYwTYiayB5i0xaEPJa+AM4Uz2HwcQ102Ve/qdEsSK8VNN7YDJPCGfntaiHwYFQ4l5C+i0oXB6GoaBM0kufVhCzZ0IotdksqYPurnZXDFIk1S0w3baegLLjB7eOKR2mUHSdoHFo9ds1yXQ+vf3G3TeR/gD8ygKyD91jF/2bnpGQS/VXlCdNa1YBInisOXdyM09mZTVHw9AtXRG3CZjy6JsZDPGdueu8RhS3NrSHkYLpSHgJ16+iKUbSuf92vBD4PhIyPCcJSlKa5xTuF5W268IZbOD3kXSQgI9ptdfnXwlTC55tQ6UHNPpTUFetahlbbK8YiWc9Y/2e7JtSJBj3fokZzOeFOHMmCOSjbFZZRcsCb4vM/Flrzc36WM8ilwnBKNwL133IKoH0vAfyNekByu/4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(376014)(1800799024)(38350700014)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rn3TmoQDcl3vp5ltonTiiNelIZAZT2Qt2ToPy6buMvRZtic+isfzWs6+WSsz?=
 =?us-ascii?Q?7JaLgkS2UdvI+tlhxRHXpTEkOvxAOrwyqd9NcrKjof/MHInigRto0ZziCwTp?=
 =?us-ascii?Q?4sShKsNWahR7hVuMfmjK/dFNJeTXCIYO4tq/XyDgBAoLe0YGaGO88Gv+IxNi?=
 =?us-ascii?Q?BsxCcbMIP86KDIeRl/aHVPpsu/akNnR0CGrOaaRT1tA27CxhlJiAqeeSYExE?=
 =?us-ascii?Q?1ki8bAx4cSO8BCXfW3IJnMSBjIcNoeaXuU+Js8vqgVDoe4zPeWiw/F5FECq6?=
 =?us-ascii?Q?+3W4Q1ZVeB/ZKjWdxEr6WfP200R7CA5WY3uhHdv2pbsofmVoIOFDqyLKwYnK?=
 =?us-ascii?Q?Oy6o1VkhRBNg2f9/iIGRL6A07ye5SVnt7dvR1DgRABP2DCQE7MYETmaX/bOo?=
 =?us-ascii?Q?4sZxtZmC7FRXMTdTz/DG/Ppd/I/GjvDT8AEAkfET1zoMANgeut/sMvJ/N6nD?=
 =?us-ascii?Q?VBpf2P+RxvmQZ+z6Q3tbuS+7Mzxs3fKTflVP7+7ikFyMfAbuB8dgTXqVmWaO?=
 =?us-ascii?Q?sUdJ/l37bjqjjKGRNCRemTUzehY8+T6bATnNVTrWd2KXTomcTbZlOhlPofbe?=
 =?us-ascii?Q?kBymaRCDU/ZC1qM+jsIGHaxu1VQpuLq83U1UHXbD5zP0oOZcS3GqYW2BqtQ9?=
 =?us-ascii?Q?E3koalCUk2gvjEFkdTC3UK2sFG0sLEnjJyG5IWWJ7RT9HrYheKXQgVD1qj5O?=
 =?us-ascii?Q?4B7HcBI6y2ggxOu4xSn76Bk1ohlVp50V8q76beX8gps767YynK9BiSArRuET?=
 =?us-ascii?Q?G8GEQG9cOnW+M/Z418AmTdNsnnbeUQ+z9G8jZ8gnIlBdf1DXVVScufroRDR/?=
 =?us-ascii?Q?nuVFXKsK5zLYRicBNSUIHP4WcegPL3mzcGJsQZuHYTJfigRX6rnVrehMPa5Z?=
 =?us-ascii?Q?zV52jyV3lGMUmyyjAMwHhXfaeYIWTaZG/yrw3q1qqwO7Zdiz/10duwMfSWJW?=
 =?us-ascii?Q?j/p6a6FhXNRCCahzycYiBRzVi0H+WykWjEeUQbMnJbyzAX+quVaZlmcOzPtF?=
 =?us-ascii?Q?1EweO9GW/USNW5py98WPh5mPYcCuCNegQ1yn5FNcyTAxZ2C+R5s44wfz8oHa?=
 =?us-ascii?Q?6SWGOvswtZ2Sys2KKfQaYEhJfGCrfhZt54M0NWnAktKjAeqhckSjkWGMwxPN?=
 =?us-ascii?Q?VLXPTHFH/DIZ0oEnUNoin84hQUhCqXDOsVAIb6z7yUCy+eJnaZ2P6JVQ20gc?=
 =?us-ascii?Q?ukYt12+fCn2pmoUi5g7atM+v8OkhywxaRZ6BfgJ3w9n2HAHJrRwJxUDXofPg?=
 =?us-ascii?Q?HfCaDxQhqvifXDGt0x6lW9zdOvScCRUnx7eDkfiSIAvgRNpkMDzdu9VTWVWB?=
 =?us-ascii?Q?6E8cpnuOgqcNc8LFR3rdWQEaMKjS8cU3wyNvkPQKCRh6KfGZok8CoCdTbsXx?=
 =?us-ascii?Q?gkrM1p1VVRMoWYyG4iK74rIOFaBAxDSXT7WxSkYq+p41WmoW1vVe12pObCX6?=
 =?us-ascii?Q?48F8+BYWmHsycjToFj15MjIdzowCnp1PSpq7jPLdb+l3GiawCnAyqPlSQAzk?=
 =?us-ascii?Q?M98AXKM+CIfiDCI2Xoura9I5Kw7GRgovkqWiSka2hzm/dYdTeUOBUiAyDaPo?=
 =?us-ascii?Q?L/nXwO2eBVxE3sxoFdPlXn9aC4c/98gfgAWcazG3lo2aLTKS5+QLpxjbLR95?=
 =?us-ascii?Q?ODoUrapMh4IDrjcY6uYD8K1UU4KGnHgJdxad0xHqEl2pjfXwQOcZgO7+A4xm?=
 =?us-ascii?Q?epMgor4HWPGWG1/x++kPzCCYrYVBvCzN+AYdEkfPUj2tM71fj2DQNEnoYwSN?=
 =?us-ascii?Q?UcLNXfUtp6XnEqoBWPgw4swY2Hetahc=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d29127-a63d-423a-ea78-08ded7231e23
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:56.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjATlD5K6J8GrTqQz+achd1PBw0v70dklvKwUcsD+I3jXB0WRm1ntcoQdf6OdWtmkL+f/T6Ez3G3obvX6XLTzpEAk4A6NmhTzaGjPqvFHa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5417

The MUEx50 UART exposes a programmable RX trigger level via the RTL
register.

Implement uart_port RX trigger set/get callbacks for the mxpcie driver
and wire them up to the generic rx_trig_bytes sysfs interface. Store the
configured trigger level in the per-port private data.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index da81ea7970f0..78a7d1994f63 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -50,6 +50,7 @@
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
 #define MOXA_PUART_FIFO_SIZE	128
+#define MOXA_PUART_RX_TRIGGER_DEFAULT	96
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
@@ -113,6 +114,7 @@ struct mxpcie8250_port {
 	struct work_struct work;
 	unsigned long event_flags;
 	int line;
+	u8 rx_trig_level;
 };
 
 struct mxpcie8250 {
@@ -259,8 +261,27 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
+static int mxpcie8250_get_rxtrig(struct uart_port *port)
+{
+	return serial_port_in(port, MOXA_PUART_RTL);
+}
+
+static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+
+	if (bytes > MOXA_PUART_FIFO_SIZE)
+		return -EINVAL;
+
+	serial_port_out(port, MOXA_PUART_RTL, bytes);
+	priv->port[port->port_id].rx_trig_level = bytes;
+
+	return 0;
+}
+
 static int mxpcie8250_startup(struct uart_port *port)
 {
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
@@ -285,7 +306,7 @@ static int mxpcie8250_startup(struct uart_port *port)
 	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
 
 	serial_out(up, MOXA_PUART_TTL, 0);
-	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_RTL, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_PUART_FCL, 16);
 	serial_out(up, MOXA_PUART_FCH, 110);
 
@@ -583,6 +604,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.regshift = 0;
 
 	up.port.set_termios = mxpcie8250_set_termios;
+	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
+	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
@@ -606,6 +629,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		}
 		new_port = serial8250_get_port(priv->port[i].line);
 
+		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIGGER_DEFAULT;
 		priv->port[i].port = &new_port->port;
 
 		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
-- 
2.45.2

