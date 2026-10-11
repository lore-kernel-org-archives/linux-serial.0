Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0F443C19;
	Sun, 11 Oct 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791720094; cv=fail; b=nzJ9rRz9rUD0FaKrBG7iQo4fRE4iP2MGhdcziPbAvRR8TjZnLK1RLTrhiZqQBB2+42UyosYDL23utjt41qg5l2RSyc/LUELNPQbGYNh9pGfDi3zvQHqwJaj23lsHhicx7RtqJ3mW4kmdNUOSiQZDrkpg3v7GjpBnq4qyslXSdeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791720094; c=relaxed/simple;
	bh=pHjGp1dTFCNKqMu8nOBWmsA9u8vF1ho3hFvk9ev5Yy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fKlpJ+vk2x0vpm2S0FCyY+vwgxYTAMJgfUGVKvHtnS1PWSxwKF5LUWrqkmL4M3vMUMcyWFNvfWMIhg/AUiepQZiVDCE/+7KlIljQvQVJc89WJTjIlGtfUuR1OVwra0briKlBsIitJFe9OFJ10EH9Qsm/HVhGQMHqUeLtYFUdc+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wQifWJl7 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wQifWJl7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD5m9GM4LeJRCh8pH9cA2zUMxSlJUeM0AkNsaYJxTbqV9sJ83ymrSNNtNu5qx1NiO5I74Nl/wk01TWDGOv33Tr3mxi1Tfaj3UUhVknNqyUP8XfsYfBFAKFcj/42dhgqQcbi60nFXbZa8eoIixK28Yxg9SzZi0JBxSgBxIkX6cW90H6UVfx9QGlUGlvfrF/bMoAMAn0ZU777oQUOQ7vKmehKCE4MTJTAyto+4u4fv4I2H8D15K8HJAYX6V5vUUP7L6herFyil3QVDqY6VYcgJfPFQIu8TS1AI6OdXooZM0biZK3Ff/wp7ACewJ36dBLbfZy4pFTFVpKEp7EtB/F1bpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4cW49dPSdMItJufPP6UiKdorE9HqzuU5ANKISC/iYo=;
 b=Maan60zbaw7v7QyYkcN25HYGAC9nj6qhHo2rTlsPMN8yVeH0q0RW2SVPEt0EoCuDj5IMBjxYCS5/iyi8vR0pF4gPp4KZHh9dguYOKWug7816pXSM0whN/r6ZSL3R8LZKWsbnUCeaH2nd0VB5nZGv0fSzzr+mYUQ7Nq3xDLlVDk/W7In16zWMN/mNuAxHb+fG98D08GszZ0Sijj4StwCu3R3nOjLnHhlE1wVPxcidnhiXJOQ8FBmbwlSGRoIEvhorDUTJ105O1F7CorsZgbzE846VwvVBmY+BYD3MidBaoRcnlHwhtENBP9MHQ97PiLBbXzT5ycLpSbIQxePlSoxpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4cW49dPSdMItJufPP6UiKdorE9HqzuU5ANKISC/iYo=;
 b=wQifWJl7NGSCacyZSYgWQjTDpPWyKiEKJJo5p47BwnV4ohTUGEnIcMfOuODfnDTr4W+3XoX1+M7ANgBmLLB6nyMBgfS0ZU48jozS5Eas7HqkNfQhumgf4KxFwB0Eqv9RaAaD5z4an2lA8n31bbNvqDc4DefASG1bgZht9LLqsYykBbzfkGS4dxbaO7V5azhdOApW1qfZo2jU1aKk5S7dETKsAzsZ52mGn1VefTRcB2pXZJ9D++6KvILBLWYWWJWbhw3xhR7Nw9JH9U/hWfe7X9rvBerO/sJwmJ6c3+wJBSQtaMFq1BWnf+fpiE0VLRAsu8YmPg6xRzX2cuuvDCPw4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8389.eurprd04.prod.outlook.com (2603:10a6:102:1bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 12:01:23 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 12:01:23 +0000
Date: Sun, 11 Oct 2026 20:05:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 3/3] serial: tegra-tcu: Make use of
 devm_mbox_request_channel_byname()
Message-ID: <ast7pC5YeRo3qCgm@shlinux89>
References: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
 <f641b6d092d1ed92e27f521e9028b5d1da3f63b4.1786547950.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f641b6d092d1ed92e27f521e9028b5d1da3f63b4.1786547950.git.u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: MA5P287CA0150.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b12305-0bdb-49fb-b937-08df278f5ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XFFOXbtFLNqPguvAmyKfyAttpzIVHsmlKqzZ142TamIE+iHd4+4Xcgl5lQjkHRvEhtIuk9OURV77M55xjb5j8Tf0V52dx1UONFLtEV087L8dmvM4u9rKcWAnE4pBYDu3/1ltIXK6pWEupvhhK730qRBVqB05TL2IUInHevRhbAwy12+impZNBsWRWoLwR2EuNKFx6LiAO6hbtbCoYZrPLtRIF+86r5XKbKyQIftp+6w1XTiDfGZDDjMVIFx5lFSafij15ONQBLB90/vyYaBGS+dDqb6gyQUBdJeDgGDpGcS++cS2O20TXk6Vl6SlzH6iCPp5aOSc1VOVgwaElIhN+l/eePWIHQmYmEfHb2qaFl71gFctS/ZbFJCLz1+XQO/MowyqTA70KWHRAaboqbliJzKSQnzqJAnEx8IX1xrcs+bMD5EEL98BySp8ovg5d07yPG3oCDFy7QQFtE2dFFe1d+2VahgtLYBFsXCii3QeE/XFeqd13oZqYyPoXyBVY1gLs/suMUl5+7cK/KHgTithEGtiHZXnH374gOmOxdWg6Acw4a37PtElJDSgEbHNF9lV70kyXn26N3f+tVbH6rzQdDLTVudZyEE9UfG+1O4DjJrKzxzgaOIm6h+kqsk6Q7jXbXa24yFwcP2cDDNbnXMKhGVNbi47tJnd0snQQ5bWVtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1KLhHg41TgVQ27Z4GxNs2UmsZ/NX/ZxtCRto9T1ca8Uu9XmqdtJi1cwSek?=
 =?iso-8859-1?Q?jI7kkaSkF63U6R+Ko6buW14g0TFrR/f+g4z24CXmbfha4M8RsE6n7kRxa/?=
 =?iso-8859-1?Q?d/xlbgvCeT8BtrXt2ZtjkCEjTKjvnFsSgNihMoFXyM2gqgPcq38nNVyH9g?=
 =?iso-8859-1?Q?MWvlKmhq8ZQOZHaSSu4tIlf4Mw/ptqNgQjsPUhmCHbCq6ySmy1ZN4dqcFP?=
 =?iso-8859-1?Q?q4sr0UAjDbJhSjPbtqLCMGX+ZXuiqnbCvj/9Eg1eOERzEldqY+OFgD+omT?=
 =?iso-8859-1?Q?Z46p0WtdULI91GKAKIYzNovNAHl+/yohatpQq4hesiWn0c5KOYGDn+s63D?=
 =?iso-8859-1?Q?l9oBxE/7YhD5n7Q8eMjUARxeCyKpKx46L29RDLS5IsvgrxhA8Jxhs4BLRR?=
 =?iso-8859-1?Q?Zm/htabMj9X8fGbWQ9KwZZT4rZusdP7xi1e4q5ijP7JOfEj6xP1XjzNoyV?=
 =?iso-8859-1?Q?rIFLV/uIzUJm42XfMnyI1GjISp5X8JshPN+RIN4t2vM9rse41rTiP5V2u5?=
 =?iso-8859-1?Q?ALsSnjNz07ftGjBPPmFLUXsOCf4QfYljcz838pr5YJXvvDZSvmtsPOylFZ?=
 =?iso-8859-1?Q?OgqhbRF8G4M2CNFnO2NhemSPHKTGs2u/48aT+tkpKavJ2gTna9ww0tc+OH?=
 =?iso-8859-1?Q?kjrRhqWDTlKbrKZjhwlC2aumq5hPhoGd+fDQD3SyO7Eyy3/6RHqs/awl7t?=
 =?iso-8859-1?Q?LOS/FaGkBhrcXYKcsFNGhzg9ocWtE24zuahqRW65tQgzNk01WAbEOQbRd6?=
 =?iso-8859-1?Q?cPKvWiFfUKcDafRwRweLO4BfwYyFwSF5gpqdt+T5QWY6bcYZK3undop3PR?=
 =?iso-8859-1?Q?937P2S06jQ2N3iJSu3xAwybOO5ZusaDwyntWbrog+wfmQaezgNCggQ7cEE?=
 =?iso-8859-1?Q?z6IJkTKA23lAHJpxZSumrsXIJQdywNajn4R2f6GqtmyGGuQGBHoScNNrTf?=
 =?iso-8859-1?Q?bcP1WrUT9WOhhCuP6zGzLmj4smUPlWp5rPwtbW4IN0AOLPKda1RM8rhNGg?=
 =?iso-8859-1?Q?9WaZUZ+RxTG9gzXNGGOdfj/UaaY1gJQVZx07MBrvKS8bceE6XyYpB1C8xR?=
 =?iso-8859-1?Q?x/Fx0z7mBcrtY9O2BeFdDshiM9qY1gz4Ig7WgrEjA0x3oEeUn2dQ/QNE4u?=
 =?iso-8859-1?Q?DtjGZgZOFiHGc7GnTCbVBtEbyXpRE2+pBWYQ942uCrun3XI/RKP1P/WH/U?=
 =?iso-8859-1?Q?YH9+WDMuq94B9FPXWY93/lQakp/KOcHjdwpZaPXowjZCyHMl8Gf0qTzK6f?=
 =?iso-8859-1?Q?cXNQup0UvZKnNomrYGq1zSXYTbqIR3nBNWzCZQ8Dn+641qrLjHVoot+bsF?=
 =?iso-8859-1?Q?aFEJskX3j+YVvHzT+RyA4a7TuUBdtRCxjx3bwVqnYM60wlCq1RTbSFuMfK?=
 =?iso-8859-1?Q?vxT7j88wEyfMtWsp+vzmnXWkmPoowcmRK11aLEqMtx1SuXzh7/dNzPgLRH?=
 =?iso-8859-1?Q?Is2C3M+hzmEjHigc1F7aeopuv/2iu0VFc103OIUU+z17399XfWv5RX9hwf?=
 =?iso-8859-1?Q?iREG7B/6s1ywRaxaLPfo44zx5WovPWPaeo9eBo7d4xM/tU4z1rYuvlp0l8?=
 =?iso-8859-1?Q?YTjhp+skrl9AC2c41os/wW6gXTSdnZCb3ir8KHHPRYffAFg0UBoWCF1+oP?=
 =?iso-8859-1?Q?j2jSM3vQi8yf8ZxEhvJVdQObnkg793lQEGczAgCIzW2El/wqWSq5rNXd87?=
 =?iso-8859-1?Q?QviHwXYYgxR4xE0kvY4/ttbidPXkT2ZTFRtE+qIBU5N7+qa/gZfw0PAXgc?=
 =?iso-8859-1?Q?dKKuSLMUvAs93Pg9KwekB5kN/YKELgKXdG/Ag8IQQSrv4jr3attnFerr5K?=
 =?iso-8859-1?Q?Q0ySgtgGcpXF6zpqhDCjB9+pPDRse223fcdgNULIekCNJGmi0T2K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b12305-0bdb-49fb-b937-08df278f5ed7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 12:01:23.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZweGet8AL1sL+dzzTRhW4uU2q4xbI51O0BRUnqiTeWOZccF4u7LLFxDl+Qi8RWzzu245Gwp2/qrzLdxoK0LXirQYDBz9YQi4r4pi+dAweCOMAP3xUc6lnG7W6Q1HMyUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8389

On Wed, Aug 12, 2026 at 05:25:54PM +0200, Uwe Kleine-König wrote:
>Simplify tegra_tcu_probe() a bit by using the devm managed variant of
>mbox_request_channel_byname(). For the rx channel the function cannot be
>used without confusing the order of resource freeing.
>
>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
