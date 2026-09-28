Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82E37A4B8;
	Mon, 28 Sep 2026 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620398; cv=fail; b=npMhOzqa2dMBdUZP3IJMuYgdvJy4gt7LKcHN4UIvua3++oF0Lpv2WCYMmtBg5wvKK36dTdgQiyyrCwI+p8o3CQY2ylsOtB7Chb/M3i2p+fb0YItrzlPbY9OQI0F8Pf55SEgH4BfypvKrijrVZRbmoEsbfjdZd94oeEEV4cl610w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620398; c=relaxed/simple;
	bh=ds91Z1jOq77Y9HAP9fdfFXBQmgCzryPA086o6Z9rlTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pET5hljVInJYdf6rnaz5zNJUESlEn0iSF7PuTH9cDaDdrv47wSdunjM4KIRx6hw5no5EMvADO8cMo7d8nuUt0mtPmCGW2Xrr+XnvVnJylKP9Nf/vPToooEiFzme9aBQqUUT+vCTAscTq+XN7LoS6HARKtDdIXj21IdyrpAMi5/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=r0Q2izSD; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r0Q2izSD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK2SRRS/JLgzuB7SfQ6sqMHN/qcmspYS2bWpASXLIH47M4eMgKw6ADMy0Nu5JTcfnv0tPlJvukS3MBO45/OUfjReQxU6AhuGrC2HXjvGYuvF9lM1CuOTCaA56wb5VybD8eigSc8h9+/bDj2CUz3m9EnENxxg9sjh4AEdLaFU3Aw0YlPYzJkA2l8rdClDRn+hmZu18KZKEks7vFF+5MQP69rE1ocm4UNF/4OIeTKk/cQJpNBFCbu0F3hcPl7UKwFX8cMCqj4oYPktw7h5lhfjJALHJ4hwBYin9/VW2Ah/JG5NIz3zIB1lLYl1w20IytH/fnwPxHZqeZ8TnPElwbcT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfo9yQbGx8NcPTsiMp5dat4kB5zyQKJsSdJX8uhj45o=;
 b=IclUWNHuvZStGbUUX4bvNOLlLX9gj8v6CfYQt0yQq+c3Qt5aiXgJC5QltqPOeET1GH9gClc2vRiNVDYGp8a0CGKcWk97BMg9P2ZttzH+J5UTINVuntc0aCiCIZ7W3bhCZcDLEqH6MvR2QhksvWRNUY0LktjgDUY18CLgIWr/ufo8SkbQOiDIRYBZBFPyiDvgebJq6gpTBg6bGVlIaCnUVTA11kIx0y1EhXoMRJidPXWg6QrzZxIlfuA1cRn/mFHoUliQmTZniRUvmlhhn3HbGnszHYW/YDK+ewilNnVq/Ngldt14WM0Yu21QFM7ACNstOveaLMN9ZI368KRyTyuTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfo9yQbGx8NcPTsiMp5dat4kB5zyQKJsSdJX8uhj45o=;
 b=r0Q2izSDbLvXlm4h9s7CJ2l86L5wH+G05a6BPaK/syGDzlo4PLhiodPzwhhSlKiHernVp6XuDpL9c1KwCkqrIEK0f9v9auMifw+tnqacNUO5GDXC8S3oYYcpl9ljEleuA09/C5Vw0iSElmU053NzT8r8be9YHvl3fzpl5BZYCjVSsZhgOZW+JlgxH3g08cM7/F0JM4C4jbZfM0MLuV28Mc0fu7UOQ/Tru8PHFPwtPHifCHuPv27k7Y7NliFS473cabr1odcFc4rGAXVGZjz/dhBh2+kZbx4yTjFQmtpzMZu4gkIkM+PaMvDcX6cFfIRFbrBrNaDw/lz5PGcJVlgwlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU6PR04MB11208.eurprd04.prod.outlook.com (2603:10a6:10:5c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:33:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 18:33:11 +0000
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
Subject: [PATCH v2 2/2] serial: amba-pl011: use dmaengine public API instead of raw ops
Date: Mon, 28 Sep 2026 14:32:36 -0400
Message-ID: <20260928183252.1965169-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928183252.1965169-1-Frank.Li@oss.nxp.com>
References: <20260928183252.1965169-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU6PR04MB11208:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a9c1c6-4246-4fbb-c813-08df1d8ef350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|18002099003|22082099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0AgTVO+xSagzudRvf45rHNOBTAv7x/m7ggcVXwYXV3l1lJze2w8p9ifQ0E7poJpT+S6wzNLXgifokXbkJCP8afHzw+THRBOj7uXw49oQ+Ff92AiDD1emwgnmgWqZWPWCa3LQ79znDS6tnrAUrf0qGtIPi1V9p9oZ0SgUrE4xGP9j8QsQJVXgiSXItDODkpbc0jcyA1tfq2ZS+28bHxQXW++oprML31j5Ndn85cjTGHSeMYWBlN7yv91ezqENQ0j8I6Rg6H2N/5egweClBeLjrXof3EVURAzHXQOy7oOe/rR2rC6m/Nx1p5uyFPIDjSpRLtaJiFbWsIR/MJjGh0y8VStWnKgM8oyGynyA2GOmp/s4AScMX5vQKltGgIuDjMXJJQnk1M97PBnS+MppdnDr/s1oHkRMCy9Qx93PIYYIYKYdo04IyMbQqKjzsHVSKFIc6Rnrwv+mbPCuPkUxbmj9MEmDMUO3l7gLdpIs/zVMMzFx2V8SHFy4UJRoAHd/27q/CIIMS1L5jMLYQ7K/HNYmufC6YW3bhFEy66Puon87oJ7pjW9GF66d6oyLF0ht1Iv8xPaRFTO1oeX08ZYbzcIbbErHx77/DfRt6izaph4hPIDn9yOXTghk9Tw6R7TeXNGYolJZO7/EgndHqPowuatRBD6tnDv6+k1HF6wtMDPim4GVXeddpp22DPHQW2vpdX6j2hL3zWviM9rYf3Su9KdMug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vcsk1Jx5xFVKG72Vlk6kKsYW6pK0UKJX+9f9lBdcuYRTK8Frxocw7L3gUf5K?=
 =?us-ascii?Q?f1ZFiFdTe4VSC7vUju9wAJkotJxCtFxjWCaPsUuPAJkNt4QUQKXszMLt1srK?=
 =?us-ascii?Q?9QC1RBlSXvdmheDp/YEkqxjSdBLJ8EwEMFxW8zahqPyU28Fyr08H5zVr0YFk?=
 =?us-ascii?Q?MR1YUrRBOwJAfEcm7o0NQ+ifeSyZPcjTIV2qkVhHSD2Sqv31zopTNyS3zK3t?=
 =?us-ascii?Q?ad7ICvD/QVfh1CV0V4NEsVwJT+GuUmUSFt2raqQwP3yDfs0HFqKm6c7cSQyt?=
 =?us-ascii?Q?buRs6Yfl7qXDHzKANWUgaW1WaDMPco4CDp4xu4O51eJNMfoXoQxRXfbsWInK?=
 =?us-ascii?Q?n3lxgH+paWteSkMZHXKDdYi/3W0/yG1vooBc32Zppm7hWu+62GTwpxSRw1Ds?=
 =?us-ascii?Q?NFif3pjbZmgte0T9qVSKq8yDqyR7wDbsiVCH/fjAAq9Xij9jmIDfc9LF8yvV?=
 =?us-ascii?Q?Z0ODiX/Ve3yWq7VFkibUf1Bp2tSL58ol1Ss8Nh852WEd6PxPXGdTppsaoVrD?=
 =?us-ascii?Q?UaMHDw8jZsbHXX2yUXUM695o50jjsvGoqILClYAss2QMyiYDQdT7z6UYG1kd?=
 =?us-ascii?Q?CyreFhRc9YyWfUIman6+yJBBTv0tSdgrO/6C5xUWruelTeU2/55/EPJYf7NM?=
 =?us-ascii?Q?UQXdXk+79HNWpw4mupnbC7NwJumof4XVwS6C85Y5EQaByaehp9ef+UwqlAdy?=
 =?us-ascii?Q?DljApvZ2/2DzbnU104Ck3IqZCzOV7bWRSbJMo9EaNOL5J9sqgkLmhSshcIlf?=
 =?us-ascii?Q?HW9CD1+yAUYv4qNnMOk6RbsMPPwvOrj5YMlU1TTFw1m/IVGjhZwx5nfQUSVU?=
 =?us-ascii?Q?raGt3GBdTNc71S4dBc4GAYZRntyIMOptiizCnSQ5r3g0pzFj7teHS9GxsMBn?=
 =?us-ascii?Q?tYAOZlCqyA2UtvYy4sOwRx6QjxGo1Ia44pfMq0vcvBmIzpwM3uFCu/JgUly7?=
 =?us-ascii?Q?UYmGFHZHnyWGDySGanr11/ICGLpxVpZS1iOOt+q2WeSOSx9wxIHVg0OAKHK+?=
 =?us-ascii?Q?UD94AO1747bfQgDJWDqtUIbgWvNOTbcj+V6VWNhDvRZFG07HrNpFojsGt0ma?=
 =?us-ascii?Q?1gsf84m/t/4V92Qki2KI3UZPhJTnYMUYdAvvWZbCHmE0j43+DTQaxxmSdJN5?=
 =?us-ascii?Q?hFSMfDPg83tQfwaH46lykjaX+WEO3Q5irS6ytkzFY1VaHfA3sbjrYEnrHVKn?=
 =?us-ascii?Q?nJ/a3bBwnjMg+vfZbQoGoajOaltcXVlhrqHX9EYeTv4ZRuOntmYMnnqXkwrL?=
 =?us-ascii?Q?BmhU7r8LXkUxJr5Pm3PwrVMzYBKs1Mt+OD947IjCkaXmGdPWP2vZ+194JkIU?=
 =?us-ascii?Q?rXgEmZ5y7BedTJA1YqBOaA9IfbgHMOM9YbjJf8lqdiQNtfQPA9KZEyRBZ/HG?=
 =?us-ascii?Q?DoQPilKuTISbqEsAb2/LZMlN0bkuMhAz+cJXO5T+gzXn1BuBkPetlm7mgE6f?=
 =?us-ascii?Q?XZgwgoUtq+ApPWaWcIUWTyefvdMLMbH6URNNii4baYLJQmxAFFITtZB0szDF?=
 =?us-ascii?Q?UYGyY87UjPyXnNwj8J8s+9E8XIY2Hyquy/RZYYzlQV7wJxumRFI8qr38ptMb?=
 =?us-ascii?Q?di+lKz7Bykd9iF/tqrshdEYLGy3Iw+tpiQS2Sk3ByBVDKQZ/2O2LudRDOSFO?=
 =?us-ascii?Q?3xWz822bnJw+dUCYfGWFn5zAjpMORCclfYGEoRQekPzxnTYici4DKS3Q1p+6?=
 =?us-ascii?Q?BKOtqTqksLb8B2P0sA4+/XDZGh7SecmvhgnWc9JmZ90IUaphA6AEJ9JLFUx+?=
 =?us-ascii?Q?LBeulRFGb1182aiuIgI13J1pYSeNJ75SmZ7USuczb6gtdGuep6uJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a9c1c6-4246-4fbb-c813-08df1d8ef350
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:33:11.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l52vtvJnUiP4/RDu5OSREabi6g+fQJ+LKMBuab3B0UlqX91cD15FVBs3lcyrnn7yDghwG3jw009IvtzzTFW3SN6P5igFHyqivnLNtX72iabdcvzxSResmLs2IFDPUiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11208

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
index eb4ba78815028..fcfa9f00aec65 100644
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

