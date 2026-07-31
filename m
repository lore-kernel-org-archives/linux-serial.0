Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013010.outbound.protection.outlook.com [52.101.127.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF539C63D;
	Fri, 31 Jul 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484153; cv=fail; b=gymPlQ04IkRL2hN7i6bAwbqnvbqBSwXgCQDOaqYlXYsTxdWQbtuSsrufbB9tnz04lEyqMHI3cUaaHRRu7wzkt/WBkklCO5aMNtckPXszV9U3oRa00oLPGiiRmIkBmRmy09S8Fo+E+GKTdekzAnO6ztJGZo2XFWhJFZDJleD6I3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484153; c=relaxed/simple;
	bh=x1+7NtEAClf0ZCJ6BhCdeSP0hP0BcbsEBD0kK2KGZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDbTkj11Y/ws3ewhPbYMV9cVJISQWF9yEa+R6iUcssy2PbFfNChxfj4IL+jX3hAyKm1H0Wp1kQRqGpc424SWLuvwQf8OpH3RqgW6Tjqvqi69S6tCDFtXtpCe+t0ABDb35lZaYedRE+HBCfqyTW/691L+H4+VccVb8YWxL+13D+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=F2xg+zg2; arc=fail smtp.client-ip=52.101.127.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="F2xg+zg2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTYmhHu3AD72+d1Me5air7FOHUdmR7IVmuu882gXbBMMb3QjoR0i1GWKX4qJIKcITd58Tp5GwYsH6aY59L27mLSu5moAI7yif3ZDaQsCzf4XkivervPOhoVYBrpa/uo7w3xfjzCrLHe1zJvZHAEsVVPy93Rk/rRy8KQTv6/M88QCVWD+auYvcvuTmQtY3XvE23h8vF7QW2uOuZmabjFbZ3+axXTlFrCGNpJQb0BFkU4MEEs/xYOshx4SLHOQXR9E6iCtjuFcQD9VbhJnwR1tKD3mOHgod0na8upP+FFi46yplFa8kp6Q1mkfSpm2kBniHPzIyBhV7oHHrvPaPejn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3ounDSVp33mnOHfHMjd8wHATtcHYCBg+sR8V0Doxnc=;
 b=tL6Hdtd4/ZafBJjz/vZY2vfer3pABtS0ukEel0lA26l4ykp1udhavR+2jog52k019CTC4+Ubd08CDLl40pauaXa629/A0KHvSld6HY+7jAHabW49NnbdPaej2l6BEzB9B3Ku2xyoOcQtVr81pFSnxoQWwnLUyMPB4MpM1Jf5XBkcr43h8NwrUuM5bDhxW9LroRlnsVD/85ovnYJq7B88W/ruAw19qW/py5f1OYNRSL9St4dchelLa6itJcGa/i7VesUmQtlQppkUqUttTmA7w4MzbHHbuR392CUUUh5/6/g7zBGRvITf7WyEBFqaGdOSTCluUHCv08p9czr4feX7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3ounDSVp33mnOHfHMjd8wHATtcHYCBg+sR8V0Doxnc=;
 b=F2xg+zg2SmKPXAzrrSKLlAouNQV9McvCOt7h07lukPIjYjYD9PFE0oeEEe2tBOv+OvpyTLsKeXUldVQJ5tamUGD/+fiaOpaydEnkNZhCCHYVufUi+fHd58n090cKjsymVJU9ZXwm96JfHYr9Kc1PjHG+t0jWAIj8voCfHGgAnlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:01 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:01 +0000
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
Subject: [PATCH v5 03/14] serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger levels
Date: Fri, 31 Jul 2026 15:48:09 +0800
Message-ID: <20260731074820.735619-4-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6cd4852-b9bb-4b38-41ba-08deeed82f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+velo6GlGdvvAxXDaj8NeI+wK9HShHP6oM3LazoybV0UjqUqxdkEaygIzriqnBkEwsXx3YmfcG9knVsuFrzZblRFr6ynzyGDStpiLsxjn1mTbNznP3jcERTQW5IZrAZd2StrBX3g26yxYuAYKg0Y2djT1bfcxulNAlLeDXymmfbG0rU2II7rUmYrGfccm/7S9J5oANKk5uv4YdWy0ffaJrTGpJuwXqfZoJlGAsFMhHp6Vi992QEKh9REnY4NVXkbSeK6bsmJHMCmnT01ZmkFcHvn3IXsBppdlCaVr0gQoJeqK/rAlm7UnCoSaeAG2AZcZUdxoQiLNZ57RcK6fnAlkbDJncugWsmHPm19jW3bnxE2e9x5t2n8dAREVuUaiKAYPyuKdYfoiqN7DsSGtF85zCpG5yDFn0u+xjzRZag7AeD2pBd4sgCHg+LUMmmWfXvgPN7kOrFF2mQFvSeful6fnXZt47wYwW0ybGDCvQKMoijlQJ18ozxn4gRftrRv7UeszJjBz+2IHGpxEQO9xr2NttXmtmja0fFPO/cDNJLVX9xrVSoUOWsBYcQE0hySFdxIxrkERHtlb0IvIeLlpntex1zwFBFySnygwhKRUG7XjvWNQhExehuNRKBFf52qA7SooF4+fQOUYGEKGoUO+UabciTTK/Da/6lqSW5Ga8dc9ZI3CjLZ1Fq4FitD/ASiFbQjNzo6Qqk1e1fBRalBBVCWsczWqDOa5h9+Z//TJKm12o4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?difHiBrwt9WuOI77hMOdwsiE/SnY7Pe649kUg2IJAeVTsMmdrQFSceVi4g9c?=
 =?us-ascii?Q?cY6o4RaA4WC3WyX5tl/CXV7w2P23mNUdJ6aXodWmi4djAleoKt79aHmWAy57?=
 =?us-ascii?Q?4r1GS84Pk1xk/hNCBu/ErLt5oYneK9Zz96RYXTkk+7R51q7dyYbu7wXJrnss?=
 =?us-ascii?Q?lNH6rkuo1C/YP3rI7BbJQA9xW7s2+X+uuDXAs7YpMQhgJgt0Y8DIRlAhi4FW?=
 =?us-ascii?Q?YGV5uEFULduGkibHLs/+g5Rk3/4ToNUyIjHxBO78BETylGXqUyeJjEm/z4Ci?=
 =?us-ascii?Q?Iork1bekIXRLGQvunVz+HoQBhwmoKA9wLmI9eMqbdlW/0TxnOspwxuJpv6qP?=
 =?us-ascii?Q?YtDDt9Ee+wxp7fNSFwGklI8KK2qoAK+EWrCtRkth3mSNUk5EzpArdaxvZutT?=
 =?us-ascii?Q?qGN2Bpp1o1uefZCQxlFPtKuZajwifLKr3CtHAsKeYSlsqqXksqDUCcjHhCKV?=
 =?us-ascii?Q?vm9AB5TX/HaxAt2IschVZkWxRhNyG36VaGIc5Xu9XIESyCKNaWvIEtedp3ve?=
 =?us-ascii?Q?XmP4fzJ6fttS0bWjdSeVmgB5vrnYtHg7QGwRA9cGWdgIpE5jUW7Pe9tkbvoV?=
 =?us-ascii?Q?+hCPRNexUVWKQ2t7qDXHeywyUpYrCLDuJ9Hz8mefXXavnCtnhPF256ahaIt4?=
 =?us-ascii?Q?o0GDODHgqFK7hl5lu2R0rv40qCTiCBvbMF7qdEoVLxZNiVLOf08hKvNfNBq2?=
 =?us-ascii?Q?VN5ppOfgSm7OxUqq6FR6NgC4FsbG6jIPnE25lkpD8ulSy2DdjNdzwsDuFwKc?=
 =?us-ascii?Q?19XsWYWRZogVQGPJte2q7mKQPq9hz/+5qxTtdikeEfeiq4xKBf+2aY2F6HLD?=
 =?us-ascii?Q?3cDAAaZnPQf1GzGqtCqYZV85RTZ3gtERA5SV5T/3KTmRB+xhpkA/DpFXzCQ7?=
 =?us-ascii?Q?aOu4PApLND6PV4moMEgCmQO5lqDKYMwFqwRzBfxhEyfNLUtf0H5QOCCui1cu?=
 =?us-ascii?Q?s6h7g4ZbbhlfnexnU5TEVX/6ETs1rHmY8Bb2R8My4kpspeK8vkcX/PE5K3Or?=
 =?us-ascii?Q?gGH80pZRYNZZA4Kuv044IwUkWJjYS5AHdUnGRyTFmOP4GScJn1nkRPAzpQQt?=
 =?us-ascii?Q?wgJEPOaetyO1nZgwzMJ9Sfxk8gJ7SplwgIHv6lNth+TZlk2/sa3vWo4GWAmK?=
 =?us-ascii?Q?D5dGJ+ImJFt9P0CGn+a2Xt6aB+MiU3FUNeNEY2Peut+ea/3hDHJJqstU1QB8?=
 =?us-ascii?Q?1+wf9C8hsA7JaHLYAW7VwkmxPULgu/D+XXeFBKVMPVRukjVrwD6GTfHA9S6Q?=
 =?us-ascii?Q?LQk8i8acRiK31Ja/zr4BjVZ2v8TVRWsyIn1DvejbubmO8MAjRsn4tYnnq++5?=
 =?us-ascii?Q?s/Sgl+sgFwo8qXFrW2DGe8GbMQmlzzd7EjM3T+jlFjuikoWZCASfO9GnCXft?=
 =?us-ascii?Q?tWSg0W8prWwCeSkAa7RlyLjEtaVEB3cDAFW0Gktp2C6G3VdAERxvzEAIA06d?=
 =?us-ascii?Q?Mh4QdqYraXRLtlqCs0okq4c2g93laT0/wC2SDEL0j3oeqb/HvDqP9DG3wA4R?=
 =?us-ascii?Q?2g6+W3xwf4KpSGyn8n7bjo8uF2Al8ff2M6viDs1lQbR61gLrQo7yNEduasUx?=
 =?us-ascii?Q?vjgnvFcooyZ6ClGJ3BeOpR9VGToqW8doiSdRhxM4RZ3NSoE4uoxENH4i1Ix9?=
 =?us-ascii?Q?9xoCKiuckh2J8s/5J1Exnj5IeLiAHdZfDohHUkNVHX1JEIm7oid9r8XZN5ru?=
 =?us-ascii?Q?Uica+kHOz3Ey0f8eoxDk3K5yOMhe61mGkdwL9T+ggwZgxDQtcZtFPU367Vaa?=
 =?us-ascii?Q?QsjqNTcaRdqon34V1kdFIW5vnFFrc6A=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cd4852-b9bb-4b38-41ba-08deeed82f75
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:01.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/K1EVMITHOTRyyLK4E5BWKtWIy7c7zDTGCzqOBsd4/6db7+Le9t2PkIVJamTlqgj7cwNduVr2qsoJtU6pfaAgVxJbZ/OkJedbjgsW5DkSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

The MUEx50 UART provides an enhanced register set and programmable FIFO
trigger levels for RX, TX, and flow control.

Enable enhanced mode during port startup and program the MUEx50 FIFO
trigger registers according to the configured port settings. Clear the
programmed state again during shutdown to restore the default UART
configuration.

The TX FIFO write pointer and read pointer are driven by different
clocks. Clear the FIFOs repeatedly during startup so both pointers are
reset before programming the trigger levels.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 9f4374d75fcc..e1d607b607e8 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -46,6 +46,23 @@
 /* UART */
 #define MOXA_PUART_BASE_BAUD		921600
 #define MOXA_PUART_OFFSET		0x200
+#define MOXA_PUART_TX_TRIG_DEFAULT	0
+#define MOXA_PUART_RX_TRIG_DEFAULT	96
+#define MOXA_PUART_RX_FLOW_LOW_DEFAULT	16
+#define MOXA_PUART_RX_FLOW_HIGH_DEFAULT	110
+
+/* Special Function Register (SFR) */
+#define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_950	BIT(5)
+
+/* Enhanced Function Register (EFR) */
+#define MOXA_PUART_EFR				0x0A
+#define MOXA_PUART_EFR_ENHANCED			BIT(4)
+
+#define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
+#define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
+#define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
+#define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -131,6 +148,49 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static int mxpcie8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TX FIFO write pointer (w_ptr) and read pointer (r_ptr)
+	 * are driven by different clocks: w_ptr uses the PCIe clock
+	 * and r_ptr uses the UART clock. When TX FIFO flush is requested,
+	 * w_ptr may be cleared before r_ptr, so the UART can still observe
+	 * pending TX data.
+	 *
+	 * It is recommended to clear the FIFOs at least 5 times to ensure
+	 * both pointers are reset.
+	 */
+	for (unsigned int i = 0; i < 5; ++i)
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
+	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
+
+	serial_out(up, MOXA_PUART_TTL, MOXA_PUART_TX_TRIG_DEFAULT);
+	serial_out(up, MOXA_PUART_RTL, MOXA_PUART_RX_TRIG_DEFAULT);
+	serial_out(up, MOXA_PUART_FCL, MOXA_PUART_RX_FLOW_LOW_DEFAULT);
+	serial_out(up, MOXA_PUART_FCH, MOXA_PUART_RX_FLOW_HIGH_DEFAULT);
+
+	return 0;
+}
+
+static void mxpcie8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_out(up, MOXA_PUART_EFR, 0);
+	serial_out(up, MOXA_PUART_SFR, 0);
+
+	serial8250_do_shutdown(port);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -225,6 +285,9 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.startup = mxpcie8250_startup;
+	up.port.shutdown = mxpcie8250_shutdown;
+
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
 
-- 
2.45.2

