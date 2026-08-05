Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012056.outbound.protection.outlook.com [52.101.126.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0652360EEE;
	Wed,  5 Aug 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889749; cv=fail; b=HaM9X39/yTDqYmYtypC0Iaq8fxIFh1bh5p6tqu1h2Pz+ZmSgMQ4a9H5KVgQfx9qNCj4dDGIh7R5q1dZWbSKoajm6DHFZtcoa3Lc0n0bXC3eCqDoqdvGzBggunoaTqHyVbgcQHExTENIrYCcjuelm02KEJHV/LCcUAcVGaxOg+pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889749; c=relaxed/simple;
	bh=54kNct6w/kejn073xna38Cq/4HJJh7eaPjTnanqiIBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtqJ8LyGRHQuZTsqXBPKARcg825BJl3I/ZhVLslfj3AIEvzVka7Un3JWkHdnOcvJmIHaK2f7Q6RqNqsvVkM8ubZj61iHsMhpVNUNq6QPvgetM0swpOzNP3ff37F3gQiEwanaUUZQzK8EtIk+yY1op++LTx73jJRbNH4zZBfAXN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=c4SvvPoI; arc=fail smtp.client-ip=52.101.126.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="c4SvvPoI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZA5PW1yPwDe8rwzPP4NEsTtBuZXVdVXC4ZborlrJV9l9jwCUwy4+smkpEY/yZwblEIdHhNQXJuTLyv0LbSJP04tbuUVfVlWIbUWai3n6/pE1jxJUfGRYw/holmSZxkgCJZ4QV6IY5yHGZmcUiRKJp8PpTWLPXFxSIJRQ8HWFKubPtYm+pd80tRsB/PDEkmU2oHNL5ElDn8YDdRE9mzMigjiVSSPBNUYroN5g/LeFo5X1OanC7lJ2HaQMWUHUGZEqXVD7muv0oUYpoCumrqUJs9Fun2XqOYdFK9nI/Cm1VcTPFgkX45eidAYjuOZ8tECgYZVwBtUt0k/G+fikiiZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBpM2GGwrlyyaPnfTMqv9O0gwhaoxUn2QERvTjLJY0s=;
 b=v6WrYi1JPX7vOYMLgN7lja3T+3xSqK7pRQjWi6Gu1+ic/MI5gcbce5OjZbocR7KqybrXTorczuBZJx7KGJ0RB6j4Zj7wffRSion4ewDglHN5MZ4fzFmQQqVgS1mxdpNxqnB3b4jP4iUDSbrnI0X0wiWEb9gZUOsdvlowj5yrF4L4pbOk4zCqVA7XuBxTgnLWoEzwYOPg0wZ3rim25iLdhD0Fv0ZDCIMEShr4Wt5Ft0MMccliBwz2GgMp+unkwLY2lpTneUz7gIwJS9cZZ7mObLV4y4GsJ9apnu9hgJHGFGvnI14NYRwYAacLst7rkaSZsgx2SG8zWoUR4nbPcQQx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBpM2GGwrlyyaPnfTMqv9O0gwhaoxUn2QERvTjLJY0s=;
 b=c4SvvPoIQA38mkNJOcrq7E6Q+Yy6RqRYJ2CKNUtEGC/OkinF5EVzVGRDH8L/6Vk+u7Gu9fTHqURVe9LMf8e/mvbG2Zyf9tJTNzZIjH5hd6BLD+ISYcc4kM1AjGGVfPA6/BiiPFa1xLEQQ2+vma2mYGuoB55mTKjGrHLHigWpl7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB5328.apcprd01.prod.exchangelabs.com
 (2603:1096:400:343::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 00:29:03 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 00:29:02 +0000
Date: Wed, 5 Aug 2026 08:28:59 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: moxa: remove driver.
Message-ID: <anKDyz8AEpyDpdeS@moxa-KabyLake-H>
References: <20260804-x-remove-moxa-v2-1-947c039b66e8@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-x-remove-moxa-v2-1-947c039b66e8@linuxfoundation.org>
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcd910e-c969-41e5-1f47-08def2888c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KbfhI1eC6rio49wgcNFysdm3E8dlUWPvNZrcsFw6Mum9aaEZRkDCFTkYpTeWjBoubKV5iA1f44zVzaPdOQvWryflOsw/26kE0DFdP3YFtRT4BBBghhlUtHhyc88bO+wXs2YZizyT8gInFSZBf9z0AYlEGWjDU1vyI8kEusDgCgttbKInRVvJKzYDPW6Vlk9mF45TCO/x5J8wfG9ayAMzafSRgd3U1+vUifg6z7iMXVOl7bT7mkkc2pe9GWOztuKk3nYdaD9FkL4GgfHNpqpv2qyLum3tcqnxfss4VgqszlKaIdkhPQeEESeDTUeNPaPyCmaUX+10hgyF9OLaaik/GBIn/LPfMrKeH+Rf/IOHuVSeVExVwaM3UnYlAVpzGUo96515+7KOl9tFto/SPwRwOemGrjoMXH0LXrE2jC98ntcw6PgX+xEPHKsLRCvzEHemzgDybQUfF1q4dSstEg0Wdy2kP85Bkdr4YHcl4Wyy3CqDlfh2Y4w+zm1OynkACimwW+2rYOARHHtFrOehQLDWRD72D/amDG3M0ubzkeqeY7ALr35zlKiU3t+XTknG2imQyvATNlTeRRa7EurVDOQrJGdv/eciF+0A4Wczisy07lM1MqewmlJSa/eit5YNtPEjgInwGhPByj3deHIJVLlADSf1iKjpuGVPEj7xEjCkZQF/3+2FZ771jAME5/f5zUDOkA2kMB4YLIgsCsDfnP5Izg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZrKiV8XDsikwYprt+Glu84rx/94atvz4IpzZvCe1wbxKneTXpcvRFH2+sfBP?=
 =?us-ascii?Q?PeTNHbiVtO24e0q2fKkdsES4mUUuIz6CAQ1mXqZ0gqhbaulniAWp4eLVsmIF?=
 =?us-ascii?Q?iRxoiQ3wec27KmR+zgV3hIGbsHmn1i0hftHEEfGlpnehaPfXFuk09i2FaIZ5?=
 =?us-ascii?Q?ICzXmT3JFo+d4+hcF84o1GSx1+xalOL6yc0a21UpKNcZ4kBvZNEuzM0NEuk2?=
 =?us-ascii?Q?37ahB+gfPbixbE9WZvrs7tEr5MC3hQvHAbhfL2jBbJN2TI7u+jNlQ2S7fY4j?=
 =?us-ascii?Q?KVyxm/qSKKdSPVsFbTKJH7jRG9PQf1iOVOqwkVRNegBOB2CNKQ0RX3yfTPGK?=
 =?us-ascii?Q?0vIjLEBOuZzMrySbrbiQk+3WKHM4Q2a60eBTcoppdQKiLRiwFKRibWCHw2uA?=
 =?us-ascii?Q?ojz4QaMBXefLtMQh7yyRpPP+gsiUE7XRruvH6b+GR7RJn9qGbeYj0ZzjHN1X?=
 =?us-ascii?Q?uIYLpHeJ+9awVNghaxAdQghNFB94eqiaD9vrrqv3fjWZgX+iafqm8yeUTxAD?=
 =?us-ascii?Q?p8IeBglSAxLRLbo2wfKw/TMUXu0+iqg3AMM/PKj2ILBEhIzRLIlwHQYyWcWo?=
 =?us-ascii?Q?9h1fq429tH+ULkdB3pKH/qbKyBN/I/5TMuiRapFRij2R7BxAzKTNN8Kgs99u?=
 =?us-ascii?Q?N/sXTkkYO1TS7phUs5392C6+bStjsSDToxjGR7OloTOjcX6jnYyaNvlOMTvh?=
 =?us-ascii?Q?PtOSuQZ3De+TNBrliZ2Ojs6NwvWaedLlhz0v1aRI4ZyaQHAsIa55SGfagwh/?=
 =?us-ascii?Q?H73uKTeDL5T/v/f1hyzMoF+gCeQ6zs5bwvYcdvsq7F5ahBHKx/nOnDwqS58h?=
 =?us-ascii?Q?nxDRfecV3tq12LQ8d49aVgpPZfZg1+ht2f54kcX//kYjRvH2Mt+nBEcX/Wzu?=
 =?us-ascii?Q?cXqQkZ3emflOscYu7wTbJgwog+mScvB0h6Yf3fwBPi9FnswpG6XnSdmrhHSy?=
 =?us-ascii?Q?Fe57P1qsHP3nuDVEfDgd0y/tG6/jfpeiDHac4M2a+xyf8vxC6X2TRSNxXtVS?=
 =?us-ascii?Q?dYounQA21oa1k0pDK+aVRZ/1lyxtmpJ5He0RCEXV1QDf3/L81cyVQwSTRMOG?=
 =?us-ascii?Q?ctDY4BK7Q0MrFQYg4ubjW3Ww7ZwjcLkdEHmfqZlHegd2aXVRuaSJlADCEp4Q?=
 =?us-ascii?Q?Lti2qiHI4dPs9bexJ80u1Ulp3LUvpWuj/FoClIee+3FE6XnZuFcz7pnJ+gEG?=
 =?us-ascii?Q?zJrKrBFYnxus1B4JWT1mzoootY1/3Hx5aGMsG9t1TobQCsIeHkbaZi+NIzek?=
 =?us-ascii?Q?PtW/8rp8qNM0HCVuAk4Rde/cRK6gL+jiX713J+BgDGHpv3hr1Od6CMyPqeNo?=
 =?us-ascii?Q?bnnvQ94hF0JYaOtxvecZIF4ncJG5T/Wm65MhkgAZzVpklmG4Vjw/GDfo5rJi?=
 =?us-ascii?Q?N3IKgaN+wxrzc0vwZw0oJn5e/ORP5xYvzdZfdthfLwNr70eF0TcfV/+cjVaX?=
 =?us-ascii?Q?X6uYjQ94mmMOMEbYpm+jidZGSqcMcX8E77IWbnhTxCqIiJD92juzYndl9qyw?=
 =?us-ascii?Q?2TN/s92E/TIcpNVzedC6scWXA4/nQiA8RluzEXsH2CvmV1XkOXBVODJdbbzd?=
 =?us-ascii?Q?0TqV+zsLjrPOQJ1a9Jg5xnBAPxYRvNVyr9kxa7x1zK6ghv8I3/WLJwTTs7o+?=
 =?us-ascii?Q?MuKIK51d93K1qqP6Cfgmv+f2goTDWpaTixZVwrtzrn0Bd0B1qj2tQRPNsfOb?=
 =?us-ascii?Q?JZ/oi5phW2TYwIw23wTBl/Jn70ZvruU50+Kly+yKJI3vca8tCHhF1MEprZEn?=
 =?us-ascii?Q?CS2Z8wM7EPBJzlUwwGI4s+fBpEDL4Kc=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcd910e-c969-41e5-1f47-08def2888c47
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:29:02.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiIITltoxOlAKdPJQk32YOpD6bPzeGUukYVv8MkFJsL5pKPECAMEjrUov5YesfGacTmVHADSenuUgtqNj6P30kcN0MSzf1DiyT7ovL85Zbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5328

On Tue, Aug 04, 2026 at 03:35:29PM +0200, Greg Kroah-Hartman wrote:
> This is a very old driver, and no known hardware is still around for it,
> and the company says they do not need it anymore, so let's remove it as
> the LLMs are starting to poke at it and find "interesting" things which
> will just waste everyone's time given it's not actually used.
> 
> So let's drop it.  If someone really needs it, it can come back in the
> future, in a more "modern" way, as the style here is very old...

The removal looks good to me.

Acked-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

With drivers/tty/moxa.c removed, the following device IDs in
include/linux/pci_ids.h would have no remaining users:

- PCI_DEVICE_ID_MOXA_CP204J
- PCI_DEVICE_ID_MOXA_C218
- PCI_DEVICE_ID_MOXA_C320

Would it make sense to remove them as part of this patch as well?

--
Thanks
Crescent Hsieh
