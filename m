Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013055.outbound.protection.outlook.com [40.107.44.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83AD3368A8;
	Mon,  4 May 2026 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884621; cv=fail; b=IYWRNTI9Mr0rIB06MOXL0DCsQsuFKA5SluRDVph6DDMm7Uhn65841GWAOzp8rfSNGyaTIInFjIeKjkuJxIDjpl3k2891apVYmCxc7aZ/6DgMR0VP1F9bcov6B6Xwwww6nVv2LwGtpnJbMAvrPznmo9q1A2pMJv4LhUfbsob77wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884621; c=relaxed/simple;
	bh=9sFkUnpZOf4lFlsUISHLPqvlQ6peziiqPc18gueOIq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6CQjkmWf74qi49bahJI0wgiWP57LwhSrcsUYo9dsdlMFsOj08bX8Dy8mZGi7XQfD58hvDpyv9Dl8vFZ/JVEZbF/cJe6z0rJTp/A8xHIx5BU8Xc5dQx9tBaU000YTTO6cyy8gazP6Q0Z9/w7Le3c4an1gINn6r0XY+RjFtWHAT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=bDhH9u+z; arc=fail smtp.client-ip=40.107.44.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="bDhH9u+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKu9XTPhgZzbHoi6O4aEiWnLR8LEr6INk5Wg63B6RR1l582s6yi7WgMcCSonIYADdZ0tL7+mMkugE56xqsn9wd9vDiB11TRBr0w/xmYwkPK9RK6lUK7VJev4FGQPdwL0wOeVHAACPZSaku63OZ9gqxQdBuUY0ryMP9kgFlvT2F9++QqOvrVPZzvIMj7zSIZ3eWEOC+js3AqqAxyo57Ui94JlgwhWEdb+2FV3jusDHSoNP/lCR4fIB3VvcDlIjvLAhnXgneId1+dRuJXwlDRjslfWAtwGeQOwuFisoKfTaJ4B84GRD/D8ituL8OdBFY5jyNKVa5E7H+/qLJNqCjc1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnKc3D4TFsTjW7cYP48eslv+rfVSlTgJqEWMbJh0vAY=;
 b=l0gwbc3+P6Ajnlu1mBEDxFABTZ5l2APoINscr50zGUULywA5tlqHngSxaWsjedS9H2dobXda1MUl9Vwjva3d0P+CHEoreBFYANNKWA5/RlEmFqhQwwSHSIKkDWQcGBhA6ypjie7jOPmpBHxnEn9NhjspZHU9O1AdHL07Dd2dRfWz483fB9D1Txsaaa15OXqRzbAhVfBeqgfKG8aKMOQthv77Nyxz1VKV4RRfqliGKjE8vqp/Kah4Xg1hqPv0w+iG7iYAbiCyP53eg9c0pAFArEINErCjtAvOkQgvZRL1NWt1cEhDls1/2H0OPOV93SPSffKb0R8u4ODCqcTWNOOsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnKc3D4TFsTjW7cYP48eslv+rfVSlTgJqEWMbJh0vAY=;
 b=bDhH9u+zVOXneFg2c7xc1jmumXgyk+fq+v0lxerVRyvoCQUE/9HlaKkqqN7oQC5weKo0f8H4LosLsp9Xr0RseGNLnZeb33ntkksQ70u9P04pTlkOhPyQqzAFdyEoTomcs8XQCfJICNIDGBwsm1o54NqBpzMLtIOjFr6qGK5l7eA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:15 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:15 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 06/15] serial: 8250_mxpcie: add custom handle_irq callback
Date: Mon,  4 May 2026 16:48:51 +0800
Message-ID: <20260504084900.22380-7-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a7607d-38f4-4e32-3194-08dea9ba2960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	DKpDvPH0QZlENtibAbbh1r4MdNnvuYJ1WnNO2ZVrkDTDRb5sXznAsCGit+4s98dYo0yaSz8jnuCfb6GvXYKDZbfIWyWOOaC3PLU8fhtflnZL+K2a4zzWnUOYNRkFWn+xyL0NRu0DN0fT43HjTAlyQ/O73iWSKwvCFa8yzWOYgqF1PgSIwd9Z61hwyvnAehj6MdmcFBQMNa4ywgDY3KC/KWczdOhyeCemWeR4IsaS3zgrPEEMzQEzicd5U9qS4iQYGW8ARHd5kbfWqheSeM5py+qDxEgQn2dwxBn+t5FoxqO9MsCfowgYOGJcwGg7IbyynTvUr9lSlmcDrjl//e6sQjwJ4+7x0IYpdx5GDfLi+GYFO+joxEwyU3Nk4Z7KRfDmWUeQCXzAGtocPBHeSDlyD2dBbXz6hrzf2ixzus1do/Q8drXAgC2rZ5i3mUmBpikeWKF00s9CC7WQRPOIAPsPzNdwlXBsxz+jykr6xJpKivW8PWoUPGFnMXH+sYEwDDa0ByjUSmsgroCmmUSvJTk4DTS+XbWvJq9+NPfYePjXFl92OlOlrOouOcVjSp0jvzGKZ7+TfSuQoqTSCc0TP7DGVXV2wjMk4qwzVIiQBsywp0p2/Y8AsoxNdoweAwCeT6Iv2Eg1L5UMeV2iL/KdgRjlMKr0WSpCLpXYm2WOvVaHChEAaF7gwoPtJFXecTMRNzdqVYXbhwP3jw70PTBCgxeTWGY2Maca7DZxRiBfiLBh+bsWf0kOu+awoT/EdK3otmJB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pusObHgdlFbjINJJyRW6ynguBj8QmfS3Pa98S/Ce3ZRpA5FYnWBKlmFHAw6X?=
 =?us-ascii?Q?zFCGA8zrAazCROhgx9W3sixm0/HAKodhiFIVWMdnfpiZIOjVrqrsf77swK/h?=
 =?us-ascii?Q?yJTLmO4QZ2y6F8jbyQ5t4fK4rsZ5nKrB+CRPPuK0XEF5xdK1tJa3l84eVAsl?=
 =?us-ascii?Q?XksrtXYoY77nTaUvLcajbuEP5JD3FLdJI2+ActavP8RoQ4WViKCSjmaWRy/b?=
 =?us-ascii?Q?wlZ56vCI3CcaaWfzBzZwMEs8V6NoDh6qdYg9tohmhjK8djhzJR50GNQORPYA?=
 =?us-ascii?Q?shkwpzc41FgkbBXVPQJZjRG80PZb8FYJUDddDMtSAVcvYF3eQpZirMzi9jLe?=
 =?us-ascii?Q?sU63UcSahN55JkpKfvi9xOHu/oduJFO/PfgPgoUtUKoY2UHK0s2+roW8oGD9?=
 =?us-ascii?Q?G4MK58R2KzVQhTdjLQtyMYnIcq2ERAWOqzbfHwudO0ldkUoUrA3kCLFY72WW?=
 =?us-ascii?Q?bIRvIf7Suq9Wfij1a59RIgFbj0CjEoEEtEguS7nVivvuNqvXg457ouVHQBBI?=
 =?us-ascii?Q?89kxIUlol2pjbuUVvIV/QQrwqb6JWEOM9XRJWhL0wOx6uhhNYAMNbtSjm5Mt?=
 =?us-ascii?Q?9AxWYqn9D3JP4k661tKQuFic6KL4Iw5uZ435f338oIRo6gRGSioF1yvhiHLK?=
 =?us-ascii?Q?Iu5rmdQFFu+3yRrh1lnknz20qTeGj8NLgtMcQdqwkbNsdSjyRoM/Ff5w7Eu9?=
 =?us-ascii?Q?64hTiDH/ow9aHeGEMcqragAS89FUAxlikqpt2QhxWcExTpUer9hxTsZRvy1k?=
 =?us-ascii?Q?PM2OUJiVfF6RnpS64NJ8QYO8jS4DL9zLa4kwThxqvkkGFfLRFD6g80+iPLRx?=
 =?us-ascii?Q?f36TGcx2xDeT7YOJ5YpLPBVl1gjDS8ZgwpwyeYZTP1UUEPH9v/y9fQux1MOK?=
 =?us-ascii?Q?NQuaAl4t/tduo22lrxvVIW7OT+oRUMNlys5cE46QEZO4qXqYXvv2LARoq9Nc?=
 =?us-ascii?Q?tv88lRNn7TQyabUVJEznVzL35Fl+Tss/8nkwD2Rs6INLmaMiGr9djreTYEEp?=
 =?us-ascii?Q?wNHWxlZ3CoJnIvWVPX45eXQi7mKrHatspKsCr2R1idSd4h5QpP/rQn5IPDSD?=
 =?us-ascii?Q?WlBvdHTjeC0MsCWIMXBrKEMqltp0MRmaM3UwC4KUxGfR0KklS79hezAVjVZN?=
 =?us-ascii?Q?oT7Hb27IDq3TcecZe4YObtXZjK8R4hV0qWeIr5CgVVfTMUAoe8Mjusog7/8J?=
 =?us-ascii?Q?7+cu/7UvzvjV2VuKkEZbfzBw0Lvvtxw75vLITIvSbaSR6qw2EkLdc+meqmAe?=
 =?us-ascii?Q?MzkrgTdAc//eCs8OuphGtYzbA5+xjLiZ89RAG+6ezsh+y/xv5xDlWzY/rkiz?=
 =?us-ascii?Q?1Km6QFwiOTlsKHiRxWpBqYRkpYm9JfyiCCAZUDFK7fQxefVoeRDuMklu5V8Q?=
 =?us-ascii?Q?sUHPWsmvfTBhA3Afil7GB2Y2l+V9n6IELNbxF+4KWWezIVOn6F5Czcsk28Nc?=
 =?us-ascii?Q?UTIMbiyer/T4jrLHq4U61tvgR7N/PN0zoCzAkNI2+kv2jCx9cu4qnUOwkZAg?=
 =?us-ascii?Q?1xw6rmaHORJCCuXAW1wyUcKxgA+Senqi6K+zag7YPWRtMhoUzrvm6ygeLWKO?=
 =?us-ascii?Q?2dYVHRmMjPXmbOymNfSURIGAqYWtIYeyYlm739+Z4nYppyPmN0gc8e+686+4?=
 =?us-ascii?Q?ey/HxgM2O60QoaqVchqMoFWJmcOBSk6thpCTD6Zu40PCsKu3rJVO2b9k/koF?=
 =?us-ascii?Q?d+VoBtf0tw5t363e90lrvUtmCEh8RRf8PBcpMyIZPWO7EFqnJmJD5Hpn2pN+?=
 =?us-ascii?Q?44xRut0gyLRP2cNVH+B42tIu2hAg23E=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a7607d-38f4-4e32-3194-08dea9ba2960
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:15.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: homCCvJYBEyBxr6TlzU1IMMiJF4PusMdiDI3DWvtI6NzLM/QL2+SuLZdUBLmq2IkyB90vo0aBdK8/TdPSyUT/yag3uCp/8gfQLdaVN9Sa38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

Add a mxpcie-specific handle_irq() implementation for Moxa PCIe serial
ports.

This keeps the interrupt handling self-contained in the driver and
provides a hook point for MUEx50-specific RX/TX paths added in subsequent
patches. The handler processes RX, updates modem status, and handles TX
when THRE is asserted.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 99fd789b7665..9860f2ac2572 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -265,6 +265,53 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 }
 
+static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
+{
+	struct uart_port *port = &up->port;
+
+	if (!(lsr & (UART_LSR_DR | UART_LSR_BI)))
+		return lsr;
+
+	if (!(port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)))
+		goto do_rx;
+	if (lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
+		goto do_rx;
+	if (port->read_status_mask & UART_LSR_DR)
+		goto do_rx;
+
+	return lsr;
+
+do_rx:
+	return serial8250_rx_chars(up, lsr);
+}
+
+static int mxpcie8250_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+	u16 lsr;
+	u8 iir;
+
+	iir = serial_in(up, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	lsr = serial_lsr_in(up);
+
+	lsr = mxpcie8250_rx_chars(up, lsr);
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
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -364,6 +411,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
+	up.port.handle_irq = mxpcie8250_handle_irq;
 
 	for (i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.43.0

