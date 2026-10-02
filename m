Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722C3EC81D;
	Fri,  2 Oct 2026 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971777; cv=fail; b=sRT6n06cXfUku5tXyQRV9Ye3l/knfcJwZ6j6pgruHosM7w+VT2UX2aT5mRwFM/B4edOU5KZ4MVrQOt9QKjP++1fFjtA04WyYQPmWUHoA1cO+u6wWCoFcMT4K/6ffDzVYQHU89PEgujZ8AcheYeu646hSLLzig++Zs4SiQ0yvL40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971777; c=relaxed/simple;
	bh=zzYQxRnp7EsD46RNSY/K3GRKjKVOWEuRbyFJ+nKQnKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dHGEiBuqFyUzvaH+k6kohaUS2CvXT4DdH+DZEllO79VGgYXj4WYJ6/O6k3egRboSToqQ/JwYdO1Am7DuQO/oWvoy/wxjz5MGqaZ5Qu0IEFyFSrao/hcTx4bhwxACOy4jfVDAew7Ag8UGLf9QCbUSzwIRPWIL3lX6/+WcTpLNJd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=i4/ZbMty; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i4/ZbMty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf7Td4vjQ1DBYbIoPkkg2fwgCeLVI5He2HhUTiFmsRvqq5mH0gIeIkpio/A1w22GHRF9Rwz6ZSZQzc7FM4fL3DR/VsC2T9Ar5J6z8CnsSxkpXoBRgB997zor5g4h7+8+ZNqRVIVTebUhC3+2WOpMMyITwppZHFsQ+uiSf1bWt/5OGBwKvfpCfqDe9hlOlzFQKXNNc38ChvQau2oIc35Xx1zGY1HRLhA1IHnZq/jlOR60V25flyZ+/nu+wcjGk9Bas7SWo4R0x2N3VzHEm2ccqodY9Z3+NWwZ9TiOSMGYyQYGV9peKtHLH0p6oad+0iDRzwgvBauqEZcJp7QUF52CLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpAKTSKcDQzxjXfX565YOIUiSeznQ8BfoOKqu+CIOqY=;
 b=kiPM7np7/O1RX3WSo4sDQNJI/TE1Y8urZTp1TOpgVQKMmOVqt8W0PARCFt37cTfRlKUvZCfhGY73wPNwVFJQHix4My+F8po/TbcuDVpfx0R1ZtR7z/1g6JGWDHG2rr4NnFKhcAdskiyANMUBgSK8A4dzyPyKCsrmxpG0AB1jXmassV61H2PnVp1g8aWliPNLR2SD3wM7IkCsSLCTHzWhDeJw0slwpTkE0fGUEAv3MtA42m5rkqgJiq5txPYSpobxiSrRy2lOtDRcfQjmnnD5sx7KqcWJ7PUFPUCt0k8EdTdt0a/0k3Av0sMS1cCiRXIoF3q1ZNP74zo9jfosdc/Euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpAKTSKcDQzxjXfX565YOIUiSeznQ8BfoOKqu+CIOqY=;
 b=i4/ZbMtyP1Cxv4T5iZdDJTox0m1zLd6cgwooEWSw/MqPh7t2GPCgp4I91/8ykDj8uiU/S71Sh8fj/+2nlZsMrYOgmTsCFX82n/wj9pP/8S5OeognU8OXWj247u4lfEbsn9bNxOa3q0+cnzv0KkAHisy1mtKOezie0SJHX4G5G3DPl06/fJvsuXE4RG4iswwtZ/IIV02aAp0erZiLPL4HkP5+4Mvx7XNAbGe7jz9qk+evBsehjNe9cuTvVtUmh2qFXLvEF3wMQ+5hYV/Zu8J6gOkMIaR5iu9tecW01OnBrdukvzhBOf8MnX/dNvyARJx8EThxN3QsckCjOodYioFGhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by VI0PR04MB11548.eurprd04.prod.outlook.com (2603:10a6:800:2fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 20:09:33 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:09:33 +0000
From: Frank.Li@oss.nxp.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Zhaoyang Yu <2426767509@qq.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees@kernel.org>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/1] tty: serial: pch_uart: use dmaengine_submit() instead of ->tx_submit()
Date: Fri,  2 Oct 2026 16:09:23 -0400
Message-ID: <20261002200927.236033-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:930:45::24) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|VI0PR04MB11548:EE_
X-MS-Office365-Filtering-Correlation-Id: c6164a3f-044e-4d2b-5303-08df20c1133a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|19092799006|921020|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z4s0hOTO12oGVUh+34myo8M8XU0GRIL79h5VqIatZQbBkbdfnuTtvUd/KwcP4m7hewml9Al6ZRx0lD4jzl5muJ2j+JL3d/T3uBLq4tkcgvIT0k/32vkl7rfUP2FZbaopGHdyz6YpwHPT0C0b+ONRwg/5gLILmOUTO3oDH9xcIa6a4AH1sp8Tjpd26j+H2Z5VUJFvAdjUunIrm7aVgImUMkogSteSRPKezmouHlMP5eb9ti37iNlu7lcOOijZb0wHiz/i4uaHlfIXz4/1/E7sh3lwGGyDx532L8BID941fZLkyrY8oGlZzPI2Xv2JJJ+urtru2Y+ezGi1rRoMZKv6lPZnUqC7c66+4Vpi/lWlmWxmHz9nNK4bEI7e4jkIn1D0YLsv7yupAcntqx4NJo3GkA9FP+NaWTX8ys4oJfzCe0nmlGGCdt2HDtyARKCqYQ7xtzEVc9FaZ07zeXw6HKO1KzC11pfsN1UDZKqXOByVUMIIU5B5LNHCkY5XtMG18PpMekzXjmTQxaEJ0zqfC29b5kVIqwUh1ULDNkY23ozE0qyavbYPFkI91mVo54h8sH4jKErLwG00jXZ0mEkgejAyDUB/mPvw6ygKLZhfk9uMSl3Tc4PP7HbJV55RjIsURDSXET1w1/5T7Ur4iJ+3H1+Az1ANkbwC/FDN60D4zvVSS0od0QUHxmSYBWAYAbhDvehhcos0lfl400l2nIaSXuGyFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(19092799006)(921020)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0UnThP8ticA0qEMkblOUL01FT1IdGGM2/eJlzvqUgmnk0NWdFL12o4rFLJhr?=
 =?us-ascii?Q?XyKMuDQ8ECf2ylEYDyGbFMkyI3mrrhDQvKoxjLJ8uKUmSQIcWaWr4veYGLHj?=
 =?us-ascii?Q?RL7ht9pV9UJjbN1LJzz2i5nV6WhnYVTYbWSVSCI2mDvDPUpKMsn0BrW9gU6e?=
 =?us-ascii?Q?5z/YxWIadJ+BQKkoTP9JogtxMxexhrMPYj8e8XP/hva2AslfMHOHqLCOjlYd?=
 =?us-ascii?Q?TcuH90irrtYDuda4bEcelxkJimfxLcEkq5Zz/HhJUEy8FNIo3500lJf16trJ?=
 =?us-ascii?Q?kCV5mfOsDhTUPTZNUk1ulpnjL66CesdpTRyqW0tp/SmKWKcjxTDQxee4h7gW?=
 =?us-ascii?Q?ZQJKpWPp0acwZc+levcViGi0kl3yHXcr4z/9y0WRcb8/1T2R2tWartfvedxs?=
 =?us-ascii?Q?i26k3MObXTLoqWjOTfjISQfqXcwHyutPSAF+zbacfNFso07UeHtE7Jx13o9d?=
 =?us-ascii?Q?ShqLuGglgOJtr1/8uqurI4dn8JYx9eanjhovel3wJnbv2Hn/1HFsHpBHJtdv?=
 =?us-ascii?Q?eliT8PTrTncQWwbbfX7Bu9/qNjt8Gg8NXNQJBtgLcd4XKx513qwO6IoIPh1g?=
 =?us-ascii?Q?6dEJr2IsP8uJi9n2dnZhQdjFlA+rql8MqYC2BdqpPxGp7I6kuTxrMBn+aIzs?=
 =?us-ascii?Q?ejpn8615hULXiWzm8uxMZSIl5lgHuTndAfTv2XkZODKhYKXdjDyhdCdYNPz2?=
 =?us-ascii?Q?fWgZO6WRaDmdWP8U2vQ4Z+s55q6ccfyVFR7WRwsw4CcbrGdly6Ms48DTVOkq?=
 =?us-ascii?Q?8VbxRUyJxGTySJCR5QgRtdUTXF3bxq0spFYOw8Otdx/tf5iTq9fajRw8HZAu?=
 =?us-ascii?Q?PhPGKmfQVDGDr6tbabZsLw5wDlPCTHyYSWMOClCwgNPKNH06r28ev6QM5WBm?=
 =?us-ascii?Q?GRIXnlAWKRARtZepxlRD0HhbP37Wcmbb1jg5H/OHH22QsOT4pIqwU6ikyIkb?=
 =?us-ascii?Q?LV9sDGdW08ELZK/iiLRID96po0mAuQvqkrY5ygle4pY9qogV9PPdBkJRrfHk?=
 =?us-ascii?Q?3u1ouhsGnJsYElaKAar3ZqF2gfMHWQ/L44ib0iTWcZfKEVpetXG/khWxswFl?=
 =?us-ascii?Q?hkr71xhImqPbbDrHcKyZjJl/uoAlJx8gwSI43LaOGoS+N/1l3MTpFMIMHXw9?=
 =?us-ascii?Q?9VLBb3SOooeL6nFpRf94HNhS7gkjR8kZiml0IhoK/w/66Tl2dV/W7n4TKVZE?=
 =?us-ascii?Q?Ek/1cmoTXP1WofVDgPiCLw3nZJyKU0UpP+Z3OiHzljEkdTbS8yQKKbEKCSAw?=
 =?us-ascii?Q?lHKInFWrMot3FJs2zZUwN3HCw5yagYsdH3ivQrxWu1Xvopcc0AVxlnVjEOVi?=
 =?us-ascii?Q?/exk/ykQ5dp2VsmEJqJC9jXxvBCMGrn1UDNV7QM2TPpkNisHoAojzvV24jKa?=
 =?us-ascii?Q?IHKk5/ych96RMVL9Ke/Sk9BBOIXVTw3sUwRUfyFvUoI7fSHKSTbHPWqNJGVd?=
 =?us-ascii?Q?/HWnLxkk4LTnb1FCukKPCqTU0W1UQqYu6Y75BQMlINqZn24kLjksW2rcOM3H?=
 =?us-ascii?Q?EoTxeuKmibszEVRo5GCmUMX/5dmNRFRU3GqV1unXTakMA+02Ny+tIY0wU2+N?=
 =?us-ascii?Q?Q6tOR9OYpCH3Fyyzzohw3WF4KV4f84o7nU0onSueXlZkTUU468VcCPrgT98r?=
 =?us-ascii?Q?hJ+3aXF0CVn/gfZQXF3d0AXlY0uOmkjf6Bnaz07B7oBWvxQ+DxSua98mZW2c?=
 =?us-ascii?Q?gAcy1oiUsk62YGB6kADwo5ruewfUcqNUexaqmKQO63r3d8K5sg3xl6ausRPT?=
 =?us-ascii?Q?inO33N587UKde/EFTWxa6bWAfRONOs9hvlIV/9y+DGrzwfYpIJvC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6164a3f-044e-4d2b-5303-08df20c1133a
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:09:33.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaqNgCdnqbztYH+I/yRYwOim3Vvtdg2TguDKTph2V1G34106MxkoU4227vDUqO5KeVdJteMSrA5apsDhZL8MSiIWzvjHHItLIbWjpY1iRQGWd6A4RkaAPoLYKcz4rTDI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11548

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_async_tx_descriptor->tx_submit() calls with the
proper dmaengine_submit() API wrapper.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/pch_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index db5c62b0322f6..9505d255f09c5 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -811,7 +811,7 @@ static int dma_handle_rx(struct eg20t_port *priv)
 	priv->desc_rx = desc;
 	desc->callback = pch_dma_rx_complete;
 	desc->callback_param = priv;
-	desc->tx_submit(desc);
+	dmaengine_submit(desc);
 	dma_async_issue_pending(priv->chan_rx);
 
 	return PCH_UART_HANDLED_RX_INT;
@@ -971,7 +971,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	desc->callback = pch_dma_tx_complete;
 	desc->callback_param = priv;
 
-	desc->tx_submit(desc);
+	dmaengine_submit(desc);
 
 	dma_async_issue_pending(priv->chan_tx);
 
-- 
2.43.0

