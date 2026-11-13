Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794597629;
	b=JwNXdho9Nv5m5xLto1faDXUpSk4jpeLKLxYvnVBwHK3cDZvDrevoTI80M5oVqsE8R5jl
	 A7MOvaCFejWScnDyaYtOlRwB22Bk9nyk8NCfMpjZ4daIGJeyn+s9AwaQmBhvG4/icnKMS
	 KnG1Y2Q33DQfL/yIhy/m+FIOO9aVNXGmiQZHdDphvNquL/hNil73ymiErhWfP3yvtgGuT
	 8W8THfirry3wo7x0AkaVFkiqhql7tPlqNbinXlCPObCIdL+gJLzrlpL+zgFt/AB81pJUb
	 eGjCoaZoC+zNsL9+Atxqh/P8duYtXJPGDFh0E0GgTvDQ4onmNyL/T1sMzFF+iLn8fnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597629;
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
	bh=i8mATEgb7FP1jtazj7G+exG9ZqQUhU3gGC7fk6iJPFc=;
	b=W104XN3o7dGKLuTLFE60tOXrk0sVyjVJJrvbeSsfpJQWIvOgQpE5AStjwprT9g19PnRN
	 Bb+rb51hOqSkJRCqmqxMaYdYoMgYoGzfx446jNQoaN0Z1TflezsGRFT98N9YfEFkPgGXI
	 RH78V7fNuydtG63gDUvfcybupaGa8AHgSzVe/9Xjph0iZTdbvMYvHr3nZdTsF+ZnnYY8g
	 xYdAnIgEm1GP9r4A7dXmFTgrcnxpp3HiJ+N3IUavMLLAx+Gv1HXO9Lt3vEVr4HRNcLTYY
	 oIQ2wSlMXil4F0BUyYj7KnMsPlzwoRcu/UOMHbYvNEpdP45/9O6IhWZPMRdvpxW1BDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=R2uHGz3z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.8
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E498606A335;
	Fri, 13 Nov 2026 19:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E498606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=R2uHGz3z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arUd0LgYcKvqgQDIpidj/8ejULShQEt9LovlSbjQWX/fm0MyiR7onmtUIuDw2M1tcsk7LyU/Nhg5+yt9ILtEo3OyM8y6As+fYmGADB4l7KlKlsm1oG8gQtSWjewjEhvZOzEmwFJ3jD66rnfsTBXLeYSfTTnoOuxMsu61KkNBPRgHsWsaBtm8hyqCjqOTCZDpbTTdTZTi5SCNbn3YwJUR7d0rSX1tSQ9jM48zlnwbfpcUTf+ceCKhyyWUXViEcmhj3k626uTcdZuaqyyLhijjYX9u1EkXT6V7TKz9ks7ZE66aNQnVJBH7oGrNkXV5RQw6vZ+CDEI18RsIOOJyhB1iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8mATEgb7FP1jtazj7G+exG9ZqQUhU3gGC7fk6iJPFc=;
 b=soSoUJAX/0WlqaKCCUCNFBaawuuDgbwi/ifoEzPu6cNuVhwmBAzxeTAmCl2aermMoRxwHL5vnWWhVb0y6g0hpFPaGNzuFWoO5mZcWDWGOEyVQKEDUYvgZYS6FJj7ZL/0U8P9nI453r+ZujDCL/kndtBIqovPnRiIvQTQuKwmO0cYHEOpkNZMytC4tO/+mODYaI5Eyj0NNZ5WHJKsqL2Dj/LYSqw+9lUxR67Q3sm40taihN+JvK5yKdHfxCRndb3OZonbWGN9tKeaohl8lzMOiufsTMlbFCn8pimT9f8ndLXXqVZ4F17ZxI6Q+ZU2fe0m5xx9IQ227DrNVRueqLfnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8mATEgb7FP1jtazj7G+exG9ZqQUhU3gGC7fk6iJPFc=;
 b=R2uHGz3z2knNMujrsr8WU1VApvEAOE8p0Lv1oCKk1d2xL9wYRAeae78vnc0SSKsGrGIJUZliCN8JjyzMAu+yJykM7Vk6hcLoD6dqXEInd6HqXkaq7DLt44UcHniDE1NWE104M8rlYeLEpkKoLevwYr/JUPYNKNPYgF3SCFwO4WO5+992Kcr4SAThG6+xxihtOd7J1oqJ33OJrz4CO3Jqz27zMiVahGXEzJX0KdTCIyFYaMDZ/5EQrXO93/RytSoGkVLl4Ym6HldlDJV3gx9+26TkfId/ImFKU++uAH2aDo4cvN+0w/FKovGc98BKrhLbUOMQ3jLNRkR7tj6oypKJCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMDPR04MB11680.eurprd04.prod.outlook.com (2603:10a6:20b:71a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 19:20:26 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 19:20:25 +0000
Date: Fri, 13 Nov 2026 14:20:17 -0500
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
Subject: Re: [PATCH v6 04/10] dmaengine: dw: extract hardware-LLP residue
 calculation
Message-ID: <avdi8eRgwmN1wZM-@lizhi-Precision-Tower-5810>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
X-ClientProxiedBy: DM6PR01CA0019.prod.exchangelabs.com (2603:10b6:5:296::24)
 To MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMDPR04MB11680:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef200fc-11c5-4498-aebf-08df41bb2b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|19092799006|10067099003|11063799006|4143699003|56012099006|261022105027099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SqK8BiR/REcb/uT657pMfv/SspnMLBRdkX4ExY5rkggig3TWGlbd3D47WpADB9P8n9jFnBa9g7zlo7CLkzYjsLlb+nHAPJRTkf7ihK7boHwY/zzL5hYpiYWZ1GiQOwzNH1KT689Wu7fIpJeBtNYhWmPJyDVajjoXVBAx3p8+rrGbl47ku7Z7oFiSJSkLh6j+xOVYChpZis8lMfLyb0yMpsnwHulFwICh8JvL7rzksnWprWkjdHJXY7J6LRaNqLlXeNmsuD4AQ2tvX5j4F13cuhHQJc+BBSv8wSip4p13q/xPJ7+UsJKvyu7ed6HSQGyy6LnRMq8lbyfveD3os7bLUmjazPsQ4GzjQ81S428Wf5B6UPA3ns55ySsa60s2WGNcKOrOtMlqTpr3z1+LtrnVHfI8x86dWvPfBRO3GnT4Vt7sZNeP75uiBw6TJeLd1uoJMKxNT5O7QArUJCziFRE+9uD15TkMgXRCf/cY8SSuJWIFyfsGjoDDbJzS+x4jBIYciVfjKkhBP0e4VEJpyWMR4NALf/njaUsdisD8+XeE3T1gdtrAYwCC3cRzOYnZrpI5ciXZWuHri54IqnDigD008jQbxK7EHtSyIpID024GIzIe2PVklkvV63ciIxFBJqm3/bL0eH9ulha05DFwYs+yQ7wPOeJxR5u9kI0aunAA23s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uofQGubsoenezpAeuJOANE6nFcYi7BOQpzsWmGJfwGlyuMxkU1bNLNevYbG?=
 =?us-ascii?Q?DlkTRRm34tGWc1yyklMLulw8qb5EsdOa/znqUqfwibiyfEv5w1+TuVTxRXXx?=
 =?us-ascii?Q?TLP0Y9yD0HP+SQUFPHeNAv6q5G2VB0ytU9AOatqxzqWFBDgSs1cRTPDcW1Hl?=
 =?us-ascii?Q?pWJEeklnUsl/yLQrOsdu6ltJ3neWW56I+J4pQXiEv7w24Vp9qfX4DP5M7YUZ?=
 =?us-ascii?Q?k8Bkb4klO3Ykm8UtrjF7aLDk3kq/sJhjKiUPZZ7abFUOoajOVnI1ugU55kJA?=
 =?us-ascii?Q?kf+cTSEOw/Z+fYjh+/ArkrvA89r+hy87YWQ/7GrWbgcNlIXUAyU9GB0x6OqY?=
 =?us-ascii?Q?M0DUX6fQWpErDcxwaZ2VTVO7oIurJ4mKAETeO/6p1SSR4mgJ6p7V397s1V/+?=
 =?us-ascii?Q?eqTcb3GyHVE58Vh73CzQ+pjX5FYQH9ShaDSCkRuYprGKyhNTRio7ivG7hhr3?=
 =?us-ascii?Q?KKOeupTbnnd6z8TPbbQL9JKMJEKirHkz3ZLqB377PmFQN8/mDe5r9BnWvl9n?=
 =?us-ascii?Q?UfaCslcrPFu67FXKmHikwU9i3Zv9z80U59dR9OwZHxU70Da57LJPsy555G08?=
 =?us-ascii?Q?hifShUzCCSUqjohwVHjg7GrHEKNaw1jyguj7hfT7eUvyoKRq5YY+GYVSTvFu?=
 =?us-ascii?Q?b3K2mdKlJXR1dHSYtk//SZLAFj42Fvz0iT9Yn/RBh6//Az52+Yaqh+t/Vkb0?=
 =?us-ascii?Q?cXD8mLIbVW9NGVMw9f8gDT829zGFQrvEBWnBaClrbSRgGeADrS7Fis2nLfuO?=
 =?us-ascii?Q?+LoRC7oxjshlo3xPIWMYzkJwe4HJCYkpCEK4vrDHfoWSExHeOXnCQJiBA4dr?=
 =?us-ascii?Q?6RzzhgwK3SwbEcyYJ58ycliP63WsdlUglymp0DPExGNAcxij0T46Q5nOJAZO?=
 =?us-ascii?Q?nGMlURW7ujTOygd8uyqaXkpZDRZ+G7sEfwfRUc+6zxshM6fQ5tnBtgUtyVy6?=
 =?us-ascii?Q?M6xvheYuljjXaSq6raX2UY6TXTyqe92XFz2JW/Rg4oLlrmdNHIONdjlueID6?=
 =?us-ascii?Q?H0j+k/FwCox2RHkuAe4iV1gygEHalC6HNwcTlYSMoXLcKuPLG9xu6luciyWh?=
 =?us-ascii?Q?J7ol1+YXppQBcQwQ5G37KZ4ZkD5GzD3o38jw4ADriCslwP53XtBHaFf2bmIf?=
 =?us-ascii?Q?J4TPU380QDCkGlL0Hx+V5aqqF094VqrG0P0z0zEcX2ZW0O4fVc1KiZLPire5?=
 =?us-ascii?Q?YiHbCARbc6qy0c42xr5+nYfsxAWUPEqOMgHl1ZYTZPMLcHZM4ckKa/3Ymc8g?=
 =?us-ascii?Q?A+3tM3/r28jiuilEm3VY0Muw1hs6zilfk90NeCwZ9Qy37PjtAVbdOjiTM56w?=
 =?us-ascii?Q?iLS2xjXEg6l2SUQR/wInKu5O725ORmjiwtHt/PhBXyw29awvXHcHGrOYQDWa?=
 =?us-ascii?Q?AWHwwwLVXz41jSw4mOMAuCOTb7ZFXM6knPAvbTj1hI00tC6pADGVgBch33PM?=
 =?us-ascii?Q?s0Skih21aQJ80V402R24bZ9beBUcpowpPn/ILWfKiBM+vTmqo3pLmLxgsuQi?=
 =?us-ascii?Q?75XUVqBpt4uzIxNeihobNZmXY3iIu7rpanhmZ5EcrVkGfjmJR+tIgDrEwmeq?=
 =?us-ascii?Q?z3Ew3cG54sXhIJVrIgnFb1CFvCAYPs1vz+EhP7oBVKfBBKaMkLFJa+m2gwK9?=
 =?us-ascii?Q?XFCHCimYElOuiqYfqWJTdzxuyvIpEH+A6uUx13zMn1GOPu9i36HAl0vCsFMb?=
 =?us-ascii?Q?1/TtbQZkq5Z6eyCkldn9yB/SuqxFBMaCIYYnJkYSc0DLWttniARjLmxyxQpN?=
 =?us-ascii?Q?GDK7/21Z6kFZazNyKo97hoahYV5Lx1zrDOmE82QCA/xzprMN5yhp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef200fc-11c5-4498-aebf-08df41bb2b62
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:20:25.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7waBociCkqo1qRPfqaaYYCOAzm0HmIinS0qNZMIZcl2LFC9WE2h0p7Du52JaknTKvI/M+rQSozN/3Bje/buvtPN8VOCveRUcMa0cFRbO2pCXngzAxylp+8R+XyWlO3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11680

On Tue, Nov 03, 2026 at 03:26:06PM -0700, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. The helper reports whether it found the current descriptor,
> including when that descriptor has zero residue, rather than using the
> residue value as a completion indication.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation without changing scanner behavior]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 58 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 2d69fab06601..5a1caca7ad68 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -267,6 +267,38 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
>  }
>
> +static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
> +				       struct dw_desc *desc, dma_addr_t llp)
> +{
> +	struct dw_desc *child;
> +
> +	/* Initial residue value */
> +	desc->residue = desc->total_len;
> +
> +	/* Check first descriptors addr */
> +	if (desc->txd.phys == DWC_LLP_LOC(llp))
> +		return true;
> +
> +	/* Check first descriptors llp */
> +	if (lli_read(desc, llp) == llp) {
> +		/* This one is currently in progress */
> +		desc->residue -= dwc_get_sent(dwc);
> +		return true;
> +	}
> +
> +	desc->residue -= desc->len;
> +	list_for_each_entry(child, &desc->tx_list, desc_node) {
> +		if (lli_read(child, llp) == llp) {
> +			/* Currently in progress */
> +			desc->residue -= dwc_get_sent(dwc);
> +			return true;
> +		}
> +		desc->residue -= child->len;
> +	}
> +
> +	return false;
> +}
> +
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
>  	dma_addr_t llp;
> @@ -354,34 +386,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
>
>  	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		/* Initial residue value */
> -		desc->residue = desc->total_len;
> -
> -		/* Check first descriptors addr */
> -		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		/* Check first descriptors llp */
> -		if (lli_read(desc, llp) == llp) {
> -			/* This one is currently in progress */
> -			desc->residue -= dwc_get_sent(dwc);
> +		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
>  			spin_unlock_irqrestore(&dwc->lock, flags);
>  			return;
>  		}
> -
> -		desc->residue -= desc->len;
> -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> -			if (lli_read(child, llp) == llp) {
> -				/* Currently in progress */
> -				desc->residue -= dwc_get_sent(dwc);
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> -			desc->residue -= child->len;
> -		}
> -
>  	}
>
>  	/* Residue describes source reads; only RAW.XFER completes a transfer. */
>
> --
> 2.53.0
>
