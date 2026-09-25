Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2594424D57;
	Fri, 25 Sep 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366966; cv=fail; b=iOOPWOUgROHCnJl22KX6FcEVt+3KRhx4QPaogp9nJ57iioItGruVWrUS3o0qpIZWi24m2W4Heghu47SQRF77kHi+OXwxLNkPt6RrpReU1w+8Hc0onTNk+hItRlGDawBq590DbB6dC37eFo3QGF9lOJxOs3WlyZNnose6dqpf/Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366966; c=relaxed/simple;
	bh=9B8IYWDzuTyDAYYXoMaAmgUFVD4ClTvAvWxhVA61tnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxv/7kNp+9CbDyXWBEoeQGrH/V+5QbX68umPsgEwx7rcTmYMG1fZyXlV1+uk8J/XWkpp2/8QIAjAe6Sh+1HlSFl69qCH1sL4YLx6Pokcv4Z9eOkY1rCqousPzvhEIyZHdNfwr2KJiJBjjkPmgeSN47nqA6oxPgjpd3gPANjKFfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DVZk7Kt7; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DVZk7Kt7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYNFR56+1k1lWUXgyk+d3tdOrc4VVot6kBK3tEyfTjoeYH0V080+OuJkfsanRE+pzXaCsS3R8GrfFujfoymI50SqW/M3u+da2WwBcGqBQkYX+oWHgWfkNBdVpiolPh+RSK4UJYhv+ynE2H7jGPRYncqYY59gLeTCuenWTgPwNVkmTYVtWL7JlcBuzhMipFAcFaSv3QzDTaETEWATouuFUile150NyJY8ut9dFjtTKh8e6ZNAbR9Kl/Uu3B2sqYQ9BP2qxQUH8bak/49ump/Jc7S9FZOLdtjf2iSKKphdrRxUK49/DH6Mi2vKr54POqAg8ziLa7IrlBpqbqS0Ct2Jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD2NHWZohDVE9N8Jf1T0uTSS49qvbpKWbkehjSM6J38=;
 b=BZ8T6adx4sbu97v8SJOoBvt3yLApT9LbWWsh7a/X8BR2GVTmx6wR5Y9gpu8NccpcFj/4mpRRO/TI8h/6xO45z39MdYW3KJyUMnLsdiRs1uWFGCwNSCvM9hHtegkJ4FA56jFUpy28K8zgRhGeJJjW4+JHz/3LqPONjFfxFrB20yc2QgoM/ttG/ooyBO/VU5Yqen1eDNtlCQokdyt3Mp3jgtQEAja75lel8bb+DRwCEN0/n8CRTqoPjSCRAq2uipdRT2UGQtIHqecAzjViq5RdxZFS1Yptm8RMd7VNZvWk+rwZiyJj/Xccd4SysuuvLVlw8icfGQr/Huc0kHsUo4PIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD2NHWZohDVE9N8Jf1T0uTSS49qvbpKWbkehjSM6J38=;
 b=DVZk7Kt7MnAC/GIS2eR2Zdv/8pQDAu6gQmOW7dVa3PN0B0fEekFwZXt84cz0yIUnN7XqysfQRS1WacIV1KyyZzFYV55lAaSaoZfqD2B9l+DDg75+zS4B7u1EdIF1q+vU2uAoOAAgH0aVjMdn8Sf2hT9jy/rhRQHDJHTiNF2EH1otnWIq3PBYMP4HspGRIBVEHs3B1/nRN1UdyOBiQge2qWMiEsoqPzp0TrFPCIq2yBtRlA4HjoexrrulSTiTK1X8HaJgg1Pe90hrQA2algEPnH3mShcLb92e2C2z5gZKgG9wbO+TTXv2yw2qmZIyAT3/zhCIhEbNtl2By1fxZIN1Ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB11627.eurprd04.prod.outlook.com (2603:10a6:10:60c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 20:09:18 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:09:18 +0000
From: Frank.Li@oss.nxp.com
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kartik Rajput <kkartik@nvidia.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 2/2] serial: amba-pl011: use dmaengine public API instead of raw ops
Date: Fri, 25 Sep 2026 16:08:31 -0400
Message-ID: <20260925200850.1678179-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
References: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:930:d1::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: bde64740-6f31-4761-0d56-08df1b40e14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	EzWodgbu2N9aUfBegoiVoBHO3LfRTPwS1qL29zK0GpDyfLg3/MPc4MZPiLxhD4QL8zXhYYqBS2H8XAm2xtTWk30OUe+FFHikrEAFIfBNtHC1B2cpAO465OI+zeG29coxFuPKUAnXj988YNbQZu1zqdRvzqQN/2wCP2ZmNDuU+wyj8+eTKiaxOOujPIWkszDZtV/zpBesCQo21gSaoC79Z9PkSYEub1Nke0V6VZQmiYblFwOdgxKZX0OviQqR6bcYoqjDSeEU/WwxGKRvqZ0AxOqSM43cVjKPfThBqsI1VgyVUHC1hdEWto9orGP/t4/Xa3Ff3pjFuOFr4NCw2yIJLV1/qCCTx0kJ/0egvyJvJf2/BynONrlTGQQ6fSvHkw7gHcjKc/Q6/0y4Oqn7vyaC0Ix94Ae1qLVSDYB/jA0GqoXCJmPd8djAYd07wsjQsbWnbEry83FZDoJNt24bF920Qw1c3JlB5+IksIbR7NveXStPJ4gl56jCfpkrDDmDcMP3GZqueyAGrzikA20YAv6U5UwIzOtcRfkox8110ZJ0u6rKQrtWlRLj6ynvfTQlkIO+P7dtEX3zKN6O9ewRTYtjp103/WO4ojjJ3lm6NfZHJy7wVn2pLItSHrHlXqeQf+XLEeuRyGNq3TbyWrw5kchJgQxNlrLy79l7tIXV5GVrlniW2qX+Pt0cU9O9cehgnlDoG6q8SoKIw2eN6+q2r20RXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CiISzYfHd1zpasi632k1V5Zrmaw1wftX4yYRQBdhTKo5Ms8dHip16++ZAv1q?=
 =?us-ascii?Q?Lx9E7iFvGzqcgUMIDx3QsH5b2m077hUeoYsU5xNINFPQMyiuUlsUgBeJkVF5?=
 =?us-ascii?Q?A4/TH6LLJi/P4ZNS04opktGhp5MurMzpnPAizCnCsn0zEB/kcc3otpv2PzPp?=
 =?us-ascii?Q?or5IGgZjDbyQxoxRVoARXggpGKkzZew/2r6/k0V6A39lWwo+GsAHqOkftylD?=
 =?us-ascii?Q?LZb7kIKV2nyTUf29Huek5HumHn9ljuuyZS1zKrK9XxqwICGe5/6cFLdSXZ00?=
 =?us-ascii?Q?oyUgREDAKBWkPJagEw9jRwhvJmc7rmiPBsdlRN5keqGz/Ru+cKlpqYKXkeWv?=
 =?us-ascii?Q?r1u2/8aeqs1YkUqN9UK0Ur+oAApHLbWR9ytMvRlhIHGQBH5mpZui3HEgv7Nm?=
 =?us-ascii?Q?i0aSLoXvpGwOn5RHDUBJVZvZl+piGsplACjeG7mDbr04Wvk1YIYTpXseWNtp?=
 =?us-ascii?Q?ELAYFZENNq7iAyNEbvErIYWRPI3JoLSV7cEyUXZmPb33sYGUjVN3MgcOPHKt?=
 =?us-ascii?Q?tDTvZ4bF7mNc/DbUatJ3r63y9+AyumC4O20OVzb69tGXqT4vIdjt+1f25gPw?=
 =?us-ascii?Q?j+Kh7XcjaBaUDxgobveEEzf1sc9dOt5piXgCLl2fTO+j/l3ObwaVV3TU62ul?=
 =?us-ascii?Q?H7qtbh2jh/6pSkxPXE7qp2Ra2NC9Xr6JhuCpi5+no/Dp7o54RPoKH5OL/ZM9?=
 =?us-ascii?Q?kiS/cYGTl81irPqp5wtUmaA4TEnpWK4jY2/eMFe/vhkWrAJ+b4xYpB0g1auX?=
 =?us-ascii?Q?WNHOsEJwaiBsBdQvAX8crj4DHHfr9aDh2ym7vfgTJw6kGphGv8f2bC2rVixk?=
 =?us-ascii?Q?ie5P7szWkEBdHFz811I01Q3yPI5UjZqHQvLopMKq8ujOqRVK/HPBTaSa7ZVG?=
 =?us-ascii?Q?gAYa51KPQBU5lDOAVMazg+VuyPhfqZ7dRgk3pxCVJKDvLJ0n1COsIEC+LbI/?=
 =?us-ascii?Q?FFeUxGUYbcpIxjYI7JgAyYLDAnV5o+antB4MIWkkA3va26q5SOue+LKe3nS3?=
 =?us-ascii?Q?2ZDWa6ZB9Z7QwanDqi5uH6Z+OGJH65FvqDgjAhgLwGDuUwXGa0rf1t0v83Yk?=
 =?us-ascii?Q?zgwltmKcJucHdjhRp5NuB8KeZofmvE9iFKhC8DEnaeAYyWClloRi5wyapGZ5?=
 =?us-ascii?Q?qbW4PlFgPcgXvytedLFb9rBjEZHSiUsE46CNl5L0vQvGZgcv2br/NQna27qN?=
 =?us-ascii?Q?s2wcHsgw5zhRzcDuBFsBL4Mtpt5PXuphRvgAQDigH167K3rFlDPShnW8BGdC?=
 =?us-ascii?Q?cYBRCpstNc0zpiF3W0BEGV8MzWv79WveFgEM590tNCpxXMAiFEp3gvmgrs7E?=
 =?us-ascii?Q?lLMqfnPoRzLcVcc+XneSm6+keh4/cBBU9xo+58vBQISPqQ2elnfLqfppssEq?=
 =?us-ascii?Q?Qsb6HuwY3Mc9Hod+nixg/nIhGyDeJQHztw1TVxqJ2IqelGYclgbeeqYXCugr?=
 =?us-ascii?Q?vNJ4KiZz5+/0MEQs7/0Ys/Fd2cchkHArAactE5jX+rmA1qg02jQwPFrtmmUZ?=
 =?us-ascii?Q?HiryzjIaHohBD7sLkUJw8ZX1kiq4R6QV+zDy5frCFS4aP6zidqpu4h/kqXWh?=
 =?us-ascii?Q?Z6z0dRwYsgFfXf9L3/yAc/cUn1GsUMB7p4a1gnh9VlbaaY7n5FstXsYE6Y49?=
 =?us-ascii?Q?fti71mpv3N1MJFMuMbT/PgtBDlMfdNc5dT2k0+caCzJNIZPzMt9vYRTmoWms?=
 =?us-ascii?Q?XNl8JYcOf2EeDtHXJte3vnzgNTw6rZZ+yxw68JYIivLLaqJ2FggYRzdBW4Te?=
 =?us-ascii?Q?HnjgWFnbhlWvB/90IqDX/XVlW2eDqN5/yXDv62gQkDUVORKCelLA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde64740-6f31-4761-0d56-08df1b40e14a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:09:18.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgJtmdrTCXQV0k7JHzZIsk8AgHSkauQLxuAMQWKYkYFVvfnFKuo+xP8R7NtKUJxZ0YGGy0hhdC0xvx3WlNGK1OqRJWYSI2rr5JM/PnUZwcyZcTWepfP0WsTXql4v9rbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11627

From: Frank Li <Frank.Li@nxp.com>

Replace direct calls to the internal DMA device ops
(device->device_tx_status() and device->device_issue_pending())
with the proper public DMA engine wrappers:
  - dmaengine_tx_status()
  - dma_async_issue_pending()

Drivers must not call device ops directly; the wrappers provide
locking, debug checks, and a stable interface that hides internal
implementation details of the DMA controller driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/amba-pl011.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 86729ddbdadc8..cd9128b213c94 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -721,7 +721,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dmaengine_submit(desc);
 
 	/* Fire the DMA transaction */
-	dma_dev->device_issue_pending(chan);
+	dma_async_issue_pending(chan);
 
 	uap->dmacr |= UART011_TXDMAE;
 	pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -1011,8 +1011,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	 */
 	if (dmaengine_pause(rxchan))
 		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
-	dmastat = rxchan->device->device_tx_status(rxchan,
-						   dmarx->cookie, &state);
+	dmastat = dmaengine_tx_status(rxchan, dmarx->cookie, &state);
 	if (dmastat != DMA_PAUSED)
 		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
 
@@ -1066,7 +1065,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * Rx data can be taken by the UART interrupts during
 	 * the DMA irq handler. So we check the residue here.
 	 */
-	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
+	dmaengine_tx_status(rxchan, dmarx->cookie, &state);
 	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
@@ -1124,7 +1123,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	struct dma_tx_state state;
 
 	dbuf = dmarx->use_buf_b ? &uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
-	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
+	dmaengine_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
 		dmataken = dbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
-- 
2.43.0

