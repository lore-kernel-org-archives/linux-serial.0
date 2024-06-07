Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E8191499;
	Fri,  7 Jun 2024 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760640; cv=fail; b=SacT4vXsYrjZnUw20itSDA81jqV4o18HAZ1Zt2DRjRi7LryWw28IxrdUQfZWp2xkcLbu9Z3RwXiOLWo2xRY/hOqisUDNHxE/4mRRb+8G/bP3TuOHIps0cPSKdWoQ+McsGzB333JtZBE6Ms7cAcEf1hx+J6N4CUq+PfVN7hnzbQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760640; c=relaxed/simple;
	bh=F9VaY+pV5mt4Nq2N5KL6cQg6RWcKUAZSkfGDPHo0rJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFcyVzVXl8o0hBC+q8LSFyumFHpuV8pQeUhme9LIEAqFDmxeD3/Z5MM3i3tvHakf3v9Urm9FhSx9qEncgaJi8HiU1y5cixz0c3VN840UWlFPAWRw/bqD2WXPc0c12MdelZL7hNPoF0B3Ikas4JO8JfGxEaHIEVGM6DHc6IyS8D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ODQXFCM4; arc=fail smtp.client-ip=40.107.215.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ODQXFCM4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjpJHHXk4D0CUlf5tSQRb0e/nj7AxSJjnjwvoLPZ7atKkPa5+BsBNPCxwwD6fFykFOphthceVd6Nf0urI/WLE4+W5+y9XdibcEZw0+fRTO5dkQVTSQlvTDczjeW86zI9QiVy1iIqILVqmbLIhQe+T0pFwoMgiQI6QloHG5MdG5B1+HCUDGEvKL6KPyuh3HClHnfTeWP0kROJ06o0rqnty5XNnLed+bx9sNpfdYExLZMYsYRFoDkRrNFicQSA4DjEMc3iqPtoI4EsFBY0dz5hrvFSkAu7+S7gJ28M4gc+RfGNLj3wIFZnAO3+C56XgrgJUyqpQTQkDWZjjzhBEkr1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3dPhyxohBs4ZLuwE+XKON4Z5J4p62gp3GkCXG2f9qc=;
 b=fLbQ+9L9umb/ZCnjnhDaE7/27PgXZ8Ol374ZV4/QkHGWbF/DdJSN3Kuoximw+q0KmWyWeefd2UUY6jCHNtY/DZQvB0X3oERha5uDul8uP6mUcNn8b5OOPSAA+6Gp8bClHCX74VqAZ0TZdqbWdZY87aOJIiDigK8WCiI+AxdKYVmSGlIyRmPXbGgW2y/pMbcVyZwAzWlmXOVUOD+QEuSFkn/fn6Cir5ft5XtZ/DrhhoMyJKLg0+8b+XaMVCdF7U5+YUu4FDIJtrse/Y1zjIonBluFgoJXhTUYw5BlR9RDylvL5IpRq5d0oevvIEVocVg4gxZkX2tzer8zOMJ1K8CJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3dPhyxohBs4ZLuwE+XKON4Z5J4p62gp3GkCXG2f9qc=;
 b=ODQXFCM4itupcA1wtqWNDxzAfeB9s1XBXqmBj0MiuP7gkBRGMRh3T0XHOWR6fhT4+gvClHVePj0aUKtFARM9KJdeZAQsrxwnmWUaqTMfcrEXZqD1NZ9HvXwDU0phqoVlMkQRYSSyhTPpHX498BuwLzCoqK8gLn3BUXMWprqPrSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:49 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:49 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 5/6] tty: serial: 8250: Add support for Moxa PCIe boards to switch interface
Date: Fri,  7 Jun 2024 19:43:35 +0800
Message-Id: <20240607114336.4496-6-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f167d30-2afa-4679-52ca-08dc86e7192b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uoTj7BhYdpzYu132bXT9X+M3r3xeY8IFgVqxya8IKYbOHcATfJ6bPjiEHo+u?=
 =?us-ascii?Q?wtwk/6OF/1YdH9CYXKkxCm576lnILXhQop0PW3AEBL6Ah2kwE4EJT1pBRbRr?=
 =?us-ascii?Q?y+yX5Hpci0ezGDE0gE+GdWF9LbHBzTGLwsM5PP/rH8sHGaOCLogfDa4Zr1y1?=
 =?us-ascii?Q?19DJWUmj2IICbl5qG57/HlZIMHE/M2kd1hR3uZmAbLEzCOzuSiq0Qmaxj/bJ?=
 =?us-ascii?Q?Hn9QJg0W5J1/h6X/8mDwAVgDpJBdYPb3s1FmsZfMpOTRY6GF+d4yAgjwqaXN?=
 =?us-ascii?Q?3pkXXrpQ8TAmrAXbPAp2m1VH5YeOUU/Wz2BO2RS9ZW5wrAiLzq5G/0iFAczB?=
 =?us-ascii?Q?P02RSqIz0Fy1uONtjDuqotvkrdan8Rn6l6YI8dGJu/wN6LRkuDTzk0u2WuLu?=
 =?us-ascii?Q?WYRgDXqDD0Ov9P0lsPjMVe+0/4OXmRAFBKADKQLbCGcEIfszkbjctSAbpiIl?=
 =?us-ascii?Q?WrGc6FMVHFwqA80BOowWiGHOHxuFBCajH9jk91REfQ/VFaP+wZwh66pE5yRF?=
 =?us-ascii?Q?mtwVqO0dBAEAveI+CqIMcVSBeaJ+9IYrrd5srD1aYv/PJIYSkEArA7pcd5Oz?=
 =?us-ascii?Q?rEMf5Fcqx9ZUBVbvNgec0VlLP970WcRJxkl2H3WOZZLZ6OeL2vzcUVXldHSJ?=
 =?us-ascii?Q?vgQ4qlR8y/qW1CeczCffh3Jgl0ROLsF19WXxfpFcDWTTahhxm5ZCPX/Vn4Uj?=
 =?us-ascii?Q?+5q50Rm2TabTPuoEj53J0Dg3/uYed89C6m4wVHCl4ED7FmyktFRfXyD7/Ga/?=
 =?us-ascii?Q?rADxjMbsBTf84wl5FF7shCDR+ETzTZvnRlrpVOy3eaUYcUGBhU/8CaEmYDfr?=
 =?us-ascii?Q?uAH+e+mZYtJO+CawGM9WZ9LkO/DMtHf8vdbhb8bMKriyeDxDXrzn30sdwqVX?=
 =?us-ascii?Q?CDiEDRLXMIl06wZAk9R9ZZrFRNw2rmF2y2W4Aod92JV2JsuzXgW8d8+Xo2JM?=
 =?us-ascii?Q?LD6xu2nfGekuIiKrHDra6KbR0Fbq13muwgCi5Zdtv2zPrZkkCwT9YrMp9Kfz?=
 =?us-ascii?Q?nuAwGZ/9+6FyD66KeLmgYjNaEqLCtRaj0+0CqmT9VZkSQmTaPAkyfggMskgn?=
 =?us-ascii?Q?LUNfKPgrQ1tWwwbU0pRjg7VHWCYNC9yT+AOao7WBp8LQ2hf9LzJdPitAS1zJ?=
 =?us-ascii?Q?AQst2IGTNDMKVWReAVJht12a0EFouS3dcDILx9c/cC1ej5TfMQ222jimITdy?=
 =?us-ascii?Q?wtzVzD0uiTEzJPDsPY9CmtY5VBFgHJVB2zI3EUjn//TCtjcSZO3SZ4/odlfe?=
 =?us-ascii?Q?ZVYsEGGezeId30m9yw9IJAS/K8BSDzDmw8D+uDWCHyKdQ7GCa/37yU4RCIHh?=
 =?us-ascii?Q?sAuzhVPaSt+YJkwEwhQV044VorlCRzH/DHRGe386FbN43Ky6WMDmZzCaL/Va?=
 =?us-ascii?Q?IFG+aiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Se63jfOWaFb2afB1Erg3JNpH5dCHav4YIw70rZjQFrbq1m3ezs/t8L01nFes?=
 =?us-ascii?Q?rml7HtHXoD5y7j8x2LCccgXwFkGEsntydY5STnyohu0ZwRw7zUt3Isef2F86?=
 =?us-ascii?Q?ryljOEPXAHao2PBqxPSWO5w5DHCo+gBIuinHh6g/ZNCGb+Iqs9uiuz6UbEkE?=
 =?us-ascii?Q?0qdgl/tuS+WwOh+7KnLRq40vhoO7zmGxW8GHYGIuTxhnIygRBjjFSIo6NfQJ?=
 =?us-ascii?Q?aA55fUafv8izN6cE4aguDe8NtMHoI4n+zP0NDwX+W6isR7dMjGKhUVifEUNb?=
 =?us-ascii?Q?bmUba1JnsiEIxzsxTPSv53HfrtO4VPM3l4/zB6g9J1mfzwYSvnek8qcKmoYG?=
 =?us-ascii?Q?FW1pyqyaxFbb6LG2ULVHdUT8s3xFL1TvLVrzEG1Sw5niyl752B1ziE2QEwUg?=
 =?us-ascii?Q?IA5bOYzvQZfAE1egyV8e6+CeWyv/UYnHjfBIyNC96sABK3aVjujdBIwe9/OH?=
 =?us-ascii?Q?JgOkeHxjXU8tGpdMw/3dvoPBlohdtd8ZAQVQrFw49EN6AfO3XiQgk4atrty6?=
 =?us-ascii?Q?dTtzO+bhbQk5LY656xmxXZD+wygofTytE1pthv42w2sSm4wAupCQEUr+iC0K?=
 =?us-ascii?Q?IXmJmANZ0ik/CUeYhl6N7IFZiCJCecXFsKrYLrE6EE1VDSFUlHC3xVb0O36I?=
 =?us-ascii?Q?biL3LpG78A/MFLQdsR0DZEN49z/qRKMX2exvZQedMEWyVlxaSgkQ80l0xl29?=
 =?us-ascii?Q?QSbaFz2pY8PJ7zw3/+g3LihwPbMVHSAAk8dGlFHovPuzUYl+z3i9owrWhEPI?=
 =?us-ascii?Q?NYcdPpfVSoG8vuUN2g0TAMrio3nT+j1YReZpF7ZF41G7njXbXVtLuHhTtYKm?=
 =?us-ascii?Q?jsP4XNpsQMrnKN9QRsechjsCvhCvNeTw4dOJsrFalo8KUGfW3wHyNpWbvdne?=
 =?us-ascii?Q?oCrDUDdfbrD0DIiSWfqr8REdoly1x2DO4Xjjrw0RlxsH80c53lThVrxRtjdh?=
 =?us-ascii?Q?AUucqknsNHVLaKLroOUNBhlNX0kSUo4FUdX5H9FvorLSOV5SqyvQ25wLV7qO?=
 =?us-ascii?Q?wcvRianC5zl4oNeYrPZ+HtfjIexauJFbpUOKXAYNoi3JE/nGqge3dkwuSqEq?=
 =?us-ascii?Q?Nn7Tqr7o0zXqajswK0iW6EUdu8xFyUJh2hwRHsazt/1gEPocwtRkBkDQpFWZ?=
 =?us-ascii?Q?4LnHgOcY+ta+vU34RYjSGGxHnmv5SMBGHo9hQ1ewKTXR/0eP67FwJnXoyYFT?=
 =?us-ascii?Q?lNRm8rv37NKmUyM5AnFxN5rfx4WQ31EtGsXTVBgN7VrwbgiHkI+Xm9aTSV/i?=
 =?us-ascii?Q?VYq25ea3Vvp7bkNjNn1KgqCNIF2BRRhBGC+LrytqjCES/RXQVvS7yKpw0MfQ?=
 =?us-ascii?Q?rTgXiGtcD5QAk8O6dDt0jPoT+DvqmStiTX14cQhQ3mNdx7ZMhZREWKFw/ZAM?=
 =?us-ascii?Q?hsZvW7ESr7KG3lwkNAgFV8GZoBcLzB/t7Wgzw6Cba0w/lidNP9aqF2u1XnU/?=
 =?us-ascii?Q?THf0v0M1I/SzOljUAuxew2wxJmqp1Xn5RMMzDsJ+qy2towzEIK7eN81WPE6g?=
 =?us-ascii?Q?+ywBrgMlmp84yVjV29h5q8Wnb/7QSJuxc4bT3cH+GdheNNXus4JhnvMXQH/O?=
 =?us-ascii?Q?gSWJZkTNRXqTt6u9DWlrRt9He+5Zqfdouck2v6lvbFbtY6KfA4+dQpqf9EMC?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f167d30-2afa-4679-52ca-08dc86e7192b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:49.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP/5iJRWJcoRSSL2BqUePbyr52cSQ00oEia+QvuAfKUpEkudfWys6tIN6ggkhUMHzW5HZJ8+0GnYjOrganCsmZYVHc+k7440H7HFBtFtUik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

This patch adds support for Moxa PCIe serial boards to switch the serial
interface by using ioctl() command "TIOCSRS485" with the flags of struct
"serial_rs485":

    - RS232                  = (no flags are set)
    - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
    - RS485_2W (half-duplex) = SER_RS485_ENABLED
    - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e4e6493a5497..e2fcddec9ab5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2010,6 +2010,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 pci_moxa_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool pci_moxa_is_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102E     ||
@@ -2078,6 +2082,37 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
 	return 0;
 }
 
+/*
+ * Moxa PCIe boards support switching the serial interface using the ioctl()
+ * command "TIOCSRS485".
+ *
+ *      RS232                   = (no flags are set)
+ *      RS422                   = SER_RS485_ENABLED | SER_RS485_MODE_RS422
+ *      RS485_2W (half-duplex)  = SER_RS485_ENABLED
+ *      RS485_4W (full-duplex)  = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int pci_moxa_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct pci_dev *dev = to_pci_dev(port->dev);
+	u8 mode = MOXA_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_MODE_RS422)
+			mode = MOXA_RS422;
+		else if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_RS485_4W;
+		else
+			mode = MOXA_RS485_2W;
+	} else {
+		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
+			return -ENODEV;
+	}
+
+	return pci_moxa_set_interface(dev, port->port_id, mode);
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
@@ -2120,9 +2155,20 @@ pci_moxa_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
 		struct uart_8250_port *port, int idx)
 {
+	struct pci_dev *dev = priv->dev;
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	if (pci_moxa_is_pcie(dev->device) || pci_moxa_is_mini_pcie(dev->device)) {
+		if (pci_moxa_supported_rs(dev) & MOXA_SUPP_RS485) {
+			port->port.rs485_config = pci_moxa_rs485_config;
+			port->port.rs485_supported = pci_moxa_rs485_supported;
+
+			if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
+				port->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
+		}
+	}
+
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
-- 
2.34.1

