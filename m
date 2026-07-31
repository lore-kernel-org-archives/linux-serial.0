Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1C3AD510;
	Fri, 31 Jul 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484162; cv=fail; b=fDd9A1hC8/53Fcdm7v2IGiM7ZhiYWBgF82z8sZ/sFlM38+Vy+AFO4A8Ohd9nkTeXRsePekwvakJ9gssjkV4+mLvUE7okBmYfr9en0f+ZTYO6oE2ADXE1+zLbGFHguvL0v1bcwSTiZCv6Dw/Bur1OtqUsM32Q7rKJzcaeYL5BBSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484162; c=relaxed/simple;
	bh=h8wYphgzdCUocvCbVLiZpqw5RJOKM8aZkXxDB5FvkLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4i6U/h4ySmS7NNhUrgrUZ5RSLzSmopYezGG2uDxYnIFg4E/30x76CtPNQvvFCrn7l79vn6wEsm/fT5lfvyRVWw5rpcENmdttr7+w5hVaceyTc5WemSa3qW5C6ckNVJYXZY+OajmALk13djDca0/dsQx1ppmqD11kinJQ99cPRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Z4qvO47B; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Z4qvO47B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC9cKySzBtT1b22EqYr4pJ7hh5AYIy8ANgEhDDHf8CI3HLFfH/O2SlnJRnS7m/pnlT+XMe5Gh8YNdfvnJAppy2NKx9BPvUn5qC4wmuMpy/7zhZabONZ96qipAvrVHuQ87wYeVXIm+tg+hy8otoHO9GmJBpuL/Y5PuqBMPDiV+rB2Afl1unHpfjO0MAoCprOuAXbiDNVSF1TWTMIgNYf+ZuYnosuA+gCNW9tPkmXqJvgLhKIcwwUv6K8ganlza0GaKWrYoZETxqb2Pkd+m6l33liADLHlrZyWjFHC+CqNWIAsr81+uiQ+8tnd2vq//MyUrVfRyzOVS++zJ0g/JeyPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVQMLeUXl+3uXEpJZjOJQQddRFKYTrrOmKvvP10SL00=;
 b=b42z0a+/03IWs9W4nB/TJz8hGFQnggfg4cuMssRa436xoCvky66brY2veALV0dcrzTHTVe7JvToF72PmdqpelyAEn5H1JyZ0Vc6t01YFl6iLSw9oCwvUE6c/B0TRB+9fu9LqD+X69dC6C1xZfWEdQdl7+h2K9R/BnhU3ZMpUT3NUhJg+d5dUwuRwpn/1CwnqtxZs7JIlap4AfpJoY/Ypb4xv7hsm1ghRfZ+p7aan5cLRMHawgK9e2T59Ae+Y66jGnpLrlw2GExJ21pZrWJEbrkGACMy64e0vs6feu7aZqtes22EnHtFcWv1arUMdrsbR92jrQpHijfjZB2VgPWiK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVQMLeUXl+3uXEpJZjOJQQddRFKYTrrOmKvvP10SL00=;
 b=Z4qvO47BCj96PbxG7lCZkmqyRyZg7Vqb8XG5BTNzY1yfAja+8qX1RK7Q4XDN7YOPEINs/T0wOFq2SUM6fj1bgz8cWo0ljSmTE6Dw95tSV7ly60U1t+4JbwOnpgkJODYcs08ymvdXJq1ri220pY0Y5vHIDftciAk7Ik1NOkRdyEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:07 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:07 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v5 09/14] serial: 8250_mxpcie: support serial interface mode switching
Date: Fri, 31 Jul 2026 15:48:15 +0800
Message-ID: <20260731074820.735619-10-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a70d780-b013-498b-0d4d-08deeed8330f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Tk9q+h3zUh5zgRdz9FqcZU9+R/OvT0wr12NTg3doa4ETfFGbnEGL67mKGmtElPZQHIM5hrIH15wStijU/R8GjUWJ/Th1AoqMb+/Ao0bx+vm+ZRTqTmxRq8dVABseh3M2Px/vNigk+ZWHwRT2N1+WMm8xlNesINjfrsy/lZ6AEp3dT0ErlkjiFOtdkcIFL3T9U00jwcaND/Q0cacoinjOeeOh710i6jKR/+lDLtlUclr4RAxfWmJeIQ9BsZxIVgYg388AgyTMiNdb+9IKw8K0DpMza+L1g8LsqNWjhb4ulLffdbcSxWmHeETi1A/fZ4K1nMA/bcL1A/kRLbjBmQjIfRyjRTwSGw2S6Wh3b6WFkU71tIwjPFU8SdKU5z4YFoKH/9osYbNlvOdsPQBbs1T8QuEVibI+XpJLz1DlnekUNO/TRyfyxiBPEiuEJughpP93kmynMB7rY9IOBOItyYBgQlRpRkyH4ufvO/4TYQTZaRb0R87mW6LMxlFJgUI1EexXtBlFJHN4mngZy4vfkjMJo3vn/YI3+ErQP9tOuws4AQhzTZLx0rupoNkhlf8LrK2gmWxy4mA/Bcw2L9K8f9TeTfdwX5DaXYdL24ISDC7MfABkI3PjDKpoPSmAp7x2nwB+7YMdC3LLC9zl6K1j/UvzF7bKFOSKXWIz+M+oj3FrqQIOzmvtSCwayXazue9Hqqo2vYmMWp0glI5gpUTy2+WTPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5JD2zp1HWUNlSVvrK4o5FxkrzJv9U18hjxKw8bJiOKfRVGgOEBy/LMCJikdz?=
 =?us-ascii?Q?BJMQBxxN4TYsYMrZdIAkeWmJuOM+RLJufzjW/jcmgvAos/uHWUsrKMB9TRRm?=
 =?us-ascii?Q?gpJYN0gjgWtRyV7CtxZnpNIVYFBX/FFfcNighX5mDTMhcM2ZBdMyMMDXBmgk?=
 =?us-ascii?Q?DbaA/b1C7drX/YZ1W9srPXBq+YYWKSpRxsN7P5wqZ5cgvV5rVNWrjQGrbiOz?=
 =?us-ascii?Q?XkqpVIvlIVQsw7rTvbh5V+1G5SiZqf1MyTC85X96BXLFpGdzt5Ror2UxW/75?=
 =?us-ascii?Q?bwTkIC7R0uznx3eGasKz3hAqte2newKuawx3HXvhPHFhGL37zD/XHzyEnwJz?=
 =?us-ascii?Q?HKS4LrO0EoB5Jlvb15Z9om5hH/QUCcLxaHjsla0ytOrpVkimyqloZfOYAvyF?=
 =?us-ascii?Q?ReG6Z3wNA2yWFobTMGFndbxsLgEcosQxvItlYPQkNYD6vwsIccZSLxdXkCy2?=
 =?us-ascii?Q?6bMrzNFVTKb2aAhXiRp4c2E3HuB73LpUa7tjRghINVAgexFAGLROnEBxjAuw?=
 =?us-ascii?Q?ThRqaUgQPfSoiF9GSVviBJNbwIkWkFyHZcqaPCCOtVI65FuT98XkhNofR4RT?=
 =?us-ascii?Q?wG7+BXKMFLSae4LYVvUSOPQna5jdEdhuxpNnzjZQtUDejS1O4P6A03H+C/sl?=
 =?us-ascii?Q?hq0L0Q7G1ll4gtIrOaFNAw8DLo+NBcqnQLlPasMoosNn2v/xGvovAc0QTFdy?=
 =?us-ascii?Q?ZOWWC9Jbmq0LqcSLS8flP7Zp2HhzcsSKLLNluTLk143r0r9atRwUnJelAsMC?=
 =?us-ascii?Q?sA6rnyFNOEbs5VDmtyI0PX1MRMNtCq+KlKyGAcmdOByXa2lvznTuFgzCb9LP?=
 =?us-ascii?Q?9s8CicvbZ0l0DYeT1wfBA9+dvtAnTYpdXBwndJxZDPZlyK1NCKDo4m1dZOzP?=
 =?us-ascii?Q?M24MZUfgRmD8C/1bc3OKFzV1IP5rJrjOhqAQI2NhyD+c7UVf4s0RE6x8DH1D?=
 =?us-ascii?Q?Um38TpDsSdf07w5dWN5FUu007C8xcmW9K2Hjys7mzWyGfLEy3Uu72GTLk5Vk?=
 =?us-ascii?Q?HIBdobjHrCxb/CQqWgdbIN2JiP5YHZwzC5DXH2BSGWn87MWsDtrQvQL2xLed?=
 =?us-ascii?Q?yoSNxA7FcYm8PPdgmKF11xYbL+t+6T8/xSMRHcp3EX2f95n1i2K4njBiqEj2?=
 =?us-ascii?Q?3WvsRQZ5mNrZ11uNk9KG+CTLH+SVxyLqQlM5RJVEGjMjyz9dIy03R13hh4+2?=
 =?us-ascii?Q?78zqRqbLPHzr/kgJYWKdtQlfvVoxO9nBuuxxGzx+nKFw+TD+IiZgUNk4u7ti?=
 =?us-ascii?Q?gZH+pIjYGaDhg9jfG6AN/iBesjO5kdvf5BPRVtMmir6stwPS89g8ADBHaIeC?=
 =?us-ascii?Q?6bQ3MB3lAv8+/0WJG4RLT5+E7HWWJ/Nhu/2lnzd5Giawl21yld7Djdd1Q6+a?=
 =?us-ascii?Q?0CumSBbd5MPmBveT++tFab6rWFdG4vEn0x2ejD0Kie0IbUhJcker3MyvQRV0?=
 =?us-ascii?Q?6yIGvt6n5NvF4ej6+zXOx/Yn3rMZx6eXQXl1DuylrcLBIpLCAkbW05ns+5Z1?=
 =?us-ascii?Q?809wXSxtCEp7iq0zEpEzVJgaWQlbPL9TQUuRb6tnZ7tnuM6EtOY7AyOQYq4C?=
 =?us-ascii?Q?5kuGyxko5nzSoGgVyC99E+p/AjlxzEyzSji/G+Kq9UNiH87/ikqpu7VsoLFf?=
 =?us-ascii?Q?shJoaEcpK1SrWcl0yCEOzR7J1F3ptBceP82FPJXsqiv7Szzj/H8QlBOUFXry?=
 =?us-ascii?Q?DWFdG+nsWQw0BXUyzM5ojBs3zeChj/3+rpan6JkZhkizSnKfB1evKSOXw+aS?=
 =?us-ascii?Q?A7iX6Y9omgyTmYdHg0E+XhUkNiPRaOI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a70d780-b013-498b-0d4d-08deeed8330f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:07.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4idtNKMv11i5xhg63eJHT/+hUXqdvSzhFsBJZYDqZeUQC28UswRr/z7DH4hO2fsx9OZsBEY42lqZm28EIgNmybmufbDK95hPTwF2Ka36IMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

Moxa PCIe multiport serial boards support switching the serial interface
mode between RS232, RS422, RS485-2W, and RS485-4W via on-board control
registers.

Implement an rs485_config() callback and map TIOCSRS485 requests to the
corresponding hardware modes using serial_rs485 flags:

  - RS232                  = (no flags set)
  - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
  - RS485_2W (half-duplex) = SER_RS485_ENABLED
  - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX

This allows users to reconfigure the serial mode at runtime via ioctl().

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 45 +++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index e864fb0624e5..93f0af958d11 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -114,6 +114,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 mxpcie8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -170,6 +174,38 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+/*
+ * Moxa PCIe multiport serial boards support switching serial interfaces
+ * via the ioctl() command "TIOCSRS485". Supported modes and corresponding
+ * flags in "serial_rs485":
+ *
+ *	RS232			= (no flags set)
+ *	RS422			= SER_RS485_ENABLED | SER_RS485_MODE_RS422
+ *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
+ *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int mxpcie8250_rs485_config(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct serial_rs485 *rs485)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+	u8 mode = MOXA_UIR_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_MODE_RS422)
+			mode = MOXA_UIR_RS422;
+		else if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_UIR_RS485_4W;
+		else
+			mode = MOXA_UIR_RS485_2W;
+	} else if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
+		return -ENODEV;
+	}
+	mxpcie8250_set_interface(priv, port->port_id, mode);
+
+	return 0;
+}
+
 static void mxpcie8250_set_termios(struct uart_port *port,
 				   struct ktermios *new,
 				   const struct ktermios *old)
@@ -383,9 +419,14 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
 	int offset = idx * MOXA_PUART_OFFSET;
 	u8 init_mode = MOXA_UIR_RS232;
 
-	if (!(priv->supp_rs & MOXA_SUPP_RS232))
+	if (priv->supp_rs & MOXA_SUPP_RS485) {
+		up->port.rs485_config = mxpcie8250_rs485_config;
+		up->port.rs485_supported = mxpcie8250_rs485_supported;
+	}
+	if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_UIR_RS422;
-
+		up->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
+	}
 	mxpcie8250_set_interface(priv, idx, init_mode);
 
 	if (idx == 3 &&
-- 
2.45.2

