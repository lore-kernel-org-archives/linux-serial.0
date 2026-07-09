Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9D3AD538;
	Thu,  9 Jul 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575246; cv=fail; b=dvn5yxcXbhXwlX4q8M6frNblxUA49Ajy/HSKK90k9relAJ6Tq3Hut5yKBLqxF7QR3VFmHbC98q4rq2IATE1o2EvgqvGud6j9a2gVAbCzKQYhhliG7+YsJelnT6tee61gho52TqcxciJTe62xIni+ptTBo3NZ3lo1kJxPd/NJFgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575246; c=relaxed/simple;
	bh=Ef2OA+zAOpJzS6oY+YIlPNVJAgXlYWUcSS/rgsJgH58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecP8ZiEY/9paD5+PqmWrf/cLI4GaQrgUxIaoAu0XVH4Iw2BhoJcRaS/o7QfpEpifoiD072K1APiGcV47l4H1rsSzlKRSBJvjgKJJXObFuw93XxXSLbZiVmHs5VCfgkYIMRBRLK+6OWzHZZ+u/x7E8zdWUM6txDPKAZK9xfdcEHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=CRSurQyv; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="CRSurQyv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5QIlK2l8VxWB00RW72AZJwYtZvGbhfaKHrxZlp2agxFSD6sR7Zpap3ZLHMvvyHtQRp7VRYQeU1GKET1ymR/GCiUkcON1sxOSUBEvMFnOQUalxHKFKrREkjxsJoO0fQKA0kpqf8UTJEmPfQUCxHBzfQqtj/iZj7fuagvbb4iACk76il7NFMXFGanFTGv4YX01gSsU9K13JUOJQAq/eQ3H9XQkg28RbCOSwZbWcORSbsL5XW8yBhbO1ZvYBNpwdMMflM4eRcuW987fjuF07d1L1qobS0lhkKV0h321U6t/rpFxtbT2ZoZqCQIw0DKykVxVHDYCeFfqWg1y+5FX1yQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYwTGHz3kee45akBUjwIeWvYc3w5gcPAdykcgmvKdW8=;
 b=bjAIfHuLQ+XeITHl2vIo+b5hqaR2TJm/vSRoW2FyM4J4JrnqjLM8ckNyTwfY/f1zvCeugAyZR4wMBVkJOyKnW4JXRtmLS/89yXL8RA+iLO46etRxIOS0SLfFBxmptTdedoYc1aeOaUaCi4bHUancO8IavOdTcqu3W4Wrg4bN1UIO/rnZ8KOIMz0LHwvJmLLq8nin5Siki6HNSyrySP1+PSDbWYUdA/2IunIBVq1LUU268pfec/PPPrftttBqNo2bvVUoxI9OQRU1yRsSI37lD0s716vYfckbLRzZT/eBylvpR+KE6ORSzYMI/YPSpJbmR64TlgeyjGhj8MXW5d+NpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYwTGHz3kee45akBUjwIeWvYc3w5gcPAdykcgmvKdW8=;
 b=CRSurQyvmyFBTSzXtsL8EfuI6boz4EzV48k7KvrrCvryiOLyeb1lcO6bHHzt0omkvwFD7glHbIR2W3IXUJnRT0MkrVvw36OXspQPbc8O+coxvUKWjdipWwQz0cmNo8giicpaBcI3r3xGqVUQ9MO985mMNrAmvGeUkxgBZEY8q8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:56 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:56 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 07/15] serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
Date: Thu,  9 Jul 2026 13:33:06 +0800
Message-ID: <20260709053314.435629-8-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 629d73c1-fb27-4a4c-0441-08dedd7bab07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|3023799007|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ppLnGYM4xqCePBQcicEgxd4qtwAGyDTX7GlQGvy5xcbqQq8OPjXK31fWx+EpB1mOn1KbaMLSmNpFbivd5aDbAY9/joiSy8u81I+hMoHBsabPD97PnzCKJzrmmxaqddtnJ8swl0HuFeQ/hnh3HwlEFEehePH44mYEZovC7yEK9dJOombELRl3kynGSONDNfuQJ9v2NypPcsUEr/GQwfCBK/mUjFIql5aunRXLs781kfMbkim1poTdVD7NQW6J7PRrZUSbAnYyEkTxX+sjg9R52RIgv7lFNBQEiKr3dQOO/jBp9NC8SNtSSAkkJiCN3HO95O3i7aJEckA5a/aPxehYzDE8LUhmC34zt4ICHpZTIAsTrD6CDuvNLu9u3noOHXCOGhbaP/1OPv+iD3bIv015f5jP4GYDyGvTGaVcq7fIyIWJ9rxRr3t2xEuFSGcQcz9KlZHNoP7zTDy9Ye4a0J5zUM4csdY4Vn2v8lv5FVIJDD291vCo+JimWB886PcabvMR2y3NfpJ2916eCkVUm/VnJy2OWB8o25NWBbNJLU9Sf5uzSjVv/yl51jFac2lM/F1XR+/7WNcgA1lRrZMeDO+yxqv6GnOqPWCLwgz1PAkI3qZAWr4/56gIrIAE5kzyRYTu4onHc/rOaykb4NELaAVQiWfjl1kXykqFNvK52ClFjwRZ8AEYRopwUf0epmQq7Y6fmcfXL5s3lxWxs4Qu6AFXQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXlQzGCgL4dCa0is2KyfbY3M8SFUMcOqS+jpjCLTaI07bqT+QSzWPetwA9ij?=
 =?us-ascii?Q?kmTyJ4eTWKdU1EkuYcvy7XRbPHZZ95IkKMXHQ6X1SAKh+vRzPkdwESxFsp2T?=
 =?us-ascii?Q?mcdi8K2yn7ClkPAl33ev8RofkJjLF7cgeNI2NXwFBSXDnajpSzChldK7iFWT?=
 =?us-ascii?Q?+eVTI7jiuJhLA/PZwvLn3A7yh3IPxbc1ZR6XMe+2b9F11yEEQSWdES9IWjEH?=
 =?us-ascii?Q?NndZ39gNFe09Ppp/Y33FRBtg7IeurFtMaBJIGYHHIxxkiIb6ULFv1J7yTXwN?=
 =?us-ascii?Q?YJf1w0xM7RNKFB+ib0PZPGjfv62KxYlwUFwCr8bEa35x25Z4f83Z3GtidzTB?=
 =?us-ascii?Q?iOYUtyrN6t7IqbN693I+rMRRzPvQOglFQde5EysAFLz9WStX3XAJsBMg2wlu?=
 =?us-ascii?Q?H9Wtk+iaj1vSA3+/Pk45rU621SMrI/O0rZIyFKohYQp1oFVGnt7SQE0MRqeX?=
 =?us-ascii?Q?5RKA8QvvR24K65QrvCCxXPxUvJe2Tk8k21WGnHfqGs+VdtUwTCzHhr1cYBxE?=
 =?us-ascii?Q?8omzar0I81XlKJ4e3NUjd1DI8enEhRah9MAIKxBX+rh/dHc821zcudVhriha?=
 =?us-ascii?Q?m/fP9ysApNtFayNEtDx9hBfBnf+6b6jMmTX0y7J/Dk1ZE7X8DvSnNsVz9a1Z?=
 =?us-ascii?Q?aEvpBpJkYUqy/PF6nnMkqourAGAidFbPeyI0+epEjpL2vatDvmWbCxJ/yxUA?=
 =?us-ascii?Q?/kxi4yudhNYyUsdPG7h7Gv+aYoMrHVo4QPN046YAQGrhz94sB3raYC5mwiVD?=
 =?us-ascii?Q?h01SzG/gokxpzzD3zp7s0m4jxmiVwYuY/VTH4Xz9YZgBIZ2zcc4bKPMLaIBi?=
 =?us-ascii?Q?OQ/Jxk67pBBb/8lcnrpSmYoTnwZ0C6fqW0vuUOQ4F81IAg6KqybJioulpezQ?=
 =?us-ascii?Q?618lNC5ZpPOemRM/L+PGvXw/a1PB+eg0VQuNoJnuoW8XonVuTsqDHuIj//JL?=
 =?us-ascii?Q?mTVpUzWU/xqfWNKmaFeXSaHwadjGvLU9mDj2NialuESpwWzMoI3wZcaF7pAz?=
 =?us-ascii?Q?Ew8Jq3xhM9TDsmKMindfAGfQK8lhBVoo5tKUhX2XifDcAUcNQV00adOT5jjP?=
 =?us-ascii?Q?D3Jna3c8KS8SVvkkRGqYNpNjnZRRamN2h0NfvtiQIk36pDriCgb78u8JhJiA?=
 =?us-ascii?Q?6YPwNCh4Nytkw/IEuC5Jc9kjUBEn9HFcKzkNinsjANk+3H37zPzZ2HJfMW8Y?=
 =?us-ascii?Q?JfaSO7a1zBbdLSBsfLji7qyMFRNk8um9undpy+SqH/ll+u56C9ppBB6A9AsP?=
 =?us-ascii?Q?Hkqq2vRWRIYJcsZ7CHNsD1qFzp5KRo++2QOhS08cRXEQyyMOJfRa1/lVZbEA?=
 =?us-ascii?Q?NzIW4luFUt0kXc0mll8wiJgUUTM/J4dKtr7aq8ypEgibRzCMBt4fReI5i0RQ?=
 =?us-ascii?Q?j/zo29FN/1zCXaYGu6amHx6RWe9U+4BvJq3KmGW+lKI2NjBd0e1PINioWKoB?=
 =?us-ascii?Q?oAaxkGxvgOBGVWpEkPN9sFhn8m+T6IKkrL0bKaBBVFqGJP0sHvGAlb+gs6mk?=
 =?us-ascii?Q?FIiCz6htZ0TWjoMZm5xBjayApe/SYgqyqjNLLUk1+IUjsao49IUPbx5p0L/d?=
 =?us-ascii?Q?9O/oMRrjCMoqbMraMwvF8vnR3aVD3Nsl0bY/Bh64VFzu9VQUDSP+6Aj2fsdn?=
 =?us-ascii?Q?mGbu376xuz3EvDM7VsF1pjnJPKm/Cdhr/UClALkqO8+pFvdOzTBcEluHF/Nw?=
 =?us-ascii?Q?3hJKUsh36duBxSj4Feo0MKUmTIEbzH2JOssKi9DZ0sFBxFM1jnkRJGtR/XP5?=
 =?us-ascii?Q?wWonW7uqBNcDH72n8g+ocyr3fBiawxw=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629d73c1-fb27-4a4c-0441-08dedd7bab07
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:55.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImU9zdNa6F+nfzCAZZUEMKrYRc8nmyCUkMHYxEHQrXpv0ijsv3ufmemnHHrOWqh+VpQCMdj49LLtHsC7hXXF//UsgehCy71Zi1rC/xbRjj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

The MUEx50 UART provides a memory-mapped RX FIFO data window along with
an RX FIFO byte counter.

When no break or error conditions are present, read received data in
bulk via the MMIO FIFO window and push it to the tty layer in one
operation. Fall back to the generic 8250 RX path for break and error
handling.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 1d2e4ca994a7..01791c56d5f2 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/tty_flip.h>
 #include <linux/types.h>
 
 #include <linux/8250_pci.h>
@@ -47,6 +48,7 @@
 /* UART */
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
+#define MOXA_PUART_FIFO_SIZE	128
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
@@ -82,6 +84,9 @@
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+#define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+
+#define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -266,6 +271,29 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+static void mxpcie8250_do_rx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	u8 buf[MOXA_PUART_FIFO_SIZE];
+	int recv_room, gdl;
+
+	recv_room = tty_buffer_request_room(tport, port->fifosize);
+	if (!recv_room)
+		return;
+
+	gdl = serial_in(up, MOXA_PUART_RX_FIFO_CNT);
+	if (gdl > recv_room)
+		gdl = recv_room;
+
+	for (int i = 0; i < gdl; ++i)
+		buf[i] = serial_in(up, MOXA_PUART_RX_FIFO_MEM + i);
+
+	port->icount.rx += gdl;
+	tty_insert_flip_string(tport, buf, gdl);
+	tty_flip_buffer_push(tport);
+}
+
 static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 {
 	struct uart_port *port = &up->port;
@@ -283,6 +311,10 @@ static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 	return lsr;
 
 do_rx:
+	if (!(lsr & UART_LSR_BRK_ERROR_BITS)) {
+		mxpcie8250_do_rx_chars(up);
+		return lsr;
+	}
 	return serial8250_rx_chars(up, lsr);
 }
 
-- 
2.45.2

