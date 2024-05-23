Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7141C3E;
	Thu, 23 May 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443616; cv=fail; b=H8ol3KJ6EM0/ThMg4byMAThILdioreYvIEvyhHMub/eqmejpdoKv7pdtWneABMrTvthl1l9hKHQMh/dF25Hs65YO2ScmErvG5yopUHwh/J8OJFwPuDmutbuVlbWV3FLzZE5ik9YFRrNUvjusWxR2nTnmYh++Oj5QnWldmJfyQ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443616; c=relaxed/simple;
	bh=WDEzKnTosfRCdaEaxVbPbA2dBBr/AsXv8bOC0S3mOmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgsfg2cvhDJ8uKSVBbww/r39prVPrf6J1LkrlFjQqI/SyKL3wj7MBGP8gmSxgcPm0D4Cn7n3rCG/ars6+VeKETyPKrtb1YeBBZ5GBNvC3LOEFtLt3U6lcPUwW/Qhb+t70T5HJirc+TvK/UR9ZRJTqPIJrAR8esP672HnX3feOaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=AMyPKsGt; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="AMyPKsGt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ2OrEM1ql1KwOn4Yyke4kHLrrxkErzdH9ll4V6p2IMC0RyfkZSJ2df8n5dOFX0YGq4ZTZFD8szTJhOsg7xel5qgX06ex/jN1DGXs/zpQDrTqTkWVwkFEhcl2cwxXkaO8zE5affGEBW4f1oIYhjPxN1zVGDqjNWmnayiW2JwUoij3ei5R1bapyV4FX9YZ96aP+b5p1DfjHgdaiwt+gccBrnxuNdP4pAZOVPz/NNNuc5OX91dZ3PTAWwRZLxmgjMT2d2tI9WTwtLCGnOg/GsN20EiJ0l6H1uR+m25cia5RqwrDi7ovzmbzROzbXVHLLxVJj484KDF3/fzjHX2I5siOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLotGJWI6Ya+/w+ybAVcesYgICuVAwyDTCOyUXAA3Ns=;
 b=GQNIjFvl4fIpGWBre2wwTE7WVoQzhuc/vwtCmmv81RVeWK7Ql0GKdnKFt8ATwODzm+2dvmO0lkRW1+gbtJlNQ3wZUer8N3iy8EVk7aYEKysrN0R/+dQcKFyFKxdgjC12/CVC5PuaXSfCxfAzHHUhbuwD9KgGW52C1HhsX4ZMIGxPfGKe7/ofgHtxX0pMawVB3sLRR2s8foTskkS3e2NsEV7Trf6gXDbwwes1+24hSxezivBVGZp/IM8Gds6YGg2hfewRBN3pEk5dvj5hnP/wNvBdjGpe513ESFbIjP735CtuSguQNSCTy3xZkqSG2Or8YM01Q5O4NETrEirpfmyANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLotGJWI6Ya+/w+ybAVcesYgICuVAwyDTCOyUXAA3Ns=;
 b=AMyPKsGtVjw0FYHjchdv31wGCt1mC3tjPDsEn2pky4WUJkbFgDO0j7i24Ah8AqJWwQ/rq/nlkK6WOtT9I/vR3QEUL7wKmzqeiEJO0ASOO+sjd0Dsuc0YPeRKrzvjw0LZroExVSjmjO1dCu+brMQP/8CwYO+TaOJ9w1fUUE9KuFk=
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by PH0PR13MB5952.namprd13.prod.outlook.com (2603:10b6:510:16b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Thu, 23 May
 2024 05:53:31 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::24) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 05:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 05:53:30 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 44N5r0xo000745;
	Thu, 23 May 2024 13:53:13 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 44N5qxuD010925;
	Thu, 23 May 2024 13:52:59 +0800
Received: by mail.sony.com (Postfix, from userid 1001)
	id E79681D808D7; Thu, 23 May 2024 11:22:58 +0530 (IST)
Date: Thu, 23 May 2024 11:22:58 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v6 1/2] printk: Add function to replay kernel log on
 consoles
Message-ID: <Zk7ZuhHGW2R6N1E4@sreenath.vijayan@sony.com>
References: <cover.1710220326.git.sreenath.vijayan@sony.com>
 <90ee131c643a5033d117b556c0792de65129d4c3.1710220326.git.sreenath.vijayan@sony.com>
 <Zk4MtXxbzGrQhSFA@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4MtXxbzGrQhSFA@pathway.suse.cz>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH0PR13MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: d3029499-0c83-47e4-f0db-08dc7aecad0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bi6PQwc8cPGzgUg1JhJxHSprMk3j4Hrspf/FiZNO1hQ5RHH6P8j9AVLJN3ey?=
 =?us-ascii?Q?f7lhYprk1rsPiJQcDJBzOhqlyeOBD2Lrno1S3IiQpvWv76zn4VIymVjbMZ3e?=
 =?us-ascii?Q?2VrP0spfuc/yWYTTheShvsHI5W6EE9Z2XtUb8cYNGcxK2yro2EkM8Qh/xfzE?=
 =?us-ascii?Q?b3Cd04YV2d5mbkixfOaPV2BJz7ICqP++0QwQ8iwv05ERVv21msxM/Y5URrJF?=
 =?us-ascii?Q?rFpoL21fDfUc+wATEq5hsmEuJ5+6eucUiwHlt67RYBy3z+cmYTcwyXMDw7Vl?=
 =?us-ascii?Q?D9upH2amzPPypWGshD7dV+1tQRuVet/lyNDoVfRZ2XbWjDJ5ZdvnluOFBkV4?=
 =?us-ascii?Q?sEyMKfkkc/gX8Po5iA1kGn/hWo+7eRhLnZqWRlFIdAO6vs7keXpJR1prUa1d?=
 =?us-ascii?Q?pBF+flAFm3l3+hXQaO9/lqi44XDWo+Wxi+UqPqb2b8PBX5qsHqou2MXbzS2z?=
 =?us-ascii?Q?o7wv0yZbftXIFa6GV+0SFLlx9WiAijr7waWl3m0XXT8BvWx60rjq1QJl/joJ?=
 =?us-ascii?Q?ZYXfxg47VXaJlGaXRVyYAKX+ErgL+opD+6J4OkLGPmwndEspCzuWly3PoZX0?=
 =?us-ascii?Q?ZI3LO0t33jAQJQDmUo6Woc16ul9ahIpXUi94m/c36LNB9mls2QqCFKpTjJvn?=
 =?us-ascii?Q?9syhRw5c4nZkSpmHDAnHf6cDnxVaZQ0XYjDCrPoSH1vRjHTFRqc/0BqQi4Ig?=
 =?us-ascii?Q?DjpzXS5j3kmAKkPU1TOTK2pTeRmvv3CGzB2/HwBqvCAfrlLq2dV75iwwSqyB?=
 =?us-ascii?Q?KRrdB4/NXqu2vYG88TZcnw3MkAg+sE0PKKgR8WvGlyXUvn0AZsHntWhIMPKx?=
 =?us-ascii?Q?SteQtnxWajZevj2PhstXHKKEhWIVKRbU6HexDrQiJLEfUo7YK4G9TUtpAuHe?=
 =?us-ascii?Q?/gTzNx8sUwxzdzY1uExYfXbzXIVGRiS89oNEq6YpU7yUHib1+GwCAcmq2u2R?=
 =?us-ascii?Q?lss1Fna/mMPctnlfqjUGtom5P5DTFDZKuNv3/CH5tijJLbM27Wh/7MJ4LXFm?=
 =?us-ascii?Q?OGkgOwInpzmspDA2dXvvIki5Chke7AJQl9XZclxx1lgFdMPcXOxek45T1kW3?=
 =?us-ascii?Q?Zxx49TiCcC0rlVAh2YDSqqXlB1UcZN571VtzEObJz8EDtle1sWBIpl227DsV?=
 =?us-ascii?Q?hIrF3HGvNaIJBFmULqSfrNwmilTp6bRLE5hrJJG/90F46dast7cp1Wj7qAGA?=
 =?us-ascii?Q?5pHg6Xi9hqbgG9iKRcHW7iM359yGZ/KC7HrQyiZkSfFfe8B1bioR7Z3Hl/pG?=
 =?us-ascii?Q?pKhuENkI1VvDrFl33tH5Q8dIAg36JWSxD+oqz2cMva+g0cVBlT2UIOMGRJWa?=
 =?us-ascii?Q?zpci4lSMjTQgbVO8URuJoovR3GrPh5mvXQ1nsT7OvEuyHPUFY/mtkFXqgGJQ?=
 =?us-ascii?Q?Yd/wRRmAg3K7Mj2+pZik1bT65cgR?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 05:53:30.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3029499-0c83-47e4-f0db-08dc7aecad0e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5952

On Wed, May 22, 2024 at 05:18:13PM +0200, Petr Mladek wrote:
> 
> On Wed 2024-03-13 15:50:52, Sreenath Vijayan wrote:
> > Add a generic function console_replay_all() for replaying
> > the kernel log on consoles, in any context. It would allow
> > viewing the logs on an unresponsive terminal via sysrq.
> > 
> > Reuse the existing code from console_flush_on_panic() for
> > resetting the sequence numbers, by introducing a new helper
> > function __console_rewind_all(). It is safe to be called
> > under console_lock().
> > 
> > Try to acquire lock on the console subsystem without waiting.
> > If successful, reset the sequence number to oldest available
> > record on all consoles and call console_unlock() which will
> > automatically flush the messages to the consoles.
> > 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -4259,6 +4271,23 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
> >  }
> >  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
> >  
> > +/**
> > + * console_replay_all - replay kernel log on consoles
> 
> It should rather be called "console_try_replay_all()" to make it clear
> that it is just the best effort.
>

Ok, noted.
 
> > + *
> > + * Try to obtain lock on console subsystem and replay all
> > + * available records in printk buffer on the consoles.
> > + * Does nothing if lock is not obtained.
> > + *
> > + * Context: Any context.
> 
> This should be:
> 
>  * Context: Any, except for NMI
> 
> Basically only lockless code is safe in NMI which is not the case here.
> 

Understood.

> > + */
> > +void console_replay_all(void)
> > +{
> > +	if (console_trylock()) {
> > +		__console_rewind_all();
> > +		/* Consoles are flushed as part of console_unlock(). */
> > +		console_unlock();
> > +	}
> > +}
> >  #endif
> 
> Otherwise, it looks good. With the two changes:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am sorry for the late review. I have been snowed under tasks.
> Also I had healthy problems.
> 
> I have seen a mail that Greg has queued the patch in tty-next.
> I am not sure if it still can be fixed. It will be perfectly fine
> to change this by a followup patch.
> 
> Best Regards,
> Petr

Thank you for the review comments. As the patch has been merged to
mainline, I will soon send a followup patch with "Fixes:" tag.

Regards,
Sreenath
