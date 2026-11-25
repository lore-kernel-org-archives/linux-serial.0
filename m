Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795639857;
	b=kvD6o6jSL1Z4qYVt5rfDvlnU6TGC2kd1AXXb0W4nDM0FLHZ4P5c+KP1pH1qK/jAOx0/I
	 6RhLG7ZydgKZ39OkHbHO4a5+S7cmkK0ynIs9PV9hr/6OG6Tm/m2RpFeOcIo6UTl9FkzbF
	 EjWLo8VMNkQFV9nSSee0dq7iTRMB0/4Q/Ph0nXEVdPonp0eFa92YbMhoddgIAbdklmtUH
	 KB8NnBgmAT4cixDiuqNADdVZYtt5mPrNCPr0rg6X6pUHwqYE7HpsOeNXAhS2vAyK/4Ixy
	 ZzOII0GLuNMTHXo+bovAD3dg2oMtrYKLWItkdJhVfv8NTP9+pALyXhu81BFA83JZ07g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639857;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Xire52QG+Z4Dxek2DjTFiau6n2r3C17ArUQPujNt2ig=;
	b=xMpwnIAqDTa3ombQcvPAR5k0K5ZmNaLV8vCUk0hz2M6CzSLVmlK2yBa16kE++KxL1LSE
	 k7saaBFU1C5w4gCiFx2gYQ0qzjAy78kG7lMowvixIPId4I3pailAtp91KcDOjeFJ51eeM
	 LEhkt0BrzjxlUUmvF7ejIg7euhImyo/+ZsXoiRWPso/E5Ox38CblGxcnsEfe1CI4zLqxN
	 pBbDaIVuInitWf/euIxCyN7dITGehVW80EPb0SFmMRLaBPvH/7xHmX8y8+1Gtht6uwHzQ
	 jp3zRYielVUh3+RMM9G6xRu2QWy98bDlQTf4QUgqle13kGOhXKh0HkTvVw17mbk5fPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vk8WYjBM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.39
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7D606A32C;
	Wed, 25 Nov 2026 20:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E7D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vk8WYjBM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ps8K4GOlxM5S/DxTj8AbichXGzwwlZR/idj4WAI3ZL9IoKnYGz7isasdhFu8/0ONp06NxilYjTiyr+mlXDjD1RJoL9MYx2nshSxCXtjt6hOItGQKaQjOsEZcNocNputQd0e+l6AURCHU98ElT9iHZvbua8zFl4SzSL4piNHrO8DooZnqIuT4AMG+dO7O/nsDVida/oYHSictgxLHJZydcW3WrodU0A0qW9aSYrJyYmAq9XmViv/b9S1kg7/csCYVb2CoVF/31x5EA/VKQnFY6Xl98BUc4SYQD1OsVb/gXFvypU4kwKo+meebGk4DbmBE8h5DcIsxbXVoBz7RQ8+D6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xire52QG+Z4Dxek2DjTFiau6n2r3C17ArUQPujNt2ig=;
 b=SCmFCmUI/33wFfUHCKbViZ8lMQ1hBk7wUpmS3+a06av/YgPTvYGI2YjerLVv0O2jRkaz4BJgdaUpv32WSGc9MK+/rGDgdQxfCdiLt+IgexG/uxRx1VW9Uyu+uYlEobHHtZMhZ+X89V+qsEWAWLaD+NBHbNCmy9c1ER1BTZvxrsaKTLlOsXREJ2P75a+0Na7aVfiZiQu/QrHkXPP34v30HGQhE/ch1eUVPfDZSlXuR3jkLi7GKBmedXqZPr/cwCXKQsaZYjatFr3uD7yds8QWuIEUq8hrLRoaMAEPYM1rvPkgsw76O7OdKdh+eUIOfFpM7CAGcCGrD/5NDm50F2CRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xire52QG+Z4Dxek2DjTFiau6n2r3C17ArUQPujNt2ig=;
 b=vk8WYjBMC4GY8GKCw7GMPR9Uxfw9k5kZxvLf7mOac+g2gpzIr7rr1KjGEMJAngT/tjEbAMKCS957+7JSJDibP5ruE+IVJmfjilqPCpQdMdzP6cCFwCfbQvQ3Qu/O+oFR0/2tJNnEl3eteUwGkAhR1W5lTYGc/bAY5VqWBnAOVWimJ+lyug50YhxA8gc+xpdfi7J0wJY8xpnLUTmbrkf5l6PTasX6liO3B+umqJaWm100+Y3rKtFpofbP94mflNYnKxT4B4PveBQdlDzHdJ1+JCTuYBsU9U7w+q/gMIHyObb4C/DU0buDPZUBgbwD8DjXGE029o9BUFe2SpRHMzCOaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS5PR04MB10019.eurprd04.prod.outlook.com (2603:10a6:20b:67f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 20:50:53 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 20:50:53 +0000
Date: Wed, 25 Nov 2026 14:50:40 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v12 5/7] dmaengine: dw: extract hardware-LLP residue
 calculation
Message-ID: <awdKII0K0WKbj7po@SMW015318>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
 <20261121-submit-dw-dma-synchronize-v1-v12-5-f51eb635209d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-5-f51eb635209d@gmail.com>
X-ClientProxiedBy: PH7PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:510:325::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS5PR04MB10019:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e5c2d6-9448-4ab7-c3c4-08df4b35cb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|19092799006|56012099006|10067099003|11063799006|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003|261009223027099003|6133799003|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z3WNHIPZ/FIl50GvhKQr69/FaKPq6zqhnhua/yDhl99dEqUlAFO+gtkGqc6J26r0sbh0ZK4FRGPDGrYs5cWLSzuvbnlxwPIf/VGZr+dANkjiubXN+IDL4+ie82Pd8wBlPlQpKx2yKpVdC/qw4jtDcq4gYPDxNz05FK8hQ4o8d19Sihfaq423TK02VAjBuoY6YqaKPOwbvtN7z7LdhIrt8egyHh4Afg4IGUhzEAARWsV3EAhARTY5oaDgzuNFSatmUswPzD+sT9AgDnT5weqnI1fEPiXEKPshV/4U9KJXhZ9GKaOkepFv47CJx3zdLPdxv8axrQhKvPaCepe3nLaCljgv4UZJWdc2RaKkhBHDCvKz9NDzOf+ENgkjD4A3GEYapCAnwou2gnoc8L9Ia1kFpFs/UooBQy3y46GaQggNF5UHTb24b6izH/4GvDQn9emkJ4B1tP5FAypySBrOGk1zgllB+JjUJyzlzHUy4MEC5yR0Lwmv756vUShWeWmJeheTki67gjEix3hWV+cjlDXyUKkIAYdVRcPILR0F+29owbS3Z6ZZE8efjxd0fbu/IS/RqumbTfUWgBWXRywvTJzw6YnvdNea41yblsnlIUUO4+nsuJZlCjqptLhMbBWCSs2qTb9j+T9tDhUtCVXGN8oP3YiQ0CYVXo7Kz/vTiVPbh6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099006)(10067099003)(11063799006)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261009223027099003)(6133799003)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lfzmz8lvEHfITQvWUFJbItgbcNWXK5aoknEk/TvFPvRmTG/Iz30a6Lh64lts?=
 =?us-ascii?Q?DRp0wml21Ser6BYJalKpJVeXm+fNQgx+Ty1pX2OJiBg43m7B/3HI1lkzUh2m?=
 =?us-ascii?Q?VOfEqJBR2/RU489nEhTkt0/eWpCSHueIOIVQSl1fc/NJZe46hdr9Ra5vZ83t?=
 =?us-ascii?Q?tyctXpBWGAN9ppKV3VFQS0IIEvIiIVxoBPL9k/ZUPekt+iLh51mnYPpGcn92?=
 =?us-ascii?Q?3lHJ+Mw4RYtbqYDuadZKlSiX38CYC9GAGaRLxsmIMPrbX/PJWRRMuekAm+Y6?=
 =?us-ascii?Q?jOHwsryOD/xrY7uabBI+qE2e0sdXq8JorNo8dB4Nv0ybjx5cTJrtEAm5BL9h?=
 =?us-ascii?Q?C/UF/m+xO3obiS6IgaZRtwRFz+eF8cTXIqGKrO4IH8zWsqriHPiBPUc/AC1N?=
 =?us-ascii?Q?mbcMaNMw9KgBFwsEvCI67cFayykzKGSWE0OdklGqZGc6TKhGjRjfdFBvoTbt?=
 =?us-ascii?Q?P/eoGWvua99cRA05iTzMhIKHqIZGplHWpmzxrkXOWy746xPVOrB/8q4ABThz?=
 =?us-ascii?Q?C0X/FjYJt5bx/YmE6NBjNHrgt4ozTL4KxM9oCAPiLgbILrZN1PkxqTE0nSkJ?=
 =?us-ascii?Q?/WTdb//2A/YQN6qDJc5+che7zwTeFu8Uo5a45hQeA2HYVwHpy6/dMRnosv+v?=
 =?us-ascii?Q?+Za28AtoHkcZ85avypAufhQmmwXloi40jlWJwMZOzsY2KZBY2RiSZAgb3sR9?=
 =?us-ascii?Q?OVvvCqZFkuIQmbdHKSyfVkTwhBuAJBGQ9IstaNExAGjfEeIIJnz6IN1lrNgV?=
 =?us-ascii?Q?gl9JWjKRNQcY9AKT5bwa6gC3Rqmyq0Va9RVxQD5oI0njoarOYVVayZeqC3b+?=
 =?us-ascii?Q?D5icgNcPEkSU/2cUCZlTiDXJD256wcirZzqVLYeHFiEH3jL1H/fwC6Wty0BW?=
 =?us-ascii?Q?jCKUiVQ3MAeAEfTT+Qi6sKY679At0n+A/5eEpjGUpIdpodJ3GmtdDAGBW6xX?=
 =?us-ascii?Q?QEjgqpFKqKWDPmMkPivPzacjUEXJWQ66j+bWYpA6/qpVag6O0pEnUEOInEtw?=
 =?us-ascii?Q?j2mbgj3yJWo4HAsnijPvgYU4f3Zlpm4PIh5GFj7EbKvpCcSBO+GlL4XktBFN?=
 =?us-ascii?Q?NkItpbtdmBKvpCYPd5QABilU6buCRyGllSOxoTp3A7FD2PYGdrpl00K+kOLw?=
 =?us-ascii?Q?yTFQE9KJj2+LR8hx5wVWq8sirPyN9Jl48Ji5bO2URwuYOTcZ6Vis/kmTIGVw?=
 =?us-ascii?Q?6L5B7nAoWcrLEa0WX2Z58qQUmvnMCoXK0BTkh34YxjAfMx75MbBWMS+kr3/k?=
 =?us-ascii?Q?8rjlez4lY73iboqFN/FQvouw0NP17qBXcg6+yGlfLKx/8Aj7Om6L1OnqbdeC?=
 =?us-ascii?Q?Od0Ys87yq8oQ212Qrez6RrQnAFi8BppQd7uB70Da+5FKmRFiYcUIYrjpnCq9?=
 =?us-ascii?Q?9CMn/I/PDZ4r0Qxv/RTG+an5loyGkrf0Hewdnq8WnLKT/WW3dMUWBihF3erE?=
 =?us-ascii?Q?iSfwtDpPW4/7ds0gSH6IceXl/tscNniv5hlUvzRO4pVuSTaeul5TjW6Wf5dd?=
 =?us-ascii?Q?prtAEuk+0k5iBNqQ68Y3L9LpQZxkG0GndwHFVxOeIf1YNOKGtvV3BVrWFMny?=
 =?us-ascii?Q?rSrajyCTsF9vwW33tpAhhlukufGH3PwTuRL5DcCdh1XFwtNHxhrrCGOOCENg?=
 =?us-ascii?Q?Zj6E7JHAzdyyogVK+jMyLLnf/4EnKd+05gRWER9FR1ECWzwsc2BhS6GR7ZdT?=
 =?us-ascii?Q?458DYrWRfeQhBEYw2HGo6zMO1pTMtIbapzJ48VQVQ+8P5jFEyV1MK7ACJv/9?=
 =?us-ascii?Q?IlNaxANuBVzNYYQ80+jG7DYIwmemMi04f//P3Nyqmr3CPuM5+Por?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e5c2d6-9448-4ab7-c3c4-08df4b35cb73
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 20:50:53.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd2jz7ni/YS+few1DkzyUJK4oVFuLmdpYPCEXFAHRDPBaaqB36hWVv+OnRZT9S/TzeJAou4foTZ/Sw1fMeBwGb72KHCiDyES4tY0+avlaHfAubCcEGGbAFSQQlIAKPs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10019

On Sat, Nov 21, 2026 at 02:03:20PM -0700, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. Only one transaction is active, so the helper updates its
> cached residue directly without reporting a completion indication.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation for the single active virt-dma transaction]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index d00d0d53f6ba..150823544f40 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -281,6 +281,30 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
>  }
>
> +static void dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
> +					  struct dw_desc *desc, dma_addr_t llp)
> +{
> +	struct dw_desc *child;
> +
> +	desc->residue = desc->total_len;
> +	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
> +		return;
> +
> +	if (lli_read(desc, llp) == llp) {
> +		desc->residue -= dwc_get_sent(dwc);
> +		return;
> +	}
> +
> +	desc->residue -= desc->len;
> +	list_for_each_entry(child, &desc->tx_list, vd.node) {
> +		if (lli_read(child, llp) == llp) {
> +			desc->residue -= dwc_get_sent(dwc);
> +			return;
> +		}
> +		desc->residue -= child->len;
> +	}
> +}
> +
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
>  	struct dw_desc *desc;
> @@ -338,23 +362,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
>  		return;
>
> -	desc->residue = desc->total_len;
> -	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
> -		return;
> -
> -	if (lli_read(desc, llp) == llp) {
> -		desc->residue -= dwc_get_sent(dwc);
> -		return;
> -	}
> -
> -	desc->residue -= desc->len;
> -	list_for_each_entry(child, &desc->tx_list, vd.node) {
> -		if (lli_read(child, llp) == llp) {
> -			desc->residue -= dwc_get_sent(dwc);
> -			return;
> -		}
> -		desc->residue -= child->len;
> -	}
> +	dwc_get_hard_llp_desc_residue(dwc, desc, llp);
>  }
>
>  static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
>
> --
> 2.53.0
>
