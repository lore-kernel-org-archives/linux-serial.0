Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296381448F2;
	Tue, 14 May 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703083; cv=fail; b=shSlT5mcoM3IXlNrKrPGv5dk4ElXZ2ZoqhFdV8h+aU6Q6j7fJoptvzabkmtjQnRMhmu7i1gEYkJEPiEYW3WvQFDAr2H7JdVJdlRkTEEgPgIISJhqRJNoeIT0/Ty87KwYE+Mg7pWMYke1CQZ3izNcd+D0ClZOMUWSmYFxtVX2pjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703083; c=relaxed/simple;
	bh=7IUotb7dRMjcwneF4XXCyPePo4bDxBd+TbG2a6E6CZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aa5MLNHPRlco0Ip0JhARFrxJC9iCI7BeM9HwKb5kzkBo+bnWrtzgjG5Ieva0RomBUjrs46QErAPRa0RZOO4nTjF+tldwJJOE0W8YTJ+XZ0gM8tOPbO2zLVsOW8XGc1Iei4RU/GocNgdYz2rjaaltFvk8qYeG2C4SVgTKTXZPlf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SeSkTYVr; arc=fail smtp.client-ip=40.107.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SeSkTYVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTYQnWGxk7fsK/0nHYaPsuSD5GkTzwcLcUXUMqEhXI0pz6z6CcqxddM8hRcj/xjbzxt4VxaVuMRiOIAPFNU9dZVpPY0uLHJRoOko6jVrqESkYLJRZG2yNNfMHndtaD1eE//t06z7/WQrJJOld+tbr97RtfW88kDEplJcUifCw/2OjOQR2Kgk6Ibd4NVpbryr+UM1vHsMdOdVX6yOpZfOyLEH51SimkSNxHLKt+kAVuEkJOaBQ01C2jksM6LAs9+QcSKQze3zyuofZ09+IQc3hPNm8jT67sjwO1FvF9jCy7t7brnNRtfkQHBlBFrb7HJXp8hAZlPYw/3XE6u6UmIwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFCdYRSaZ7CHthTz497muRRr/63qBRcHhOCR9Ipqoz4=;
 b=Jm45uH+pqzYV4s2+v95Ov9CcGwhPJlxcUQuyIjaKXeeOqxrf7eX8Zi4mafnanSMak7p4pFlGVAgY1/LzJX26ARbYtYypRWugyFZB5utGI8NQX3+FIr1PyhKdIHl5gjGBzpdJKWgb9xIPWqQGsHSx0iQ5YLXoZ8Zh72JKhMoXjLmHUSXVQcrXJHbvUXhpG2jWLjE9w4ECFSlsHYIaGHQc1CK7Hnz0AzJzUzJNKzvXnmaYJ5LTJwXPVgv5Y8HbADBrXrlRygyZDduSETx6z0TAhQZcgefBaQNWQdwMEsQDu73EuBQiXw2VqPeh8rX3PvcaQn6zM6gcUypIZnUT/gy4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFCdYRSaZ7CHthTz497muRRr/63qBRcHhOCR9Ipqoz4=;
 b=SeSkTYVrhiZvYZSn3FLefC41Mtw2pmyqY4vZaHxNtLzIyA9eygmniQ8fen9FxHSBdLDNkrh6pttiHo/icaAMz1IHBAO/Oneg/Ma1P84bAaDnOuq6Q82w/i7qOf+HtVyIMuEovQy2K12tfiHrWzeZ75hNaH4BfaeTqoua4IhptTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB11064.eurprd04.prod.outlook.com (2603:10a6:150:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22; Tue, 14 May
 2024 16:11:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 16:11:14 +0000
Date: Tue, 14 May 2024 12:11:05 -0400
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
Message-ID: <ZkONGQPBeuR6oZ0Q@lizhi-Precision-Tower-5810>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
 <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkJgf/oRMMBswih1@lizhi-Precision-Tower-5810>
 <SH0PR01MB084183D40B4ECC0C4B3A9BF0F9E32@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB084183D40B4ECC0C4B3A9BF0F9E32@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB11064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5851d6ca-fd41-4f48-aa27-08dc74307ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|7416005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGocreDMOXxu430td5z92c0udjSUZx5vkC5x8c0Zo1aaNnBnqIhLzeBLIU4m?=
 =?us-ascii?Q?mkQJ6q0PYK639YxPTTQS3RBXVKtOIhs/RLAhmdmclMeMKwg+d9SEXxhCQAiO?=
 =?us-ascii?Q?Jz2BFxqCF508/AtdujWk4f6HeXHBxtWxDTAqwnBwzHePZFKGcDGbL6Mh0CW+?=
 =?us-ascii?Q?rA7VmcjcQkiiaEjmVgrPCI0rQGTlO5JBynFPh6v1F6mm/IjmHVHEbUrAb3kP?=
 =?us-ascii?Q?UShD+ujtdixWvEWY5ZkUqfJUdbbxLfGkgjrI8yPnfdJQWqIvLmdpTvRNLni+?=
 =?us-ascii?Q?iLGnrwRsg4AIt5c4ixNOpjQnffjEFUICYmowKWRXrVXOLeRzSoBBCWykmUKf?=
 =?us-ascii?Q?SFiCd0B4SY9pia7uugPPSv9NLH0Pv9Wg2Y63PE/6O0nqMZxL/Hw5NXxB0q0y?=
 =?us-ascii?Q?WNW+bg/j1Gm+gWaO2ixr04O3LdaxoE4Xn1H1kz1MjvlvBEPir3C1fiHaiW4c?=
 =?us-ascii?Q?GYBtNEMyO/zkfYxGhdzotO21zJx6nnD4prT+9HEP3T66UD/8HkwdrNZ3J8fz?=
 =?us-ascii?Q?NubHA1kkYAUi0LeRywLTH33eIq3yn5/27JN8Cyeahe11YDNea04MFYH1i956?=
 =?us-ascii?Q?L5QCHtoUdA6kzMt3jFoxSYlfnAU1QfkwXueg2iJNrG1kFEi0suQdfJV9WoAj?=
 =?us-ascii?Q?w2kZqyIA0qsR4ZiFJrWcPs3ZhbGYBUVKPOW4hXsBryYKVwm9zm+2nQrVg0IV?=
 =?us-ascii?Q?dKNZgoGQjtdPLudxC4gxXQ01gpRhpXy2pv1cqno7dFKi1MdPsByB08pgmneX?=
 =?us-ascii?Q?YEjF7qghJWtfbqLGyf80+nXsaK8KhFtpDqsb3W3M5gjvcDfRfBOWKZdJntg9?=
 =?us-ascii?Q?iLn1LeE20fBDS+Bt6DL0ViIme29jU010IYXtBClwLGw+erG9HkayR714Hbf6?=
 =?us-ascii?Q?kI47UodnX3EVn9BBXa6nZ01yVWrwdbEauSX4eu1/0DwSVadthBJ0NpwYABUH?=
 =?us-ascii?Q?CBZqcat1yxsXhau5PscEJXdOcPGgqnUtnNW1OvepTP2y4frC7RhhQjEn/7Ul?=
 =?us-ascii?Q?Zlw6mCY2Ke66I+Otp0hLNOoTILDGqakLaVfB9cnJS7qHzgJO/P2dZFCu4uKj?=
 =?us-ascii?Q?oW7snMeoyd0ECjcEqFCnAdXMMLisRxWa2Djd7Xn7QpF8OPoCyCQ/M4TIL16p?=
 =?us-ascii?Q?ZQykNAWNUuQSCXDZNdyFNNUrphmN4aIl/mALbc7w2RgkvC4ektad5z52FVyV?=
 =?us-ascii?Q?oNR9Hvtv/UymFdCcsv/m1+3vj1tA/3veyLTtFsAl8+IOLyJeiJOQ2x+nuRJS?=
 =?us-ascii?Q?hnfSclExCYZj0r+B8t0cSijGfIAVxsWQB/5lo8+pbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPgRHmWUVBGplQKJCrq6yb/CTXYrHxdJXfjr6iJ7q28odOLNo6ge7GcrFfCO?=
 =?us-ascii?Q?iHgoQ/AId2X0fHP0FWFMg84t78z7xUZRNtfixksoS+qanvNFLMIqMbOxZaAQ?=
 =?us-ascii?Q?uvd01FZU5Drg9ZTuOzFCBC3ehfsB9NVBYRV0LT0gXBx0RY9HfZSoUIZrCr4f?=
 =?us-ascii?Q?oJbQq7vHkFHJJnUG6iLY2oDoXq/QpofSJjVkbkdTkbSd1MW//7UqGVMfH1yq?=
 =?us-ascii?Q?3SsJW1xla4wZ05zzcL7id6+9yOMcbmCfeSVHNEAhRsd4r8dfDxk7nRPMT4Gy?=
 =?us-ascii?Q?g0MW+gYPH5joWQg9u4k7mljx+hLFOR/W/TiQaZSNSQ5Je5alKIEL1EMlLkNu?=
 =?us-ascii?Q?6b9Tg+Mbs4txKKeNgHT6vpYk1iYzPG/Z2+mvZk0/jnC5DZXA18HVSAHpoVJy?=
 =?us-ascii?Q?UUVbJA/4o/UywRBSUxChGIHFeAtNox5DH+Vn25KVuz7KXV/n4Ta3ukA6RPJk?=
 =?us-ascii?Q?Nt81Eq/EYVObjoCr+Nwxe/zWzM52Zh5iYOvDP3F1OV9Q5FCEbMrheCEfd4ly?=
 =?us-ascii?Q?9hwd+uHZbHUCQ8k8OAsNna+wSbVdVBPjpxVIqM00y9PoJvlb7ulDrsAP/A7D?=
 =?us-ascii?Q?S0cB3Ud5EDj3/MxA5IZP3Jsn8tDsBZbYc5aq13gJcQLVlYBO9XTVEfnjrIhk?=
 =?us-ascii?Q?xuDM5QUc+mG8MrtDk9Fbnowr7re47OgaqA0MTgia+/lE8L3e0oj+YB9vZTN0?=
 =?us-ascii?Q?dDTkN+X8EvITz+HlvaNMrlDdsHvXv6g/xoee3Y9AKRqpmVkX4nDNNgJAv8cc?=
 =?us-ascii?Q?Zmg9Bb4kT6ICUyUPN+x3CNRE5TS4y3Cqa51u3gPDGe8Qkyj/1mt5utTUJu/n?=
 =?us-ascii?Q?hwEDTgj5Y8/6RjZ8jquQ/H4QFWopZQ2U+HcJL1G9oSNCp/r53sYzX1fNXUOX?=
 =?us-ascii?Q?ca3vzFGmLo3nqs7cD9mso9rAttcRnk1jEUXezEMSFdhbdFOdzdMEv++miswL?=
 =?us-ascii?Q?eoEI7LXpjuW8a09IL9yy6iN7+YOq7m1iTTR/7vTOC5Lld62U3pwY8cChGmGQ?=
 =?us-ascii?Q?AdDwi+qkJ1QL7GELCv6IbLB0a0NiZDA6zGdbW2v6jTxqGsmZ082WOkuAa2hB?=
 =?us-ascii?Q?8wPGQFmyPIhMblUBXDkrHRNmRyf3p5MaET65kagWS1/ueJxDFhYenkA0QYCY?=
 =?us-ascii?Q?mUkc/rpY3XTiSnQ891ufjnPMypsRuV9YYhyFpdKI1mi6k1OsILASKt/dNjYN?=
 =?us-ascii?Q?kxGW/fXjEmRkwrab3gXnoDCDgirmZ4FzcF3PUisXZ2rgAWgOjA8pA1nCIut5?=
 =?us-ascii?Q?jywelpS4Vo+k+sj1CVmPNbc8rx8n7mqTK8l9bAMEyFt6gYRcSGWxw0bte1/E?=
 =?us-ascii?Q?kdpjRhl4Lmd83ibP0k9xnFDMUD76I0mUrCKvx0O/xqhUJnXUT3LW6aazsQbV?=
 =?us-ascii?Q?DoQwKbSnxYlY3kXpuY39dw8AMag4RY078DdrRK2sITOH+CTmvV5jRbXeBHk+?=
 =?us-ascii?Q?ISA8XphlQy8zm3XvJl+4zaUeZahBBQ8TpxjVh3lL4fuvameriXNAtcvqgoIh?=
 =?us-ascii?Q?uAoot6yg8VtXpkcmDjzpkm9JJDAqLRQplTcDmYaOUfwmvt/4pxq2u0C0+cDU?=
 =?us-ascii?Q?ETTZ5ZrF34jwnSdRlzWIqiujZLMqq0lzYHdJvnpa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5851d6ca-fd41-4f48-aa27-08dc74307ad6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:11:14.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Osnbo/LECo9PVgloVnU11CLlsOliMmHZQ5OHGwsmdIkmrO7ODTb7UJCku0yDmeb/7jgOBieT+0k03/LS0oG5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11064

On Tue, May 14, 2024 at 03:07:25AM +0000, Joshua Yeong wrote:
> Frank Li wrote:
> > 
> > On Mon, May 13, 2024 at 04:18:00PM +0000, Joshua Yeong wrote:
> > > Frank Li wrote:
> > > > On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> > > > > Joshua Yeong wrote:
> > > > > >
> > > > > > Introduce a new target core layer in order to support target
> > > > > > functions in linux kernel. This comprises the controller library
> > > > > > and function
> > > > library.
> > > > > > Controller library implements functions specific to an target
> > > > > > controller and function library implements functions specific to
> > > > > > an target
> > > > function.
> > > > > >
> > > > > > Introduce a new configfs entry to configure the target function
> > > > > > configuring and bind the target function with target controller.
> > > > > >
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > Notes:
> > > > > >     Change from v8 to v9
> > > > > >     -none
> > > > > >
> > > > > >     Change from v7 to v8
> > > > > >     Added missed head files
> > > > > >
> > > > > >     Change from v5 to v6
> > > > > >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > >     | Closes:
> > > > > > https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > > > > > lkp@intel.com/
> > > > > >
> > > > > >     Chagne from v4 to v5
> > > > > >     - add include <linux/slab.h> to fix build error
> > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > >     | Closes:
> > > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > > lkp@intel.com/
> > > > > >
> > > > > >     Chagne from v4 to v8
> > > > > >     - add include <linux/slab.h> to fix build error
> > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > >     | Closes:
> > > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > > lkp@intel.com/
> > > > > >
> > > > > >  drivers/i3c/Kconfig        |  28 +-
> > > > > >  drivers/i3c/Makefile       |   2 +
> > > > > >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> > > > > >  drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
> > > > > >  include/linux/i3c/target.h | 548
> > > > > > +++++++++++++++++++++++++++++++++++++
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > diff --git a/include/linux/i3c/target.h
> > > > > > b/include/linux/i3c/target.h new file mode 100644 index
> > > > > > 0000000000000..b0bf06685834c
> > > > > > --- /dev/null
> > > > > > +++ b/include/linux/i3c/target.h
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > +/**
> > > > > > + * struct i3c_target_ctrl_ops - set of function pointers for
> > > > > > +performing controller operations
> > > > > > + * @set_config: set I3C controller configuration
> > > > > > + * @enable: enable I3C controller
> > > > > > + * @disable: disable I3C controller
> > > > > > + * @raise_ibi: raise IBI interrupt to master
> > > > > > + * @alloc_request: allocate a i3c_request, optional, default
> > > > > > +use kmalloc
> > > > > > + * @free_request: free a i3c_request, default use kfree
> > > > > > + * @queue: queue an I3C transfer
> > > > > > + * @dequeue: dequeue an I3C transfer
> > > > > > + * @cancel_all_reqs: call all pending requests
> > > > > > + * @fifo_status: current FIFO status
> > > > > > + * @fifo_flush: flush hardware FIFO
> > > > > > + * @hotjoin: raise hotjoin request to master
> > > > > > + * @set_status_format1: set i3c status format1
> > > > > > + * @get_status_format1: get i3c status format1
> > > > > > + * @get_addr: get i3c dynmatic address
> > > > > > + * @get_features: ops to get the features supported by the I3C
> > > > > > +target controller
> > > > > > + * @owner: the module owner containing the ops  */ struct
> > > > > > +i3c_target_ctrl_ops {
> > > > > > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct
> > > > > > +i3c_target_func
> > > > > > *func);
> > > > > > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > > > > > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > > > > > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8
> > > > > > +size);
> > > > > > +
> > > > > > +	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl
> > > > > > +*ctrl, gfp_t
> > > > > > gfp_flags);
> > > > > > +	void (*free_request)(struct i3c_request *req);
> > > > > > +
> > > > > > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > > > > > +	int (*dequeue)(struct i3c_request *req);
> > > > > > +
> > > > > > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool
> > > > > > +tx);
> > > > > > +
> > > > > > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > > > > > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16
> > status);
> > > > > > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > > > > > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > > > > > +	const struct i3c_target_ctrl_features *(*get_features)(struct
> > > > > > i3c_target_ctrl *ctrl);
> > > > > > +	struct module *owner;
> > > > > > +};
> > > > >
> > > > > This structure looks very different from the master controller ops
> > > > 'i3c_master_controller_ops'.
> > > > > I think you could probably combine 'set_config, enable' into
> > > > > 'bus_init',
> > > > 'disable' to 'bus_cleanup'.
> > > > > Also using the 'struct i3c_priv_xfer' rather redefining another
> > > > > 'struct
> > > > i3c_request' would be much cleaner.
> > > >
> > > > Thanks, let me think this. i3c_priv_xter may include read and write,
> > > > or write and read. I3C is quite fast. Most time software are not
> > > > quite enough to handle it in time.
> > > >
> > > > If data len bigger than FIFO size, it have to use DMA to transfer it
> > > > because there are not flow controler at target side (write direction).
> > > > Read, hardware to use early terminate to tell host read too fast.
> > > > but for write, 9th bit is parit check bit. Data will be lost if
> > > > software have not read from FIFO in time. If use external DMA to do
> > > > that, it needs switch dma channel(generally, DMA rx and tx are two
> > > > channel). switch channel automatically are quite challenge at current dma
> > engine framework.
> > > >
> > >
> > > I guess when data is larger than FIFO, the i3c controller (master)
> > > should 'aware' of this limitation when using such target device. So
> > > that appropriate handle like make new read command, or do a write then
> > > another larger read request.
> > 
> > Between two commands, such as two write command, some data may lost
> > because first one have not chance to fetch it from FIFO.
> > 
> > Function driver can add some recovery mathod. But still better to use modem
> > async method to queue multi transfer and handle by dma automatically. One
> > transfer each time are just special case for queue.
> > 
> > If DMA support,  queue can work as big cycle buffer, underrun will never
> > happen unless system wrong, such as disable irq over 1 second.
> > 
> > Actually, I worry about still i3c_priv_xfer, write followed read case.
> > Most likely, host driver do like
> > 
> > 	write (cmd index/reg index) then read value or command result.
> > 
> > It is hard to decode cmd and send back data immedicately.
> > 
> > if there are not special DMA support,  more realistic usage mode is
> > 
> > cmd1, cmd2, cmd3,....
> > 
> > send back
> > 	resp1, resp2, ....
> > 
> > instead of comebine cmd1 and resp1 at one transfer.
> > 
> > Host can do that just because all SCL are controller by host controllers.
> 
> The DMA queue mechanism should still be invisible to the framework. Target
> could use info from SETMRL/SETMWL to 'prepare' whether internally DMA 
> is needed.

You are right. DMA should be invisiable to the framework, but framework
need provide API to prepare receiver buffer advance before transfer happen.
Only function driver know how much data need be prepared advance. For host
read/target write case, It also need cancel request function incase host
have not fetch data in certain time. Data need be updated. function driver
can't simple update data buffer, because it may already map to DMA. 
function driver need dequeue and queue request again.

framework should abstract common part of difference i3c target controller
and target function driver to avoid duplicate code.

And also need consider linux's irq latency limiation, try to make the
function driver can work on all target controller drivers.

I think priv_xfer, W, R, ...  are hard to implement. Maybe limit priv_xfer
's len to 1 or 2. But if limited to 1, it becames no big difference with
current implement.

> 
> We can also argue that the max read length should always not larger than 
> the FIFO size. Slave data transfer interface should still match what i3c
> spec expect to be, rather than the hardware limitation here.
> 

According to spec:
 	5.1.9.3.5 Maximum write length in a single command

I am not resure "singe command here". I think it should be between
"start" and "repeat start/stop". 

If my understand is correct,  host still send out W R W R ... as whole
I3C transaction, each one less than FIFO size. but totally size may exceed
FIFO size. 


> 
> > 
> > >
> > > > Of course it will be possible if hardware implement simpilar I3C HCI
> > > > command queue. But I still not found any hardware that can do that yet.
> > > >
> > > > If only limited data size to FIFO size, there are still limiation
> > > > for xfer.  if write, read, write, read, two write may combined in
> > > > one FIFO, target driver may not split it which depend on hardware
> > > > detect repeat start and insert something into fifo.
> > > >
> > > > It is hard to support all user case by I3C target software in linux.
> > >
> > > Can I know the speed limitation that you having issue while running on
> > silicon?
> > 
> > I am not sure what "speed limitation" here? Do you means irq latency issue.
> > 
> > when I get "stop", there are new data already come into FIFO.  It is not for
> > problem for tty case now.
> > 
> > But if it is well defined frame data, it may be problem.
> > 
> > I saw some data lost when target are busy without DMA support. driver can
> > query how many fifo space avaible before send data, but it reduced bus
> > utilities rate.
> > 
> > >
> > > >
> > > > write follow by read, generally used from get hardware register
> > > > value from target side, which almost impossible by software, it is
> > > > not quick enough to parse (write value) then send back data.
> > > >
> > > > >
> > > > > In the master i3c side they don't abbreviate i3c_master_controller
> > > > > to i3c_master_ctrl. I think we should do the same here to standardize it.
> > > > > Thanks
> > > >
> > > > The problem is in I3C spec: "master" already depericated
> > > >
> > > > from i3c spec 1.1.1
> > > >
> > > > "Controller: An I3C Device that is capable of controlling the I3C Bus."
> > > >
> > > > master/slave => controller/target.
> > > >
> > > > It will become more confused if i3c_target_controller. "controller"
> > > > are ambiguity.
> > > >
> > > > If "master" => "host" would be better situation, but not happen. A
> > > > point, I use "ctrl"  here to avoid I3C spec defined "controller" term.
> > > >
> > > > Anyway, I hope more people that involve target support discussion.
> > > >
> > > > >
> > > > > Regards,
> > > > > Joshua
> > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > > >
> > > > > > --
> > > > > > linux-i3c mailing list
> > > > > > linux-i3c@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c
