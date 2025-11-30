Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA642279907;
	Sun, 30 Nov 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499442; cv=fail; b=SbHxCIFhRfNKb4K3eRktMiQ7Url37JZ5PW9rS+blxHiNohSKfleqNIUXMk8SSTCz+2UKLCPNfUNJqISlpLk4qiNj9zH29Czkez+EuZM50c3rljcuzVGLF41zAMh1WARkoZCvFGW7Gaka8IbG87ixVmvub4dEhThNuBXpSDNZQQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499442; c=relaxed/simple;
	bh=bg8oXFYVCbg6rPyUYson1FAG5kw46dWNZC6x8iVIPV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhVQTrKWrBKu5eAnVGCqRdbF9XFiEdVQjFITz6gek6wATVrsYKt/18qxjaBIaxjwtXwHnvXh26/H2b+MEghlPfA0HBJsWFunrbTGSTa9gBrU5oCthbnlSgvpQbqCXpjHwc5iIKvmrEhSzBx26u3X+KPYy2UnQ/kqzd1q8vMODHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Ch07YtFK; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Ch07YtFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPXdHKLN34UJ6Q7stPRBDOPveP/lxD5dqv0AVr4ASPgY1vLIEtDUpM7tgeX3e9135ofGhvfcoTBrlKsp/NSsx2akFeSDGtJjNZ5xfwP7nhUbW2i5Qfh1ElS601flULPdPy9jVQRrDr0QYKkPgT7W0FQZOE4BOE98BMG7KZiOlgLHkjGfMQ4oecdlsoCq980aLCWlTI90dtgfpBmhl+36glajB0AOaLCE/UrfKrI9wg/x97Gh1x+/1e5ZVH74tckBVKKHaRPEIseStHWuTBkOLK2HZeJnlVKWG7NeGj7C8alBE/g9hMFFzot6OkLvJyMBOttfpDp/VqkKic+g1MRxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/P2OQ/sxqilOOPwRb9C82y2/Gu+3YyYplvALC/oxyQ=;
 b=BnsI6vlZsXRtoMIysWg92lmUzj3Nkn6/BG3NiWWW460FjeqzzqNrv/mMcP8SSlFreBHNwYLvj0E0WB08T5QG3CjwbrcteWb7O3C6gTkBF9+TcpWVp067o4SsmMtuoUm+hHFpyLuXZwtRZVSQbyffaEipGZDdpJXeV9G7AFkNn9Kl/W3+7hC8gpvDUlaHONqydmZH/33ycLwj8+ucHrTB0cJktyGigRplAeayJ2XbuH6s2qhHjVlQzBD9N16Z0M5tyc/zNP2vL3MbLOXpA/jXtDTWix340bYfr3wX0koEXkNFxkKmLBI8/SoaEC8ie9h6i5rj8CTD0UyNmFaqK77edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/P2OQ/sxqilOOPwRb9C82y2/Gu+3YyYplvALC/oxyQ=;
 b=Ch07YtFKPIH38Dfe6iXssLMRBsxBBMMJagZAJvIh34HxNv7XoSIPdvoJo2ErbOoSjXlGOUGgRvHWr4JPRu5RtrWKXPgLxljgI4lToqzTC3UK5ZGmhF0wcI0tfnyN88gvPtnZ3RI1B1Z5djfoIivL65TxGwkoAn8TG6XAJj/uxDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:54 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:54 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 07/31] serial: 8250_mxupci: add GDL-based Rx routine for 8250_mxupci
Date: Sun, 30 Nov 2025 18:41:58 +0800
Message-ID: <20251130104222.63077-8-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95729ba1-c647-4125-82ae-08de2ffd5b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ioY2V/qw2OxGRRy4lo4+SB/1VwFGtEbPao7LgJjhTlzS2jaEaihYNiq1YzbQ?=
 =?us-ascii?Q?x3+lGBmkvWxvo60qILcf448ikeoek9rmKz2zXVjMvcnUL/DZ/uPh6raiEQor?=
 =?us-ascii?Q?/knS5/luR4OruJJAuQfcC9AHwrwJupyp0MjuL1ZEXeke8yFHIgviSc4rqzez?=
 =?us-ascii?Q?NDl5j0IphK+Dy1KbZVh0qZU2x/JY6QW6QQDlvxDgAm5A6o745e5eSi858FEz?=
 =?us-ascii?Q?9dA4Jcb1Zkx0V0rxpuMfL17l/al6ZU+rSkQS5HZaVBasqJVg3WJ9uApZKpPc?=
 =?us-ascii?Q?3yFGJvHqlShzfVl2QLC20UChpPN2WF3xnWdx6R+x1HIhfhMUzJy6Mxaxwxor?=
 =?us-ascii?Q?XdEStJYAl2TvcmoY0z3/4GgUXMQlukKVEafuVhF7xBlqTBU3VCSRuVISshog?=
 =?us-ascii?Q?SQC1m/H7eB+y6z5112xmTp9NMGb9xV/z44yn0KOAosmjWKpdLaXJHxu8Ijac?=
 =?us-ascii?Q?BUFIajwVWPOQiVbDdQSEe41vJ55EdYnXL34WYqnCCcrxxCQo12SoyGPUIYCO?=
 =?us-ascii?Q?YjhEqFe688vgJ0VAwHw/0cOoyM2sKJQdJdHM1VLR1P/ZJwZ6YaD02Xe798/n?=
 =?us-ascii?Q?b1UaDUiOmGIZyXCR1BMgfZmTfmjOhG00PVUno9g8prNoU9EG76O997/uu8/+?=
 =?us-ascii?Q?Qmun8Wzvk7P0S58+9ZWix/LBgMFO2OvW0UNQy3c/I6sx0Fnaua5ZGyQpAYAX?=
 =?us-ascii?Q?tWd9s7FF/lmHV0NWc04wSzPAd2b2gSZhQwgab9BlkupIDfePKguFIQFFV7TC?=
 =?us-ascii?Q?mik3pU0B7yo6uZ8XiJJ+UlJSQ43DrXa6DKkVgyKqbLdjAm33N7qwbP6UwHsT?=
 =?us-ascii?Q?zb+FdzdKFDHEmhImRlJ8XzJbmjUHlGQ8okuC3+mjPRUUupPthW54tsyd/LR6?=
 =?us-ascii?Q?I7Mfx/LVe6Y5YvibEIdzrMtCulfAqbWpoP+KBZSiY+if+ozdvgiOGBYSW1x1?=
 =?us-ascii?Q?M10K08MbOGm5iphyAGwM1+JN0ac0T8pWcSLWCCgHjyygfFtR2bUppbOjvAXU?=
 =?us-ascii?Q?J2+u16o8jfPvtj7W2NrkIeDSHsSMXIaw2fE9SsFEzhU7vNiUeu/SJpMf92Uj?=
 =?us-ascii?Q?JBw4I1KItcw5w1bPii03/VuADNjkEKODQPKNKybpvKEUC4jfjzmBk5vcqK9z?=
 =?us-ascii?Q?5NlpElGyzerP5MxZHSJlXv++K5ii7xTcYAZYHCYYSWI0MPBQALl6AZQRTLs0?=
 =?us-ascii?Q?h581DS5j2ZqwAipzuakcNEsSrjFk6UgRmcBwWA/2B+ycwHzVx/0lWiK93avl?=
 =?us-ascii?Q?RwLpuFLghz6Yu6fsS3NtmrkjeDb+Jr4ByemJnztwF4yZvcKty/5xhrW2LJfs?=
 =?us-ascii?Q?kX+c8FOchNg5t9gaHoPIC68BRZDdbcz7SoTz7nIumYDoVL70mJnPtP0EK/C0?=
 =?us-ascii?Q?fXTcyh7IHwAYbhH3NwSeGoIqzGWc9IzHfMXjkiB6UW7M3/3AQTGbI+6am+AV?=
 =?us-ascii?Q?U4NRVwvg4e13iAPcu0Cb7xSHIeNvLmM6I9QYjfu4ObgclMxSla4VTHfgKo3h?=
 =?us-ascii?Q?vikHH379kUwlZoIOfqIFd7RgQBsoSDGlgMxo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cwBx368tO7VRgQ+/MNVMbFHL0D204msfGJoYKZG0eyqjBu7Nk5uNpgr41//E?=
 =?us-ascii?Q?s893gdK64ckJHw6pecsr/peV5rDx/bbGfBUZhIX1Kkx7c1hpqH5urglfEiKd?=
 =?us-ascii?Q?CT8auZ04qJA4IAc7wiGEuXfMQlZDzNXLGb3/wp9N3SXwOPpwQLSaMjo8R5AJ?=
 =?us-ascii?Q?Lb7hIyKo/V7rXL3xFyc44JlC8W02eAVVEey2V16lF9O4JO1aZFCTX7qfM2DZ?=
 =?us-ascii?Q?pNZVdnqU93yg+StNsT+6ftp2vdOw9XR9PqeF4xhOZc4Dx1/zZOEqnacPUBX+?=
 =?us-ascii?Q?eokFZpAVZ3GoOkBMJnkm/5y1stq7het19Zwt9T2N8gcK+itOFH7YfDRQtHoN?=
 =?us-ascii?Q?IbNSV91mxnJYTUvVyzG9Yr5MMoM9wovPSs9yO8FR4nFCtZ9N9CBdDbD2AXrG?=
 =?us-ascii?Q?GtZ4m8+4NoIfRC8OEVGb0NOAq/y51int3QxFKUvp3i/oL4u864Jjx6ek2H0S?=
 =?us-ascii?Q?e3Aiu8SC49e34LHAOBizRf95yBAumqiBJzKMq2hcYVAYTAWAPtFnk/8M4WSi?=
 =?us-ascii?Q?GrZpQtAHX45MlJ3Ux1cDgPu7rLf2gEl4uff5U9tWaD8VQJWw4vXx5Zi3G7Gp?=
 =?us-ascii?Q?o3fgxUcuOFrApv3mSyS14GGYWo/kSlOTVnItCQVcF9m/34oXpsWM9T0D3BML?=
 =?us-ascii?Q?saMyr54DQDxdJF5hMxgQfvgmfrYRKm65xlr00RqovnrV3TW6frBXUiazlqAX?=
 =?us-ascii?Q?fNEkSXWfNI4oqo77WgLxucmhE8k8LQPNsxa0Wu9hcDOQc9NgtTxvU3Af0W7x?=
 =?us-ascii?Q?EG/WIfZMHAx/7QyN6YaqMNf+FVA+hPnOqTxhTBLF/o7WQL5v5WGV+pINbuGp?=
 =?us-ascii?Q?O2Xa++fDc1lFvsSmP1xZAoG/8YbsJjfZZ802jr8fDLlJ6fvuGOXbA72CCrr2?=
 =?us-ascii?Q?Iw8b7l2YD7V6jdKfNcXKoRYX0/inpsKi4yh0u5tCIQIdqjhIqoCS5QqUpgXv?=
 =?us-ascii?Q?IwwxdxJwSr+0bJeVOYPIyClyJ+rWb40NChvNRlVr/p7pibTJ1agmhf5QHfSL?=
 =?us-ascii?Q?LQAA5uZdYCLVK2sPn0vCs3IFX4g7fT3uhfBzxU94m+OWBZ/9UT9rfeRsSPhS?=
 =?us-ascii?Q?9Xf6gF2VMCe41FR7uIvyE64BntC0nXh+3Ppf6yUUvABC6arxyhkPecWxwSBk?=
 =?us-ascii?Q?bSKhwNXhLMOTtqhyp5kek61rG8oBHBj6Qp7dVHtgYyotwETiVs/DlLGSSjS2?=
 =?us-ascii?Q?zP3IQw3TxB3dRGDcCJU7hpP8ywv0Af1V7SSEp6JoSxuTnKNqPrZS53zehL7l?=
 =?us-ascii?Q?mMxO1FVCFt7QazfoMw+MQIoXAOviwpdB3DSPo4QsuqJs/YoyO6nKNEAXpLfe?=
 =?us-ascii?Q?uUE2I76KxlxFdPtBdwaEYjijq+MaD2LvOCKr3LHQR7NK6F9KTrcZOOJnhcoh?=
 =?us-ascii?Q?ax3erofZeGOGRtCz9+DY+ppP2aS9g1dh7fpXdr9To8hWjbYoWVbHqwD1x/K0?=
 =?us-ascii?Q?+/xxQSINRfhs9K/lkgakC6z/pN+efi01h2YWamqrf39bh9y3vm9dv9RgWYNc?=
 =?us-ascii?Q?p2gH6izELzz7gKibjggYFC1TALr4VtYoBXuQkY3ficqOv7AGOTYB7kGXzCyu?=
 =?us-ascii?Q?Pk7mSJEzEVwtx91BdUXDSl3IpRDggKV8osjCB6jk+uMibokzCMyVGTySiy8l?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95729ba1-c647-4125-82ae-08de2ffd5b87
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:54.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJNwqFZ/PaK/x/wci3Mdrzl8gniDfpW6JkliALIfihxhhQJ+8ZUjpe/qgU7Ut6k2d3c22QGlN/RxIXQtwlWeZexntimkbjLe1bAH5mqxMQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Introduce a custom Rx routine using the GDL (Good Data Length) register to
read multiple bytes from the Rx FIFO on Moxa UPCI serial boards.

When no LSR error bits are present, the handler reads GDL bytes from
UART_RX and inserts them into the TTY flip buffer. If error bits are
detected, it falls back to the default serial8250_rx_chars() handler.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 37 ++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index 376c6d6135a3..ab6042f157c6 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/tty_flip.h>
 #include <linux/8250_pci.h>
 
 #include "8250.h"
@@ -42,6 +43,7 @@
 
 #define MOXA_UART_BASE_BAUD	921600
 #define MOXA_UART_OFFSET	8
+#define MOXA_UART_FIFO_SIZE	128
 
 /* Enhanced Function Register (EFR) */
 /*
@@ -70,6 +72,8 @@
 #define MOXA_UART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 #define MOXA_UART_EFR_PAGE_MASK		GENMASK(7, 6)
 
+#define MOXA_UART_GDL	0x07	/* Good data length register (enhanced mode only) */
+
 /* Enhanced Registers Page 0 */
 #define MOXA_UART_XON1	0x04
 #define MOXA_UART_XON2	0x05
@@ -212,6 +216,30 @@ static void mxupci8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 }
 
+static void mxupci8250_rx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	int recv_room, gdl, i;
+	u8 buf[MOXA_UART_FIFO_SIZE];
+
+	recv_room = tty_buffer_request_room(tport, port->fifosize);
+
+	if (recv_room) {
+		gdl = serial_in(up, MOXA_UART_GDL);
+
+		if (gdl > recv_room)
+			gdl = recv_room;
+
+		for (i = 0; i < gdl; ++i)
+			buf[i] = serial_in(up, UART_RX);
+
+		port->icount.rx += gdl;
+		tty_insert_flip_string(tport, buf, gdl);
+		tty_flip_buffer_push(tport);
+	}
+}
+
 static int mxupci8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -234,9 +262,12 @@ static int mxupci8250_handle_irq(struct uart_port *port)
 	    !(port->read_status_mask & UART_LSR_DR))
 		skip_rx = true;
 
-	if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
-		lsr = serial8250_rx_chars(up, lsr);
-
+	if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (lsr & UART_LSR_BRK_ERROR_BITS)
+			lsr = serial8250_rx_chars(up, lsr);
+		else
+			mxupci8250_rx_chars(up);
+	}
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-- 
2.45.2

