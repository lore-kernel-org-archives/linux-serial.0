Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321B368D79;
	Wed,  1 Jul 2026 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877444; cv=fail; b=Ry4OblENRd+k//M46qjOWffsJlx+xa+lcbInzWMW+XNxtYd6+I4MJTtp3R4xFDkoa5SsNyKcXzyGhe3nZAWHX1TK+ZU5q7wtbn+yWwXU7mPq4Xl8u5Bx3tGLyd5+umfvIVL2vH8YD8vgOrLYLZvZ1uEOj3MvuDwb+n5B2lb5cZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877444; c=relaxed/simple;
	bh=OtQkJfp2X3Enrgbep5OSeUOHOVlVSw193p4E2JHky68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5XdYvPJ9q4EEkx9jHLrlGsKWUc33KVCG225WiEhu5SjJrQ0Q+ZmmQsCdB9dbBfFPB6s33r3jLbhrSrv4va6mYGyd5y/qQyM0c/JyXcf+RVMvl5VJ2hW2zSo+jAgGWWWWGViML+Vh0Oj1ajJHkpWezRBlh/fVxVO/rI8Ums7bC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Yyhbw623; arc=fail smtp.client-ip=40.107.75.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Yyhbw623"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JI6Kka55zQjjqfqDXQCBZmkxdsbnMcJeaWbZqqMuYs1oDQH99kPzFWTSD81XqXhAG+OBUOu8TGl8QPiz2iMnNo1XxNakeKOGWAThxlS9C5/5WJ0K6iYYRqrzKNoKjfkIOQ1wUSDt/pGe8/qin9+bBCnZCxbBZOUIsNuuCNyXbNVJM5rnbWkAwGprhskivC0QsamtaBEW7U5bBXD6ux8+qWM1EGw1MMhxMkh9RA9k8uSPEbGyhagvu10AqzIORioeBh5jHXEDWh9yz5JA9zb9O7/jZOldR0OcCY8++j1Z9IHcpWBS6LlwUXfpZRXYW18be1M0nXuTLbNTNyrz0s811w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzTiveW9fRRfpnPIUSNfvbqTdCYHWHuHepIxWQRS9o8=;
 b=EamBxHf92kdA/5Bbw04D+wVVshsyGkczfOmyCcHmiXcTXqw88p3tKw/diyZJFOSjSm+13K6kyslj6mJd44dhZTR5NmOsyRdzj4ljWqMKDgozRliakYerRRq9Oa8ZGFZMLOPENiUF5UOX5RZpJAvqAu/ErMBQFQyim8qajqRJzjgTld2clMu+CpUeXBdZA3nCuuC+Q2NTHisPTMV9JeRZGShQsi72FRO2kSmIqYQQroLfLwdEzRGu4rH3lBqhMmA73LmadtmvV5g2rrmkqQnZhpAmulwatfR+fnaPog3ck0IGuEaJmHsBWrVSm3A3Ss5BQggw+M6SHDK4wAjsNyUmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzTiveW9fRRfpnPIUSNfvbqTdCYHWHuHepIxWQRS9o8=;
 b=Yyhbw6232n5ri6QbLXvp0bKMie9C5Wor/qxh4zMQcjo+JdsHrJG6T4QIyE2rjqiIwgazYQKdLqJyJRws6bLzY5wxScCptRbTguFcpgS8V3fuOFFz8YgS4QoKQG3CuZwd2v9hg61wdDDm78PhivQHnmpCEyZ5G7UNpc+iUte0TLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:01 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:01 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 06/15] serial: 8250_mxpcie: add custom handle_irq callback
Date: Wed,  1 Jul 2026 11:41:19 +0800
Message-ID: <20260701034128.218569-7-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 248a8641-50b7-4a15-fb5d-08ded722fd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZdpIvTQYVojTKFcQnO+rkP0jS88DuVWCX786htQMHMAM7AjIyvhoymXat8l8tJGDVenwxCDR0jEexMDbjw4CboGQPCteaRI/n76CCrkUR9mHyiSykmJFOa0ym/o4q3y3Jb0ORnZ8KpVsnVx33Z6IUHuCzh79t2CJirdHc5rnwSr/sYnqjVs9ETcVtA59cS2iL285duwWTvhQUOJmxrlG++rkSuhYLAynMCp7iuh5Xlp/726YghJZXcyw+jawHNHkWcqU6CZC27O905WEbOuBxgh/uV+Ut2It9tNgu+9qEN51TgjlYGy1Rz9+Wk8enayRNcCsydXFMeB5UO5ei1IJzVLw9URhztQdGjjdymiAmw2RXzHPTUswqM5Lwk5h5gznzaGZNQ6uW5zpy/i2xVp1UVJcHYIdtLRUNA6kuis2Rqf0dCaS9RVoFlkHZaS1vhqleqdyDgIFMOKkahXepp/NxoPdIpx0xbzOSS1yx/thz+qPwsBVhGbIj65ixsg/WOyjooRCiRKD0HXVOePmcuhQA3SpIySbLfsxo7Ergs98OC35aokg+fbNrf6Zt0AkY1vW1vvh1S27q+c9wB+QhwSDHm4PNwnaQEj7U8hhnXROwQ/aj1a2KBmaVRuhy6U+oRFL4bgCOnNzxu0KiwJ9zyOYLeO+b5mwjBtPW29+GdV4O4SWnXkej44MHPpwxVqPgFqMewZh6n4exVob1dpCPF3P8GI7utfA0ARgFIUmY9y+g1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPetvyRbups5ZwEXvjABXsKzA8aRp4okUwYt1kCwtW65uMH2mIoFFZdRTCx2?=
 =?us-ascii?Q?vGRNvGpyPBMVpWyHXeXWkMvfwpVj4OuYvzSSk1xGpuu5gJ2XkQgKK405DX7Z?=
 =?us-ascii?Q?Aq6eErSBdiMsKiSLnI1L8TdMu3m1pMOnngisku+119q3OeB6JTg28S5+Uf0B?=
 =?us-ascii?Q?oNDeNwC2FJ7LxMi+QlBVrFt/+80IBdFcjms10WBVUTcRiH4xt8ybS/+AdxrB?=
 =?us-ascii?Q?hJwiZHKH5ecMrAryD98wEz53AecisGYD2pZVIZXfT+yC5+3vv80KaooFG9uJ?=
 =?us-ascii?Q?Hn2gvBHZPPMM23F04cIqUbYthzpa6/BWQJslxwYm7jMFAX54gZIadoSwsTnZ?=
 =?us-ascii?Q?5U32kdPudlw/RSRMEP7IfLLAjM9n6FkG7BXrbita1NJQhwk3oQ7o49AWraef?=
 =?us-ascii?Q?IsVqydhz0iMkQ+gyxwv144g/CTvRuOBe6/4F6mCDNquSa1ZX0qcPi4RlcM+T?=
 =?us-ascii?Q?Yan/LtbaQQLrtwy2vk8Z5u5nlOK1OGxt5uiTtZxvRg9YBFc7Umtz/OzPqrxj?=
 =?us-ascii?Q?Xm+YLocrEvQvX2tpN/aaxp0Dd+u6W8KzWDRvQpGv0LzDBzFESIq9n1jfGkF5?=
 =?us-ascii?Q?kk5drCq6g3TEh8LlXz4lzTMhTm8edA9rqh7pme8jpEP6ic3ugWZRFCn/2Oyo?=
 =?us-ascii?Q?En1gzuAFFP+LF8DdFby1wD0dQz3lx8YoAhjmQmWbcapMK7rPJ5FqXOVvSIk+?=
 =?us-ascii?Q?GHAz+OqEMRImWF4Gw8weQ0NIbiCRFiDioUZ2FLUqtA7NrmVl8rw6ri/8nhcj?=
 =?us-ascii?Q?qMIAkLLUXAjMpoWMPXZEQuKMtNifSYUIoor7vqe+AEByzXMRKfWfTpVUWFCp?=
 =?us-ascii?Q?cVbinmR7eGRyLeEDVs0hTk+sTeKv/53rWImtfx+TyGGhooPB+220cn/85HJV?=
 =?us-ascii?Q?bXh/rnthCTLfdVP4rIUtRXbvBxIXHGU4/kxeZmsZgGm+P0YUD6UvCzzqLqlO?=
 =?us-ascii?Q?9SHOSyRH5FjuurJK7O+o+c99oxO5gcRnTYt4hg0glF8ZwUasU1f3cfN0W1RA?=
 =?us-ascii?Q?Icv/cGRJR1viI4d8Xv/S8bZtDB9lUYk56Ctw52aejUv1Mb85fWnPTh7WnKsH?=
 =?us-ascii?Q?VADQM2i+wNuqr2UI0NwbcF1ZGvAXmvsDdNFIj2AFFWSPGRn4x4pwE0ZmWiqZ?=
 =?us-ascii?Q?GPs/fDkdVO0w/L7yxFMIlEQRoG/yf09UwVff8cuNKSlZNCcGLsiPbAjJYv4i?=
 =?us-ascii?Q?P9k8wq/O/KDDppg5ophB2k0WdQYEV/63NchVx93yRz3S2zrs8XHMHi9JHsGT?=
 =?us-ascii?Q?sa2XFGH4xBLrzJRGzda5p5UkKXqZWBeM54QF6nV7BiT8OShJ0539DpLqkALe?=
 =?us-ascii?Q?mnxV7pItkJLxPTAfC4H7x7c1zSrQwxUTQnGUSraFlFeqVWE/L2waVCmXNfJg?=
 =?us-ascii?Q?RfolW5Q/r5mc7snmCF5laJNSxHu04+TGM855+/HGADUPsAdDzhKglxZKpKmg?=
 =?us-ascii?Q?VlSMAcK83sI3Rx/HHX7M4bfYEasYWktuqEplzsYqODFnoGnxSBJzbQDFqHFZ?=
 =?us-ascii?Q?+fR8N2SedEmNeleyabfGXhB2wAKLiEwxL10UV9NZ1DM03gvDBVAgVbXf1iBR?=
 =?us-ascii?Q?nOT/wDPJYnkt7r8EL4nLyEvKZgtl2Zako6IanRXnjqwxKVMBsIlhflFEmmg4?=
 =?us-ascii?Q?4WPo4Pp1ylmURsFbLxcLybjjOfrv2hLnrsUCKtOAkk/hWEYgIKZLCS+tfW8G?=
 =?us-ascii?Q?0J06FWKg8NaRy3kkA0b1Z06xu9vGYO5cXVrIgwtMiAoE/veaOk2QrqrMTfGk?=
 =?us-ascii?Q?c5sGuzY3MSJrtfWE01S2wR+Sqek/SxQ=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a8641-50b7-4a15-fb5d-08ded722fd1b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:01.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Uz2H6q6W6nA2/TV9zvjt3T8RrZ47KPVtBjUBRenC3YGp63exgo0Xubv8YR0v59eigM5lAdO+ojSTHq7n/wMfWkN4lq4AGBlyHrPh4BHZFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

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
index 0cdb7984cbcc..966c8f8cf38e 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -266,6 +266,53 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
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
@@ -365,6 +412,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
+	up.port.handle_irq = mxpcie8250_handle_irq;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

