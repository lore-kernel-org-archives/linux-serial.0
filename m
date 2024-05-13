Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F74207A;
	Mon, 13 May 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626131; cv=fail; b=nrh2KlYXlMNHr0DEIc4kewbDjMJGhjBJ/zpRTP7lw0FF1YsfC1nWuktrL0Wl7hILWcuDpqKCAfESYBpCrMI89EwJQTArsEmUwvtuIYkdjHDJcOUBk99V/hQaop0jY+ZRGaZmTCAsbZTa27pqnkzKKbjgKPjp2BS65ExIBq4vf9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626131; c=relaxed/simple;
	bh=3aIPnLIxM5c0xDR2vW6mBzUE391YMYcsAQH1s7de6eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FifCYlESQatHhy+fS25Txvb/LKKMASMdRCdAF3K9JblCSlrEKxpDWNpJ9JArgjyoHvclL8FHA4tactFYPQh+0pvHbPERFhmSP7KrjrINaO7rkXUV02ZsKXCJK1JllB7jMSisUzApYy2M26TieVia1KO/BPaEZYG/hbrsvpKvHxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oQkcQC+W; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oQkcQC+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVoHT00TTub5FkRasvi0t633WxamJGJv1aYC0Ul4S9aw5zcWY//kBpbk1LPA1a7MmtvD3B3yeDs9nwJLmI085bfcZHDpWP2CmTi8s0uHNGT6b5WTVJ4a79XfU0YMiyRNg0Z3YbypB8S4LGJtJCTiVp+NVRG52qc4rsnYgTBkVk5J+lnHUFpQPmpqRiAfm9V7wnSDbsstHfW7CidI7NBzE4MfHsTjBlPYsdW2Ed+0yVg4DdmHEv87vVr3+eKfnoySNxo3aCJgzFgSPU1ZW5yP61ouAy0qNHyU1GsEdM97NKFOLKEbqaIcxkTnvZJrg6xxOK+Wnou7cktzIlOTnexrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIYj9FvTsgbLOsEnSBoCZlbFBF+OJbhjdqIxMjhPXqo=;
 b=Y+9UWa/0+gSxeIiM/rxq6QgKZK4X/0ct4fa8qNuf7Bo0iVf2S37uQRYN7mbwjfzYTptmeG53EKa3qojK69g1jso+vNDi8i7Eyeq8n0Lnl6XffvCYi8WFs8zR4GD4RAQKY10xhQ1WSgNaH0kz5mSvqFn5qC0F3SU/6ncZ0fbRby7OHQ/72nVC5UZJ+saanlX6jji9c1uXaPTMTqLjal+JamibvkEYr+KMUvmZSQyFvq9oFihYnZzkeYILD84drpc3RCd0/5V0UwHppvlDMhWIqnOZFDbHd+O4XFGkhaA7NLoh6p0IXwKa/wijAr7MDw22MsCjjW89ocObFCNh03mnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIYj9FvTsgbLOsEnSBoCZlbFBF+OJbhjdqIxMjhPXqo=;
 b=oQkcQC+W1YfbrLwxqk8hZd/qEilB2+H8P6qrTxAgLSmm/vssE8DhN2vNVBGLlT7StEZhWtjoxvHt4kcZpkBMvWXVk86Bavt2ig2nBCKyAh4twSDwNLgCkmllJspJ66RYkJJ7VBZg+VlYXeJ7XzTkhkGRQz+4dwcfeS8gPeSGOI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 18:48:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 18:48:40 +0000
Date: Mon, 13 May 2024 14:48:31 -0400
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
Message-ID: <ZkJgf/oRMMBswih1@lizhi-Precision-Tower-5810>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
 <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c4f53c-9955-4187-5205-08dc737d4e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rweGXksIpa3zb+dpO7J4AzKyj3x3o3fH7vw5d7Odd5R/54hbOh0G7oXWz1Z/?=
 =?us-ascii?Q?nzvxGWqJmc5b8164VcNAU17BKzrEbg0HyYqn7GNFyZPlW0Zwitamsmnoog2K?=
 =?us-ascii?Q?0lC/HVGP5lSdv4T8ISeRPxiuDcxZ7R/H6aZpkFdmuKyr7e5TwtQi9Wi5y44u?=
 =?us-ascii?Q?9pww0ooXOngBTOBRNbV4fnnzqn+rwpUQ/H7LwrY0w1+ulQ/cJX/Pbkiv/EoT?=
 =?us-ascii?Q?ueLpxDLZxTfxFNqzF3WFTSP/Rq408eZzCCsZ9hYdAN1KelwJbK6VJ67uq+og?=
 =?us-ascii?Q?L/iFBKN2m4i4xDC6YM4EhyAqjOHjTxZHnLwlHbtICuUJaQFemS8iRxBMra6V?=
 =?us-ascii?Q?5j4TSLBaYE6xfsqNTzOijpl3WXc0g19s3DvEDwA4MlJKSeqb9yD73VEIL/jO?=
 =?us-ascii?Q?NrIFWImaoj57gqKPz9YQiWsIMVeZcAZ2yaG/00rS9xzm2WYcIklE27+rBszv?=
 =?us-ascii?Q?vyN0ZyXttyk/cZxOb2vflcwoN/AwZhc3rgXVPIwejuNIpIA2zWaM4CDFkxaJ?=
 =?us-ascii?Q?nhd7OUK4kwjn787YdmHVI1+gUIH1XkbUQovDtIO+nZGLjDLmTTRcoeDrOosz?=
 =?us-ascii?Q?/lwuXEInHuvMcB0kAQPeRF4upiJFdFGgVOI3trMk2/HgNU+97wKceKFFwCSj?=
 =?us-ascii?Q?W4snWl0MSxCWMBhYO/u1tMbPXn1juiJLZJOQVjCdG3xmTNAOI8zsM2mTwmg0?=
 =?us-ascii?Q?BccL+hpEc7QULd3dM9H91wMTuaF7QkpAqsne5TR4IuaULl8PZCtt/WO/UNNA?=
 =?us-ascii?Q?Gc+WwfQX6C5RfEnvfeG3bpzfRzHjvzeXv4S0cZSMWyxJGDrlOfwrwbqCqEhi?=
 =?us-ascii?Q?1Cskuq7an6heuGEbQ9Eae5g3NNuINQiI+g2aKJrA7QiClVZC4FWDPT9XjvP9?=
 =?us-ascii?Q?33O70JI8Pvc9bdMhtOmtp6xgHvOkBbcwhpcBAOjFoNNN7+zE6+8layAtOO3Q?=
 =?us-ascii?Q?jLGxHDJS2gZzzgwA2X69nXL+qjWU+aSp8GLGKguqtBfTFc1r7Dc0UJoC6qCI?=
 =?us-ascii?Q?7BIX7doE44JZaYtIOtudcxavjDtj/GxNKf+Zhpz3DBLt5wyzOO5o3iPuckaa?=
 =?us-ascii?Q?HaE5GbGEdHSAZHhK/EILfM2BcePCx8itXSgNKqybHR7fBtYExKjSse0dsJ3X?=
 =?us-ascii?Q?gf5kxypd+KQJELKlMqtzPn7i+CVSZdTdfB4Bdzu5crL82BWyGidi4mQf9CP6?=
 =?us-ascii?Q?dbLa7oVECbpvEO0BgQzmmE5rflqAM1B2jPTCGfsMXSHLA3B86ckGPrA7KsCx?=
 =?us-ascii?Q?4ViMWfheDuElQSFVEHSTdfYcAEMrdPnVYAUpEE9LJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXEJxuj8Z8PzLeiZgJ/zUJfu2UAaKh5R82zTGFqb3k852AIQY43fpZzHWqBL?=
 =?us-ascii?Q?hlhk1pNyQ48RCJAqriXUu+7tRXnAw4+ykcba6AZ2cS14XPocoWZuP8Q9/ik6?=
 =?us-ascii?Q?2Ll6pvTfR5VQBDLfq9ePppR912ngj/PjotlXorMujGWCmZSfDqP/2JcwSmN/?=
 =?us-ascii?Q?lAVXEqbKb3sPK6lyp7Gq7mCLmx/lURuJLq1bFcIIP/bIeid6uIVFbth4g8h/?=
 =?us-ascii?Q?P84D/MdOXE28RmR7lIQMdnXHCHEUBZsfqLMC6e0R6C8NP39rUQJvNi5jlw7X?=
 =?us-ascii?Q?GXVTXG3DzHXvHUia9uhU9iOFYzB+azP86YGv+X5atKg/wunugdAVvRHbrtOE?=
 =?us-ascii?Q?4rEIpXrF6ESyKcRWQ8eJ4ySu7MUni08n038IPilFcJIu1GdTdOglV8ujOEK9?=
 =?us-ascii?Q?F4QIeX5zmj1RhVpW3fng3skuXRbyF1vWjHONUA92UVRMJx1qW97HxW4PjGfR?=
 =?us-ascii?Q?o1hnLiD++UQRQG/1RfV8Hj5ObhXdD/s5frBG0pY/lmoWJjjjBBiVfPk1nHWu?=
 =?us-ascii?Q?9oEBBDxW2K89njrzG38WxYXNfKXA/bsiSd0bcH3IGNBuG4zBRgOwYbXSM+fc?=
 =?us-ascii?Q?um3DAasQXkliX3jkpbZJfUwyQ+TFsDY9SSJEXXN+rFQ8KKgyCCn8lVbfNJnm?=
 =?us-ascii?Q?700T+KFGRNxn2WyaYZbDxIpc4qmDQcevN6mqn/U9R9iriZtC9zMzotih67CF?=
 =?us-ascii?Q?mu96ZnT7qNoRXGxIDtQpoxUnaUSglVMFIYpM9+D7LYSYb3CN36jhAKjQ4T8Y?=
 =?us-ascii?Q?ZJcBTGejrRevF3EgIW0nh/YM8q+VZ9iQup+UfxVMGV12SzNOjuOqG54ho+ME?=
 =?us-ascii?Q?2xQqu28OBgztcgipUX1OguHEpvBzWXxIstP+jDDt7a448d/p9pA8daZGtqR5?=
 =?us-ascii?Q?xZc13ine0k2bk37sDS+PYbpCeECuTn2YbBLwT4OyFXlqF6VzpAYyRDHXNbTd?=
 =?us-ascii?Q?m6kHLtohH5StM/zWSLXgOkow78FxlB8y16/p0mVM5UXz1TRY2pOEFFELbqCT?=
 =?us-ascii?Q?uMeCCWR7r8ujMSbBLNzgSZ0KoonNrQzpBNw+jZmLCRsu9IRRtsFtreHy0S+z?=
 =?us-ascii?Q?iR5HBBDdzvjToEskWvP5QwAMzFReZpGwTdZceY0veAN3+KxiJF3+Uo5RBHiH?=
 =?us-ascii?Q?vmubJn8lHczcNmKSK60JyQjzOoyx6j1jZ2Z2rVWC+VVFE9DcVqIlqQoxbVNe?=
 =?us-ascii?Q?ChApAM8H3Zh7zp8ibpOSZZBts0YKhJ9mS4QitT17w9zlL5jGxwJdJ4X851lP?=
 =?us-ascii?Q?n02UtMTiVNyu8KyuJumztC5he/jSN4WRhBnBGVaV/WzidNHw6mV3BU87zI0A?=
 =?us-ascii?Q?YSPBioGiUGSGZzSwIK+R0bIv7sdIzoueCpQRGpcpHKPHOmPe9UjEPOqNNS+q?=
 =?us-ascii?Q?Y+ZFwBXqtKbt59n/NXlBAByY7PjANm2B8X67LnNBLczqtgetKCRQXlO/N519?=
 =?us-ascii?Q?6qVYbF9ctgFa4pGRLDul8pVH0nrYTefYW2dYE7ka3C3Y0vbgJIjHsVPmyUG2?=
 =?us-ascii?Q?FrXokEd8cOy+LaCDXqPxgC3cXFTn+EGlqz5KYNij02btO3IctQH5l1EFcUe8?=
 =?us-ascii?Q?hOJvL4vJ5M7aB3HfO9g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c4f53c-9955-4187-5205-08dc737d4e6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 18:48:40.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brwgZfFkk7Zmj00BcP0cD01aS30+7nOOT07tcq2tvmvhyExLlKPjXskxclHEvKcD1TvrALpiwW1QqjZm4zHbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977

On Mon, May 13, 2024 at 04:18:00PM +0000, Joshua Yeong wrote:
> Frank Li wrote:
> > On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> > > Joshua Yeong wrote:
> > > >
> > > > Introduce a new target core layer in order to support target
> > > > functions in linux kernel. This comprises the controller library and function
> > library.
> > > > Controller library implements functions specific to an target
> > > > controller and function library implements functions specific to an target
> > function.
> > > >
> > > > Introduce a new configfs entry to configure the target function
> > > > configuring and bind the target function with target controller.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >
> > > > Notes:
> > > >     Change from v8 to v9
> > > >     -none
> > > >
> > > >     Change from v7 to v8
> > > >     Added missed head files
> > > >
> > > >     Change from v5 to v6
> > > >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > >     | Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > > > lkp@intel.com/
> > > >
> > > >     Chagne from v4 to v5
> > > >     - add include <linux/slab.h> to fix build error
> > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > >     | Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > lkp@intel.com/
> > > >
> > > >     Chagne from v4 to v8
> > > >     - add include <linux/slab.h> to fix build error
> > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > >     | Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > lkp@intel.com/
> > > >
> > > >  drivers/i3c/Kconfig        |  28 +-
> > > >  drivers/i3c/Makefile       |   2 +
> > > >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> > > >  drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
> > > >  include/linux/i3c/target.h | 548
> > > > +++++++++++++++++++++++++++++++++++++
> > > >
> > > > ...
> > > >
> > > > diff --git a/include/linux/i3c/target.h b/include/linux/i3c/target.h
> > > > new file mode 100644 index 0000000000000..b0bf06685834c
> > > > --- /dev/null
> > > > +++ b/include/linux/i3c/target.h
> > > >
> > > > ...
> > > >
> > > > +/**
> > > > + * struct i3c_target_ctrl_ops - set of function pointers for
> > > > +performing controller operations
> > > > + * @set_config: set I3C controller configuration
> > > > + * @enable: enable I3C controller
> > > > + * @disable: disable I3C controller
> > > > + * @raise_ibi: raise IBI interrupt to master
> > > > + * @alloc_request: allocate a i3c_request, optional, default use
> > > > +kmalloc
> > > > + * @free_request: free a i3c_request, default use kfree
> > > > + * @queue: queue an I3C transfer
> > > > + * @dequeue: dequeue an I3C transfer
> > > > + * @cancel_all_reqs: call all pending requests
> > > > + * @fifo_status: current FIFO status
> > > > + * @fifo_flush: flush hardware FIFO
> > > > + * @hotjoin: raise hotjoin request to master
> > > > + * @set_status_format1: set i3c status format1
> > > > + * @get_status_format1: get i3c status format1
> > > > + * @get_addr: get i3c dynmatic address
> > > > + * @get_features: ops to get the features supported by the I3C
> > > > +target controller
> > > > + * @owner: the module owner containing the ops  */ struct
> > > > +i3c_target_ctrl_ops {
> > > > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct
> > > > +i3c_target_func
> > > > *func);
> > > > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > > > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > > > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8 size);
> > > > +
> > > > +	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl *ctrl,
> > > > +gfp_t
> > > > gfp_flags);
> > > > +	void (*free_request)(struct i3c_request *req);
> > > > +
> > > > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > > > +	int (*dequeue)(struct i3c_request *req);
> > > > +
> > > > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > +
> > > > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > > > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16 status);
> > > > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > > > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > > > +	const struct i3c_target_ctrl_features *(*get_features)(struct
> > > > i3c_target_ctrl *ctrl);
> > > > +	struct module *owner;
> > > > +};
> > >
> > > This structure looks very different from the master controller ops
> > 'i3c_master_controller_ops'.
> > > I think you could probably combine 'set_config, enable' into 'bus_init',
> > 'disable' to 'bus_cleanup'.
> > > Also using the 'struct i3c_priv_xfer' rather redefining another 'struct
> > i3c_request' would be much cleaner.
> > 
> > Thanks, let me think this. i3c_priv_xter may include read and write, or write
> > and read. I3C is quite fast. Most time software are not quite enough to handle
> > it in time.
> > 
> > If data len bigger than FIFO size, it have to use DMA to transfer it because
> > there are not flow controler at target side (write direction).
> > Read, hardware to use early terminate to tell host read too fast. but for write,
> > 9th bit is parit check bit. Data will be lost if software have not read from FIFO
> > in time. If use external DMA to do that, it needs switch dma channel(generally,
> > DMA rx and tx are two channel). switch channel automatically are quite
> > challenge at current dma engine framework.
> > 
> 
> I guess when data is larger than FIFO, the i3c controller (master) should 
> 'aware' of this limitation when using such target device. So that appropriate
> handle like make new read command, or do a write then another larger read
> request. 

Between two commands, such as two write command, some data may lost because
first one have not chance to fetch it from FIFO.

Function driver can add some recovery mathod. But still better to use modem
async method to queue multi transfer and handle by dma automatically. One
transfer each time are just special case for queue.

If DMA support,  queue can work as big cycle buffer, underrun will never
happen unless system wrong, such as disable irq over 1 second. 

Actually, I worry about still i3c_priv_xfer, write followed read case.
Most likely, host driver do like

	write (cmd index/reg index) then read value or command result.

It is hard to decode cmd and send back data immedicately.

if there are not special DMA support,  more realistic usage mode is

cmd1, cmd2, cmd3,....

send back
	resp1, resp2, ....

instead of comebine cmd1 and resp1 at one transfer.

Host can do that just because all SCL are controller by host controllers.

> 
> > Of course it will be possible if hardware implement simpilar I3C HCI command
> > queue. But I still not found any hardware that can do that yet.
> > 
> > If only limited data size to FIFO size, there are still limiation for xfer.  if write,
> > read, write, read, two write may combined in one FIFO, target driver may not
> > split it which depend on hardware detect repeat start and insert something
> > into fifo.
> > 
> > It is hard to support all user case by I3C target software in linux.
> 
> Can I know the speed limitation that you having issue while running on silicon? 

I am not sure what "speed limitation" here? Do you means irq latency issue.

when I get "stop", there are new data already come into FIFO.  It is not
for problem for tty case now. 

But if it is well defined frame data, it may be problem.

I saw some data lost when target are busy without DMA support. driver can
query how many fifo space avaible before send data, but it reduced bus
utilities rate.

> 
> > 
> > write follow by read, generally used from get hardware register value from
> > target side, which almost impossible by software, it is not quick enough to
> > parse (write value) then send back data.
> > 
> > >
> > > In the master i3c side they don't abbreviate i3c_master_controller to
> > > i3c_master_ctrl. I think we should do the same here to standardize it.
> > > Thanks
> > 
> > The problem is in I3C spec: "master" already depericated
> > 
> > from i3c spec 1.1.1
> > 
> > "Controller: An I3C Device that is capable of controlling the I3C Bus."
> > 
> > master/slave => controller/target.
> > 
> > It will become more confused if i3c_target_controller. "controller"
> > are ambiguity.
> > 
> > If "master" => "host" would be better situation, but not happen. A point, I use
> > "ctrl"  here to avoid I3C spec defined "controller" term.
> > 
> > Anyway, I hope more people that involve target support discussion.
> > 
> > >
> > > Regards,
> > > Joshua
> > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > > > --
> > > > linux-i3c mailing list
> > > > linux-i3c@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-i3c
