Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223D155723;
	Wed, 15 May 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788568; cv=fail; b=FyMVjo1WiwC4YBPeKlTtiFLutr/6bLYP2eLAkXvbR/pL0vqGrQda9zysRVGuZRB/SJMtyuQPFErVxtbtzTaDNP61++fqulYl87VO7q6jIhEOjsuzsPzfVpMYAuafSLjF9NNzebSQIzUClY9LX5l/8X2WkdnxiTqEu7aif6kFpxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788568; c=relaxed/simple;
	bh=ifbMh9rjGvYhilfXoHTK1ndSSCza2u0rpZPnL/lO2PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pqqAUqCo9rTBnVe7a7XKN3hm2AETDiByCDB/ZuGJQWyrBKNR3ZCaCDPcGDgJML3eHXMR6XHPqGcp0GINwrqwWr/LEjK/XRqpydOsZcPzFJE/t1heMjXV3KMV59aXm6/RWwEuYVi6R1cUZsXyhmBBWRXSB0IL7nJ3RsWJBx1hRZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ldt6EXKD; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ldt6EXKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7/FDLPvuli9Qh5GHMTo7J7VjsmWMgg3gg/robeYiasRz7y9B7R9FaeCR7B7MN68y3sa3IEiYV7eMHJc2zSq8YhtN3ifC68O+VjLcmEGGaBDuv8Eexydrxf+LbL3N1e/MxFgcCa6aET1xtWi087RCKIEozUtc3vPVH/kZ3GdNgCfw3qybZ4TrQd6dSUUeiwtD3R9P+Y6YbA1z97HtX4475eRK1d6eC02ZusmtCg5kR/4t2NvYa5qWEKmtscn8MXBYJLot9d3fkBZ/+1xqFqlfhfJLFpfcO4Cc2HCF/UxTOBxjLFPzCfwzn2sKEaMOPhEQKk0E68QuNFvEoHj1EYSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AjIRyeidK/yc09gkNz7xu5Snym/9/xTkU3SDDc14R0=;
 b=bnWkDUgCguHbTKbyPwdW1meype01qQ2bnbqvUQYIbVIqxFuZJfVNioZDCTx/RpV1kUY0shNrWuSvV/snW5sLnWD628ERglsC01hzfnhmY4PIRYDle7hvwqQ/1tscymmbK1sSOArnOln+ubYmoHsp9wlcgp9f9/um0LStv2HrdGYiHxBMptF9pp0gKZBDKBiiWyMLK2aPzD7HXuYvFVnDIPLC+hz5fy9oQguoHfmmIC8TEQA0Ff/w5qa8WJwSbPSk+mFCk3XFHB+tLIMPIz6MMQLuroHrR89c5iM3+Awx39bYg6hmpgfq6xSPMIn4m6+VWzQtRQ6DhIBEsF7T9+Um/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AjIRyeidK/yc09gkNz7xu5Snym/9/xTkU3SDDc14R0=;
 b=ldt6EXKDrSpxLBrL4FO9RsRwEI+WaUJJy+B0AT8Ox4txEnpulXBb1j7mdRy90O+RKycocX6DG21jpQi8G+qT+WHXp7M9IIxdNtU92gXvbjKNZ16ID8Jo24VBG56FrHTStcCDGDRvpcQItOaHMxQKazmQTxPDGIIhBez5/VOWpac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 15:56:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 15:56:00 +0000
Date: Wed, 15 May 2024 11:55:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"joe@perches.com" <joe@perches.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"zbigniew.lukwinski@linux.intel.com" <zbigniew.lukwinski@linux.intel.com>
Subject: Re: [PATCH resend v9 1/8] i3c: add target mode support
Message-ID: <ZkTbBRRtmGlTU142@lizhi-Precision-Tower-5810>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
 <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkJgf/oRMMBswih1@lizhi-Precision-Tower-5810>
 <SH0PR01MB084183D40B4ECC0C4B3A9BF0F9E32@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkONGQPBeuR6oZ0Q@lizhi-Precision-Tower-5810>
 <SH0PR01MB084106A67DF4656C9B8CF686F9EC2@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB084106A67DF4656C9B8CF686F9EC2@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: SJ0PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a66fd99-9dad-4fd5-eb89-08dc74f78441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7MvF0cHIOW/V8tI8ifwBEGzPsxnzfs0QAes2AjywZswDP87bbIZeGkxv/yQ?=
 =?us-ascii?Q?ScP0hqvHjti0QoniMGwjqALW3JM57Vp5Yl8eqJqxoiWLFg52CQ3iZ1YFAEre?=
 =?us-ascii?Q?yM/AoEHJdxYF/COODE4Z/UpvfvcMA4bM6TkNTz88NUborKI8WsxzT7wvTuED?=
 =?us-ascii?Q?Qnj28SsIK1VtJ7DHAudppf3Oz5NqmV+V7csVdav1VGBYT/qhMdmu0UUwoWrT?=
 =?us-ascii?Q?PpOebqOGt077xvcNAYpUDSXZOKomQxdoSSzb/I8Lw+Vh4QOkE2KS/U5Ze9JS?=
 =?us-ascii?Q?EFzbBsYxiPnpyUe3I4e6ZD4WSInlmWEMMEWiqjIgvh11IK2+lvJX4Bd8+W5T?=
 =?us-ascii?Q?IStO9FkEWsswxFrP/ElkM74u3NBsIo9FfnrwD6bPY13Xw+B2YXv6mh7jF29p?=
 =?us-ascii?Q?yR5GSn7MJMuox8efzEDSr03vEbrGruOAgc8hhROZaNwrAhxgy/afI/lKVZPE?=
 =?us-ascii?Q?ZDcrMPQIJ49knSQbb01to5/kPUNJrT5CA4yJlzT8mGaUOJFDwwOmk6TaAf7z?=
 =?us-ascii?Q?2GhzhGjdw5gWt5pUyl7EWVfGcM7nhDd9qViINW8kFSpNjDrETGX+Svghtbr+?=
 =?us-ascii?Q?1RGI9l0dyvA6uGg7CpuwXPEkC7q7YqrrExaVcm+m6mv2fCl4YwGzGDlbjF//?=
 =?us-ascii?Q?KceTxezk+62alncWB4ERz0Ok6lzcNUsy242Eg8L+Qag96Wm7EAnNyq741dOO?=
 =?us-ascii?Q?OdafggMF1ItffYI5MN21qNXKPmbLiEww7mJngNphC5aNmOXkANQJQwrS61dn?=
 =?us-ascii?Q?FqJPCy8768mBcCoVWS+3/APZ02yhIrFGlpBMfrs+MVOHz1Mr+ba0JuDkVUwE?=
 =?us-ascii?Q?IhkXre3N+F+kBkPZdlP1WqZlcvZbGi0Grk4p+xsdve2qPr65EnobdeGduI51?=
 =?us-ascii?Q?+yQfoSAunTjimp/bm3NQdjRH9Vr1jla/1HFoxK9FaQW1Yv74edQCQbwfTU1c?=
 =?us-ascii?Q?K26qQBZHvzZk/6mNouI/FbDEbiV97QqqLd0VET8tm4MdNZFjmHALNDlfB0jC?=
 =?us-ascii?Q?W1HjW2jA1VMdaPBc9/ALtJSYmHUhpAEjQGwC0F+ok86RH2JlB3LztG6kcvLu?=
 =?us-ascii?Q?oCfvPSOcdw2uEslhDQtO4KWgBB/+ZDPMdropgJH+E8herdlzoEJrJLWXew8i?=
 =?us-ascii?Q?JO6aEGzeovvGFI+TzcpzH/rn9nHbi6UnA1bHlRRvYJy+tT/RW0HXxFc9N48g?=
 =?us-ascii?Q?mvyPBFLu3yguxu34jcBbWUyEkyY9ha2BtYn2N5YoIqBP92wnIfz9h+odQbYL?=
 =?us-ascii?Q?aFplzTOO+cQfnh1fIdx1jz1aW9g20IBn4v2VTpt2jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QWM18DXLLHbvcfHT/SPuxs1O2KVgNoEsVvSmPTyn34ESv446UHOIbDMCGimb?=
 =?us-ascii?Q?rEhSivLyinEEMggKU9Z8MdEQcittvQ9jdOUgZcdNqBMN58GNI74s4jJ7fS8U?=
 =?us-ascii?Q?UJP1+nJSmzbmHAwKzHM0tnfqCJQwwHuOAwRkFL5S8BEmDcOeWjwFJxyzUqRv?=
 =?us-ascii?Q?atiY1zqmFKZJVEESVPVbuGxA9S372pDaPQ7wZr7nu7TTKM8y1qhUsbKXPAex?=
 =?us-ascii?Q?Gw5WHfe6yzi+hzyOI1NI0S70r9QMd7hEgL+QzOOcQo2EbNfbLs3TQZYYnlCM?=
 =?us-ascii?Q?me39yTYWxTFekw6KLQrdIBGYUYTjHWa0kSsEvO5f/HXIr82ZkITRa7fCHhO2?=
 =?us-ascii?Q?oDaG6aQuq8ipj/TnEB2JyFWuAUEG3wlLZ3UR2dhfCE1tqfWRIjAtWpPEFftV?=
 =?us-ascii?Q?R6R7Mm3kJRshwedi17FfUVpCAOk5ursXdLSF14F80aAXlU9E53znGyQie6Pd?=
 =?us-ascii?Q?999/kgWm0+WVh3hhnFjv1aqTz4VXEjU2dmOtAjQQ7plpqBc6gUi0LKb7XcPH?=
 =?us-ascii?Q?st0yBqR06ffUPP4puIFJVRLy725Bx9Wn+duWPblg99esda9DNWTjnNHqf1Zb?=
 =?us-ascii?Q?RNdnXGVKnqL7jgwhykmDTHRV6AIg9DFbmtXbpNSSSoB73mrSIlGiW2cx4fF3?=
 =?us-ascii?Q?OQlUSOXnlQpmuIZLwKTzLilMUJNDvjxVlecDRLarbKc6WTlVAA8tWH4Ne9+S?=
 =?us-ascii?Q?qy5BOfMICWhBisxSZOurEmVtcN3MgFtwJ4l0E/I30JJokzRucHazXeo7s075?=
 =?us-ascii?Q?wLjfi9AAUaxcJIlcsEs6GQJD98H4eaCi5g0nuvR9tjWum0NY31DbfmoiC7Iq?=
 =?us-ascii?Q?ZoOy/ZVnOtRhlD1bu24KC216TZBkS+qTQsnq2si4bC9ctdDCa6FLSMvT8+Ol?=
 =?us-ascii?Q?htY4/5RlcA3z3ARrHTDUejntOROMePRE9Vga89hQnTjnq0/v9+iZqO12uRP/?=
 =?us-ascii?Q?i7cEWvDDCyIftpY3XM5p4KCisDdTRKc9HxQ3FWa/Rualu1qIIw2mBp/5QcIY?=
 =?us-ascii?Q?2LdolEpVShyOgMtGyMVbwUjFyd4XIeiCW90Cair2aNkDEBXkfKTbetu88LSK?=
 =?us-ascii?Q?WUlCvnEkmbh8diRfsAvqzBr1YA+wqBH8nLg50WluH5ju43q9orkSTWEoC5Y5?=
 =?us-ascii?Q?5/xzekagkfYfA5ampvzA3dzQugkDGEZMxftHfElvDjyh5GXtMVyXOmshaAxB?=
 =?us-ascii?Q?AXE8XQlUUqKBuXkfZmjyBAdU+GfC8Pxw/pHh4NR8aTd90+hVmO+NFmz7bt4u?=
 =?us-ascii?Q?aOrFVnNKUYZIRNxwJlNEQVG8+FCCGmJ4ShPI2iSLgpgZ9l77K1erJC6o+0XG?=
 =?us-ascii?Q?aamaEI4uGJ3sZZkiXQXau3fR5oVqgK6xnX4/FEttaAeEvU8Z+yyP6iWBMdXM?=
 =?us-ascii?Q?XeR+a5QbQLyF7Uzi5gOUrh0lgVzBX6ZIrIAJOVX4JQZqLvVk9CWQvMPImFGL?=
 =?us-ascii?Q?EblECyJ+Ll2vhhsrw+cAcVOdTlxYCndVElsy2ae97m3/9LmE/46fybR4PLTr?=
 =?us-ascii?Q?niO0SLP2YPZpj005NHLTx+Z/zK1xfPzNW9fLfIUVkYzN9c/PNijrYjm1Q2pn?=
 =?us-ascii?Q?H932N6jD4tqETAaXH9k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a66fd99-9dad-4fd5-eb89-08dc74f78441
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 15:56:00.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tju0fTMYIslMA7wflDmOcP/ES+WzXbBpq4gCXcqnY3Fl3d8WjPb1gGxxs7P7CuodseSepT46+n019itVzma3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645

On Wed, May 15, 2024 at 03:07:37AM +0000, Joshua Yeong wrote:
> Frank Li wrote:
> > 
> > On Tue, May 14, 2024 at 03:07:25AM +0000, Joshua Yeong wrote:
> > > Frank Li wrote:
> > > >
> > > > On Mon, May 13, 2024 at 04:18:00PM +0000, Joshua Yeong wrote:
> > > > > Frank Li wrote:
> > > > > > On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> > > > > > > Joshua Yeong wrote:
> > > > > > > >
> > > > > > > > Introduce a new target core layer in order to support target
> > > > > > > > functions in linux kernel. This comprises the controller
> > > > > > > > library and function
> > > > > > library.
> > > > > > > > Controller library implements functions specific to an
> > > > > > > > target controller and function library implements functions
> > > > > > > > specific to an target
> > > > > > function.
> > > > > > > >
> > > > > > > > Introduce a new configfs entry to configure the target
> > > > > > > > function configuring and bind the target function with target
> > controller.
> > > > > > > >
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Notes:
> > > > > > > >     Change from v8 to v9
> > > > > > > >     -none
> > > > > > > >
> > > > > > > >     Change from v7 to v8
> > > > > > > >     Added missed head files
> > > > > > > >
> > > > > > > >     Change from v5 to v6
> > > > > > > >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> > > > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > >     | Closes:
> > > > > > > > https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > > > > > > > lkp@intel.com/
> > > > > > > >
> > > > > > > >     Chagne from v4 to v5
> > > > > > > >     - add include <linux/slab.h> to fix build error
> > > > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > >     | Closes:
> > > > > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > > > > lkp@intel.com/
> > > > > > > >
> > > > > > > >     Chagne from v4 to v8
> > > > > > > >     - add include <linux/slab.h> to fix build error
> > > > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > >     | Closes:
> > > > > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > > > > lkp@intel.com/
> > > > > > > >
> > > > > > > >  drivers/i3c/Kconfig        |  28 +-
> > > > > > > >  drivers/i3c/Makefile       |   2 +
> > > > > > > >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> > > > > > > >  drivers/i3c/target.c       | 453
> > ++++++++++++++++++++++++++++++
> > > > > > > >  include/linux/i3c/target.h | 548
> > > > > > > > +++++++++++++++++++++++++++++++++++++
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > diff --git a/include/linux/i3c/target.h
> > > > > > > > b/include/linux/i3c/target.h new file mode 100644 index
> > > > > > > > 0000000000000..b0bf06685834c
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/include/linux/i3c/target.h
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > +/**
> > > > > > > > + * struct i3c_target_ctrl_ops - set of function pointers
> > > > > > > > +for performing controller operations
> > > > > > > > + * @set_config: set I3C controller configuration
> > > > > > > > + * @enable: enable I3C controller
> > > > > > > > + * @disable: disable I3C controller
> > > > > > > > + * @raise_ibi: raise IBI interrupt to master
> > > > > > > > + * @alloc_request: allocate a i3c_request, optional,
> > > > > > > > +default use kmalloc
> > > > > > > > + * @free_request: free a i3c_request, default use kfree
> > > > > > > > + * @queue: queue an I3C transfer
> > > > > > > > + * @dequeue: dequeue an I3C transfer
> > > > > > > > + * @cancel_all_reqs: call all pending requests
> > > > > > > > + * @fifo_status: current FIFO status
> > > > > > > > + * @fifo_flush: flush hardware FIFO
> > > > > > > > + * @hotjoin: raise hotjoin request to master
> > > > > > > > + * @set_status_format1: set i3c status format1
> > > > > > > > + * @get_status_format1: get i3c status format1
> > > > > > > > + * @get_addr: get i3c dynmatic address
> > > > > > > > + * @get_features: ops to get the features supported by the
> > > > > > > > +I3C target controller
> > > > > > > > + * @owner: the module owner containing the ops  */ struct
> > > > > > > > +i3c_target_ctrl_ops {
> > > > > > > > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct
> > > > > > > > +i3c_target_func
> > > > > > > > *func);
> > > > > > > > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > > > > > > > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > > > > > > > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8
> > > > > > > > +size);
> > > > > > > > +
> > > > > > > > +	struct i3c_request *(*alloc_request)(struct
> > > > > > > > +i3c_target_ctrl *ctrl, gfp_t
> > > > > > > > gfp_flags);
> > > > > > > > +	void (*free_request)(struct i3c_request *req);
> > > > > > > > +
> > > > > > > > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > > > > > > > +	int (*dequeue)(struct i3c_request *req);
> > > > > > > > +
> > > > > > > > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool
> > > > > > > > +tx);
> > > > > > > > +
> > > > > > > > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > > > > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > > > > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > > > > > > > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl,
> > > > > > > > +u16
> > > > status);
> > > > > > > > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > > > > > > > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > > > > > > > +	const struct i3c_target_ctrl_features
> > > > > > > > +*(*get_features)(struct
> > > > > > > > i3c_target_ctrl *ctrl);
> > > > > > > > +	struct module *owner;
> > > > > > > > +};
> > > > > > >
> > > > > > > This structure looks very different from the master controller
> > > > > > > ops
> > > > > > 'i3c_master_controller_ops'.
> > > > > > > I think you could probably combine 'set_config, enable' into
> > > > > > > 'bus_init',
> > > > > > 'disable' to 'bus_cleanup'.
> > > > > > > Also using the 'struct i3c_priv_xfer' rather redefining
> > > > > > > another 'struct
> > > > > > i3c_request' would be much cleaner.
> > > > > >
> > > > > > Thanks, let me think this. i3c_priv_xter may include read and
> > > > > > write, or write and read. I3C is quite fast. Most time software
> > > > > > are not quite enough to handle it in time.
> > > > > >
> > > > > > If data len bigger than FIFO size, it have to use DMA to
> > > > > > transfer it because there are not flow controler at target side (write
> > direction).
> > > > > > Read, hardware to use early terminate to tell host read too fast.
> > > > > > but for write, 9th bit is parit check bit. Data will be lost if
> > > > > > software have not read from FIFO in time. If use external DMA to
> > > > > > do that, it needs switch dma channel(generally, DMA rx and tx
> > > > > > are two channel). switch channel automatically are quite
> > > > > > challenge at current dma
> > > > engine framework.
> > > > > >
> > > > >
> > > > > I guess when data is larger than FIFO, the i3c controller (master)
> > > > > should 'aware' of this limitation when using such target device.
> > > > > So that appropriate handle like make new read command, or do a
> > > > > write then another larger read request.
> > > >
> > > > Between two commands, such as two write command, some data may lost
> > > > because first one have not chance to fetch it from FIFO.
> > > >
> > > > Function driver can add some recovery mathod. But still better to
> > > > use modem async method to queue multi transfer and handle by dma
> > > > automatically. One transfer each time are just special case for queue.
> > > >
> > > > If DMA support,  queue can work as big cycle buffer, underrun will
> > > > never happen unless system wrong, such as disable irq over 1 second.
> > > >
> > > > Actually, I worry about still i3c_priv_xfer, write followed read case.
> > > > Most likely, host driver do like
> > > >
> > > > 	write (cmd index/reg index) then read value or command result.
> > > >
> > > > It is hard to decode cmd and send back data immedicately.
> > > >
> > > > if there are not special DMA support,  more realistic usage mode is
> > > >
> > > > cmd1, cmd2, cmd3,....
> > > >
> > > > send back
> > > > 	resp1, resp2, ....
> > > >
> > > > instead of comebine cmd1 and resp1 at one transfer.
> > > >
> > > > Host can do that just because all SCL are controller by host controllers.
> > >
> > > The DMA queue mechanism should still be invisible to the framework.
> > > Target could use info from SETMRL/SETMWL to 'prepare' whether
> > > internally DMA is needed.
> > 
> > You are right. DMA should be invisiable to the framework, but framework
> > need provide API to prepare receiver buffer advance before transfer happen.
> > Only function driver know how much data need be prepared advance. For
> > host read/target write case, It also need cancel request function incase host
> > have not fetch data in certain time. Data need be updated. function driver
> > can't simple update data buffer, because it may already map to DMA.
> > function driver need dequeue and queue request again.
> > 
> > framework should abstract common part of difference i3c target controller
> > and target function driver to avoid duplicate code.
> > 
> > And also need consider linux's irq latency limiation, try to make the function
> > driver can work on all target controller drivers.
> > 
> > I think priv_xfer, W, R, ...  are hard to implement. Maybe limit priv_xfer 's len to
> > 1 or 2. But if limited to 1, it becames no big difference with current implement.
> > 
> 
> I think if the target unable to handle multiple transaction I think it is safe
> to throw NACK. In the case small transaction is needed we can still use the 
> same 'struc i3c_priv_xfer'. If it is large transaction and target unable to 
> support multiple transaction it should be the target limitation rather than 
> limiting every target private transfer here. 
> 

Do you have any actual user case for i3c target? So I will have better
overy all view?

Frank

> > >
> > > We can also argue that the max read length should always not larger
> > > than the FIFO size. Slave data transfer interface should still match
> > > what i3c spec expect to be, rather than the hardware limitation here.
> > >
> > 
> > According to spec:
> >  	5.1.9.3.5 Maximum write length in a single command
> > 
> > I am not resure "singe command here". I think it should be between "start"
> > and "repeat start/stop".
> > 
> > If my understand is correct,  host still send out W R W R ... as whole I3C
> > transaction, each one less than FIFO size. but totally size may exceed FIFO size.
> > 
> > 
> > >
> > > >
> > > > >
> > > > > > Of course it will be possible if hardware implement simpilar I3C
> > > > > > HCI command queue. But I still not found any hardware that can do
> > that yet.
> > > > > >
> > > > > > If only limited data size to FIFO size, there are still
> > > > > > limiation for xfer.  if write, read, write, read, two write may
> > > > > > combined in one FIFO, target driver may not split it which
> > > > > > depend on hardware detect repeat start and insert something into fifo.
> > > > > >
> > > > > > It is hard to support all user case by I3C target software in linux.
> > > > >
> > > > > Can I know the speed limitation that you having issue while
> > > > > running on
> > > > silicon?
> > > >
> > > > I am not sure what "speed limitation" here? Do you means irq latency
> > issue.
> > > >
> > > > when I get "stop", there are new data already come into FIFO.  It is
> > > > not for problem for tty case now.
> > > >
> > > > But if it is well defined frame data, it may be problem.
> > > >
> > > > I saw some data lost when target are busy without DMA support.
> > > > driver can query how many fifo space avaible before send data, but
> > > > it reduced bus utilities rate.
> > > >
> > > > >
> > > > > >
> > > > > > write follow by read, generally used from get hardware register
> > > > > > value from target side, which almost impossible by software, it
> > > > > > is not quick enough to parse (write value) then send back data.
> > > > > >
> > > > > > >
> > > > > > > In the master i3c side they don't abbreviate
> > > > > > > i3c_master_controller to i3c_master_ctrl. I think we should do the
> > same here to standardize it.
> > > > > > > Thanks
> > > > > >
> > > > > > The problem is in I3C spec: "master" already depericated
> > > > > >
> > > > > > from i3c spec 1.1.1
> > > > > >
> > > > > > "Controller: An I3C Device that is capable of controlling the I3C Bus."
> > > > > >
> > > > > > master/slave => controller/target.
> > > > > >
> > > > > > It will become more confused if i3c_target_controller. "controller"
> > > > > > are ambiguity.
> > > > > >
> > > > > > If "master" => "host" would be better situation, but not happen.
> > > > > > A point, I use "ctrl"  here to avoid I3C spec defined "controller" term.
> > > > > >
> > > > > > Anyway, I hope more people that involve target support discussion.
> > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > > Joshua
> > > > > > >
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > linux-i3c mailing list
> > > > > > > > linux-i3c@lists.infradead.org
> > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c
