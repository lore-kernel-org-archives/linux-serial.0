Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03A168B1;
	Fri,  7 Mar 2025 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314392; cv=fail; b=O7xcyrJAsRCnQiXl7/8kJw/lZ0k2/mM2jnlOapxjFXLnH6c2rVq7Jvb1DBIdpU0tU5RpNktkg55j/bAA8bQeY2FZxz8oeJWL6mXsnVqrMx/0kY4RLOadL2/EL/I/vVG+ecwubnyXxAIfEL0CxLVUhI4vp3/Lpd0gzX9gOjX1jDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314392; c=relaxed/simple;
	bh=Hbl7/6QxbuM3dzINYerbOjtBySoeTZrBpn/K++/WMZc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L81DVi6JbM8yI11L2BOEXBgwHO8P0x9XVgsYRLu51JTkAOb+XdDh3NY8KWTjPmK+b0EunkOXihwjj8YjWoPjgxHbIpBRrQSsfYDn6yDoSbkQCkqtAcZUdXHlT753aCvtC2uscPMof1XtH/efT0rLI3Ghacz8w5S3HUwmK1xQHA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lzEi+W6G; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lzEi+W6G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhzN5+gfgTE35zCb+bvq7m0wyO8QEBCruf/nwlKI/zlmsKjOjWH3QqtLm554RYCOjXmY/ikK43+gkUm5cODoKEqzSxOyEpCLIslIft2GOvQfSczd4hMJoCt/Sk9Ef4ca5W8EnZ8xP6LG41scQdZyY/mwpiTJF1nud5bT7RsLx3Y8DH3AX02iaNVPlcjHMjGFFZOf630TPP2ETnQJENpST/3H1ly4k7gzmDDvzCKnj4oQ3ucMglDCWz51fjuyYwFm/zM1+veiMdAB49o6GWcN4Ko/vS4MX9WGndhfeqXcg48LAynJGKauXM3107AYG1z+caNaZGXoWPUcktmZT3LGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qOSkXKPPKSLnqmtQHRtxaaS1H698NeI4XzKpeaBX6I=;
 b=e/6+Tk0QeTCH79QN7IFHLuhrL6JeKD7OGtyjfw0bQbJdDe12b3vdHzYnZ+E5Rpdd6EbS+7slWl1Adh+jQVCgWeIZ62ZYSrOJ40Ce4E2qeBPfyrcPaDOiBYwJfxCRLmA9lElgWfuqMcAgf4zg1MaWaaZuKKNOpamSq3I4azoezTftvZ6CHeLC5WPo/2cj1WDUUVJ4bHJWj4tmZm9NptRKvCLoRFiwnt0GXfby2w9ZF/mUWyLb9fowTPkCrc4eRU4o0Qn4QsD1opwXuWKVuSKJXHJ8n62JUxREu6sHzFb6lTpqZYWvhfpBoAXlzPkF73fQCTUHdA2dNxnxVJFNwsqPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qOSkXKPPKSLnqmtQHRtxaaS1H698NeI4XzKpeaBX6I=;
 b=lzEi+W6GKYPo3WzP/3nRw5UK2gjxPXBtJaKFjV3wFL+W+aACu3h9FDN+mWvql976gQYOegaNBJVdxxLvhEIZMMfKjXkjvI3Wo/AFzjR7RlIKAKuatFW89m/9rZLSQfcFdwvYAAAg9Ri6PHYDR/+mkZvTrgFTYvNCdcKgGXmNSFsOCFw6ayeXOFJeqnkcdqazm3/6dMp5QWkl6idX/6tXzdYLnl67U0FgTJjH3gQsORxrQ52HxrAzO5do2EUOliFUsYKZTbeW/eJjxNQ1uzBe4GY3AZ7LfOEw1xFz9oJ0zvbIry8BZDR397cU7H05RWgPZwijlqUmCJG+hKYN5nzw1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 02:26:27 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:26:27 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH 0/2] tty: serial: fsl_lpuart: cleanup lpuart driver
Date: Fri,  7 Mar 2025 10:25:45 +0800
Message-Id: <20250307022547.1000293-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a1ad47-46f3-4ca1-7981-08dd5d1f7696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXKA5Vn3F150k9G2Zjp88pAfsnEYNe8zzGW/Hv9KLi4Kei0sWS4rfcuMROF7?=
 =?us-ascii?Q?x2BcRWKACIeUJkxGFTi7E5afwSS1dTXKU5k3/9zYMbYR5Esysvx4fC7vPaqE?=
 =?us-ascii?Q?Te8GSt9vZ/AyTmfOQj7VjnOlZlU0nkDMlrnVzRygdXQWMq4Z/PC10adTs2Bp?=
 =?us-ascii?Q?L5+uFFv2Y73wVO0JGhTZCgPeD0cT7x2h6SGKJCGecHF1hUIJaXXJtMXIOpT1?=
 =?us-ascii?Q?WL0gLSlyp1GMb5KvqmrQ0b2YKNKAY0E5f0Bcr5tpXCfnGh2E/yEvVi1fj26N?=
 =?us-ascii?Q?AlZ1iMjbFeeZSzLeOvazLf12LZFXrB6L5V4v5mD5fWAoACsCu7FtNA7bL+Gu?=
 =?us-ascii?Q?LSU/pggqTaJTTmjnv+hT0wa+OJ1EWuP/ZdDPtNhIP1AC9rngfB2Blj9WBZ8i?=
 =?us-ascii?Q?ygWHEdwH30TJBX/J4uFsb/BlcR7dv+foKIrBEEPaqf5BdqlxCvP9AwwTfEYq?=
 =?us-ascii?Q?eWxaeJLaMCilYrkT3gd4CiRYAErwhqHLcX6dHiOleRoqOd5nsAe0yElXTs4e?=
 =?us-ascii?Q?JmUQGVKAxSfg7KRAIua3/TRj0sQUhYxtHlTW9qHYK9anZb4TpoUoHzAWjuqd?=
 =?us-ascii?Q?bvXoMshPgwifjNY24MR5Sdlahf8eH0ye/M9X2F348PewYTCwr/YGbFoTq+fS?=
 =?us-ascii?Q?U5Dvsnm/+0BFHU5173LfKO9pjYPLDQsWlvJroRYKHl6I3Vi4mZChxydi3zAS?=
 =?us-ascii?Q?84POTBux3U48FN4G0opS5XGJuehedeCQ2qfNWyNnMPhPyWhTwoZtk7kXP7Zz?=
 =?us-ascii?Q?2D2SLg8SUoPVBfcZhLnXskET4ZbE/EAKHF4sTK2joYSqPJllu863/CGqcOn2?=
 =?us-ascii?Q?E5ebnv6/0+66A/vrj76VywghHwNGQvoYZcGcCC0HI/7sWp/KxAw+8tRCrRM5?=
 =?us-ascii?Q?dMyo9lLyH44EfVl1dZDunDm/GXOncJeo3K9ulss1BO9wPc+mZ07c4PVga2fo?=
 =?us-ascii?Q?ahm0mvjCfx9cHioIQl+b863E5P6Ri0hXfWRHGQbiIgLhJBD3bDVYJbL01CR9?=
 =?us-ascii?Q?QWJyJ0XJgBqT+/x8vBfX/cOLWzZuf+MaQjJ86VxVlU/Bzl8voXAzopAEG9UE?=
 =?us-ascii?Q?eSURRDvjv6MjwL2GlKG7X+nXZ8XJpOKZkf5t18YbbNwtGYcwyWgqzSjO3TR5?=
 =?us-ascii?Q?mU0IVjU4v3bWPVj9kyXIxtxSWFKDZjryZ8QALG/2X63KO0oc9FpuGjQ5/ucM?=
 =?us-ascii?Q?+WbcpC3gf5eJ5+LTE1k0AkovJDthcQIHzt4i15H5gcp1H1SK7B0Xj8s+XvH2?=
 =?us-ascii?Q?z0/9InTlj7iuxWOg1+EEOT+lq2HygdbCkZeWWe8bfZx1zyTHM4E26HQYZzA4?=
 =?us-ascii?Q?GMKKjDDgKkDUXhLr0+z3LL54JKUxn9Iy69ETiLRVusv6qBoT+t+UxffKtx/8?=
 =?us-ascii?Q?3lYALG/mbYdKGr0lpDJEFll1bDDt1mcB9RA4Y6TKOBvMc7PIfb3iiHok0m4h?=
 =?us-ascii?Q?7pphAGSqHkgt7DdEF5DknbIi1pbc83xH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIjGUDoodPeJ2CQneky0YoEqn93x9KoxT1OOfwIdBcle4f9yRTNcuHvpN252?=
 =?us-ascii?Q?z9iqVhDMX9gi5Ns65t5va+w4nO5BYcvgAUE+Xle0uvRfyfhGd5TQDaB7z2Dv?=
 =?us-ascii?Q?vEx2cmoYvs1Bf+WQk65vb+C2qm1Lx5Su37B6dRj8z2qTGafVwl0MQt3tvK07?=
 =?us-ascii?Q?38QOhH7vfC2NG1ZRROydUDaAa/BZKTa9rtABkMuzNobwObpd2DimpheM/U/i?=
 =?us-ascii?Q?tPoeEIBeoambEWC8dGhPVKlWMxPhlXGm6LC0fEWaVyWTg89nQnBPa8Jo5XGg?=
 =?us-ascii?Q?IlrF4cYR53TieO+59qrzXJR7x/CnWvSfKOUZWAPiC+S9ELHQ1GSHvFoUKWEV?=
 =?us-ascii?Q?X9lvUrmth/8gI6H1PvGmG3h4P1mV8Y8xusIfdV8sINnMjzvHEEULrvJfcbSD?=
 =?us-ascii?Q?cXhMZDc92KWbL99BwjZciV1JUS2KybrXU8SHAWIT0IfebnJfZWg1RqQrmBSB?=
 =?us-ascii?Q?/ejegqKRqdWr3E+BxqNeE5IncisT2XIG72rTOwK8g6q27c85Q2XBv53hz9On?=
 =?us-ascii?Q?JZj9hPiqR4C9E7iPjuD55h1oxbIxuTMAI5Ju/KkobAVsyJXULb7Cmdsnn6JB?=
 =?us-ascii?Q?narMJLOFMb5VPgnFytr0nD17uZMzMYFlVh1eKL9/CJw4lFJw3FDb2wri4RD8?=
 =?us-ascii?Q?+WAVf3rnShheRnhMUqJcDmjQdp/sjxYbw3ph13b66x22/yqzbscNwuirxJBo?=
 =?us-ascii?Q?5Ga0m+N27BbnDyLcuLn8yPmP+NbG7oAQjWtk9xi6weKsftwesou/bt+IB26T?=
 =?us-ascii?Q?DQ2HY4atn40v2GWetjmiA1ayqPa4Y0Mre8G0X8p7sgB6BnTnTkx2pJ9HJWth?=
 =?us-ascii?Q?t+jyB//0I/PwiDNUuBlaesrJI2VOJUe2/fGLWTksEVACs4Ng70A00aU3S7Ef?=
 =?us-ascii?Q?9jDjW79XKrZ48+d+1goPgPOvjPB9O097nYDN/UPZpgEIArFvhLwjYI3tEzuT?=
 =?us-ascii?Q?IR8kH9OgYR5USvNDlHAlUmH1ht5sZIfj670jZ7HZf29pTkH/Gb8xfpUhFwd5?=
 =?us-ascii?Q?Kp0oDSVd4QcJbpGSRwR49rvyYfWqcQ+zGOWDJ8425opS3e6ZqJhi2iLOebKO?=
 =?us-ascii?Q?xY/tqel92JkUyG7cB7HdVb3q5KMNWrKgpsVB6hWw1mNNlNBaA1uOYJsuM4HQ?=
 =?us-ascii?Q?4SGwlmqs78JvcwlMIsOGUfm4xhXPNDcxy9O/JX2k4u7qat3155BJdzBLKt/u?=
 =?us-ascii?Q?QvgX6KZ9vLq2M476GGAcJFdHAWjKvnANx5KoPVOAoZ8FSP+Jkcq8Vse1kyfq?=
 =?us-ascii?Q?6h/uf15od4/TfbZkW70a4d4Rcap3A8CVQDaASN/FoTY+bFeWuqYGmGg0u9wj?=
 =?us-ascii?Q?za/H6AKQPrDYTxgSJfWKXFQ2CWfTD1AxxfX7gq3XZDD9T55QZYN+sK18tL7k?=
 =?us-ascii?Q?jVR1Uj0pCoGHRgGxvi1ADWic9cSxIqBmaDLBVDer9o8GGCZ8oYvkBHVQpmTO?=
 =?us-ascii?Q?KrVf7MReUOVGfkoLMA5eTai8YLEDwP+oNrjpPMzsW5AnPmH9lPh54hvInUFM?=
 =?us-ascii?Q?rRpjjeEmhKG6ArT/55JHQA4rrWn5qYZiQt0xKMQSJQtwN0MgrGrW/0doIdXJ?=
 =?us-ascii?Q?rOIty95A+UZozlHDFrubvw4Ty7KEwn5Hr4yDxa47?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a1ad47-46f3-4ca1-7981-08dd5d1f7696
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:26:27.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5UigSNydEEl659OUKm3i1SNuSLRC5kYp8ReUTIb+hNshjoaeZbsI9FyqDQvZQ5kTm7T2250sSbzmf2zWQ5xlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

Do some cleanup for lpuart driver, no functionality change.

Sherry Sun (2):
  tty: serial: fsl_lpuart: Use u32 for register variables
  tty: serial: fsl_lpuart: use port struct directly to simply code

 drivers/tty/serial/fsl_lpuart.c | 260 ++++++++++++++++----------------
 1 file changed, 127 insertions(+), 133 deletions(-)

-- 
2.34.1

