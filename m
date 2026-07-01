Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0F36921E;
	Wed,  1 Jul 2026 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877449; cv=fail; b=bZ3tYqHRTewfE3QaMN/1urHer0TQ3Oir2oK43PZjyvEIalIgAk0SoufoPUaUT1gUfPULhWaaDMaLzco8vrQme0K5w+3qGgf7y1vGyMXDZMB86bU27waMmnltU3176Ra/7Xt2TZk6cmu5/ZtwJJqbO1xVectMxJK/lheSbr/ZRok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877449; c=relaxed/simple;
	bh=qQnvbidMr+DasJrLnF3YNrX5OZDLJHoeV8pw96U+YhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qG0G8reAK56clpQaorUyO07JxU36eZ7S8NQC6VGkQb+fXTM3H+o+BG5skIEhgX6YsVaoqalAJanyJvgX8fxJ7Dw2VBFV7+luf56zC0xiGaR1wuppd7Ue19EoTnxfW9MLX2UGJXYKB+XP3vUvf5lhWehbo2VJpj5CVTomUz8Sx+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Vd9UC8eg; arc=fail smtp.client-ip=40.107.75.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Vd9UC8eg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAxW335//K8qKW1NGbsxA0QGS9SkU3aDD5EHs2/Z/TA40Ds9Connaqca2LY3HYb23pbmntM22nWxcGnCqMtYApy+iBnMxUxI614BQeWlUI/xDYGJik2x1OoIrEkCNGnhHbzK+TK8MLskAVlrEBjdLBRRmT+4Sinv743pBQ2j3he1+WwiO1qOQO47NLZXdVJiVxjQ1h2CgLLBSOsC0NjlgzGXwOm1iCZ1bA2o9GJfoELL5ELShoRMPP99dX4ArPWsRoBebkD+bQUlGDGCV103mE9ZotX1U1IL029ze0Pa6QzGeBtxie82zmIJV2YOuX1UcyR8z814rKpFO+xbZPzkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlmlO+Wez1QBmx6kHb2DNMh8sZk/AR9F4ps6GpFO6fI=;
 b=pNLyrCwV39ci9J3Rl/T7Vqmqcgm7Pedtpymis/fUiikav0/1EB8h5Xm+YRZWzo9Xx9ngXWSYaBG9YNFaBoHJnw4CS70r+VSMENShme/yRAZ9rFh9I1XJJH1kc8S8K5JoM9gKemm0MkQ6n+hvijKb5DCp2wh9E0Qg+X8TyEnrdw3YS6TYx8Xkslx25o3f8OTiZ23a5ARnS0ZekLCb6YoO1aJqA6+MLF6GSmhAQH813l0D162O8SOvKDSoHe/yLzlUJzYUQFlz0yoTbBS9WbgSsCZSY9iDl0pShfS4OelobxpbBqVZhuwyFqyvfaj7iCNEwTCcteCsjyQ+OiOVpMp9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlmlO+Wez1QBmx6kHb2DNMh8sZk/AR9F4ps6GpFO6fI=;
 b=Vd9UC8egoZXoF1tcqX2tg9V0FtR0cM8fhqCP9SIr1byzqwrAZLV91ufZiGNIPwVfiWyEWFkXSpZFILWDsQ7d677JPi922d0LhALe43o8BxLn/2Cud3nu9wn4C+B5gHrCvaUicBeRlH7EZVvLF11eTyMXzRsss7hN+SgG3D1vijE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:06 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:06 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 07/15] serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
Date: Wed,  1 Jul 2026 11:41:20 +0800
Message-ID: <20260701034128.218569-8-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: f20ab78e-46bd-44b8-b529-08ded723004c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|3023799007|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	bZnAOSF6q0xTg4iu9X4feNxKaUyYyw8X4ArIR8gF0f2MEXHAaqKZ5qbGvJ4oFkUMxFm2WFpvcqpGjqKzLcCYZIB6DGW0VD4QVJgXJQbTQZ4DfgWe8F6OHlAA9uUm7sLvhNkehJy7WFTeblomEJG/9/3juRAzftst6lu4Uk8XmNepFLGkrYD9SeMKF2bCbtnX741Rge9vueEkEIAEh1xVt9U9tXm2XV0MXXppa5pnYdXbP3Gl7rTCYo8/Pm9eLvLLMPJkNUJlDqIBEwIQpyVlQlXjM9C60oTLu0lzVEeHq1NSFxppRYEXhm8CtLaz0Nl2gqilo9zlzNM5uFrzsCsaAnE1QzcJZVyfiaJStE7l7VKYG+eqOtVt1fOItXxlgdo5b+g59G3GCtZAJjHaf0TXgrIGLozTZGm1PlMg7EYb8ITsJE4X7RNS2ZPEx5sq5tguViDw//DCUukvC1PLV8ESjAIgwY0xU0ADViQEND3Y2NX2BNEdmlWXinrW+xpxhX4WyGkBJPSmVAcjy15FOhmkLPOjP/9+EIvNiqnxgThoGV/NjfMuf/QcIkqlVuaUFKE687uGpRlSGlnN1b83FY8sKvTn2+xyBqaup5UXtD4jYK6ZJab2pTgrVUk6i4sJjp3ePIA0gbI+86OA3CSU9IWF7cIMo3jOSiCj7ii6cr/sTnv4MaOdf8pcGkDfjWo6zi8xLuGJJRwRNG6HMLpeF0TajA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwPRnzXaDW4IJSjQVMLVKHAvGAFQrWRBqAPq9ZvbkAjogTxhVA+smF0v9JBv?=
 =?us-ascii?Q?LQotnC6NT/zN2dwNymebXwCM9WHARYTDraNwe0BMlm4EyqbRSxPdeph2xVJS?=
 =?us-ascii?Q?pIkn2a3B1fqR/xJc+V/ri2K9v4P97+YGICnwIyL3kCkr7dPDwQZ0vcBID9RU?=
 =?us-ascii?Q?YGJaFMI3iT577hsqeX085cMMj8NH65Mxme0TX8nRZmPtaf0Vt+F7yrME3Be+?=
 =?us-ascii?Q?3YpVJkNdFsArcvPV/tAE9j8daLUFARbvPkDwxeCaWln9gS9ETOFr3RbjJ7Ng?=
 =?us-ascii?Q?WXqJQVU7jaKPkYDNlKjTg+9R/zan9wPDmuoOdHst7EVqCDtEVDFXPsq2yTES?=
 =?us-ascii?Q?TyGlsNTEH3ghyWnOp+h3nSlUzZTMiSTFrDn3iEQiuztp4QNy7bzgpHD7i7d/?=
 =?us-ascii?Q?PhZIP89JHTosI+IsyT7eOS/eHb53nz+yWdMWuBXeJYCT6IgFpqNjCYCfzxM7?=
 =?us-ascii?Q?EmnSZWXCPzb8xc4mg1NxikC/p6dVonMoTbvkifH58JZhUqjHSG0Rx83Af/xZ?=
 =?us-ascii?Q?nBbV2uw5yX5t/aJ2dxlE46OSgpYFqZvuhLS/jFeYPvBMnGl7RqJ8oQU1E4oa?=
 =?us-ascii?Q?XrOo0wLIDvMaCNFaGZj5SlfkHdZ3tITZ0n9Rd+vmd/lT/1CBd5RJnQ8n/XrW?=
 =?us-ascii?Q?CKjdYfleM94bE+vqw2CC6or3RugmQ1Hwww2co65C2bnDsGkiN0Tesht+LPWS?=
 =?us-ascii?Q?auiwFdQN6n4ZC8l3S2uJv/lSGis6+xiMJOo/QREZjTh956DepDxGEwN0JW/X?=
 =?us-ascii?Q?RMFTI/lppa4Kg4vHKnPjZb5B0trboprxxsIEitgPdAUFERIe7Qk1V6bIizRm?=
 =?us-ascii?Q?RJwW89Hm0/sHQE46hFOHyAShPN7EfuxbOb+BNd65bDY3cZ+rqNCuacPkQ5SX?=
 =?us-ascii?Q?sQNgbmc8mx/qGbXY9ShSJqNWuBdhDSlqysEReMzgbp+DRIUJoeqMBZ3+OAE8?=
 =?us-ascii?Q?vftMHBVJMig/dXJolyZfN47EP1j3izQW8FBxMTXITpkzlKbBrAR6Pj8FR2Wf?=
 =?us-ascii?Q?Dml4nk8ydgn4FYeYZ5d8cQttMgj+E+kAbN3j797GMrhslvAkeDdPD2ekRJUs?=
 =?us-ascii?Q?6im5Yyq1G+4D416AS4Xpe9fpHn/fgsN80eYjOBmI8iFCr7JnQMiv+zUk81oU?=
 =?us-ascii?Q?L5J2RgwTXVWiKm9VtcFpU1F6sptD2GoSkoQBUAvzOPwB7H3CXomQb/EvDw7I?=
 =?us-ascii?Q?P0bac8fzKA8UX06Et+EsYPjBTGZ5SJ8UtgwJbWs6wpqFCeJECclgLsDRqAMg?=
 =?us-ascii?Q?VXyskFxMl7ubVl2yKf2LkHPrRBAmUR50lhX9koHND3Db753erfMYElvXG219?=
 =?us-ascii?Q?dnGHiPxDXEtsGIeXCjN9P1RR3+1kLYgRUlmU6JRvsNTuycA2fpw6qhlRtb3a?=
 =?us-ascii?Q?dur8dBGx/GnL1rwwgqYaX3ST5AGYSSalR3jNSJSpaF1QXSnBh9vuG9Uv7GMZ?=
 =?us-ascii?Q?yzuMT+ANE3qQLrXUPfl+igYQfdKWRQu6hvXfdHN/3/LCT9TaFjWNGceaEEOP?=
 =?us-ascii?Q?mJXViGm5BCaXcWRJ2AvnQ2g962EG2IgZFoUyYJ0PDsOU+NzYnhdWFtAhQTXj?=
 =?us-ascii?Q?38grRN8R83VbP9DXs8/C0ySR7yv8xdF2GFUYifVint8CjV5nHXfCLHDKudIj?=
 =?us-ascii?Q?x9aNASxKm3hnLzAuaMkAJUVOsa6AA7P9xO9OAnnc8ybYj+2lFLaUjyGKyHw9?=
 =?us-ascii?Q?lFhRU5u71VpA6mIwpJO59+0Ltn8UDSQqBW8tB3SshK3ooVzfyRux3TEl+pRk?=
 =?us-ascii?Q?4KkphqnUH8WtsMSTMAfm5A3FTYmYS3A=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20ab78e-46bd-44b8-b529-08ded723004c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:06.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvgLrhivDNQqcl7MmTtI+0r3K7ky2au4UELIHOa5/JI74COq8pC1s+oOrzrd72YR9zNevDxlwopZIOktLnsUAKA4GWxDee4Iz5sIBz77nak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

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
index 966c8f8cf38e..4aaf56902949 100644
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
+	int recv_room, gdl, i;
+
+	recv_room = tty_buffer_request_room(tport, port->fifosize);
+	if (!recv_room)
+		return;
+
+	gdl = serial_in(up, MOXA_PUART_RX_FIFO_CNT);
+	if (gdl > recv_room)
+		gdl = recv_room;
+
+	for (i = 0; i < gdl; ++i)
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

