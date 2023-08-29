Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC2C6FA8F
	for <linux-serial@archiver.kernel.org>; Tue, 29 Aug 2023 13:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjH2Np7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjH2Npj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Aug 2023 09:45:39 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011001.outbound.protection.outlook.com [40.93.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E7E56
        for <linux-serial@vger.kernel.org>; Tue, 29 Aug 2023 06:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgwcfWCunE/wUz+qyuNNAvmecIdhjR5h11Av2n4pRHF0pP5Zd0ALXQnxBdAr9qcpdAQCATk3oWppyEmD1aX1LA7kDSMW052rKXCpqLpR1K6bsVL+qQLTR5ko+L+FoqKcxJlIm0AWpXDiV6SrMqETV5bdi755Tb/CTeI8ayaewhPR8grXbt+A+23ruiptMMokb4Vsp+jzBAtp6HPaP9tvCgy2Zm7UU8gkI/JRKO1OD4d4XPEfW1Up15u83kbY9NbKD4bFYdqVspLeuk1BSNCC8pSHzp08lBBkafdFmKxiK5ym7xWDZAwGL4IL2msRSp3LYw4+iRt8ycIdnne8cVh8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9L0Cqe7NDwjdwS7OfodHKXbty/NuWUXK8fKmTEZVAk=;
 b=W0Kk2JuqeK7Rnw27lh+BCQjoWV3jXzJfzettY4pd7PNs+6ncXTuwjDoybquKCfuFb3fN5N/yDuyJpRXNfXYdGoXu2LA2NFB0u93MtOYvi2G4QDce/5O0KsgCAXlQu3caQKjEQ/qXJaVrobOjBUbqKovyBvrk7fGVHT6QkE8C1CyNb5xACNVEka+dqMaMfpMFd4JJYOSmP3lRQo29uQnQlGT5Q913J/vfqA3RllU3c/lfJJFgZqHE4Faip5HS8MVry9C5XXy0/EhBGvY3QP/85b5J2SjejpHHu28wxKmahlXq7ISYNsVLaMUCpbGdtOkWrb5q8ho8bNqZEiXF4J6Sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9L0Cqe7NDwjdwS7OfodHKXbty/NuWUXK8fKmTEZVAk=;
 b=Z8csAGruhGcXT2yN7EYivGGXb6uuZWyFr3I7Yn6wVt2MBAO3mUzSMaD1uRe8ZaM2lgx5gSiN6Ukh5bi2zLqJwlTwoZtWc0cp2Kr+XaNJvAr3ozTSXhAwIMVCitHzuxdgHFUCtM3N+j1iL1YQhM+zJfMJyBbGbd3S6dgEI9SqHDhddJ5qCUdjntFIRNWvGq4t4eXMRifSHBJqOf3QjchvK6xEiS7WTzlkTraY15+3tHoWAh+YSoamHnB3rp5c+4KEc+AjtC14VEtMmbKF+crUMuTFrDfQCHOuPXrgXyrBx/HUsFfhVT8wl7CTV8WpW9CQmP9/YVGOSBSESSqXPA+PEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by BY3PR05MB8161.namprd05.prod.outlook.com (2603:10b6:a03:3b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 13:42:50 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 13:42:49 +0000
Date:   Tue, 29 Aug 2023 09:42:46 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
In-Reply-To: <20230829035245.GF11662@atomide.com>
Message-ID: <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com> <20230829035245.GF11662@atomide.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN8PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:408:70::15) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|BY3PR05MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c43e182-32be-4e1e-c312-08dba895d5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RImjN+bGy5BLxQz4dyl67DmvCiWcqiUnQYbUWKcgoMzHMtRC+y0Fav+HFFR6HYN26Efy8Frc4IpKknWTTfhWC8/Y2crXPg5YM7hQlSJKEN7WixYnM251lGrUqK0eWZTiH8b+1O2sRB7f44vcqANNvVG3Ppbdc80NJ8YZm7RC2mxjtJwOp++bmiA+MiPqlXU9fkDbBpcd3jQW8eb72P/q5iCpdIjkWwJI5YJFGzlun8Gq6a6sJ0xLZ105OfpGT/uJSGtKQp3S5i6UWF2kC0Gdt5vzug3jIzXApolU7+y7/62BWAm1ZKeWKS5ssxkg4T65gz89fiEVRwGcyo24KxTia//eRPIdR/ib8DzNGl6dXVWzMsUp2vnTmN8AN7hRWHh8WvMzP+k3HArujbzxf6Ok0CftBjkxodsCsuxSUtsZY/TGGqdJrn+F9VeJzsVtxtsHOqZBZxL4soHzHfs/VIMfCwz9KwhYZyFNHmK/MXNplMJ8CQckXyN88O4as4hFZRbaNdKNN/aRvIYIA01HNpnUqa/t16psJzjznLVpvqRH7FLbT/8KUqi0021rzUau5bncgB2A8P1ptS6LD/6SPuG3ZEeDwB/3q/QpQNcIjMDSSVJngrAE3m0pXU/l/LSJc/hJWI1Z2e3nzlaS9UWN/tRxEi5X3JPnVftR6sgr+toqtkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39850400004)(346002)(376002)(451199024)(186009)(1800799009)(6486002)(6506007)(6512007)(6666004)(478600001)(2616005)(83380400001)(26005)(2906002)(316002)(6916009)(66556008)(66946007)(66476007)(107886003)(5660300002)(44832011)(41300700001)(8936002)(8676002)(4326008)(86362001)(36756003)(38100700002)(12101799020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qhQGsFMCCx9SI29ZXVR9jbAhOdlKc0fnRvCpNBednI0VpWenfOg5r9IZeEMi?=
 =?us-ascii?Q?ulmEqk16EcEuwVNZw4UEaQqbyLUkHUb7uDtUM86HM38n8NnCC5pyfA/dtRtx?=
 =?us-ascii?Q?u4ZG2w/zadSZhhcBasuAxGhmxn3QH6qTQGQe863pCeaI28/m7eA5ud0XLzgh?=
 =?us-ascii?Q?+sPG7RqjlvvOQS967z+zenQ6UPwW8JC06nqHwLxic9zn/YqGud6t8XE0FHw6?=
 =?us-ascii?Q?JPVX7h1C8Kr7FLIG0HUd69140gixFZmyx193ilShkzex9WVpZIwfED4mHGs2?=
 =?us-ascii?Q?HgprBWqAB/JXEfB9l1jlM2fhvsmfErcX2PZfBXwxRyBH9/MqJjf84pRD6YfS?=
 =?us-ascii?Q?Sxl4sspHix1NZHRVvxzTTE3diVoA5vMtlz0osIGAEjzes5HCyMiM2GEbmetK?=
 =?us-ascii?Q?/G38V9KrsWl/apalTn6ZgxhhPPnUSqt0PKzM+hxJGFPCf17wGoab8QPLSn89?=
 =?us-ascii?Q?5eFHYyXXteiNAGrvli+U4+IZO/ypGzzNgl85Sa2yJrWG3XpbJ+cfiMRMgTUV?=
 =?us-ascii?Q?TyFviBOpOUr1r0PhK8+UKNWvIWiwESB9u8eVZPC35jRqEtk7mMg/Y65ccg00?=
 =?us-ascii?Q?G2FcFu1sodh6iZwRGFMYZgyPwpi+7GsCo7xc0nJ/1R9HgWBULFun7U+owvpF?=
 =?us-ascii?Q?+dNcm55R8FT/R9/yat24EBH8JMQEWA7LCubOs83Hfiub4RIxPwiWYy0Y/wLu?=
 =?us-ascii?Q?uCjrBJ1FN0gLyMODyC97emN5px5g060vlCXUlExIkYPUVnpQUEmhh7MtYsb/?=
 =?us-ascii?Q?3RD2enHpkUd8Ivg1EXzF9gTjjbElj/DfyojNEdV7A1ZQeLuTrzHLdOEOOG2U?=
 =?us-ascii?Q?T69J+pKd5OOPo0NTUClVST39aAwTCjhAVFYNjjC9AN/VaLCnurW3HlEs/sMu?=
 =?us-ascii?Q?6juIjpI5Uk3PWmeqW1w/iwxeYOnvIrDaR/O7tWTKCFg1vMKhHUKi/HqZl/JQ?=
 =?us-ascii?Q?zQD2sgUVNklUINBTx1k4MrM/FL65k22nCufuhkPvhjn0GyOrU58rmzew2IAD?=
 =?us-ascii?Q?umbDX5fIekRJePWBOUfBpSxEZ4x1qgXwBwJOJwLp/rjSYSFg8tbApWfDdewZ?=
 =?us-ascii?Q?/bO1DU/zDweWKQbzoJV2JNXhln0GpGAaSs8vGJZG0UOx67HPLhc8KrLg5OZB?=
 =?us-ascii?Q?4LKV14F0IZT74awswAxn/qjwYb7eegUa0RcoWivoPZPIDBKf+rX8rvveL867?=
 =?us-ascii?Q?0lV3ZUNYNHLaP3MXweaR5XLsa4LJh64SyscQ+aVHvyqRxs/OH52dX5bcMxIr?=
 =?us-ascii?Q?XtHaTNoRqmIFyaBzQ5GgFRmW7rwLf4A7iNKlw5UGqa1y4sPR4tF3YoGjboMH?=
 =?us-ascii?Q?pOGIHFt+mF23dcSYtRQ/X9fhxdRIBabH+p9Yq5F0oKdTO7M6rAx/y+fNb4/s?=
 =?us-ascii?Q?7ju/4+Bgpdfqp1cRAwtgtpN5aS9OW/ObDvD9YbIDOQIx/j2VhsUT6EZtqv2O?=
 =?us-ascii?Q?LNLDmlRjwwlj0CamfhJjMHIaMHzyzf34LH6g4iAbyrmjwVM7H5dGMGweih2Z?=
 =?us-ascii?Q?dDesC7WHGD1CFWRsQRtIT9v2GxBvET57/JDC793XGeBRk9XF1nR0jNUehpu9?=
 =?us-ascii?Q?UHfT5dlZo0jp3Gl7VZD3eiu3syfSA3mczFNrrHXzXkkZqRCItV+Qp8YHtlaX?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c43e182-32be-4e1e-c312-08dba895d5bc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:42:49.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKFpdR9getHjwBcBKkQfQe4NOj5AUAJS5Vs5i1yQ4qswkPOZfbit7KxH4NXryTZUf6wD+DcTYozMQFHe4n05TaiXP9zJ+Ag75bJweKzJNvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8161
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 29 Aug 2023, Tony Lindgren wrote:

> Hi,
> 
> * Matthew Howell <matthew.howell@sealevel.com> [230828 20:41]:
> > From: Matthew Howell <matthew.howell@sealevel.com>
> > XR17V35X cards seemingly unable to register serial port. Confirmed on
> > Sealevel 7202C, 7204EC, and Exar XR17V352 reference board.
> > dmesg states: "Couldn't register serial port 0, irq 24, type 2, error -22"
> >
> > I first identified the problem when I pulled down 6.6-rc1 and I was able
> > to trace it to d962de6ae51f9b76ad736220077cda83084090b1. I understand that this
> > commit is noted as being reverted in 1ef2c2df1199, but I was only able to
> > resolve the issue by reverting d962de6ae51f myself using this patch.
> 
> Thanks for the report. Do you maybe mean 6.5-rc1 instead of 6.6-rc1 above?

Apologies, I meant 6.5, no RC. Specifically, I first found this issue on 
the v6.5 tag (2dde18cd1d8f). I then rolled back until I traced the issue 
down to the patch in question (d962de6ae51f). Even more specifically, 
according to my test notes I tested the following commits, with results as 
indicated:

04c7f60ca477ffbf7b7910320482335050f0d23a -> Not working
3d9e6f556e235ddcdc9f73600fdd46fe1736b090 -> Not working
3c4f8333b582487a2d1e02171f1465531cde53e3 -> Not working
a4a79e03bab57729bd8046d22bf3666912e586fb -> Not working
1ef2c2df11997b8135f34adcf2c200d3b4aacbe9 -> Not working
d962de6ae51f9b76ad736220077cda83084090b1 -> Not working
282069845af388b08d622ad192b831dcd0549c62 -> Working
e6d34ced01bc3aaad616b9446bbaa96cd04617c4 -> Working
748c5ea8b8796ae8ee80b8d3a3d940570b588d59 -> Working
868a9fd9480785952336e5f119e1f75877c423a8 -> Working

> > If so, I suspect the issue you are reporting got already fixed during the
> -rc cycle for v6.5 kernel.
> 
> > I suggest reverting using this patch unless someone more knowledgeable
> > about what these changes actually do has a better suggestion.
> 
> Can you please test with v6.5 kernel? It has the two fixes below that
> sounds like you may have been missing:
> 
> a4a79e03bab5 ("serial: core: Revert port_id use")
> 04c7f60ca477 ("serial: core: Fix serial core port id, including multiport devices")
> 
> Note how commit a4a79e03bab5 already did a partial revert of what you're
> suggesting.
> 
> If you already have these two commits, then let's investigate further to
> see what might be still wrong.

Looking at the results in my notes (see above), I had tested those 
two commits specifically and found they still had the same issue.

What I can say for certain is that of the commits I have tested: 

1) Commits before d962de6ae51f work on the hardware I have tested 
2) Commits after d962de6ae51f don't work on the hardware I have tested
3) Pulling v6.5 and reverting d962de6ae51f with git revert resolves the 
issue

> Regards,
> 
> Tony
> 
