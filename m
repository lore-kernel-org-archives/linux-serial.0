Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DCCA0FEF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Sep 2023 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjIASsv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Sep 2023 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjIASsu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Sep 2023 14:48:50 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013006.outbound.protection.outlook.com [52.101.49.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351EB1BF
        for <linux-serial@vger.kernel.org>; Fri,  1 Sep 2023 11:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRutMkCEsC9YLF1j6LlkNGjxFwlPG7+YVuNc+hMhketR4oG1p8msAmx3Z/zW6givfGzhH5HQt86aBe6iZokcD/dRI8AhJ3Yq1SrLWmzoKrndZ5C/DKUstZEyG/I3s8dOTatfjmoripFRMeyhqhmmZcQ6+mADyz9qQK9et176WpKUNje1UMJsPRWO2YxiEoCW0FetOG59AHey1GP+HlOlgZ+UsHtaLYsdocnSFOhGxFxRtr3vDVT+8C+Z76VdHvTgeZISRwUc6fLg/1DV21mDckb2yIdTJBQiqXJN8TMExjdG9smlJEmFOW14MWr2zX3VTSQp/bfx9+PtqN+4zWNuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8pM/xtOBB0aAPPnrX0rM4xE3FqM6Y9WvpDd4pidsS8=;
 b=eeFDlrtCt0hECSgL1AphED1NQyIE5nglEViqQyZ4Ob+nlOAKZIDUG1iFRdHOAqFGsFRq/4eI8MnznmM8ld96h+rI7yM2wmecMChKR9v0NOPx7Pc+VFxENTrzE+6v2Gm+bpaKi2Z+bQI1jIAwvXWDTRKdrhAZJ7fPTnZMgSneLdTr01SV5bXlr5xpZDe2p81Vp2E3oXMNhNFH//PXb0Etmei4LajuG/c3XemGfEYy9bZjhqAK+m6j/1vofvbYk4CZjTAxWyU0mknoGF0/UJmbokgjEVvfPO8eBx3uxsw6+7fG2YwLRPdXtajNg6CJgFHF4A73adxrB5aeHHRYxWE2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8pM/xtOBB0aAPPnrX0rM4xE3FqM6Y9WvpDd4pidsS8=;
 b=RAMVYBvr2WC8nEPbSL1SaaTp+svxRJy0nQ8wSW7ZpvmusBZ0bySOxadihyFoBvAx0WVZgyp9MhIwkzRMXh7E35SYTfVH/G6h8KJbW0bBLP/BJrQK/q2rpXuQVp9aeg1NIddL32yuidNRSzflRRY92LRDZKW5rNiv0aOnWQx0OTdmixbN9tRGwkfZXJq/TN3HOPJPkXm96niejP5Rvf9Kr8dZqZG4InYvizLA6ThmCQQFBZXNYKbz2XtB5UQSkBRWMsj2gQBD8rdQBst8ounhNx5zQOFm8wRIgiUheG7bDRB6xaTF5ZNPxqhjGYpJpzfDPP4x2b95746XLSDylYdJBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SJ2PR05MB10071.namprd05.prod.outlook.com (2603:10b6:a03:4f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 18:48:43 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 18:48:43 +0000
Date:   Fri, 1 Sep 2023 14:48:40 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
In-Reply-To: <20230901044730.GL11662@atomide.com>
Message-ID: <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com> <20230829035245.GF11662@atomide.com> <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com> <20230829201557.GK11662@atomide.com> <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com>
 <20230901044730.GL11662@atomide.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:408:112::18) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SJ2PR05MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: a25715d9-ae8b-4b31-7014-08dbab1c10b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EL2m2cBCjTFCjpXMasAuTkgzIVHdCmqDgnYvjumNcOkhuRkLFfQFloqZGtGeRMDrLQXtXU2wnHHW4OYMa4A3t2juLVrlPrjfZxoiS8JPOtyu4KnTf6ji1qEMlEmONErP3Je8YfmJdE9pe3LZ1RNBSpMo2wCzAAF+QD6Qyyo/Ox4lrwIO8v5byf9jbXw7awiVAHraFHS9tQvuMtog2zP0yPKcylQHVyZuzcZobfFnYFUmCcs14pR1uajffA7IOeh/v9WyjAnGmm6It/fvdHYtqs0LAOUIGoboGYqetd+uGJ3NM2GnFWjq+TYVkew3bWv2iaw54L8rIVptf+GnCS2Z+Jle4Gq22vZKX2eJs2n2bpNH7/oI+lFAS+rO8fm51tcGbbbjU0jWzte7soM9oUzGoa4TQIcVot4oP66wmS5Ae3EZq+IJq7AfFFNE7irLLQ13moOLty9ChgZemfGeSi2fARLoQx4d2SNzl6Z5pHiPHJiN/NUBp64vA+4P4d5wAavna8AKZqiGF1azRlyDSG0vH8QuDzwqWlw40YqycqFv78cT55UEFiwc89BYbh7u7o315ZceQ8ehwvtFOdd2GWkHbFU6fY5do6ytBAeyLENRPTEHSlv+/Uh8o5wKA557cHLAJtea0tn3mOC0x5i2Y4j1E5uXL/J7o8i8PsVh41iDkoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39850400004)(346002)(366004)(136003)(186009)(1800799009)(451199024)(41300700001)(83380400001)(36756003)(316002)(2906002)(2616005)(26005)(107886003)(38100700002)(5660300002)(8936002)(44832011)(8676002)(4326008)(6916009)(6512007)(478600001)(6506007)(6486002)(31696002)(86362001)(31686004)(66556008)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kLXil4xrcxklEDOzV8B7OUgeKD8DNBV7JrrzVZqAZlxmRg9CkzkxVCPtestP?=
 =?us-ascii?Q?Mdc4jL+8vI0wRsLB49mou/3VtgHJPFjMAUUqIQ2DKQq6ZpQButdXmmEbN41O?=
 =?us-ascii?Q?kt7a2CSPdOgnUOB7u3eKMv2dMTauIa1eSHEWpsVymbauCmrPH0pVjiueZc9l?=
 =?us-ascii?Q?R0IpKGIylA0iZs6f0rBz1UP6N0w1xP5IXk2Mcq9cJmarpanVLcEg4UR537fA?=
 =?us-ascii?Q?P6IGQowal4ioKr6n6L0LPxg85V6lCdc3avSNZkYF5w3yUL92RDjM7usXfdoR?=
 =?us-ascii?Q?eq4F0bHeILUutrSjPkRGqvCueygwNPuvEpznbdikVVbHdzs2ZDJgHR91tyib?=
 =?us-ascii?Q?TeVG5M7CEyZApVjd3Mu3pvwMbpMLYchGi4//TwSGqYwiwqnG5kj0PX+HgRiv?=
 =?us-ascii?Q?BgNPVsI4cDXr/debh5+tkUr5seoKkcMLKR3uLQDtKI5OgMR4F58uZUr0jeX+?=
 =?us-ascii?Q?eWtkjV90f8mVTIPUD9nl+a7/ny+xrAHpP7PA4k+WQbl0FDO0wO4Q4lxeaR7I?=
 =?us-ascii?Q?9Ib52f9jWwnfHWNkWOsHxyHEf3p6vgyW9Pq0Go/Tq5FeRQyU1qvpyt8wauaI?=
 =?us-ascii?Q?FJPrjLRJeC9B5NPgY2pSc+19Is4F+8SzKBod6wYo3a/U1JCGIiW83/vCM7rl?=
 =?us-ascii?Q?gPTWeslKITjYXIjMESPH/S2lRfFNFjFi2so7J/8DIBYYhZZGsnBa977TSl65?=
 =?us-ascii?Q?KrQrjtWfeaWqXWxpjToKLPNWNixv4U8LBN+rltUu/XCB8ILnfIDn9lKNMuqY?=
 =?us-ascii?Q?pzV45LMLuUYALlMvq8fGmL3Pfm1Oh+r/uH5hZM3WJm1zRCrTbiFCJh/+KOh5?=
 =?us-ascii?Q?Bm1lD6eWb21zxnErytfRYWA3CogGKKDnA9+ygG+eSIXyWBuVUvt94Z5x5vO9?=
 =?us-ascii?Q?RzU1NlE1mRr71NTSRpiZJDDHyCMnji4dgxxt0RGp1rhGLQdBSErJcgICBGjk?=
 =?us-ascii?Q?dYcsYulcWwpn8OJr2wR7pbBvw4yNqZNChZ5OUzZRzhPfvwMjL1OhjaHS06ka?=
 =?us-ascii?Q?OtydXohAMVQu5FF9n4HT8SUsd7F2aNSg7sBGEN5qJMdBi7zWa66ph/6omlOO?=
 =?us-ascii?Q?vKFKRiibqe66TeOCoOQOcQ3CjldkWVqJGX1TQJxM81wG+dcPlrfetdeAKdE9?=
 =?us-ascii?Q?2s7hMrs/G5WaRMlXoEUrpeZiFFywU0i9a5Y1kcspeDuCYB6rG6weZpFVcFU1?=
 =?us-ascii?Q?rz1I1Y6AAsdhAQh+myOr1zU5veKNbSWDbPI7DSRzryDhXumX6nb6voc/5CYW?=
 =?us-ascii?Q?fb2G88OjK8U2adx9tjL577BY0kGqQ6WULDXcdySwZz6afhyMwz23YdsuKjnf?=
 =?us-ascii?Q?95EFrQ2hs/w9Xz+IkpkKqgn45+28fuH3T9bdpk45HGQZCndCTYjvWTME3y2K?=
 =?us-ascii?Q?0Z9pPlrOVcuAW6c6V3k2479OQazukyqQPz9yH7QovJjOAaezxvEUO53Dfqn/?=
 =?us-ascii?Q?Dyk67uPjNF1nUlQ1KQ20GMAyvLQMAc6UnnOjq3MYnw6XonyqvzoQwdcbgzrD?=
 =?us-ascii?Q?cRqL2kvwb+LKjiU0wmef6Zie5sk8dZn6yTr3kvUQzNLxIMhu/B/sEV+71OJ9?=
 =?us-ascii?Q?DiHD5ni9qGcY6wbwLlbk2sYxIZIgxu3gCui9XBSdm+NMkpGPU03AsgwAKzlq?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25715d9-ae8b-4b31-7014-08dbab1c10b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:48:43.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78VHYM1rJJ4nSHjTLQbucfaZEHeAUwhx0kMdbKpFawd3nX3MO+35HGwIuuBbvl/vZqW+dUzrG+OtZp6NgSYAkRVUcTx4UgNRP15+8HgCv5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB10071
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 1 Sep 2023, Tony Lindgren wrote:
> * Matthew Howell <matthew.howell@sealevel.com> [230831 14:58]:
> > On Tue, 29 Aug 2023, Tony Lindgren wrote:
> > > If it is a port_id conflict I'm not sure why commit 3d9e6f556e23 is not
> > > working for your as it has commit a4a79e03bab5 ("serial: core: Revert
> > > port_id use"). Care to check that again, or maybe try with v6.5 with just
> > > the commit below reverted?
> > >
> > > 04c7f60ca477 ("serial: core: Fix serial core port id, including multiport devices")
> >
> > Just tried that, but no difference. Same error.
> 
> OK thanks to testing it. So it's starting to look like the issue is
> somehow related to the serial8250_setup_port() change in commit d962de6ae51f
> ("serial: core: Fix serial core port id to not use port->line").
> 
> The experimental patch below should confirm if the issue is related to the
> port_id usage or serial8250_setup_port(). Care to give this a try against
> v6.5 without other patches?

For some reason I am unable to apply the patch using either git apply or 
the patch command. I made the change manually though and the issue still 
occurs.
 
> > > Dmesg output might help also to figure out if this happens on the first
> > > port or the second port.
> >
> > The full error in dmesg is:
> > [Aug30 15:48] exar_serial 0000:04:00.0: Couldn't register serial port 0, irq 24, type 2, error -22
> >
> > This is on a 2-port adapter. I don't see any indication in dmesg that it
> > attempted to register the other port.
> 
> OK. Are there other 8520 related uarts probing before that?

Not that I can see. The only earlier entries I see are from before I load 
the patched driver. If I add another card in I can see that both are 
probed, but both have the error:

[  +0.005929] exar_serial 0000:01:00.0: Couldn't register serial port 0, 
irq 24, type 2, error -22
[  +0.003431] exar_serial 0000:04:00.0: Couldn't register serial port 0, 
irq 25, type 2, error -22

04:00.0 is a Sealevel card and the other is a reference Exar XR17V352.

> Regards,
> 
> Tony
> 
> 8< --------------------
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -169,7 +169,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
>         err = serial_base_device_init(port, &port_dev->dev,
>                                       &ctrl_dev->dev, &serial_port_type,
>                                       serial_base_port_release,
> -                                     port->ctrl_id, port->port_id);
> +                                     port->ctrl_id, port->line);
>         if (err)
>                 goto err_put_device;
> 
> 
