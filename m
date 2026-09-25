Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC003B9931;
	Fri, 25 Sep 2026 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366954; cv=fail; b=fW2ZH7ETHS01/k+a0j/MSI2B6ENGjycwU6+uahQzgrEUQmSsD/EEwoprJKVwPHY/151nFHJoQZEzsJh38jgkvtSJPW9Gad+atXBdwnNTZSqzA5YznIDiAFI/kyDAykLpsk956WV6ICpKB91P/CiIBq3w/qfkXRd2/RdzMGv9d7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366954; c=relaxed/simple;
	bh=w0EHt8ZYtDKxAXbLOonoWCl3hFfwd9qGx6fxl9LOGpg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=thICmPVDHTZSPr0rjPGPmYzCWmQyFVA1JSWnbMJOLIKqremciQ/lQ9Dj62t0ZNf/5LXbHLRYECQuHlmM6S6ZUc121mygLk60A5O8yMjGyMjfYdoczmoFg9evYwNhsZL/OMmxwSg+YUdneJwm+4T6cdvh+t+1TBIyu+LyFiJcWlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x0cyYGLg; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x0cyYGLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG7j4Pt6s7q2xscBhfOlLDl/Hr4gGD5JBxo5ydcsblWd2z1RFssarFhVXKpiuK0i6p8sJFC9FgqAQPldDxnUuFHsrL0hv2bBESEvzLjGb3nxw+fhE//JLg8Jy2OvrlLX381bz0baozaQC227YOj1uPGFW1ZbRdzPSc+lMrKef1DPBnR1rSEkH+DuzMORn/anrkDSvZXdbNVYGdUUvXI1lFIjCdLcAQFVVthdZUprD67BeLPVLpAd8qlBI2Q5k8GBbO8L0vIdJ+FneZskT/dqnz/+Qs/JPS2uif9/W22JTNtp0SczXrIdvshN0cZcATG5Dezgrv5G0IV0jV28WbfYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7EjYyotsXIBmjrdrIh0zUAPbe/C/Q6QJHJbi4UIdkg=;
 b=Gvc8huO1X7lGdayTPntmjpdAjeicBu1lHWqtH+3GAmjhuyNS/PPU/tD88N5Rww3Qk/mF0TOwViTBlVp8hZy4fLxuJ/UWibCCAC/ORA+dhjQCEqEkG/7aW4CpdwEpV+f642m+ho7T9S+byTxgjHVkk1xIof4OoruEKubn+i+7Bk/kpYxnigtm0/wr1z8TZ7uHmvjHoLC3698thpn9vvI/pwYC4b36G9mXHIIhuD0gfYxEdh7b8Eq3CyQuE/4OSdx2cNLxCpgEwahkeqWiKej/E1/QiODy1atKvgYmjIw0jyvxtS71TneOL6ba9iRdMLBRl1e7ifBF9Uotj2uV2+JtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7EjYyotsXIBmjrdrIh0zUAPbe/C/Q6QJHJbi4UIdkg=;
 b=x0cyYGLgJyiwTIRbA9R0b1VKASI56jtWlNBsjailI+pUwQhnH6/kT5UmFGNJm4taJGKMJh8LfPsisA5NUIp2UIngKYPYSRH2rfZ/e09dUp54E2GbuH2fvyCajAL160MWHJ4iynFVMuJmV3tHlZAOF3AMOI/1QCqKbyDSffGB4W6r6Eyp1ODbFP6kQqzCPQwkhiudrqZX83u+1pcBEZr4919kQEwPJgL1k7krZvM+DXM7epNqvYAtJDeKL0llPzuhxLo/1cmRqia47FeYt5THJoymV3q7sV+5KkJYIJySymFPHQSWPkYrKBinEQHyx19S8p9/dj2JRMdo4CtKCJDPww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12352.eurprd04.prod.outlook.com (2603:10a6:800:322::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:09:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:09:07 +0000
From: Frank.Li@oss.nxp.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Cunhao Lu <1579567540@qq.com>,
	Frank Li <Frank.Li@nxp.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>,
	Kartik Rajput <kkartik@nvidia.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Zhaoyang Yu <2426767509@qq.com>,
	Kees Cook <kees@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/2] serial: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Fri, 25 Sep 2026 16:08:30 -0400
Message-ID: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:930::26)
 To GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12352:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f1b205-d60b-46e7-becb-08df1b40dae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|19092799006|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	IosuMMYKujRudtFLRImfdw1bxe6HJ7cj2Fw4mMPIeuneAKWJCN6pKBBHfrIhSw1BO0qOgWDfNTOdQ2mR1cPalNdGctNd+f8CnBOuFlAwnuxLARyZrtXe3NYK6Psx7XqeR8HPQNjb+bAPG2SpHT4csUlQDymukHT0nut9PNnD6Q7wHRYgX3v5sEJP2HFF2mqs88J1yNMhA7wzJdbIhprsGtCW3yGpzLdN2THIMa5gETNVZ812PW7Rs6P0+wl6OXB5xHM+wQNeh3fz/xFaCD7eM3ABqUPNjUYHxLxz2iqLkgVXFrvq8N31iYQl8uDY3PIqCr4ywR8ZugKZi2RR6+U1PoP6LXwC23ymxnC/7PvWYRIJvs4IqaymsJtfsnsHK1ddZ5bukVgyF0SVLLwDmL99cyYJjj6+5cIHUViWpjjB8TfoIQu6/BF2AmrFNFneaNh4Mx90T9hY7km5Qxxe5BYgKbVIbFB+6Nk1aw35525pRLQnl7Ghw2dcnhhzBYy3Nl5O+xEibV/7QgT9yBNpjqs4h6Ok2pssiRBmk03cY5Dd2EvAqihg/hztKj3Ty3ABd8MFpsDSSZE26t0yrR6il+QD9GEvCuW1tUpRSSxaMJGJ2KEfB+QGhJefBqHnfwN9tm9uPmtpKWGNk7TodaA8Pqy9is5cNq49+rPydmuoj+ingPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(19092799006)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlQtk4P5+PsYwkifG2MLRTrCXZE+pJ7cyC0hP4En78/Jf0E1Q0nTv6aM7vMu?=
 =?us-ascii?Q?XthD8UzeKsb/xSfJTuavWNKUHRTqvMfjtNToqBlfkW3wa7i0Sfr0PJ9rUdHS?=
 =?us-ascii?Q?sMLCv6deVRrVVUDecr+NJwJCj8M20tuRnB5AFclU8b6k9jOtA31vq6gLuGre?=
 =?us-ascii?Q?zpL2jzBIQ5MYZbzX18kIAhqRY1WR2BDGCTnYmpop04Y3aFE94DyKMS6hPQ5Y?=
 =?us-ascii?Q?RF/R1tz1W1bC61uRIqShmJtn4RjL7O16A/AG+GUyoT6oRlbUR950RRV9NSZW?=
 =?us-ascii?Q?2h3IxTvgmWQeHZMkKky5fybZzpngHs16ReMh/uGyKiEghWYcs9biFHCDzXMX?=
 =?us-ascii?Q?6eZ1upnj2xtLW+2QDX45/PHFqsqkarSI5J65uOihvEePr7elbzQvjtKpdaex?=
 =?us-ascii?Q?T8PM+IiIdNCyoTwl6iAlCwhDnlHAYcT/y8VBL3vgokVccNJQhnvQ8F+0XQPx?=
 =?us-ascii?Q?eNxCSa8azAL+B75E3pYf7ylgVO+g8gu1bWVolAriRtByqmZ5AWS7IrftaGMA?=
 =?us-ascii?Q?HD8lUhOxsGqC4nRyTuDcHi4GGIIFUiApWSBziHKXiWzAsRwZywXpHVijACFC?=
 =?us-ascii?Q?IIx+NOIuclZmYjOPM7SZbZkH9CqskO9UxBKNLo07YqBWZSzR5N8V7/Z7rzOk?=
 =?us-ascii?Q?YTe53/WqjrveAWiXPk6daG9z1p59R3i29ixonfjlSIan11g18DKmrC+0vFmg?=
 =?us-ascii?Q?hUnXp5WqaQwTaFEvi3b78KM7pZqnaNt6393ate1vKjDu+95FpfgpEuKicI7s?=
 =?us-ascii?Q?Jt6KahYXinugUFUkuZ5Jj8Ei4s5FNecPP60BSEe8ydgxRGyG+4IilVcQDHX0?=
 =?us-ascii?Q?R8PjK/tT6f+S/N9DPREhn0Uvb6bXj0dSz/fqbu+d3MUQmhtMS3aSljD2mARX?=
 =?us-ascii?Q?OJrE1zpb1ZYhFRN0gzsW6QoP8iEiFq9c++dRBVIgapmvfFzCca4bi464S3KK?=
 =?us-ascii?Q?tn0OvnZ1A98yMJskZ+fblWtS/WAbgga34xY3lJrYXkfrAL/dzXA2Jf7/OE7v?=
 =?us-ascii?Q?C8hhEO9gQO7btEBENw9pNoG59eSxWNFM4PyW8vRySgy8fTA8lzl5uNnScFRJ?=
 =?us-ascii?Q?LxQuhLlV10nDwp6EkQevAVP4zgx5ESz2X1goAczBSY7WLcSiRgTN7BbGCwTl?=
 =?us-ascii?Q?0mEI1igPF9VzmPWi2BuonqwO7dt3KYB7Ld6IHtwkZYdDSMxgZCspOpPNM7vE?=
 =?us-ascii?Q?3S9k0Nv95OtfmWXNRU3IxiZv1UK67WsXSil73Zw2WiEmxXB9m5/QssuEg+gX?=
 =?us-ascii?Q?ERMNwTVki93I9pgCsT8yLqRlqxK4YAHY1qd6LvUxbzcYLlvLvOB3LauvlI7i?=
 =?us-ascii?Q?wy3C3KVxM9w3rzQTl5/HEr2UuELgXaZzKus48Y0d4AnlE9HTyfWzjf9oNBv9?=
 =?us-ascii?Q?HsiAZuGCMOigBBw2vQieBnOhDFwZ1/dIcGIvWUf38bnpCqA/vCey+IBjNQfY?=
 =?us-ascii?Q?hu7VaBeR8/LrIW20nuBoJgkfxkLSkAixXnIUjWvQfZqzLbS7bxnCNj3zMxwH?=
 =?us-ascii?Q?5X0mW8PuqMzxjmOPoyQGTYaj8gM07mIAldwWiI1d7JiwzCk16ONDNxR/NtaW?=
 =?us-ascii?Q?bQiC8RPbJwtkuCch02LHoQhm9CZF5zM7v5nG5CSSyd6/8BUKUJj35SiRkURe?=
 =?us-ascii?Q?R2Y4lxJ75sHKy5RL3PlW6kFxOkPgkjciwSsCBj6ksKpIiJzqtzXccd33YlhF?=
 =?us-ascii?Q?wS6amyvva777bZOWNB81tFdPEV1CPI7JCOHejAp/buUTgsQZXPkizgioBvxl?=
 =?us-ascii?Q?e3XFrAD7dHWZCQ5GOeGDLrZEGdKbrXVEOvdDDS7Aw2IdiksZT/zN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f1b205-d60b-46e7-becb-08df1b40dae0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:09:07.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42RDZ/bEjne9JkJGtavjlJnpYxYwbVCHE+th6qrvQ+9PVfhG97XVAKHa5zh4e8efM81ohPZ/N5W6R4KQXc7JSmTwAChZSLrSXoFgPmf+euL0ps21YGM7T7fQzhuQOfZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12352

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() for consumer API

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Check all unders driver/tty/ by rename device to _device in dma_chan struct
with all yes config.

Still few left, one for copy_align access, which need new API. some filter
DMA channel, need new API to get provider devices.

In https://lore.kernel.org/imx/67966b47-22cb-4b07-80c7-2044f557dbcb@app.fastmail.com/
There are better idea to move map singe/sg into dma prep functions.

But it takes more times, not straightforward works. Let replace this firstly,
---
 drivers/tty/serial/8250/8250_dma.c  | 21 +++++++++++++--------
 drivers/tty/serial/8250/8250_omap.c |  4 ++--
 drivers/tty/serial/amba-pl011.c     | 10 +++++-----
 drivers/tty/serial/pch_uart.c       |  2 +-
 drivers/tty/serial/samsung_tty.c    | 27 +++++++++++++++------------
 drivers/tty/serial/sh-sci.c         | 14 ++++++++------
 6 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 5a83e5269b415..dc7fb3db1584d 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -19,7 +19,7 @@ static void __dma_tx_complete(void *param)
 	unsigned long	flags;
 	int		ret;
 
-	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	uart_port_lock_irqsave(&p->port, &flags);
@@ -136,7 +136,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
-	dma_sync_single_for_device(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(dma->txchan);
@@ -223,6 +223,8 @@ EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 int serial8250_request_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
+	struct device *rx_dev;
+	struct device *tx_dev;
 	phys_addr_t rx_dma_addr = dma->rx_dma_addr ?
 				  dma->rx_dma_addr : p->port.mapbase;
 	phys_addr_t tx_dma_addr = dma->tx_dma_addr ?
@@ -282,11 +284,14 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dmaengine_slave_config(dma->txchan, &dma->txconf);
 
+	rx_dev = dmaengine_get_dma_device(dma->rxchan);
+	tx_dev = dmaengine_get_dma_device(dma->txchan);
+
 	/* RX buffer */
 	if (!dma->rx_size)
 		dma->rx_size = PAGE_SIZE;
 
-	dma->rx_buf = dma_alloc_coherent(dma->rxchan->device->dev, dma->rx_size,
+	dma->rx_buf = dma_alloc_coherent(rx_dev, dma->rx_size,
 					&dma->rx_addr, GFP_KERNEL);
 	if (!dma->rx_buf) {
 		ret = -ENOMEM;
@@ -294,12 +299,12 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	}
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(dma->txchan->device->dev,
+	dma->tx_addr = dma_map_single(tx_dev,
 					p->port.state->port.xmit_buf,
 					UART_XMIT_SIZE,
 					DMA_TO_DEVICE);
-	if (dma_mapping_error(dma->txchan->device->dev, dma->tx_addr)) {
-		dma_free_coherent(dma->rxchan->device->dev, dma->rx_size,
+	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
+		dma_free_coherent(rx_dev, dma->rx_size,
 				  dma->rx_buf, dma->rx_addr);
 		ret = -ENOMEM;
 		goto err;
@@ -326,14 +331,14 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
 	dma->rx_running = 0;
-	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size, dma->rx_buf,
+	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size, dma->rx_buf,
 			  dma->rx_addr);
 	dma_release_channel(dma->rxchan);
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
 	dmaengine_terminate_sync(dma->txchan);
-	dma_unmap_single(dma->txchan->device->dev, dma->tx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);
 	dma->txchan = NULL;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ceecb39fb82da..3a1473bf54d0f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1076,7 +1076,7 @@ static void omap_8250_dma_tx_complete(void *param)
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	guard(uart_port_lock_irqsave)(&p->port);
@@ -1193,7 +1193,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
-	dma_sync_single_for_device(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(dma->txchan);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201e1c3..86729ddbdadc8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -435,7 +435,7 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 			     enum dma_data_direction dir)
 {
-	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+	db->buf = dma_alloc_coherent(dmaengine_get_dma_device(chan), PL011_DMA_BUFFER_SIZE,
 				     &db->dma, GFP_KERNEL);
 	if (!db->buf)
 		return -ENOMEM;
@@ -448,7 +448,7 @@ static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
 			      enum dma_data_direction dir)
 {
 	if (db->buf) {
-		dma_free_coherent(chan->device->dev,
+		dma_free_coherent(dmaengine_get_dma_device(chan),
 				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);
 	}
 }
@@ -609,7 +609,7 @@ static void pl011_dma_tx_callback(void *data)
 
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
-		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+		dma_unmap_single(dmaengine_get_dma_device(dmatx->chan), dmatx->dma,
 				 dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
@@ -867,7 +867,7 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+		dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan), uap->dmatx.dma,
 				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
@@ -1249,7 +1249,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_single(uap->dmatx.chan->device->dev,
+			dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan),
 					 uap->dmatx.dma, uap->dmatx.len,
 					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index db5c62b0322f6..5e8540e835351 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -656,7 +656,7 @@ static bool filter(struct dma_chan *chan, void *slave)
 	struct pch_dma_slave *param = slave;
 
 	if ((chan->chan_id == param->chan_id) && (param->dma_dev ==
-						  chan->device->dev)) {
+						  dmaengine_get_dma_device(chan))) {
 		chan->private = param;
 		return true;
 	} else {
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 63d0232dffc20..640f85e2d636b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -300,7 +300,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		dmaengine_pause(dma->tx_chan);
 		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
 					dma->tx_transfer_addr, dma->tx_size,
 					DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
@@ -333,7 +333,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
-	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
 				dma->tx_transfer_addr, dma->tx_size,
 				DMA_TO_DEVICE);
 
@@ -435,7 +435,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + tail;
 
-	dma_sync_single_for_device(dma->tx_chan->device->dev,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->tx_chan),
 				   dma->tx_transfer_addr, dma->tx_size,
 				   DMA_TO_DEVICE);
 
@@ -509,7 +509,7 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 	if (!count)
 		return;
 
-	dma_sync_single_for_cpu(dma->rx_chan->device->dev, dma->rx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	ourport->port.icount.rx += count;
@@ -631,7 +631,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 
-	dma_sync_single_for_device(dma->rx_chan->device->dev, dma->rx_addr,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				   dma->rx_size, DMA_FROM_DEVICE);
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
@@ -1101,20 +1101,23 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_release_tx;
 	}
 
-	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
+	struct device *rx_dev = dmaengine_get_dma_device(dma->rx_chan);
+	struct device *tx_dev = dmaengine_get_dma_device(dma->tx_chan);
+
+	dma->rx_addr = dma_map_single(rx_dev, dma->rx_buf,
 				      dma->rx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dma->rx_chan->device->dev, dma->rx_addr)) {
+	if (dma_mapping_error(rx_dev, dma->rx_addr)) {
 		reason = "DMA mapping error for RX buffer";
 		ret = -EIO;
 		goto err_free_rx;
 	}
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
+	dma->tx_addr = dma_map_single(tx_dev,
 				      p->port.state->port.xmit_buf,
 				      UART_XMIT_SIZE,
 				      DMA_TO_DEVICE);
-	if (dma_mapping_error(dma->tx_chan->device->dev, dma->tx_addr)) {
+	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
 		reason = "DMA mapping error for TX buffer";
 		ret = -EIO;
 		goto err_unmap_rx;
@@ -1123,7 +1126,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	return 0;
 
 err_unmap_rx:
-	dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 			 dma->rx_size, DMA_FROM_DEVICE);
 err_free_rx:
 	kfree(dma->rx_buf);
@@ -1143,7 +1146,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->rx_chan) {
 		dmaengine_terminate_all(dma->rx_chan);
-		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+		dma_unmap_single(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				 dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
 		dma_release_channel(dma->rx_chan);
@@ -1152,7 +1155,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->tx_chan) {
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
+		dma_unmap_single(dmaengine_get_dma_device(dma->tx_chan), dma->tx_addr,
 				 UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);
 		dma->tx_chan = NULL;
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 50ae9aae6b614..bd58bbfa65aa7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1495,7 +1495,7 @@ static void sci_dma_rx_release(struct sci_port *s)
 	uart_port_unlock_irqrestore(port, flags);
 
 	dmaengine_terminate_sync(chan);
-	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
+	dma_free_coherent(dmaengine_get_dma_device(chan), s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
 }
@@ -1591,7 +1591,7 @@ static void sci_dma_tx_release(struct sci_port *s)
 	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
 	dmaengine_terminate_sync(chan);
-	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
+	dma_unmap_single(dmaengine_get_dma_device(chan), s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
 }
@@ -1676,7 +1676,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 		goto switch_to_pio;
 	}
 
-	dma_sync_single_for_device(chan->device->dev, buf, s->tx_dma_len,
+	dma_sync_single_for_device(dmaengine_get_dma_device(chan), buf, s->tx_dma_len,
 				   DMA_TO_DEVICE);
 
 	desc->callback = sci_dma_tx_complete;
@@ -1832,12 +1832,13 @@ static void sci_request_dma(struct uart_port *port)
 	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
+		struct device *dma_dev = dmaengine_get_dma_device(chan);
 		/* UART circular tx buffer is an aligned page. */
-		s->tx_dma_addr = dma_map_single(chan->device->dev,
+		s->tx_dma_addr = dma_map_single(dma_dev,
 						tport->xmit_buf,
 						UART_XMIT_SIZE,
 						DMA_TO_DEVICE);
-		if (dma_mapping_error(chan->device->dev, s->tx_dma_addr)) {
+		if (dma_mapping_error(dma_dev, s->tx_dma_addr)) {
 			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
 			dma_release_channel(chan);
 		} else {
@@ -1853,12 +1854,13 @@ static void sci_request_dma(struct uart_port *port)
 	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
+		struct device *dma_dev = dmaengine_get_dma_device(chan);
 		unsigned int i;
 		dma_addr_t dma;
 		void *buf;
 
 		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
-		buf = dma_alloc_coherent(chan->device->dev, s->buf_len_rx * 2,
+		buf = dma_alloc_coherent(dma_dev, s->buf_len_rx * 2,
 					 &dma, GFP_KERNEL);
 		if (!buf) {
 			dev_warn(port->dev,
-- 
2.43.0

