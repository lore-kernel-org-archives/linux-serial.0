Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793824076;
	b=A9seb8SJ5aoXDv8n797zfe5HA2X7wru5tfNPHpx6d/qgd9YBDhTjkK3dLBplf3EGkjhq
	 3mIgiEGpRQVZrZQ2Mh2yFrE8lUMWqprTIHRuDJ93roFCDRGEq54FQS+1LFzaRRk0hLp/8
	 4uAUYyg4IpAiim77gxo8vIG8wr0bOpK2/W3E6hL93yFSmqKvZ42Aqq8GERrixSukRdhea
	 9Oye4k+JKqu0x4GdRcnKYbrclbt6WxNu+bFHG4ON+PSXJhYifOfOM5GCPzztKvj2MCZCx
	 vL9EoGEOfMNMJoM8/xDs2RTnnJ06vYu/VRjtItb+s83yXQI7eZ5eb4VkNdUqtqfyxzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824076;
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
	bh=Oic2ax+eAW7GEe1SOxcCoi10OIbF+2eIhxd6DI5aPqo=;
	b=CXIXcgfxwl+UoADVAZHEWLbLuOxm3VLW6qHp3xbyOn6izTna2jI9IxqYPB0Br0LTXgtc
	 YTQZp3j5VBR8g/QT5KuVXm474ah6KU7LKvRtszfprpIZhp1tcqKdNjYQvowMDgsrMjx2m
	 xMUWWMlqySYsWRtuv/QRjRiyfSa+PhWF0GfRAxtcjxwIdayGRhqqSD4A11Q5ZmiIPtL/q
	 qB+Z/X8NXucPsOoJBOwOSXXENcZWydldJNpfoblcTFFMfjEqlfGD0ud8l6D28eap5HYCN
	 gqn/DCwDnU2I+4mfsS6BRd6MMEc1rgx+E38iskYF6Vhz9dJKIiGd5ynpB0PofbfqtDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LhN6EXpW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.47
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626D606A336;
	Wed,  4 Nov 2026 20:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B626D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LhN6EXpW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfPb+qrNjhqgxQ6jgODp2PS/DWdMdJjV/ib1l5+opMBiEnNRGa8ToCaKTm94l7fQfpDJTu30cyA+/QjvyZd+5YNycHpWcL82xZKVKvTO3lXUfXMNlseacVP3VOiUjY96FiCP7IpRK5ETM2+lxmAx+mgeuS2SWdoI4D7v3NWdl8Z48uAtFthlprsVr4xPkL88MxVOD0gOU4x7aGbUllpqUfnrtwuDGG36141iLgo+1czza5UFX/LavxsT4ygHwUOw5oXhG87+DdcRjqR7lwWuklgX6E/cxJ8PIVGFADerManQz6BvgLhXCPWxUuxBy4XXsABLhnhhoQMV3gXuCb5cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oic2ax+eAW7GEe1SOxcCoi10OIbF+2eIhxd6DI5aPqo=;
 b=MWDFJzBC28R1ChoaOyrFS28BGwOP2YKV6h0uQxYUQO1cfGTXWB3RooMqDMV7yEBC9o2YKQEcyzgsz109kLS7a/wUjVhgJcdhqBTue0QVxFzVUb771wbH99jeLnYQnThHseweUwVk6RW2yalMgCxrDeflXqHeSc4SWyYWlUlHy6eEclk1UCqnhI3wFjPprzDSqTaeXzhrExgBhjJOirFxRd9j7q75Lw2wBi7VkqaPtRoeILFW7jAhiNBThn/MZbrpNhGKIgA+kZ+85FJisSDs6VZGy3lf2eY/KxFZOtU+PkYbBWfm7t70CWp+fLju0VRABIMUD1TZfRpadOTlXg/o3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oic2ax+eAW7GEe1SOxcCoi10OIbF+2eIhxd6DI5aPqo=;
 b=LhN6EXpW36Ufk2XaknFwQMP/oWNOUQZPGrdOczvn9bdlLmWVyV/fK/GotwQQ+UTNkcPeW5DCaPyj1/ueQZFbXbpRjAnHiGTRkhuvF97zmNuKMzTvJiqbfFKWga1mSdxAz4Pw8pS2AdThdokhAzQHtYJ9GNK1onSffUjMDn//jvnkhgmFfWcUTaZAnMLkoZ1u0YxNzQHjKnEURu9DxGaSryXZ+efee/88KtgQXWuObFTZSuAT42x/tgQ29gKRNqG+Gac4M9FuGsk3/UNy3S60TtnpJ/W2Z6K0dNejxyddSA8qxtksfdV7tsx7/TVG19NwbU5iKLZXEd12aXzu5XMZ4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB135762.eurprd04.prod.outlook.com (2603:10a6:150:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 20:27:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:27:50 +0000
Date: Wed, 4 Nov 2026 14:27:40 -0600
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
Subject: Re: [PATCH v6 06/10] dmaengine: dw: simplify transfer-complete
 handling
Message-ID: <auuVPDkHrggJ37zL@SMW015318>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-6-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-6-2ee0c348224d@gmail.com>
X-ClientProxiedBy: PH8P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB135762:EE_
X-MS-Office365-Filtering-Correlation-Id: 95496f65-1f4b-45a9-d1a6-08df3ab218cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|7416014|1800799024|10067099003|22082099003|18002099003|6133799003|56012099006|261102123227099003|261022075727099003|5023799004|11063799006|261026121527099003|261021123027099003|261028144727099003|261021121427099003|4143699003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	BDH+riYrvAPdZGU3PCBtVKJslmYqeWqnq2sARcO0pjYvoqiLM7Dqr/sVwq1rgDnMkmhQBCUlWSEbl1IOL6pYzNkFFOVb5VLL4KbRQ3i/oJpBcL6h6Wo182b3PAjX/4wYv9TAr42copy4vp1ERK5v8mMljOXabEquYdfr4sNh76ZxNjad8xLM9uYtfmT28P/ygkFPtpBoAGN99p8aMf+y5kafF0KUdsXNSOPyytdY9HBeAXAspu1cHGz57KIUCfTpWKb50Sm9VT2aMIJrq9eQ9UGA3cBgIpafPAzLA/Dt9ORs04/+nQYPr5QYXqa9OyfiUxluV+3+TA7oU+WHg96b7O0X4NB2wDxU75Lq9UNeeBO5kaI2rhrs85VO7GW1I1EDmKMPa9W2MQrq9i7tMtmZCu3sc/G0KRlHSldsbszi9/dIDxAFShxOZCzR4Fq6jQqX7lZHGRsCrNQ8Z781J635drHeS7iiATbc9rXnZEq7UdaiDS1ShK+aHR5aTPK/9lXnuqAE4m3orZwRqBfUzb4KcY+Izz5QQfp217VQSkRDvYFiMEzhH/5TD/yEX6xP4MNJTs+hUWpn/qnDj/WPQ5NaHzFMo3kQQb2+x6pdRDKsz7OjqQE9q/RXPRzBbZskeo9qmZmfoXB3keLp5ZsFWUux/EaaPpwsSTTi7jinlVX3438=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(6133799003)(56012099006)(261102123227099003)(261022075727099003)(5023799004)(11063799006)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003)(4143699003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQmEwsIMM6Vxndbjc8l4SZCqCnadykQbBKYtLcueYYL+V/e2uZ9LrqIN1yLr?=
 =?us-ascii?Q?YN0z7+rp9ZshaaUEbUxhvtE0vlfkinsH8XveJvH6/40mjyIAfuOeCmk4LFYn?=
 =?us-ascii?Q?CrjXrKh+/7O4OXkcg9Q/yvocfZ+IXfBTNQkQ1xfIUAlYEQgDtWGartHJlFx/?=
 =?us-ascii?Q?oD0KjqaHNPIoT5kW9KNI33CtGSsmeBJgpbsw6pqPONcohZGVF5Z4coBPkbQ3?=
 =?us-ascii?Q?fFYWa53kjX7TpuuF22ZwNpIitOcWceNSfhNAnKGOK6allbp8tdRYAKFWn6xp?=
 =?us-ascii?Q?jG1eGLvjBOKWWCoeXon4kJ7rrSPY+An2uCSvQ9oNY2BRYbYGVQcdqUyJN4WF?=
 =?us-ascii?Q?jUDIyZpnUA/9f8arfRTOp3ypbxatBpcmL5I/oWB0HRF3T5pSylb0y/V0rX3I?=
 =?us-ascii?Q?Yz7bAnZdaU3WMkufX2JfEsOeHSG7dmYgAV8h3Svtx54SEmgWHbOOh5h4cZ8T?=
 =?us-ascii?Q?SnYSyHb5gKrWEWQXRZQGtTvtwSYqTRHTfJfWzqGxlnarLNr0Gy4XarXjOPjB?=
 =?us-ascii?Q?i5sIBCutOs3RUxj+0VYYQCn5NWS4q9q56DIoni90tPPmpAW7VtxLCrLoX0ZK?=
 =?us-ascii?Q?OEmjPsSoxBt1C8PPJtuPK5ADYimr47SQr3iBl2Rt2sUmRR7C3f8VPtGN1DsA?=
 =?us-ascii?Q?DOLFsLgmlZHkGf6M66Q70giiTTQfOdvZfU8HByMNvSlccbzKMH4R5nM192NE?=
 =?us-ascii?Q?vb7nwZYilJkKaUM320s7mjFgEF+W97QAJO9EPrS0iMsKPxCmMOfspFWBdKF2?=
 =?us-ascii?Q?aKVeTmj2lz2ksZL92A5bBTNCAH36ZLtShS2D4LyK24Hp1w1XgX+3BxnZ4/wC?=
 =?us-ascii?Q?uvZN8eVoYkrG17En7eYHkswAAGLqzMsI2Zpv4Z1zQS+JzUWae3gm6xL2lGKI?=
 =?us-ascii?Q?jEdLBrZNjaV96K+MVOwVKz3Ww1dYA8QdEuHL1ldR+HKNyrGcXC+geamQW8E0?=
 =?us-ascii?Q?Uwvv3V1U8Jnr1PrQGCoCAaVgiHc68zIj3RvTqsHF1DlMnbKuuM5R5xcDun+B?=
 =?us-ascii?Q?SZqtMjn9aYRaWc7PrAtduqtdOLNoUNoJsY7o7ROJUksJkxWclzXMqGFnIxah?=
 =?us-ascii?Q?y0RiSrZljQSEx92u4AL1B1W4U8GaX6ch0C+KhVVMMh9FualOd6VDnR9zDEaJ?=
 =?us-ascii?Q?aNmuInnIOwuOIY21XoFG0zH+Wo7aa77iy4lWhD3Ooh+Z6lHdWzNVM5SPM229?=
 =?us-ascii?Q?ZE08ZMgCEaCcymyPu4OlmC06VMZH/s30iD8grKQqJkWcYeXHswiNxScxnZWt?=
 =?us-ascii?Q?zkqSEGmsziP38Mwxnk9Ci+WX6RczXNz7Ner13r/hri3HCeBo8Vo8z+ESvquu?=
 =?us-ascii?Q?T2RD4uz4UjmLAQhxGIrcjOFUeQkMMtcZ+O2836MU4yTOdLyv/UmA3/p8+8hC?=
 =?us-ascii?Q?Jtdg+k9iF19Av2Y3RLns5hjsehgFAYypnwc9xTHQ8dSa7Q0Zhfo9hIx6nszG?=
 =?us-ascii?Q?YpWyZ3pVdW1bCrCUJ9ZhvF2D3IAxsWbrsZt+TEz8WYqjBLRG4clldpte8Zcw?=
 =?us-ascii?Q?8J8V5+o5bk3SmquPQI4XMW+S4tv4u/vuigageKGaxYtp1XXaPTUZXUjsdUma?=
 =?us-ascii?Q?usoH6JerHG+A3BeO8nT0Yb+ztrVzcZl27rCGCN1hvvPCaii4KBQOPA8QukV6?=
 =?us-ascii?Q?6FTpec+jQD5ako9AFA4vE7W7pRaeiWRY5pFSGkzK/ldaMsROX7Mrr2fOfZc3?=
 =?us-ascii?Q?hw+vwzSoLsYdM87B8cJ9BJ78WW8Ft9mSBOyqYWyxjbxROB4g41s8w8uVRMLS?=
 =?us-ascii?Q?qkeGOy5Pll9ZVHAofrlr/Tm8G1cS3wuUTTOTJYh5dd5Nd3dSlANo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95496f65-1f4b-45a9-d1a6-08df3ab218cf
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:27:50.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zup/o2IRmPAYjQQ6ul+MxP3U0iz2bZ3jLwonbJHy8aUgdMdMKomOJ0ZgBl+FW4dLtxOxAd/HJKPABA7cO94IX/Cvb9sLcESGqeKzSdDvzXGN40UnoT+sVTkslM5kV9xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB135762

On Tue, Nov 03, 2026 at 03:26:08PM -0700, James Hilliard wrote:
> With hardware-LLP residue handled by the status getter, the descriptor
> scanner only needs to process transfer-complete events. Return through a
> common unlock path when no event or active descriptor remains, and flatten
> the completion handling.
>
> Only one transaction is active on a channel. Detach that descriptor before
> starting the next queued transfer, keeping cookie completion under the
> channel lock and client notification outside it. Preserve software-LLP
> block advancement before completing the transaction.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 92 +++++++++++++++++++++------------------------------
>  1 file changed, 38 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index d9127337c849..3cc8579f8829 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -297,74 +297,58 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
>  	struct dw_desc *desc, *_desc;
>  	struct dw_desc *child;
> -	u32 status_xfer;
>  	unsigned long flags;
>  	LIST_HEAD(list);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	status_xfer = dma_readl(dw, RAW.XFER);
> -
> -	if (status_xfer & dwc->mask) {
> -		/* Everything we've submitted is done */
> -		dma_writel(dw, CLEAR.XFER, dwc->mask);
> -		if (list_empty(&dwc->active_list)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> -			struct list_head *head, *active = dwc->tx_node_active;
> -
> -			/*
> -			 * We are inside first active descriptor.
> -			 * Otherwise something is really wrong.
> -			 */
> -			desc = dwc_first_active(dwc);
> -
> -			head = &desc->tx_list;
> -			if (active != head) {
> -				/* Update residue to reflect last sent descriptor */
> -				if (active == head->next)
> -					desc->residue -= desc->len;
> -				else
> -					desc->residue -= to_dw_desc(active->prev)->len;
>
> -				child = to_dw_desc(active);
> -
> -				/* Submit next block */
> -				dwc_do_single_block(dwc, child);
> +	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
> +		goto unlock;
>
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> +	dma_writel(dw, CLEAR.XFER, dwc->mask);
> +	if (list_empty(&dwc->active_list))
> +		goto unlock;
>
> -			/* We are done here */
> -			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> +	desc = dwc_first_active(dwc);
> +	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> +		struct list_head *head = &desc->tx_list;
> +		struct list_head *active = dwc->tx_node_active;
> +
> +		if (active != head) {
> +			/* Update residue to reflect last sent descriptor. */
> +			if (active == head->next)
> +				desc->residue -= desc->len;
> +			else
> +				desc->residue -= to_dw_desc(active->prev)->len;
> +
> +			child = to_dw_desc(active);
> +
> +			/* Submit next block, including for polled transfers. */
> +			dwc_do_single_block(dwc, child);
> +			goto unlock;
>  		}
>
> -		if (dma_readl(dw, CH_EN) & dwc->mask) {
> -			dev_err(dmaengine_chan_dev(&dwc->chan),
> -				"BUG: XFER bit set, but channel not idle!\n");
> -
> -			/* Try to continue after resetting the channel... */
> -			dwc_chan_disable(dw, dwc);
> -		}
> +		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> +	}
>
> -		/* Detach the completed transfer before starting queued work. */
> -		list_splice_init(&dwc->active_list, &list);
> -		list_for_each_entry(desc, &list, desc_node)
> -			dma_cookie_complete(&desc->txd);
> -		dwc_dostart_first_queued(dwc);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> +	if (dma_readl(dw, CH_EN) & dwc->mask) {
> +		dev_err(dmaengine_chan_dev(&dwc->chan),
> +			"BUG: XFER bit set, but channel not idle!\n");
>
> -		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> -			list_del_init(&desc->desc_node);
> -			dwc_descriptor_free(dwc, desc, true);
> -		}
> -		return;
> +		/* Try to continue after resetting the channel... */
> +		dwc_chan_disable(dw, dwc);
>  	}
>
> +	dma_cookie_complete(&desc->txd);
> +	list_move_tail(&desc->desc_node, &list);
> +	dwc_dostart_first_queued(dwc);
> +unlock:
>  	spin_unlock_irqrestore(&dwc->lock, flags);
> +
> +	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +		list_del_init(&desc->desc_node);
> +		dwc_descriptor_free(dwc, desc, true);
> +	}
>  }
>
>  static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
>
> --
> 2.53.0
>
