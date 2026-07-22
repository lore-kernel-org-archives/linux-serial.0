Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D13E9F8E;
	Wed, 22 Jul 2026 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692021; cv=fail; b=I7/il5j+mQqUz2upPXg3I0vbstLix9nqjCLgkKnD9UJgvyerbpS5FREtgHBKqEscmf1SFlzuA3c4/d1kaLwqo6FNQFqf/mLKburufx2TRYTWWeM2NHK/RQTqKmC7f1JeswmaUql42SUsIk/ACGTpCI8wQjXTrTj4SzqGhRnR0Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692021; c=relaxed/simple;
	bh=JBVv4XR2/V8x2lEkRQ2hU9oc5J2MFu9Ds9YtLSYQ7Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKiOWF+APgstzGMtfoXem6OCRUAfc2htMje8WOsSW3eZ8x3XMkZoQgthRb4aacwmnmTYDnxzZ3vhe5bWLzP7ve/3VlYnO5hf+IS4DB0z2BbUW1W2QyecSk1PFSUdpUUNss2MDQQGYeaQ9LFpfHRAMg8T4dVqW73Xl+k6onB1clA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IHle0Ejz; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IHle0Ejz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdEYg6Em7vKKhkH6hTxQB8V+MDRc3cW4BQqp12z5OmzeZrctYCb4nHeFh3jcAevZ5KktSxCSyxT9jLItXtWN2hZ3Df6I8cvjgNpxzu5yywKlTtCivZA4gRn9HJXCJYoymO+6SXh5GqJV3BqluXQUACYl76z3Du0g1VIPcRiNXhXY5RrjRl7Vb6q4zknj9jfsRWwaIhxVJ/Fn9umw48mBHHDVKXX8aMEnt8jTP4GcU75thNfneZxyN6t5CP52hbl7qeMZ5itNg6ciBnCIGsq/sCJ8I2X9XgkimHrxCe8Qun+pHFH4IoxwMEDdw3S0aEMkyh5mCTvbiKoP67QMHPUt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+aGVhrOI6bMbWQ+jyup82pLEm06n0X3E4QdbpW4kgU=;
 b=Q3oql+rzcG4yAFzvazAlJBSswO7T5mkzbZajCTY+WRL7gVs3H6+I+MdCw0Tne2vpXkVnFYCanLKoen9EzEIXlMRgHCpVPQVsUv5NFCnLBwoPJ35sHEsmIad6UWHNP4mcw2YWFCdWwrSxkB838RR1L0eZ76no0oaxib1tV+/Q14U8owsVQ/QqngFmF/TH1IeAzsOlNzJtLu6t7814vQLUvfsvggB6czXnJxSLur9SO7wGT7m69VshBa2us4CKB/a79CkrIp7vdL6hvvStIRXj4ecb8eMsCtJsr6E/HiVtVwJ1ZGZ4TGD5vdFfUchwmzRpXs4/UhJhrVfwhhrca7PlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+aGVhrOI6bMbWQ+jyup82pLEm06n0X3E4QdbpW4kgU=;
 b=IHle0EjzOGQrNVctRp66FpbiClTm4y521+B+QOAguS21tklAKcZnwvowCfitNvT2AP56dYO3u69aKthYfoeLslFp6OoHpODOSiHFoR1tDBw4gexZRAOakvL//KBvmk4pkT+Dyetvh0AHcEORi88SabzeUi7VnBj96Euzd+ijvc9xzof2+8IZEWsq5cvfVnJxUIj9orQVbBUi3BHCyLGz/EndRnnrnPn5fU0IuFazfHEdVv9TgFZMRD1v8S1arcuoh8u5OWRmkTfANZUCs+Hr1YZrd6KZfXfeu1AgVbMvZgnzr7Tr00AoqzbTWdDHpD9DXRev8Ic/LdQzMRArBxwdAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB8863.apcprd06.prod.outlook.com (2603:1096:101:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:46:53 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:46:53 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 3/5] serial: mvebu-uart: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 11:43:31 +0800
Message-Id: <20260722034342.316755-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722034342.316755-1-panchuang@vivo.com>
References: <20260722034342.316755-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b1946a-25a6-4ab8-d5d1-08dee7a3dec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|52116014|38350700014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	64Ct3SIH230ppppRtwO3E/Gu30Ods48srDAKSk79RRh/D/3ILvwv7HGfeLxR3P/AJwtw4+LcCqUhquL2vUSuxhl/A7a8sudIvhaB34h1ZwT97+hh8rEFdlCJ3KgjhX2CUSEw1L4Dm8mn0zGwZ53sxDslAT0UUctNUsM1M8n5FMTRDHQMZ8VCY3j/N0Q+HLdi36s75rFzORuU+NF1z5/cbyafqqUWQGQL5XidLbj5ObRkqCbqE0JvmErs65a7wUCLSQsTDNEAUn14cxVbE0dsUzAOvpBamxaG4144JdyumD44OlsqLfgPsI1swn30ztN5eo/vR5/mixXekhdzabAGUjh8LZK2tqqyvGZfbWvvnQmiwbDt14X86p1y0Vzoq7uBh09gpx32P25KDzHfTJyLSPj76Ge4RgDJtO9/LS9HVap1m1XgNgcLOkyznxLvl5yszLS0WKzTCk6E2RQ25O9N0EJzOnD5h0W32yQm2YtUkhGdGljtHDJImr/KE/MKxi3w/P009RiCEX3rUjak5d5WJxFg7ZlD/5mTS2vylI98skQt+pUMZQGPwrUD8zA9n+z2lzE4dX+ovGtZPDabLHdYLSzfM5FR2vmU+d2GF65lwbz2VD2E7zOYxEBUcU+1ruh8FiTkuHFEuKHoz36QESa5UYlm2bbdMPl0KWX+PgkqJDRitGKE8r83/1OQT51ciS+2Xh2tigULMzjEJIhl2Hde/Jfci6+bLgH/6QvVqEHnm2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(52116014)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?manR91W7YlAxsJG2U0DRqrBqUjU2oqzHR9sbbe6FGQRhWxLIxwKIVoyJSvL3?=
 =?us-ascii?Q?+oyYMGQyTyk7JEX2cufBgZp/xOqHkRTQa0L3izpIOqto5Xt4PA5wC+GDyvNp?=
 =?us-ascii?Q?ggj0s0tZss2nLPlLbR6AEik1Qhu3XWCZxSgZfW/l4kebjaobLVgjlHNw/CUT?=
 =?us-ascii?Q?VACqY9elFEGrqaDig5NQUVL2nSfeJhLR18Pwig8NKS+22RzRJ1cFnoLHo2iz?=
 =?us-ascii?Q?/irP6jDpqXmjDxIyfZBKD0iZR8BQQgjjfCyK92PY5OADmNFHs3Sjb1J52Iad?=
 =?us-ascii?Q?yMZIs/LVbdXLGEk40rh6VXx3mBWCv1uGqCdOvyqxgtHGGxNokC/xlnidVwPP?=
 =?us-ascii?Q?jVn/TRsi3qv+qckCeBP5IRoIaBIkkiWNM88FtM/gE3VtZ9WJRnvB8WO5fc8y?=
 =?us-ascii?Q?YRGvUyW12yWywjh0XVOhgRGuAluxyVFRQmG0HQyp1N+EGMUp4TuJ10WXix/z?=
 =?us-ascii?Q?+zlyACeiu0ap7ZdWFc6O+gm7RvZrBbCxhAGEiEM1mpfWRXXq6uEvEDhdci+P?=
 =?us-ascii?Q?QP4kxRSYvjWER6xScwys6o/yNhh4F3hyarBHUNXMW8TPo9d/2dSCINWYyPXB?=
 =?us-ascii?Q?6YArCJyIGy3xg/dg7elB6bjF1+I94brh2GF5mxJHeSspUuED6rmOKOzpssJE?=
 =?us-ascii?Q?4PeOrA947MWWlp33FyKh7gRlp7qJd9Q37fCEX9cvpTUac+K6d9iiIa5wCUiE?=
 =?us-ascii?Q?GXFcxIjgQP6pISGJzxf1fHNwLaKQQ9AtX4qb8im2hvAjO4e+f86YM+3QdHV3?=
 =?us-ascii?Q?u1IzANYySEfKaYT+xkDFSpZe5WeEQjV9aL/BMZmP5iBQ4eFFd12TjJv+KxpV?=
 =?us-ascii?Q?zdf+a2io7Dg90nVKKQWod2PipT+G446EP/ey5IvFXczrqFpvtRrQxYavYSFC?=
 =?us-ascii?Q?aKJe8jH7CJqDn0u/xQgc8TPTJXEu55W/m2pQ/Yn8EySczpUBe6YjcP9OzMYF?=
 =?us-ascii?Q?YMGX0nuku92tGmhwY13CPkZj7TXcK0TvLaeK0mcSnda4cduy3vPpUTvqWpZW?=
 =?us-ascii?Q?BmMiGk756HLjwsfUJfV0/OGt8XGGv9q/bjqY7j5cIaDhCNVEycfH9t5RCdTu?=
 =?us-ascii?Q?+yhppMBcGoQO06nwSe9BwjoUiNwhkHw9CP3RjUKkRlcEZ4b/8XflbfoX7B4d?=
 =?us-ascii?Q?vO0zGl8u99+LUE14EJvch8JgN6JDpYz3T7kO5PAVXw6l29+FyUJt06/x7wbd?=
 =?us-ascii?Q?rO0LjxwAhrudlUOUv+QBBt8w6dggbkJ/1WlEJO5KlIZt6dRmo0C98yIdjzSF?=
 =?us-ascii?Q?GCLk49CfWC9UKasUk68jaWpUkcjOvB8EKzkkSKQMAwrzj3VED6bKjBINZT0m?=
 =?us-ascii?Q?G+alWCv7Q6cpoBkbWtDHDmvPOAL7LRkUVWOnseyhiBVAGKlbritQrq5pRwTf?=
 =?us-ascii?Q?Uf4TwpV/2VKZGK2ao1zmIwWFlOFNxea//vtaRJDLICLrKWKdLGWpqTEAB41N?=
 =?us-ascii?Q?ywT1HlhaxPAAbXbrTu6WMrKm1lWhj+HUKhd12w1/rH85F3kAYyehJdIntbSS?=
 =?us-ascii?Q?I6Ydct8gbxN9tjG5gAhgNQQY2c7LQauGZa5FC/5TZWx1yMDeW+EXn7pEMejo?=
 =?us-ascii?Q?n/6GR0KA13rQ9l2XqRz986U6J8VIbHKvaJFrvXxPhHnLqW2T47zoHSb/tcod?=
 =?us-ascii?Q?9vS+9+AKiZWFuIM3JpF++Lwxl55xLdSB73e7fWi8zDFph8bgCK3Ylagnkrys?=
 =?us-ascii?Q?ut3tcE+ekiM0zU7rb+ywobCNxe8dQqvKTqJ5uZkSDhJayk3T/b3pfLzHFZPs?=
 =?us-ascii?Q?sjZ7ANsKzw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b1946a-25a6-4ab8-d5d1-08dee7a3dec9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:46:53.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDFefycnXAJz1Jv6IGcvqQV8dz0AUCwGd5+vy1CQnorDfybrW+WayqMGC3yffvO7vTXzkwzWeW+xjckWIo7+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8863

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/tty/serial/mvebu-uart.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 8e52be2b34ea..33ea496c93b2 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -404,29 +404,21 @@ static int mvebu_uart_startup(struct uart_port *port)
 		ret = devm_request_irq(port->dev, mvuart->irq[UART_IRQ_SUM],
 				       mvebu_uart_isr, port->irqflags,
 				       dev_name(port->dev), port);
-		if (ret) {
-			dev_err(port->dev, "unable to request IRQ %d\n",
-				mvuart->irq[UART_IRQ_SUM]);
+		if (ret)
 			return ret;
-		}
 	} else {
 		/* New bindings with an IRQ for RX and TX (both UART) */
 		ret = devm_request_irq(port->dev, mvuart->irq[UART_RX_IRQ],
 				       mvebu_uart_rx_isr, port->irqflags,
 				       dev_name(port->dev), port);
-		if (ret) {
-			dev_err(port->dev, "unable to request IRQ %d\n",
-				mvuart->irq[UART_RX_IRQ]);
+		if (ret)
 			return ret;
-		}
 
 		ret = devm_request_irq(port->dev, mvuart->irq[UART_TX_IRQ],
 				       mvebu_uart_tx_isr, port->irqflags,
 				       dev_name(port->dev),
 				       port);
 		if (ret) {
-			dev_err(port->dev, "unable to request IRQ %d\n",
-				mvuart->irq[UART_TX_IRQ]);
 			devm_free_irq(port->dev, mvuart->irq[UART_RX_IRQ],
 				      port);
 			return ret;
-- 
2.34.1

