Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF1CA0EF0
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348722AbjIKVaS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbjIKNEa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 09:04:30 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011011.outbound.protection.outlook.com [40.93.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DEDF
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 06:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M06So40clsi1gP48clGJgXeTH+xAue7JhKkjaU8mKPqBE+65s9Dk4PTT0p7nGFm1l/CVkZjcovMgxqVnvNnA6i15047e6r7IzDwp0bNYs48n50f7Q4aGAxidtqYpuQPDDFhKzJO5hNvo8DdnJugGhWLftSUxkT448Z2Bg8WXbmGI+BdG0CHMlS2bdXi+8tfKQOND2kRHS1ukrRXjLNyYd1rz0XrhMpLDgDbwBb8J67g7V7ShLgFv8QkzrbKsD3TXs7bRaQzqwUP4clIj5XTjSk3xSAmUrVS7Lar7ZrX1ALBoIfjWWeJTy+YxrSEAYmFPKB07RXdjjC3/jBCEa450Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wulud/Gzhc55TA/LoLHSsPBEM3gVkc0ByVopV2yySw=;
 b=F3VFga4l+Nk1sx8DzkFH7NiwhPfq6xtJDrptEOWKm4sGZpE9VqwERuun68Ri9ZlwlUA51LXCDy6zkXCYPUDXpc04+e6iKgtaeAB0sbE0FGGSkIlIYRph+ImmmKr5cKAKaBHB1T9mI61EmguwtSWG0nj5DInM6GKQx6iYvf9cwxTgxUIkhfmYt8I+bR61VmuDk4fxr/Pr85G0LsP4SWnHq5Vk5MDmtFHIl4ARnOMB93P9BvTv3Y1GJ7oHK/clVHxg4Lx1Cz1+V8PItERj7pVkhJ0eynKQmW9O64c/4JDcm8GlcLjL3e9Pi65Gry/Y+ql0S+SvxWMxnsN2yNPx1ZmXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wulud/Gzhc55TA/LoLHSsPBEM3gVkc0ByVopV2yySw=;
 b=hdA4lj1/MYHN6CR9+PB5XSocMoAk9v3WrpXEWIn3qORzXTfWGKfsYy1XGnEzh6p6Uw3rCNFLLyCpZ3R6wYb1M21g3hBvlX6LbHzfj0tFYZD3pjose0tfMEzh7TbfYQvrnYq99VWIRXlCeECu4fkSsWxvmXu+bef5eLujCVIU10uJ0iU8ES7kLWjXJ4NeyKlaQo/30EqqRGFuv3Xxc14q6HrC3SDDJMfiMu9hsmlw01esCOJumpEabuxEFImIMerZAl0e6cbCM09JKNdUzpkvLu5JpMeJh468/QjN18Cyrbbb5Iy6R3bJmm8whRGUVRyy/vdQOchNf1dLKsredOT+DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SJ0PR05MB8743.namprd05.prod.outlook.com (2603:10b6:a03:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 13:04:18 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:04:18 +0000
Date:   Mon, 11 Sep 2023 09:04:14 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
In-Reply-To: <20230905165147.GS11662@atomide.com>
Message-ID: <73817d5-cab-341-be76-ee9d565df57@sealevel.com>
References: <20230829035245.GF11662@atomide.com> <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com> <20230829201557.GK11662@atomide.com> <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com> <20230901044730.GL11662@atomide.com> <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
 <20230902043424.GM11662@atomide.com> <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com> <20230905155524.GR11662@atomide.com> <79e44ee3-f4a0-6f3e-cb5d-dc2b7bd048fb@sealevel.com> <20230905165147.GS11662@atomide.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0861.namprd03.prod.outlook.com
 (2603:10b6:408:13d::26) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SJ0PR05MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: a16cd9b1-c1f5-420f-935f-08dbb2c79b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbMmdgHKY3Mn07n1eylZsbh5URkTXsegcsXmgdPQB55FHuCwPlDwgyABfuFzIJteGY38qHNNCSdfZunNU2A8TYDDblY1YvtelqfpTZknxIeE1qXT6EGDhe48CD9F2gI8Ewkr68iuLmy6JAefO1gIf6bY/f4gxIdIrAWVOvRszprVsgy0NIYDmGPrIdRjuyeS9dQFSvacSuZH2drGFo0QglGhXYKz70DFynsGnGvfTzmVX2HYA/hrC11Unsxsyo8l7FJP2ncHRbzEjMtfSblDbQin/Ppsf913CCVC/kQWMOZyGDVAJ+siFNSEBq/7pulBQteRrJe15eI4eOv5p9AiOhhntN0PkFnbVTVkx66Z9Y/5bAw2lrrpmP/jxvFLI6vwQO5U9agGevMt3RFJugp1IgcxMQoqSNMMks824ObYCsY42mSSiq8qRsgbKdCSTrmhk6Pae3lAMS/rwVXtptB4ZtFBt+GuLCUyarLydnO9hrQLDN+BYiRynxzO6l4R/WTzozE/apYgSYMtcE4GBl4kZ6KNzr7zb3j4+f3SLTsj7aGMuBgLyEbsQdLz/yFrzqN7DbhQdLVv2WTIOTZVmm/9/rmswy50OhRjJhffTmAvSzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39840400004)(136003)(396003)(186009)(451199024)(1800799009)(38100700002)(36756003)(8676002)(41300700001)(5660300002)(8936002)(86362001)(4326008)(107886003)(6666004)(6486002)(26005)(44832011)(6512007)(2616005)(6506007)(83380400001)(66476007)(2906002)(478600001)(6916009)(66946007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hun/x1+If8/9DPpH+CguMI50rNhwKA17k6tcPGp1VD+bL2uTvzkeAhR/IBZO?=
 =?us-ascii?Q?vlPVHLU/gSW9Z6ItWc0r8cKaMWYK5Qk7p47V/wz2QZrj3ShN0vtWKko4gfra?=
 =?us-ascii?Q?BeDalF1f95fK3Va9o5fCByQj0afMsNI4P3xsfkuDt376WXiA49YokF8Txytz?=
 =?us-ascii?Q?cCk19KP77UHoecfbudSpV6gd5/i+s5yGsJHie5ydowXpQDG9HOXWOksKw8Dg?=
 =?us-ascii?Q?j0nTeBOlafQKpbI+k9o1d8s9ypXpm9LJe77P60YC4PNYcvZbJ8dhRfS4botU?=
 =?us-ascii?Q?QnfvWg09OygZdUAzs1FOFXF4S0anxWwcFoK/sJgWaAMiAz2hIxo5FlQb7lxM?=
 =?us-ascii?Q?uFYcv4NevsGj5UZFjcLzYhu11ShCa8XmvzpQP0wbEFtFtRXvpLVtf977wH79?=
 =?us-ascii?Q?MiIkoUNFlRQVWiJr9uW34zN4utx8YYpXn0ezz3Ag0+XXHaqFyZb+WKO4B89c?=
 =?us-ascii?Q?QnBIHvH5uYAF+nfjkfi6VjyZBPa/VzQ9TTNVj4sweuvcPn0l0INlrT/lojs2?=
 =?us-ascii?Q?EzE3C2PaiIlYQwFzwDJYbl3JPm7tnbkasZhO1Z3uapsDzZrSUbi52vHtobsu?=
 =?us-ascii?Q?ttMhB/7XsTkdl6lTYBbUl+4JyR476hOfXsDQhdgNJzYqz7ty62gxvOop4Rcx?=
 =?us-ascii?Q?nfY77hBL+U6k/FxEIYLXztlFR536/8r7ytMxK7ck9KQmUFqJXJdIEwTi8auq?=
 =?us-ascii?Q?BppVXRoQbdijSJAJFrJQ2/jK3TV2k9m/pDgedm45yar1Szd4JCGAPOUugAbi?=
 =?us-ascii?Q?mO7R2yIolWVzevxIfTgjl1+BltDn6x3L7rQYp8dpoEWLaiLZMYoS9RKnJuiC?=
 =?us-ascii?Q?Bs/NORNNA++aHK1hS+hc7rP4PV7JfWojIQ9f5kyEcPecc3hQWCF9JuNd+Kf7?=
 =?us-ascii?Q?OqPAX/r+314Qv/IJXWurj5gJ0kDsjRYjWRNZ3rwomCz8Qwb8pWO1/xROYnhz?=
 =?us-ascii?Q?ninEVfeqjMx2r73fmV8kNYewIYx6IhNpNqrMS5uXrv0i6VKOiIF1NDCGVxnE?=
 =?us-ascii?Q?+R+FAyh3jdpui1VUoqwez+0bomu/+imJLxNz8SzQC8r1ltF5PAnf/5rfUlYl?=
 =?us-ascii?Q?vK40trNHhn+XZEFXHMsCynt+lEr8ek5pFwuZzwxcvo/nMClnqvkFFdKNzQRL?=
 =?us-ascii?Q?RZ5pGOCRjkWH3I78lS5dUXC4GNZbxGjc71TxYJfbhHpmv3JLMMlGeMubHFCu?=
 =?us-ascii?Q?2YTee5FF+5um20RL9IHQ6z+0tyyLLNUJIRUwwKrNt2J0XJNl8CuaLWgPT3ZZ?=
 =?us-ascii?Q?gp2sul3XORQ7ZT95lYtIHbTO80SLSnCnWSlf9nd6ge9AsD712aMKVvYg1B+X?=
 =?us-ascii?Q?9/ELJbUhinmzvK9nmKTEToSAR9iauEkvY8jQBuSQNEflJphCrLrVJjhaibxO?=
 =?us-ascii?Q?dKNa2jk5Nm+htMH+D+nsjRZMzA7mDDojEVZJLe7LBlgp0PPxgqdSPe0BpNOa?=
 =?us-ascii?Q?BghQ7xZgr4c5H0VJBvymGsnhAhnH+8jwC4od2ZfB2eCBqJfAr8ChDCrnwcKn?=
 =?us-ascii?Q?GDlA9PnOQ/YqbEMNi+WbWu3DSHiCXe5DrH3iBk9e4Bnl1oOt3Vm50YoPYYuD?=
 =?us-ascii?Q?7gZ19GmtMytM/Gcu9eNCCt23jlsCmjE1XcVCOY2jLxliozfKGBU+MG88Oggl?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16cd9b1-c1f5-420f-935f-08dbb2c79b6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:04:18.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMNqpMY1cG41fOZoSre4KeTAMj5Y2fjEjhH175P9q/4pzmX3u7WUEeCZGBSvL1vNotyFfsl5B0uCsLy4tTn0YwM553xDqDR7JIYVCaYSadE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8743
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 5 Sep 2023, Tony Lindgren wrote:
> * Matthew Howell <matthew.howell@sealevel.com> [230905 16:43]:
> > On Tue, 5 Sep 2023, Tony Lindgren wrote:
> > > Maybe check if rmmod 8250_exar now somehow causes the following insmod
> > > 8250_exar attempts to fail?
> >
> > Could you clarify what you mean? It is at that stage that I normally see
> > the error in dmesg unless I have reverted the port id patch. In other
> > words, if I just load it as-is I get the error in question.
> >
> > Do you mean to try loading the installed kernel module with insmod?
> > If that is what you mean, I just tried loading the included binary with
> > insmod but did not get the error and it loaded correctly. I loaded it
> > with:
> >
> > sudo insmod /usr/lib/modules/6.5.0-1-MANJARO/kernel/drivers/tty/serial/8250/8250_exar.ko.zst
> 
> I meant maybe reloading 8250_exar fails. So the test I would do is build
> build a plain v6.5 kernel, boot it, modprobe 8250_exar, rmmod 8250_exar,
> and then again modprobe 8250_exar.

Sorry for the late reply, had some Manjaro/Arch specific issues installing 
the plain v6.5 kernel and so I switched over to Ubuntu 23.04. 

The results are as follows:

1. I confirmed I get the same behavior on Ubuntu as I do on Manjaro as far 
as compiling and loading 8250_exar from v6.5 using insmod. In this case, 
the running kernel was v6.2.

2. I installed the v6.5 kernel package and confirmed the issue does NOT 
occur 'out of the box'. In other words, the 8250_exar module 'bundled' / 
installed with the Ubuntu v6.5 kernel package does not have issues loading 
the ports.

3. I then attempted to insmod the 8250_exar module I built from the v6.5 
source. This still results in the same dmesg error.

4. I then built the entire v6.5 kernel from source and installed it on 
Ubuntu 23.04. I used the .config file from the Ubuntu v6.5 kernel. This 
behaves the same as the v6.5 kernel package. In other words, the 8250_exar 
module bundled / installed with the kernel has no issues, even when I 
compile it myself.

5. Finally, I tested to see if insmod vs modprobe was significant by 
unloading and reloading the installed / bundled 8250_exar with both 
modprobe and rmmod/insmod. There were no differences between the two 
methods. For insmod, I tried this against both the 8250_exar module in 
/lib/modules and the 8250_Exar module in the original source directory.   

In conclusion, it seems like the 8250_exar module works as expected when 
running against exactly the kernel it was built against, but fails when 
running against any other kernel, even if that kernel is practically 
identical. I also would have expected some symbol or symver error if the 
kernels actually differed in some meaningful way.

So it seems like this might not be an issue for typical 'users' of the 
kernel, but may impact people who need to build and load 8250_exar 
manually for whatever reason, unless I am just building the module 
incorrectly somehow. 

Any chance you could try building the module with your setup and then send 
it over? I changed the EXTRAVERSION and LOCALVERSION of my build such that 
the final version string is 6.5.0-090823-TESTING and I think your module 
would need to match for me to load it.

> So maybe the first modprobe 8250_exar works after boot, but the second
> modprobe 8250_exar won't?
> 
> > Do you see anything concerning or possibly incorrect with the way I am
> > building the 8250_exar module?
> 
> No I don't see how that would make a difference.
> 
> Regards,
> 
> Tony
> 
> 
