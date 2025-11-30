Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA027E05E;
	Sun, 30 Nov 2025 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499435; cv=fail; b=XXD2k5GS4poS+yXYPK1OnUdYu+iN5lUKTeu1zu7JGNV8jId2OXL1zvwsTT6NB0js/bbrBNL3hYAWOOmFDoSwyh5b/B6023pGiiN1K60P+dOv+mQSSzmik6+TR4mGI61tUFxIm5vT4ykEwxslKRP80OToEDsriOYY+/GYKFIifa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499435; c=relaxed/simple;
	bh=/d3476j44XzBLTeH0VXiDioeLnxwf/vrYS2h4D/rVbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0S8gG9hipp2TUehIdNyDDbK9MmZekuR4+FmqMilCzeMH2N2OCBrrZ9dWUC4KixUrm+VWlyfAUMOrnLjHWc0MU+y3XH6SqTAD6vanR6h94rDh5tmHGvD2dJ3Qfd/m4XkVgBqD2THQx/hASbXsIJGE252oKIaxMChWEI8R/bq4IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=d07jtc35; arc=fail smtp.client-ip=40.107.44.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="d07jtc35"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roeUVS7kl9Pv9PKo0NmqndxaE4FmI9TsiZBEEUToQSd71ENJ5AEVerJNbJfn589Nsr1yH2PGTYwGrmnNe+rB1+NZMf336OTbGYxjy77QFYAEwO4YmhDmxfB/cJ7ZRnk2F9+I/zR6hQZxXlC++EJqsh6lX9YXTre+RG0ydprugWPJvljJYwQUq73MyPM3O1F/HlGBy5Y/SfG3zYcJ0ppbx8JsldnCucpEeGQCxePMCBuKuGbT4K6UHAb9+Seu6dAumOwUFvwuHgXjl0JXLOmSkq5jjFPFQRpCCSLjrQNPpGW+wrT3sMuKKtF31mlwbwnaVqXkOCx6cL99WNpuuprZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7NnCPTAF0MpDtIV9l6ZfdbTboRa8DfUMVlJCxL14+A=;
 b=VvN+sGzyY4ETsMUVVIJ9BwXIlZK+xfiUFLcQgpeNGeMFtlTQE3/BI51Z17InlbH9ansWbNUAuBcTI4ki4bq7CHEMWNM9VsL8hY0OUsWLv1tJRkRKQMMXQnkHhySJlWtJF0G2LG3FmRI7HhlI3QcZurmjkHPjA36TasD1sunrDcYWZTd0ukWCS2k/KBPkwkeTPaNQn1joNG3al7HyWuJqiup6nbZbzKVZ+hY7SFLfJwsLfAIh4IyOcGtrh1mUprq/hZv2mEh4Rdv9mDxnmWInCB2h9JQ4UC1sSV7EkiPP3Wr369QVFNBVFoziULhpwaA9aliDpdwC+Th662vHDxCTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7NnCPTAF0MpDtIV9l6ZfdbTboRa8DfUMVlJCxL14+A=;
 b=d07jtc352AnCWMbYmU7wcmZy0tasGf6AV5QbBkkD5oRRD57v1NjmypfPGNnMPQG/K25DM7jTRxB9JBvTpds6a0aZNGiGDLRpDZ6Hal8Ojd0LiUz+4JWmrq1ub+UvH9XuWT8qMGCeJT7FbNr7532bwPgY+gybQXvSc3gCiKxIiiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:48 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:48 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 06/31] serial: 8250_mxupci: add custom handle_irq()
Date: Sun, 30 Nov 2025 18:41:57 +0800
Message-ID: <20251130104222.63077-7-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e54e9b-d705-4607-1099-08de2ffd5823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hQcdgKEMe6sWcRoReM7L078WPrKnWX8hM+C+5tQoDu2osZ+nXlvYlMHH2BOe?=
 =?us-ascii?Q?G60fGE2ulos1gVT7UFm//JskU/8ExlQO9UOB4ku207YkEMwIV8oNXakHGY5p?=
 =?us-ascii?Q?Na4nigpbYlmdZFRfTAHLh0BAmD1I79Tq9CEOSXVqu9mHUKsXOZ5bxO7d05jK?=
 =?us-ascii?Q?W6wEJBhnS8flucO5MXOUV1aX3Ju/bq0fS/bSIZ2ZNpa3s59pKJ1/6uXOmyEX?=
 =?us-ascii?Q?XrFkmXKLaN4p9bny6bqN5m3laiRBrnES1j9EnGakB4GVn7q2KMIf1IOt43py?=
 =?us-ascii?Q?CECi/kMdeDvHUQNS+LytxxPzuzBrErvM96zelKIx1B51ecdfUs1lU8JUWV8Z?=
 =?us-ascii?Q?I2RSKWlng8tm10tbWFoh3+ssbR+kDspWWjCBjVazU6ASDbhpuevCkfqbicMy?=
 =?us-ascii?Q?dmX1GpD9wzj6qi/MzKo54bexnK6ojv3ATUx1mNJJGZgmz31Gkl+O5sc8WvHp?=
 =?us-ascii?Q?C2MEWxUJuU/GYq3uwBy7xIRcPdC9U09matwz1+MOQX7WltsieODi3uHIWVOV?=
 =?us-ascii?Q?nIqtFYq1XLIoHNmpNp/AfNINC9DPBT4lipE8pz/s4/fEq8LTsl2IPlqiYq5a?=
 =?us-ascii?Q?te25b96oJ7aCRqCctxwSIO4Bih0RbT1i0rYxd1SY+2Oou7lnxQouJeObj5wp?=
 =?us-ascii?Q?wEOz3O+XjYV0sVuOA4MTyhqV2cfuC6RRmzvC4voovMN8ADUsoa0prDHZsIlE?=
 =?us-ascii?Q?NKaXS169ps3dUWZ0OGGbeMXG8EVZy/UOHbWwYBMn/PrBbaPtM4E9EjUG1p1Q?=
 =?us-ascii?Q?VH6mUTVKaNjjiLEZIDJ/yXgJ/3e8m/FBLTLLdKib6IyuVjZkjIcC2pJ3703q?=
 =?us-ascii?Q?ZAE1HKTTcNPmr10j2O5IFB53H0vXUO06DSJlG7Vmlywey864zXyi5d306Kyq?=
 =?us-ascii?Q?+CcN9IIUIVYNoiu27I6IG8KQK/Y1o3oSWbOXoGdHdD71UYhYMqN7E9+zHl71?=
 =?us-ascii?Q?6ZRCcTRTs5H5o0yu7Pgk4+xSwoRAFlBeO094wz42qVdkUFAstedJwhU6+Hrl?=
 =?us-ascii?Q?AUxHdvNq+YWBOUKL3TXvJ77UDeuZa7c0Zlke51Tc//aUbHVLBd59sYX6yVHu?=
 =?us-ascii?Q?jOzq0ReU9sRJSVuKs8bcOJyIDzfB6dBrTCUL8O5ZJ7g07gyHDYgDbNNlayAF?=
 =?us-ascii?Q?4cVMn0q4897ebe0fni5B4z2B5ifns88fJtUysIi+q1nC3VIP9TwZX7P10K9F?=
 =?us-ascii?Q?ARhYECUte0ZAcvZc7rpwX7h4ZDNxORKMTG1pu0is7vfmi0VaIMXxqrOvZD5b?=
 =?us-ascii?Q?S6sh4DvLxx0K3z1t21g4CLBQEFHJxmTMzALvo7VZzmFjVIvugotoLPkFo839?=
 =?us-ascii?Q?cU44S/RkEWMA8f9JTmB30S5fWQVyUxWCNn/o2WhLxCCZY2h3WqIjJDqrXXNj?=
 =?us-ascii?Q?SlOxS3tmDvW3E+2wM6XMPG+N8wC6uss6cmA4rfUqVYEaM62VS3tE8Bu+tMTS?=
 =?us-ascii?Q?Yk8QTNeRxcIOAl1nHljNxDV3cGUkfuMbatD2yQELQWUBoGkLsziS2XnQ177t?=
 =?us-ascii?Q?Sn3bxTZbEIil8MaKGErVDLlDi4lTae2hDX3o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nfLOxUzGsEXvpWy+X1nNvg+OP/tSBHUET8nPpg+jy9dX+UPehUeDpzmrV5/?=
 =?us-ascii?Q?BkxDV0h098Nf0dn2w/3l3JWOViQck47n4l2pO/7JTDC7arrwsk8nZkfrCweS?=
 =?us-ascii?Q?MLGblhokWuW7IZSABCb50qw5M5XM1BKeLv/mht7ygCR3ZAVBKPK/0xqd3H3k?=
 =?us-ascii?Q?E+4l15e/gSR2g960BCS+KEaJD9iAHIYjrQoxOBJUfKO5DRB2wCv3cn+5aVK/?=
 =?us-ascii?Q?mznZSpLiTZFccZclXpGJCKnqAYb2kWhEcC7B/v7PgMxjSTdUksjJR3sfr4ce?=
 =?us-ascii?Q?T/d86hgdwzPBzBO0ckFlVq0tZ+1rshSl2xQJmTm5rBs1qJyUOwvJR8mzeBqM?=
 =?us-ascii?Q?obllfQJIC9fPI7pljMCi8jcicb/Ymxy6te8mj+ai+D6nYXa/bg4BIl0I3dKJ?=
 =?us-ascii?Q?2HAdSPEjVlEXBHnDGW/5seMQRDPpw9zFVSucEl7G9rY5RJcF1Wok0o8wj2Fs?=
 =?us-ascii?Q?5INhZvao/izT+x7C0OQlV35R8xZWNA/I0fMX5OfbRd2K9WJeZ/73o83o+LI+?=
 =?us-ascii?Q?VG14UyY/6QJP2HP4bjaHpQmRnFCDEPBiobUyOndct3rDh3iBPZXSnS80ry8t?=
 =?us-ascii?Q?bJ8/Mv2AnsBKIQKHQ/Yuwu7kLP+HWGNEwV0oZwOzT8mG0/IP68GKZfaWlwYm?=
 =?us-ascii?Q?+TyQO/6kdEPIQXR33Valdf9/8p28qlizMBcZD5kfZSP2UnSpDNzalDE6AmrX?=
 =?us-ascii?Q?j2i+6Iuw+ARG8rD1+2Qk2sWcvLIwQJTw5XEsb9YJ4rzLMZxab5D63+jxZMSA?=
 =?us-ascii?Q?8salbkMGEgt0ijE+I/PZEM4lIJBc8RPxvp1RZYH0Lk3YQQbvoLArUF3FEIpC?=
 =?us-ascii?Q?vu2JY3qHxWyesxLpTB1af7SGh2UJE+fs8AEIBOBa8BuP8a+O5ZuchNa0JKEB?=
 =?us-ascii?Q?jNgubNy2jJAMKTkGSBfNnu/EU8HotPBWOxxfNtAvE5VrEHQQkEROKDp/wQxd?=
 =?us-ascii?Q?GgpCAREIlByJ8hzqZX4BBVn0vhOP6bq4JC/PXvoNiqk0+rGqbo9GGQSNpc4w?=
 =?us-ascii?Q?p9MQmgw7FT0CKQ6hJfM5cUlnN3n+W8pGSAAcyxeCiFMe1DtyF60ZgLUuwP99?=
 =?us-ascii?Q?8VSpefdX1dcE99iyaW2xsiPMIp1k3o3ETCyk19I5xHaTmtd9llX8XapTvbyU?=
 =?us-ascii?Q?8PrnVLUZCnzmrpobfocuoHQmGhy1HbOnNp6pR5rO3dTGDlJAfwxOWICFbkq3?=
 =?us-ascii?Q?qj5kJIq1hl5hzHdt6HgcyIV7ycpULgtbcsAuLc3P4Z+mLhHE1YA9j+uaYsaQ?=
 =?us-ascii?Q?aV07yUdKDabzkP3bqN4p2242unng+OpQV+Rg/ZFrNPRR02+oxsRrcXjJqN57?=
 =?us-ascii?Q?nfZ+e1K7t9yr6M5m3q3JhBAa00epETCl27J0S4jElloxWVVj+3AWPnT9037k?=
 =?us-ascii?Q?WtF9dIyOD1DhCEzXyyjbR+c4wekIdYjGoNR/xSWEM6Wa7iCWYicTxuxT49Og?=
 =?us-ascii?Q?4ujOQtm23xCv60ciigqD+nLZYa/uiUiJBUqfsImUvmX1TAaS+N11h/TeMlka?=
 =?us-ascii?Q?GVbWYj2W//kfij7GF8SoB7lMhnuhbJnJ3ljVET3XCV1IfYOG17Brs8uxTWeY?=
 =?us-ascii?Q?lIqpZRmWgfoeR3t0Fbdq0l20zwRQaWyUBlDFKcDf8XkDgnMheTl6hv8zotx2?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e54e9b-d705-4607-1099-08de2ffd5823
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:48.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFM7mQC8SsGiVUG/bnJXU8MGGT511puvOmgiJ4sRaJ81m6IfgTxoywuGHYX+vVDoPJZF88ayvRDWHdke5tsixB9JyiCqgAd+jInb7xoqXK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Add a custom handle_irq() for 8250_mxupci based on serial8250_handle_irq(),
removing PM wakeup and DMA handling that are not needed.

This prepares for future adjustments to RX and TX behavior specific to
Moxa MU860 UART.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index 99bd3e504549..376c6d6135a3 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -212,6 +212,41 @@ static void mxupci8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 }
 
+static int mxupci8250_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	bool skip_rx = false;
+	unsigned long flags;
+	u16 lsr;
+	u8 iir;
+
+	iir = serial_in(up, UART_IIR);
+
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	lsr = serial_lsr_in(up);
+
+	if (!(lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)) &&
+	    (port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)) &&
+	    !(port->read_status_mask & UART_LSR_DR))
+		skip_rx = true;
+
+	if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
+		lsr = serial8250_rx_chars(up, lsr);
+
+	serial8250_modem_status(up);
+
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
+		serial8250_tx_chars(up);
+
+	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+
+	return 1;
+}
+
 static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port up;
@@ -248,6 +283,7 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxupci8250_shutdown;
 	up.port.throttle = mxupci8250_throttle;
 	up.port.unthrottle = mxupci8250_unthrottle;
+	up.port.handle_irq = mxupci8250_handle_irq;
 
 	for (i = 0; i < num_ports; i++) {
 		if (serial8250_pci_setup_port(pdev, &up, FL_GET_BASE(FL_BASE2), i * MOXA_UART_OFFSET, 0))
-- 
2.45.2

