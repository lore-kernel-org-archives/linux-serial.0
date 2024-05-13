Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A91552E8;
	Mon, 13 May 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615785; cv=fail; b=R7aHx1tlBYBSZlvDiW0RVuzO4RFd2yZ6kqf4KRAsrS4a76yGTt/rhW+K/4FTEVwxWbfPZBZHZKBUuJ1yWJx+5pzClBG/qb+MD6Tc975Pk7q9/RE1bNBUpOda3ELQemsxxXPanWB4ngh+AB9vZEEsH2HXRsvKCW/TKP/ijOT6cO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615785; c=relaxed/simple;
	bh=RQgnGaes2D0/qeCcZcyNXsqTrr3h6KYtO/cn6Nc7w9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ckQm/llXsep4sumPktVZuhu/uRLsTeRBNXbYu8/iV7hiuC64Og1wr0Q2WQtAhBiftp9znUi3daCouOg2NI6axXsvFbYrf/rHyEE/UZ+qVHFhrZ8f3PN+vcyFcsLl5AEZjuZE6iYzesWYSVb1uhu/h8+7qnwz1y9DOG1T9bwN6b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AgTn5Dgq; arc=fail smtp.client-ip=40.107.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AgTn5Dgq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQX/jqT3a47s2PM07xrvAlO+YxJkCzocfDprKhIKa77moxd36COIsAcab2VD8CwpjcMAJWzyRDem+kktDNApHm7vxmm2nML52cF6xSgrok7J4HVvuaX0x+HzgDZ3ThDR699TKAVs8XTc0MPkrjMWPZ/isCmjSV3TIzfmUHvKBG03dIsJBB6u+iepcQj0Z1Kz/YThlmeuRgGo8SBgW+b5bWRRz8653+kqCn3kGKicj6LsK+WqqZwyZGLo4qniUVIelf1KbBde3BHEMRaw3o3w7+7jJOZsGzMDn5fS90AE4MBCPKca0Q3r75RtKIry+eTwPrznGLWLUAd15AhzuO/Kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69q0+TJA8q9YRpl4M/gqNBFAn5Q+wYV+vHHMyvEXwMk=;
 b=Jx7BzbGqM7Bs9vv1wkBBPDnBDfNICD22uh2xGYtiJsDDSX50nYBfStJfwZV42WOIeKDirM9OSRaMRpOLuzRoIm3FKuWjmj5eyhq1IoUsF3ueCkud3K8+FGvGwFG6sdc6ZM3xTq3ev58hUWltujEjWJO9ti8ikYSvT9e4oWvNLvLD6SuvdEf5cTEVciHvjDrApCp8EEi3usMTGS4IBsu6DGOO3ROQ1wjhVkz0LAjt1lYvXim44WTTCFe7mgaSwbMOrvnn3CB4Bo/74XDv2dKKi9Qz9E6c53JEdBpZ6WXV9xuddYsLuCd6MiT5+kYEw+sy4IBfsMKHa2GdkqlkSHLspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69q0+TJA8q9YRpl4M/gqNBFAn5Q+wYV+vHHMyvEXwMk=;
 b=AgTn5Dgq8FjncMR7S87Ayu6oCH8ZYcAt8xFlbZ2E7s4sN6xdSs1VYqWnPBnTthMLhJC9XjiHyOgQ+bazwkPtmVBVJmGNNVNgq6hrIWEZeQwmG3U6C+cfMDDOlmZuGs5Yopccz/BL4stNGZukJtURhCT5atHB2TXzNNztrPWGn/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 15:56:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 15:56:19 +0000
Date: Mon, 13 May 2024 11:56:08 -0400
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
Message-ID: <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba5edc5-32ad-4cad-f625-08dc73653af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcrfT/wPcI0zBGlXp3i4/JHjNtL6BiUc79lly04DMDxHm/2eDcCW9/KD2tZC?=
 =?us-ascii?Q?ayLcRr630jzB6XUfqIcU8qKuAT1+ewCUOCx9HTQnVdk03IByYRuWl8frMX/J?=
 =?us-ascii?Q?DHlYKOBTSdbAMTKaZkTY8TxSUDte4w7/MG+d20qAjlZ0LT3Zf7TCcpqcrXd8?=
 =?us-ascii?Q?CuSin8WK7FcWowEXKAPHc2l9bCf6wSTJqao7YHSy+g6bGhHzAadHHfj8faF9?=
 =?us-ascii?Q?rsss6tQIllWtTT2HxPb9N8KV0USwttHMjODc23asBpyWvmlB6yyUiQKo+IHk?=
 =?us-ascii?Q?MT3UpdLnRfm05Jcr/7nF5czK0Xyr5q8PmCbO19Kwxp/r1xymvZUbeZ9jwIrT?=
 =?us-ascii?Q?54DLm8VOliEykdy2XYA2C9EmT3oH+TWpcjCYBWr9j2f7jFwQlUyFxhss4qSx?=
 =?us-ascii?Q?fwtJkAT54u67mtZ2TYUxNmykV/tCERr5zEfPPd/ghihZLPodcgMywD0WHL19?=
 =?us-ascii?Q?Y/c36bmxfXaX1aJG19m+HdZnS+d/gBWaB1co9kIvp1bwc50USKqMMIPyMlJX?=
 =?us-ascii?Q?lM2ahClwfpkL1KYHQiwk8rV7lZDxPVKAJVCFCU/nAwGRzvRPfFP6n8ZuD128?=
 =?us-ascii?Q?BjdMQsEnXN1kVPzcRA7h3jtUhFQpC4PLUhbPFd1aobQSb1cuVZDchpaexAht?=
 =?us-ascii?Q?QTttqebDZ0TFpi0nvNEky6TCnGRLWul1cLrAJZyULLFb1ID0JATbonM2aaIa?=
 =?us-ascii?Q?rPvcq2IzqC/VGyZb/c1Dw3u6uk5x6kErYkubqQXLbMvJerAA6CkUzhQMajWe?=
 =?us-ascii?Q?QEqLDDD2cs7UQ3FZj9xv6VyArRDxgU/Yla0qfSM0b3AqFoHROjnTKJ5f1Hfc?=
 =?us-ascii?Q?oQMAwyiaxj5BFuk6Oz9I1AWWOE8wHMdeDu1kH0eF1oankcwNdLUDjlyb6Y+/?=
 =?us-ascii?Q?mj2AjKU3+lj476Co3pA4TkqGOJk/sL2wuvMwxi7EEU+/uiLuiv9qDUdT3F92?=
 =?us-ascii?Q?UvQTNtfyJFj7mTeux3uLIUhhajfmnxw39xiaf5JFfbhZVujbF/mqqKFOmL3Q?=
 =?us-ascii?Q?z2PumAlGwT6wdft3zRSI/ZVvyYGx35zH/3H0SCqjyfbGERj87eH8vwE3WoEM?=
 =?us-ascii?Q?VeAeUmZZYbbIWRes3OA6L896p81WKqIVi/jkVp3yWDYgyeygv4XFvBw6fn53?=
 =?us-ascii?Q?WIKk6gYTU9p0uEcFosanPhLAVZxR1euxWdjk/PFlE49ClYk+t5z8Lqarsxl8?=
 =?us-ascii?Q?urJZ9t/fcZREWeYtzLyz/lQlbHlwMI2/8OX8aTnEk142wMTW2FzoDVPZOCjY?=
 =?us-ascii?Q?HE8eKB7zNl1Ap+Y/0ZqxO+8npcmdwOEd4s2UyeIFwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrvVPbwNWeLbI160iWE0poZ5c2nwC9RXJImeBHMuciYqhQQneB3lBpAM88nQ?=
 =?us-ascii?Q?Q/a7WqkFnUGe5L/RC1KNCYDrqP1V399osnxjmVCLQmRi7b0Ls9SmbGW0u2Ug?=
 =?us-ascii?Q?OSbIH50xPKB+c7YKqCVCzvasDtGHDL2ITBmzc+B0HBxrTIaHazT7xSBmKpZm?=
 =?us-ascii?Q?B0zY21iKnKHUjpEmqDBdyA6bl81aot4jMwpD6hKXqXGkwU5ckn5M6/esyR6r?=
 =?us-ascii?Q?kP/I5O3pivIWtVI1WBkJ6dBJmz7HO460/3Cddzt/9+pzFInescLwFaC+7poA?=
 =?us-ascii?Q?yqjpbguLrsswxU3C7ROLFMH9w7cxRY7GBaXzRCTTol8CLKRPxv8XPk1u4TPh?=
 =?us-ascii?Q?F+ChdiI9g6QpOltG/Hnm8u2wxEw0/NBChfwrAwtuKUMfbgWcya0TOyxw3lAS?=
 =?us-ascii?Q?6/qo9Lc+lzsXPfo6Z+X3u+gTz0b7HDgOJLDeemLCoCAB9QLzBRJsEQ2PIWjf?=
 =?us-ascii?Q?Uzj7Pj3UOG+JhQKKGcy5R71ujPU/pFD2Pqlq07ykOl2QwIlrmpydN1HbwCkx?=
 =?us-ascii?Q?cYdytrL7uKNzvwxrTgrQtLW+P2G8jeV9LiPlDpSfnUY5Y1LiaSySONE3hgTJ?=
 =?us-ascii?Q?bNplOt9iopU8FhKHtKZyPl7xW11dNfgBDgLtLzaOM8ZNBCBvvdnor6T1j2QN?=
 =?us-ascii?Q?M6T5qm2gnE4pIpRMOzq3bCYoPbZp9kFJ0LcrjF8vg087E5OY5sDWtvLPMi5P?=
 =?us-ascii?Q?A168go8WGIHoWX2ZNqdjjnLpRMUKaBZJCCJZOTQMA98CRxAI0G+MjtW8kLuy?=
 =?us-ascii?Q?PAiLWs9TYNx5S1FEeraCxm7n1WPz/1TWw3fY5VMIH4ERywale5yUJYNuJxJK?=
 =?us-ascii?Q?B2j7tK/BtUvHz4G3UQ+ofS+dAjt9C1nMaa2BrYGesUzmmGG+lhqvOkeDh5MC?=
 =?us-ascii?Q?juu0s/u6X6o/HFxH8rma9eLiyBKym+nybYC9yQPTlmSiDpcSvcMGkvYGyHrp?=
 =?us-ascii?Q?36KXinCBZGzohYekO/HMeF3lmxZzYTxZYFk0+K9EIBKxRRwg9TM89bvKgFvD?=
 =?us-ascii?Q?nytsYXBozhYuj1cxokpbI3kpADSGKovn7UNJzNRG7Y16ia3zFiWQOP5xTwRA?=
 =?us-ascii?Q?U1E/+4d79QIGaTFeahPO/81EYuRRz3X4UW+jeykw72NGT1Rvzq9Ojbd9cYnA?=
 =?us-ascii?Q?qaLzFDGu0R7sQIQkDqoWL9ZKY/bpgmbAoAb0QyStNP+ODsITTXYcn5PsA223?=
 =?us-ascii?Q?WrihGzKXKMQYs5cKX4jBwHoByWSUBm05YRQKJB2VELMjn1EU/SJ4BK67RA1X?=
 =?us-ascii?Q?Lngxdhok+qiXQGfMQJcWrIlCqOqs5541wGuAzqBpmdYh/zvpqP0kWuM4wsZe?=
 =?us-ascii?Q?Ne+gNEU5tbUafRxQBOpTCamGnoxL9Gd3FcfAFhd1jyMKS5KIV95N0xC3WtPP?=
 =?us-ascii?Q?NFUFY6kM0YDkaMgm7UfPtf2h329Daq4qfR0UlXi1maC45qvqT/PltQZUSft+?=
 =?us-ascii?Q?8fVkYUitBCEfga7ZPzlEtgAxB5xz2zxkBi+JoURgUk/ulNgXH/hR8UvxpmSK?=
 =?us-ascii?Q?dqJgNpa0fyeOU+slztW2sqGHUl/Pg2KdRpu7liaWbzyt43Duuht1q7UIhsYu?=
 =?us-ascii?Q?uSwJiWFxYQhxv6F1fsw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba5edc5-32ad-4cad-f625-08dc73653af7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 15:56:19.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1R8BOXhtL/Hlmpn56AoY7ADxhvShADWJ86mdLY2bAB93HjUtXC/5wPnYRCkpU3363uUWb8GmjBwb8/vPSFLZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986

On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> Joshua Yeong wrote:
> > 
> > Introduce a new target core layer in order to support target functions in linux
> > kernel. This comprises the controller library and function library.
> > Controller library implements functions specific to an target controller and
> > function library implements functions specific to an target function.
> > 
> > Introduce a new configfs entry to configure the target function configuring
> > and bind the target function with target controller.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v8 to v9
> >     -none
> > 
> >     Change from v7 to v8
> >     Added missed head files
> > 
> >     Change from v5 to v6
> >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> >     | Reported-by: kernel test robot <lkp@intel.com>
> >     | Closes: https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > lkp@intel.com/
> > 
> >     Chagne from v4 to v5
> >     - add include <linux/slab.h> to fix build error
> >     | Reported-by: kernel test robot <lkp@intel.com>
> >     | Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > lkp@intel.com/
> > 
> >     Chagne from v4 to v8
> >     - add include <linux/slab.h> to fix build error
> >     | Reported-by: kernel test robot <lkp@intel.com>
> >     | Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > lkp@intel.com/
> > 
> >  drivers/i3c/Kconfig        |  28 +-
> >  drivers/i3c/Makefile       |   2 +
> >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> >  drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
> >  include/linux/i3c/target.h | 548
> > +++++++++++++++++++++++++++++++++++++
> >
> > ...
> >
> > diff --git a/include/linux/i3c/target.h b/include/linux/i3c/target.h new file
> > mode 100644 index 0000000000000..b0bf06685834c
> > --- /dev/null
> > +++ b/include/linux/i3c/target.h
> >
> > ...
> >
> > +/**
> > + * struct i3c_target_ctrl_ops - set of function pointers for performing
> > +controller operations
> > + * @set_config: set I3C controller configuration
> > + * @enable: enable I3C controller
> > + * @disable: disable I3C controller
> > + * @raise_ibi: raise IBI interrupt to master
> > + * @alloc_request: allocate a i3c_request, optional, default use
> > +kmalloc
> > + * @free_request: free a i3c_request, default use kfree
> > + * @queue: queue an I3C transfer
> > + * @dequeue: dequeue an I3C transfer
> > + * @cancel_all_reqs: call all pending requests
> > + * @fifo_status: current FIFO status
> > + * @fifo_flush: flush hardware FIFO
> > + * @hotjoin: raise hotjoin request to master
> > + * @set_status_format1: set i3c status format1
> > + * @get_status_format1: get i3c status format1
> > + * @get_addr: get i3c dynmatic address
> > + * @get_features: ops to get the features supported by the I3C target
> > +controller
> > + * @owner: the module owner containing the ops  */ struct
> > +i3c_target_ctrl_ops {
> > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct i3c_target_func
> > *func);
> > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8 size);
> > +
> > +	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl *ctrl, gfp_t
> > gfp_flags);
> > +	void (*free_request)(struct i3c_request *req);
> > +
> > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > +	int (*dequeue)(struct i3c_request *req);
> > +
> > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool tx);
> > +
> > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16 status);
> > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > +	const struct i3c_target_ctrl_features *(*get_features)(struct
> > i3c_target_ctrl *ctrl);
> > +	struct module *owner;
> > +};
> 
> This structure looks very different from the master controller ops 'i3c_master_controller_ops'.
> I think you could probably combine 'set_config, enable' into 'bus_init', 'disable' to 'bus_cleanup'.
> Also using the 'struct i3c_priv_xfer' rather redefining another 'struct i3c_request' would be much cleaner.

Thanks, let me think this. i3c_priv_xter may include read and write, 
or write and read. I3C is quite fast. Most time software are not quite
enough to handle it in time.

If data len bigger than FIFO size, it have to use DMA to transfer it
because there are not flow controler at target side (write direction).
Read, hardware to use early terminate to tell host read too fast. but
for write, 9th bit is parit check bit. Data will be lost if software
have not read from FIFO in time. If use external DMA to do that, it needs
switch dma channel(generally, DMA rx and tx are two channel). switch
channel automatically are quite challenge at current dma engine
framework. 

Of course it will be possible if hardware implement simpilar I3C HCI
command queue. But I still not found any hardware that can do that yet.

If only limited data size to FIFO size, there are still limiation for 
xfer.  if write, read, write, read, two write may combined in one FIFO,
target driver may not split it which depend on hardware detect repeat
start and insert something into fifo.

It is hard to support all user case by I3C target software in linux.

write follow by read, generally used from get hardware register value
from target side, which almost impossible by software, it is not quick
enough to parse (write value) then send back data. 

> 
> In the master i3c side they don't abbreviate i3c_master_controller to i3c_master_ctrl. I think we should
> do the same here to standardize it. Thanks

The problem is in I3C spec: "master" already depericated

from i3c spec 1.1.1

"Controller: An I3C Device that is capable of controlling the I3C Bus."

master/slave => controller/target. 

It will become more confused if i3c_target_controller. "controller"
are ambiguity.

If "master" => "host" would be better situation, but not happen. A point, 
I use "ctrl"  here to avoid I3C spec defined "controller" term.

Anyway, I hope more people that involve target support discussion. 

> 
> Regards,
> Joshua
> 
> > --
> > 2.34.1
> > 
> > 
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c
