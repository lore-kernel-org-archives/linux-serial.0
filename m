Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795639098;
	b=U3t1VNZI7V7liv2NU8Augk5BSoRrRUKmflI03AQV9xfBkT+UmVN/Q10ztQo1Mnuh3+bc
	 vx3wvlQzlj4Eu8PySqfICA+aaAGnJdIIw5qesb1rs2/X6RKNUNOeQ7QmnVaCcTeKTQEmS
	 WmWpROcVPOR/LcPg5DtZ3nVRR+CU8VFrkKjvKbyD6/ruyA8zOYBjehaOuOf1K0zLpfVe7
	 ferKzrnEGKJuQZ/83tFrh/RG+3Ux0Tb0U1Bfya/S6b+w2f6Qq8Mw/sq5aaVhnhao+sGZb
	 sXFBIxlaG6drejDbc1XWuiGPkJonhw3USPpYlf7O1GGHGbrtn0+wDvYpYcVEhv0gfGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639098;
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
	bh=2r75e3ySEgJRdelySusMv4ZDUVEcN+7iVuXpgTxMDOk=;
	b=d+Eg//5mo2DsrDcmMIef5J5F8KdfLZBtbA85jvkMTd/mVqwfprS3cXYNVI8zmlGot8kd
	 4FYR2ETHooq0ExGdLATC0/rh9uyr6U1AEfWypY+ZKHDdT3+m7Zgta4+fMEweW9S//yC46
	 i4Fk2k0gAxPwsc83C6e001bIA7whAO/SFDrK5HzqlT3xLwWZpiPtJEbDqBZK+lkgXePKm
	 Y7rHnRiUwOaRO8rLokaPt8DfxsjbgebsY6saLOD1jyfE6IfvQEdR661KVCbCkXbsQXLvu
	 cl/O1RcFFkpQo2h0hKhobH84agLpVcaAU2vtL9Ty45JAcctXDLCjyAWI4RFylzJ3+Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KEj029lF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.50
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214C606A69D;
	Wed, 25 Nov 2026 20:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F214C606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KEj029lF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADfGEYNjXfMPt3HVT54Z7CoZUggUgz8VNeYWbMgbqzQcC742OIiVbDzX6zWahF/0sqhFM3w/tKYQPeup3LOd7cFUpRe17YuOrntuRvEPWayCylXI2b0HHAi/MrCpoGFnCtqUw0+fGpbXtQWsjIkoZMXkGwOd95OwzXOVkBy8uwjHlo9K3fcm6HmARpzEiACcok9zPtwp9DWJgkrMow2f+jl9+Qs7Yp4eiPcuqjrFhatNMSLqXpa1rpIs7ODKugukyL+8YdiX/PwNM/H8heUQ5eJf5hTlOU0+TQmayfwPS65jsAuQvA83YTsAXCvPXCdE5XEicSBKiepN2lXGgkNJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r75e3ySEgJRdelySusMv4ZDUVEcN+7iVuXpgTxMDOk=;
 b=ElrRjSNxXHTKujov6gI+8tUR/uHojbH7FMd+FPZgfR/mWhbTlvhn2BUPCsWe/9wp0svvm+A4yGQdu+SxER/WTga8/J9+413jnoc+cz9jdTsAZiPE/fJMNSk22vs4n3V83G3jIbVcFrZWzOBXc257+r56oPW+MzaVcoQZfWajdAdsYnaJ803hQaJsDtNl4F9CFf6c0fpixuLtDJU0Xdc+JrL7cRmpcKj25iGMlTh/Ui2pDIqVornqp5ljDmYVHL9icuhyHemoXrg0xhGgOOsMv7yQCtbL5Ws8tdtIB7yWjpfv1e/aTUjEpaTIwsnrayvv7JcephGq0st89W0m2FKCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r75e3ySEgJRdelySusMv4ZDUVEcN+7iVuXpgTxMDOk=;
 b=KEj029lFZJpHdzp0i002VeT8BnJST+lg7SOi6PEHJ/+Np7fuNnTiPIj0VzCdl8GUVoC45fqLCy/H9H6EQyO64VlXPY47ocX5mup5xbU5Ljjd1pEtKGCKfiRHdzC86fLMqwt2gdEgHGK2pMPt3W8RaCj9qo6hrCqa7oV4DXXJSy5kA8V11kauqxtetslgFAlndq89wuLrce5TgsaryTLvGGl7HMvrBZr1w4gukG3/ND4RmwTxSq9AeMlRfHBMQ/DfTluXcHUPZEewW2dZZvIXQ4Vnot36P8IWECNFIWeCBMej5EOKZyLGpm/mD7SpZvFtAd49N118gFQJTr/twT8Jaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB11841.eurprd04.prod.outlook.com (2603:10a6:800:2e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 20:38:09 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 20:38:09 +0000
Date: Wed, 25 Nov 2026 15:38:03 -0500
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
	Lars-Peter Clausen <lars@metafoo.de>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v12 3/7] dmaengine: dw: embed a virt-dma channel
Message-ID: <awdHK4lM8Qa0lpi2@lizhi-Precision-Tower-5810>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
 <20261121-submit-dw-dma-synchronize-v1-v12-3-f51eb635209d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-3-f51eb635209d@gmail.com>
X-ClientProxiedBy: CPBP307CA0013.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB11841:EE_
X-MS-Office365-Filtering-Correlation-Id: db3d1aa1-ca32-4410-1d32-08df4b340480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|7416014|376014|261026140227099003|261022105027099003|10067099003|261026121527099003|261022075727099003|261021123027099003|261102123227099003|261021135927099003|261021121427099003|261028144727099003|261009223027099003|6133799003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	rnVHdw5xrkRSDAMhRx2vaqOBUYIKEMG4m1KBiXhRVKbRnr8KwC3iogoDrpOqf5iAR4Z2oDb4BxZ8UQR/qCTqKe4QP9lBEGQH/8A2L5ZAxCNefNXoB4EeQLyZdCmitHDsC+4evkqjssiSagv4z/DRGhH0UoBvknUfq4BdttCxIiqisgWZQUT19EBkbymACgS5ZwtZvqokT5s1jO+8KKBswfLTUoZQYgdTqn3J9wjXbWj3qcaQ5cX3SHDQyBD/5rjuwdjER8OrbMSjNpozBrZjuypzh3O3H7s0KHFMCBffAqGx7aOoms4e3dHKEQN4vNwSdwULb1uGlUOyMv1NDNrDhHyZhDIzhrqtGahH7JESwOEzcO1UWvvebM/YJdKmv0pRvKPXUfAqL2FZ1bC2VxUR9i02czttK1HUCTkTJ1k1GHnOfNhKq8EXNPkPJN1tf4qdIDnqtPbxeeo0Z7nrvTqxdu6AHqY4nY/sLdDgh4Br0RaZLyKCzZr60BqmGIQFMf7KVYOCKy5Lue2fWQVRNbwolaac94P9M14GXVPmGZkxM+Q7AP0aGA+0dR/9oKXgfSZ3WC9fy/4ByUWKRZxTlSjcQwdv6PdKKze3al7i/WDyCt9grxYUUEkvLcfSBpIdQ5LFx/HO/8csyQpZg+9XHgoP+KrmWU+7H50nrJvhCMPdo5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(7416014)(376014)(261026140227099003)(261022105027099003)(10067099003)(261026121527099003)(261022075727099003)(261021123027099003)(261102123227099003)(261021135927099003)(261021121427099003)(261028144727099003)(261009223027099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8SE1rqgBxdO3vAqqM9h8x1yXfHMotUjqy8hYj+JSqExQkQrVV1y+aH2UFns?=
 =?us-ascii?Q?9fir6a0ln5VJp2YYQkrklim2f5n4ovIk3UMfPaInKBZ5gGrDH+LpI6QiNZ7T?=
 =?us-ascii?Q?k1r4ic4MsZuHddxyIOK6qI3vgWcP0LcA1NRqmIv6w2scUgRqiKOQd+dmYRQt?=
 =?us-ascii?Q?HmoCAF3UkTcIIozAEMCVENNqIo4ip2s80tl7lh/zKI63Li750bBLxeT4Oypx?=
 =?us-ascii?Q?yH+topLMuy+MqH8+AkJXFuYTNSAVgRYnosV2J64AOOZLzotNZr6yZ1N3APCv?=
 =?us-ascii?Q?3qe0OvHJxug2caisvU+Aud5iM3+oBJYztj+NLf/leOxlm/vwIdx7KhXm2y/X?=
 =?us-ascii?Q?+Aj5VdM/wLmXBW5SSynlu6TdDY+5kj4XDtZ9n2MIdG8Wf1cMvXj/aD8HDzoo?=
 =?us-ascii?Q?M4iDXqQbHv+Ni/SoYbt1C7IrrP4/OzC3SGoOpPHtJ/pRvSp3L5mUv/nMwfK4?=
 =?us-ascii?Q?3E/WKCDeHdWNdkH+Jt3K/iH41HZMbYZt9LBZCZtw326lLGThZW2DvKVqRVC1?=
 =?us-ascii?Q?ll3mhPqg5in+i/cWZl4eHTdVE+wZ4QL8/KkYlb0qvsbsKarDsTe7E0KIBk/Q?=
 =?us-ascii?Q?Zf5L4Sfo4gIaMCioj2ikTaBl4zNZbvAk3rn2CFSkmmcfK87r4jz+QtWCZMz4?=
 =?us-ascii?Q?3knzS63rOFI3GFASFh6t4d8l1hPf+6rcDebsKZR1S9eCuz9PhV3O11ZpeaP+?=
 =?us-ascii?Q?vjBM6CqeIMXsH7aAd+vaMHC+0GpQxq2tz7+yxwuw7fiI55Dss5MCjXT5bHdI?=
 =?us-ascii?Q?BenXp7PwCw2jOKUUFjm8OP/ZPCseav8SOhl16Dl5vx+i++E+q6Lj6ARt3eCh?=
 =?us-ascii?Q?TEfzHR4bem/Zo2MYbveZoeFkSaV+I6n8c1hdIdzl7HOhu2hHIb4tGBRVgbp+?=
 =?us-ascii?Q?yCvWa/sRixt7bwYO8OEh+mMFPsRQio9MfeMHm7cvtstNbkKk/SmZakSKnfYb?=
 =?us-ascii?Q?remgnsw9hB/FyQQMC9/bj2tCLyKctcYoQ4W3ha+upoUPqFUQZO9avlN/4E/E?=
 =?us-ascii?Q?zzwtkRyjphkU82ONknNdQqR+haL91zfErqxjeYHwvHmUR1TqBR82p+uZRioY?=
 =?us-ascii?Q?A8h2uR8xZbZlORSokY1Q8C3HSYa9q6AL6FHFM4JshKb8rAA95sHiajnxI9bM?=
 =?us-ascii?Q?IfPq52HG70h4zdThvUtOKxZbTAB8isRLptdHMSXl0pOe0/gwJ8luCEUY1TEJ?=
 =?us-ascii?Q?1MnyVvKOtbVTqOfgrO9n7UeLbSeGGtuOSDYM+62YhvsBGV9MzSQlNi3tTNzR?=
 =?us-ascii?Q?e/2e8yJal30s5v2TgtEyRy8IjmTTODE6LdLAmHg3mB+YV9m1rx/2cFX31O0E?=
 =?us-ascii?Q?QK8W3zl9Gk8T1WNGUGovJQ/iMfayO9qvqe2KwcL4b4/d7RbQR6Kg/0c+VwUH?=
 =?us-ascii?Q?S/gq1qiEhpZ1RmZ3K+D1n+lXm+ZXkVZ8Jlg9z5ZrqstQkUEDcgKt4eCG7MWb?=
 =?us-ascii?Q?vZrvqK+WwOy/eEyBleEDik0vzVXL/f2iRnp3TgKPU3m6IGPEw14uKnZ520yD?=
 =?us-ascii?Q?eY0OiuRrClZb0q7oba6lET2rK4MBbxEBmi4jbTN9VVW2oP/VLnpndEnGf7ON?=
 =?us-ascii?Q?aNZM2yVFM3sVQF+BNM2F6lQ1DqXYrXwqDkE5kzoK34XOJMPld2F9nXSdn5L1?=
 =?us-ascii?Q?OlHwiYz9MnTTwS84bsYO6qpmCZkqAE0z9o+DN7A96WIC+OWPhWyo/WTCFc3f?=
 =?us-ascii?Q?RpDQbS6H73G3MJTWcecWzt4Cn9q3kqv/ZuN4AkLAhRakaHy7HioxmlBjjbsk?=
 =?us-ascii?Q?aoKzcVr5Cc/7MN/dAIVHgLqZ53ZvGZEUpojg9EQAOyfHc2V6MP7S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3d1aa1-ca32-4410-1d32-08df4b340480
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 20:38:09.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N8w0PHtSBE7EQfuL3bI55AxsQGUF+h7PYZ+ZW1EE1q7oYY+1iGTcclVFIruzzVAnBlMnvDbW+0XdFqlYXcZvT9fmLYPWcTfdDf8djC9bwoqjGsQshNnHscKMrKAGYDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11841

On Sat, Nov 21, 2026 at 02:03:18PM -0700, James Hilliard wrote:
> Move the DMAengine channel and its lock into an embedded virt_dma_chan.
> Keeping channel registration, descriptor queues and callback delivery
> unchanged separates the mechanical member changes from the conversion
> to virt-dma queue management.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c   | 112 ++++++++++++++++++++++++------------------------
>  drivers/dma/dw/dw.c     |   2 +-
>  drivers/dma/dw/idma32.c |  18 ++++----
>  drivers/dma/dw/regs.h   |   9 ++--
>  4 files changed, 70 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index f7ca9da5af90..3df696e41ff2 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -53,7 +53,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
>  	dma_cookie_t		cookie;
>  	unsigned long		flags;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>  	cookie = dma_cookie_assign(tx);
>
>  	/*
> @@ -63,7 +63,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
>  	 */
>
>  	list_add_tail(&desc->desc_node, &dwc->queue);
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: queued %u\n",
>  		 __func__, desc->txd.cookie);
>
> @@ -72,7 +72,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
>
>  static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>  	struct dw_desc *desc;
>  	dma_addr_t phys;
>
> @@ -82,7 +82,7 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
>
>  	dwc->descs_allocated++;
>  	INIT_LIST_HEAD(&desc->tx_list);
> -	dma_async_tx_descriptor_init(&desc->txd, &dwc->chan);
> +	dma_async_tx_descriptor_init(&desc->txd, &dwc->vc.chan);
>  	desc->txd.tx_submit = dwc_tx_submit;
>  	desc->txd.flags = DMA_CTRL_ACK;
>  	desc->txd.phys = phys;
> @@ -91,7 +91,7 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
>
>  static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>  	struct dw_desc *child, *_next;
>
>  	if (unlikely(!desc))
> @@ -109,7 +109,7 @@ static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
>
>  static void dwc_initialize(struct dw_dma_chan *dwc)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>
>  	dw->initialize_chan(dwc);
>
> @@ -122,7 +122,7 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
>
>  static inline void dwc_dump_chan_regs(struct dw_dma_chan *dwc)
>  {
> -	dev_err(dmaengine_chan_dev(&dwc->chan),
> +	dev_err(dmaengine_chan_dev(&dwc->vc.chan),
>  		"  SAR: 0x%x DAR: 0x%x LLP: 0x%x CTL: 0x%x:%08x\n",
>  		channel_readl(dwc, SAR),
>  		channel_readl(dwc, DAR),
> @@ -150,7 +150,7 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
>  				       struct dw_desc *desc)
>  {
> -	struct dw_dma	*dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma	*dw = to_dw_dma(dwc->vc.chan.device);
>  	u32		ctllo;
>
>  	/*
> @@ -169,16 +169,16 @@ static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
>  	dwc->tx_node_active = dwc->tx_node_active->next;
>  }
>
> -/* Called with dwc->lock held and bh disabled */
> +/* Called with dwc->vc.lock held and bh disabled */
>  static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
>  {
> -	struct dw_dma	*dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma	*dw = to_dw_dma(dwc->vc.chan.device);
>  	u8		lms = DWC_LLP_LMS(dwc->dws.m_master);
>  	unsigned long	was_soft_llp;
>
>  	/* ASSERT:  channel is idle */
>  	if (dma_readl(dw, CH_EN) & dwc->mask) {
> -		dev_err(dmaengine_chan_dev(&dwc->chan),
> +		dev_err(dmaengine_chan_dev(&dwc->vc.chan),
>  			"%s: BUG: Attempted to start non-idle channel\n",
>  			__func__);
>  		dwc_dump_chan_regs(dwc);
> @@ -191,7 +191,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
>  		was_soft_llp = test_and_set_bit(DW_DMA_IS_SOFT_LLP,
>  						&dwc->flags);
>  		if (was_soft_llp) {
> -			dev_err(dmaengine_chan_dev(&dwc->chan),
> +			dev_err(dmaengine_chan_dev(&dwc->vc.chan),
>  				"BUG: Attempted to start new LLP transfer inside ongoing one\n");
>  			return;
>  		}
> @@ -224,7 +224,7 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
>
>  	list_move(dwc->queue.next, &dwc->active_list);
>  	desc = dwc_first_active(dwc);
> -	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: started %u\n", __func__, desc->txd.cookie);
> +	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: started %u\n", __func__, desc->txd.cookie);
>  	dwc_dostart(dwc, desc);
>  }
>
> @@ -239,9 +239,9 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  	unsigned long			flags;
>  	struct dmaengine_desc_callback	cb;
>
> -	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
> +	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "descriptor %u complete\n", txd->cookie);
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>  	dma_cookie_complete(txd);
>  	if (callback_required)
>  		dmaengine_desc_get_callback(txd, &cb);
> @@ -253,7 +253,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  		async_tx_ack(&child->txd);
>  	async_tx_ack(&desc->txd);
>  	dwc_desc_put(dwc, desc);
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  	dmaengine_desc_callback_invoke(&cb, NULL);
>  }
> @@ -261,7 +261,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  /* Returns how many bytes were already received from source */
>  static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>  	u32 ctlhi = channel_readl(dwc, CTL_HI);
>  	u32 ctllo = channel_readl(dwc, CTL_LO);
>
> @@ -277,7 +277,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	unsigned long flags;
>  	LIST_HEAD(list);
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>  	llp = channel_readl(dwc, LLP);
>  	status_xfer = dma_readl(dw, RAW.XFER);
>
> @@ -285,7 +285,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		/* Everything we've submitted is done */
>  		dma_writel(dw, CLEAR.XFER, dwc->mask);
>  		if (list_empty(&dwc->active_list)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> +			spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  			return;
>  		}
>
> @@ -311,7 +311,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  				/* Submit next block */
>  				dwc_do_single_block(dwc, child);
>
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> +				spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  				return;
>  			}
>
> @@ -320,7 +320,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		}
>
>  		if (dma_readl(dw, CH_EN) & dwc->mask) {
> -			dev_err(dmaengine_chan_dev(&dwc->chan),
> +			dev_err(dmaengine_chan_dev(&dwc->vc.chan),
>  				"BUG: XFER bit set, but channel not idle!\n");
>
>  			/* Try to continue after resetting the channel... */
> @@ -330,7 +330,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		/* Detach the completed transfer before starting queued work. */
>  		list_splice_init(&dwc->active_list, &list);
>  		dwc_dostart_first_queued(dwc);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> +		spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
>  			list_del_init(&desc->desc_node);
> @@ -340,17 +340,17 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	}
>
>  	if (list_empty(&dwc->active_list)) {
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> +		spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  		return;
>  	}
>
>  	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> -		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> +		dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: soft LLP mode\n", __func__);
> +		spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  		return;
>  	}
>
> -	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
> +	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: llp=%pad\n", __func__, &llp);
>
>  	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
>  		/* Initial residue value */
> @@ -358,7 +358,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>
>  		/* Check first descriptors addr */
>  		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> +			spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  			return;
>  		}
>
> @@ -366,7 +366,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		if (lli_read(desc, llp) == llp) {
>  			/* This one is currently in progress */
>  			desc->residue -= dwc_get_sent(dwc);
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> +			spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  			return;
>  		}
>
> @@ -375,7 +375,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  			if (lli_read(child, llp) == llp) {
>  				/* Currently in progress */
>  				desc->residue -= dwc_get_sent(dwc);
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> +				spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  				return;
>  			}
>  			desc->residue -= child->len;
> @@ -384,12 +384,12 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	}
>
>  	/* Residue describes source reads; only RAW.XFER completes a transfer. */
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  }
>
>  static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
>  {
> -	dev_crit(dmaengine_chan_dev(&dwc->chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
> +	dev_crit(dmaengine_chan_dev(&dwc->vc.chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
>  		 lli_read(desc, sar),
>  		 lli_read(desc, dar),
>  		 lli_read(desc, llp),
> @@ -403,7 +403,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	struct dw_desc *child;
>  	unsigned long flags;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>
>  	/* Termination may have cleared the error since the tasklet sampled it. */
>  	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
> @@ -430,20 +430,20 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	 * controller flagged an error instead of scribbling over
>  	 * random memory locations.
>  	 */
> -	dev_WARN(dmaengine_chan_dev(&dwc->chan), "Bad descriptor submitted for DMA!\n"
> +	dev_WARN(dmaengine_chan_dev(&dwc->vc.chan), "Bad descriptor submitted for DMA!\n"
>  				       "  cookie: %d\n", bad_desc->txd.cookie);
>  	dwc_dump_lli(dwc, bad_desc);
>  	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
>  		dwc_dump_lli(dwc, child);
>
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  	/* Pretend the descriptor completed successfully */
>  	dwc_descriptor_complete(dwc, bad_desc, true);
>  	return;
>
>  unlock:
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  }
>
>  static void dw_dma_tasklet(struct tasklet_struct *t)
> @@ -872,7 +872,7 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
>
>  static void dwc_chan_pause(struct dw_dma_chan *dwc, bool drain)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>  	unsigned int		count = 20;	/* timeout iterations */
>
>  	dw->suspend_chan(dwc, drain);
> @@ -888,16 +888,16 @@ static int dwc_pause(struct dma_chan *chan)
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
>  	unsigned long		flags;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>  	dwc_chan_pause(dwc, false);
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  	return 0;
>  }
>
>  static inline void dwc_chan_resume(struct dw_dma_chan *dwc, bool drain)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>
>  	dw->resume_chan(dwc, drain);
>
> @@ -909,12 +909,12 @@ static int dwc_resume(struct dma_chan *chan)
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
>  	unsigned long		flags;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>
>  	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
>  		dwc_chan_resume(dwc, false);
>
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  	return 0;
>  }
> @@ -927,7 +927,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
>  	unsigned long		flags;
>  	LIST_HEAD(list);
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>
>  	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>
> @@ -941,7 +941,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
>  	list_splice_init(&dwc->queue, &list);
>  	list_splice_init(&dwc->active_list, &list);
>
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  	/* Flush all pending and queued descriptors */
>  	list_for_each_entry_safe(desc, _desc, &list, desc_node)
> @@ -968,7 +968,7 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
>  	unsigned long flags;
>  	u32 residue;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>
>  	desc = dwc_find_desc(dwc, cookie);
>  	if (desc) {
> @@ -985,7 +985,7 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
>  		residue = 0;
>  	}
>
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  	return residue;
>  }
>
> @@ -1016,10 +1016,10 @@ static void dwc_issue_pending(struct dma_chan *chan)
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
>  	unsigned long		flags;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>  	if (list_empty(&dwc->active_list))
>  		dwc_dostart_first_queued(dwc);
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>  }
>
>  /*----------------------------------------------------------------------*/
> @@ -1094,7 +1094,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	BUG_ON(!list_empty(&dwc->queue));
>  	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	spin_lock_irqsave(&dwc->vc.lock, flags);
>
>  	/* Clear custom channel configuration */
>  	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
> @@ -1104,7 +1104,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	channel_clear_bit(dw, MASK.BLOCK, dwc->mask);
>  	channel_clear_bit(dw, MASK.ERROR, dwc->mask);
>
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	spin_unlock_irqrestore(&dwc->vc.lock, flags);
>
>  	/* Disable controller in case it was a last user */
>  	dw->in_use &= ~dwc->mask;
> @@ -1221,13 +1221,13 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  	for (i = 0; i < pdata->nr_channels; i++) {
>  		struct dw_dma_chan	*dwc = &dw->chan[i];
>
> -		dwc->chan.device = &dw->dma;
> -		dma_cookie_init(&dwc->chan);
> +		dwc->vc.chan.device = &dw->dma;
> +		dma_cookie_init(&dwc->vc.chan);
>  		if (pdata->chan_allocation_order == CHAN_ALLOCATION_ASCENDING)
> -			list_add_tail(&dwc->chan.device_node,
> +			list_add_tail(&dwc->vc.chan.device_node,
>  					&dw->dma.channels);
>  		else
> -			list_add(&dwc->chan.device_node, &dw->dma.channels);
> +			list_add(&dwc->vc.chan.device_node, &dw->dma.channels);
>
>  		/* 7 is highest priority & 0 is lowest. */
>  		if (pdata->chan_priority == CHAN_PRIORITY_ASCENDING)
> @@ -1236,7 +1236,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  			dwc->priority = i;
>
>  		dwc->ch_regs = &__dw_regs(dw)->CHAN[i];
> -		spin_lock_init(&dwc->lock);
> +		spin_lock_init(&dwc->vc.lock);
>  		dwc->mask = 1 << i;
>
>  		INIT_LIST_HEAD(&dwc->active_list);
> @@ -1358,8 +1358,8 @@ int do_dma_remove(struct dw_dma_chip *chip)
>  	tasklet_kill(&dw->tasklet);
>
>  	list_for_each_entry_safe(dwc, _dwc, &dw->dma.channels,
> -			chan.device_node) {
> -		list_del(&dwc->chan.device_node);
> +			vc.chan.device_node) {
> +		list_del(&dwc->vc.chan.device_node);
>  		channel_clear_bit(dw, CH_EN, dwc->mask);
>  	}
>
> diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
> index e56974e7d4af..fd4f57476b67 100644
> --- a/drivers/dma/dw/dw.c
> +++ b/drivers/dma/dw/dw.c
> @@ -14,7 +14,7 @@
>
>  static void dw_dma_initialize_chan(struct dw_dma_chan *dwc)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>  	u32 cfghi = is_slave_direction(dwc->direction) ? 0 : DWC_CFGH_FIFO_MODE;
>  	u32 cfglo = DWC_CFGL_CH_PRIOR(dwc->priority);
>  	bool hs_polarity = dwc->dws.hs_polarity;
> diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
> index dac617c183e6..52e591f8410b 100644
> --- a/drivers/dma/dw/idma32.c
> +++ b/drivers/dma/dw/idma32.c
> @@ -35,7 +35,7 @@
>
>  static unsigned int idma32_get_slave_devfn(struct dw_dma_chan *dwc)
>  {
> -	struct device *slave = dwc->chan.slave;
> +	struct device *slave = dwc->vc.chan.slave;
>
>  	if (!slave || !dev_is_pci(slave))
>  		return 0;
> @@ -45,7 +45,7 @@ static unsigned int idma32_get_slave_devfn(struct dw_dma_chan *dwc)
>
>  static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
>  {
> -	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
>  	void __iomem *misc = __dw_regs(dw);
>  	u32 cfghi = 0, cfglo = 0;
>  	u8 dst_id, src_id;
> @@ -55,12 +55,12 @@ static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
>  	value = readl(misc + DMA_REGACCESS_CHID_CFG);
>
>  	value &= ~REGACCESS_CHID_MASK;
> -	value |= dwc->chan.chan_id;
> +	value |= dwc->vc.chan.chan_id;
>
>  	writel(value, misc + DMA_REGACCESS_CHID_CFG);
>
>  	/* Configure channel attributes */
> -	value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));
> +	value = readl(misc + DMA_CTL_CH(dwc->vc.chan.chan_id));
>
>  	value &= ~(CTL_CH_RD_NON_SNOOP_BIT | CTL_CH_WR_NON_SNOOP_BIT);
>  	value &= ~(CTL_CH_RD_RS_MASK | CTL_CH_WR_RS_MASK);
> @@ -85,10 +85,10 @@ static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
>  		return;
>  	}
>
> -	writel(value, misc + DMA_CTL_CH(dwc->chan.chan_id));
> +	writel(value, misc + DMA_CTL_CH(dwc->vc.chan.chan_id));
>
>  	/* Configure crossbar selection */
> -	value = readl(misc + DMA_XBAR_SEL(dwc->chan.chan_id));
> +	value = readl(misc + DMA_XBAR_SEL(dwc->vc.chan.chan_id));
>
>  	/* DEVFN selection */
>  	value &= ~XBAR_SEL_DEVID_MASK;
> @@ -106,17 +106,17 @@ static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
>  		return;
>  	}
>
> -	writel(value, misc + DMA_XBAR_SEL(dwc->chan.chan_id));
> +	writel(value, misc + DMA_XBAR_SEL(dwc->vc.chan.chan_id));
>
>  	/* Configure DMA channel low and high registers */
>  	switch (dwc->direction) {
>  	case DMA_MEM_TO_DEV:
> -		dst_id = dwc->chan.chan_id;
> +		dst_id = dwc->vc.chan.chan_id;
>  		src_id = dwc->dws.src_id;
>  		break;
>  	case DMA_DEV_TO_MEM:
>  		dst_id = dwc->dws.dst_id;
> -		src_id = dwc->chan.chan_id;
> +		src_id = dwc->vc.chan.chan_id;
>  		break;
>  	default:
>  		/* Memory-to-Memory and Device-to-Device are ignored for now */
> diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
> index 5969d9cc8d7a..f47b42d638dd 100644
> --- a/drivers/dma/dw/regs.h
> +++ b/drivers/dma/dw/regs.h
> @@ -13,6 +13,7 @@
>
>  #include <linux/io-64-nonatomic-hi-lo.h>
>
> +#include "../virt-dma.h"
>  #include "internal.h"
>
>  #define DW_DMA_MAX_NR_REQUESTS	16
> @@ -264,7 +265,7 @@ enum dw_dmac_flags {
>  };
>
>  struct dw_dma_chan {
> -	struct dma_chan			chan;
> +	struct virt_dma_chan		vc;
>  	void __iomem			*ch_regs;
>  	u8				mask;
>  	u8				priority;
> @@ -273,9 +274,7 @@ struct dw_dma_chan {
>  	/* software emulation of the LLP transfers */
>  	struct list_head	*tx_node_active;
>
> -	spinlock_t		lock;
> -
> -	/* these other elements are all protected by lock */
> +	/* these other elements are all protected by vc.lock */
>  	unsigned long		flags;
>  	struct list_head	active_list;
>  	struct list_head	queue;
> @@ -307,7 +306,7 @@ __dwc_regs(struct dw_dma_chan *dwc)
>
>  static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
>  {
> -	return container_of(chan, struct dw_dma_chan, chan);
> +	return container_of(chan, struct dw_dma_chan, vc.chan);
>  }
>
>  struct dw_dma {
>
> --
> 2.53.0
>
