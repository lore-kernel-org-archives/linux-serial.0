Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA92CD13D2
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 15:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRPSm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjIRPSl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 11:18:41 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013013.outbound.protection.outlook.com [52.101.49.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479B0E75
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 08:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EorAJOcqLHejOZFsbQFrXdYtx0gZVyfvo1B+NCR3xY2KUGCY+W/PFE8R+xu/eOYikmAZfjIJ2K/xrhhyksU5fjzJYC0a1qHyFk6YlXvEe+qnCb7Jeop35wKaDhdqafneujNjo9V6OjqpTdoykyDVqgbi1E8frrvk1Vl1W2M3ABItylsS4Q1MbJ61yg1SF62jZcP4zyZxko8kEqcYlrJrqElsKwiScXRlPsQi2s3tuQiBHKH7kPeAwxd80PbT6TBv0Beeh7llPKxg6pEHlu1SHk+o7GQJcyjutT8x2Ht2T6RNW8EWi8Uxp6GLTxzu7lIW8LzM0HgAbdZWdNI1a4mmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M0EaIeuf2L/WgQka9h+IZzVyy7vLZBOMLpX0qx8lBM=;
 b=SExnsUQskkUUjqOSqNMgAsvHKicC/0+bOjUZY4iWbwg0l5oBteqzGaSAznnjK8qhBMebxGauAFFjWczqt6zEieF+3di7mCV1fF8wU3czizaa+wC6swtUkZKdhehZPvfi0B5LlA8zKASEIkkoFmrL7yYfTg8LyKOTwZM5bxmKvXw281q93xSegMKTHa5iv1b8fXyB92QN7fJA6fDsaNzkAeDeoHYyGz+yuQd9grhIkHQe9HMdxaVMuuLNXo9gLRyVdM2mm35OiGikb6BiXXdcVIN50sKvGQPHo+dy+XbByKOUJBXbollcmCUGS70ECFrUjjwqU4YLqrfvoAa5EAzHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M0EaIeuf2L/WgQka9h+IZzVyy7vLZBOMLpX0qx8lBM=;
 b=H2mcO+ncz5T10qkqjH5hb68k5wqqgDtkwFXfDiduRbqAIurbyxxv8kCi/JXPiFP4Y3snlhb84tV9CtHJTGdEPQgWec6LASxUZOxaQfSmq7W1gFR44eQdvZvXwPpU/LutXyvVLqrnk97oKvFtZyZWjVZ07+hMWvK/x0LBDuyTR171FmapVqMqSsC8C2zZSjEo9mVi/yTShPSYgE97xXWT1VRE6Lf/Jx2q91USmOp1F4BxsN9LKuMaCFD5XGzZLgYDv+hOikp3v3C6yb+6230ymyLmQzvUPeJ8gD1PW4aqmgZHjdOxTyBs+KoYKarz9da7MlevCyca1UDYQm2M2OXgZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SJ0PR05MB8183.namprd05.prod.outlook.com (2603:10b6:a03:399::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 14:51:31 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:51:31 +0000
Date:   Mon, 18 Sep 2023 10:51:25 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V5 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
In-Reply-To: <2023091836-distract-lend-e606@gregkh>
Message-ID: <64fe4fc6-ecb3-9172-4468-e58335b246ea@sealevel.com>
References: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com> <ZQNZJwJoad0EkIYL@smile.fi.intel.com> <15c38a1b-65ed-54db-c973-0ae995e201d4@sealevel.com> <2023091836-distract-lend-e606@gregkh>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:408:112::24) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SJ0PR05MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dec756-685f-4300-aa8c-08dbb856beb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qogJ47WYSQj0vzaXPQka5BL5TPKv/1LKNMLy7a99al4qqeI1baZ72gdxlB3Q7Lnl4PW31qjykc/PLPeQjCAoQgBJbevkScgGui0KAz0y+ntmeC0Flb3R4HrjAmynI8Z+djIhwgQ+ad5p+VMgoeAGb7nBMnss9xSZpbcW4UludDdgJq4FBGOlPvSAS6neGO7gf9X5uCJx1+Wz2YI6nqvvjcSOhsquRTDicQcvQ5GuwByoi27PKyWzc0LT+Xe6728LHpdM4kOLK9JuvY0wXYr3druLmIqX0Oce/dwECDlTvllhOPA/eVh2bbJI+LpzKK+A38dp0JAVNAfsoUuqapnof2mIKmJxXoHIk1TpIWP1TBqByclzbqF0tbW5WAE4mDDTlNFVuew/sEuQVYWMqv+agCX5UqMEDljGic/Eoybxe+iB85kkh+eHxpGndAgaptSKNrqGJu20WoqjVREHsxOIYMy0GY+6nI+a+nPiHkxMuBt8gZVxmL7pR1YgvHSVJ0azW9WADNdkWTiYmOBofDxqyKp0dzGCLBd3TL7qwOcNelIKJeUPucgGjlnbNYlFuPdKempTXsi9oDYNDqyeX3e46boUGYGL/QEXlETclQy+0YOeKGJtn6VfORXhYIY3SaYewkbUtzR5078JRX269IRZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39850400004)(396003)(346002)(1800799009)(451199024)(186009)(31686004)(36756003)(38100700002)(31696002)(86362001)(6486002)(6506007)(478600001)(2906002)(44832011)(5660300002)(66556008)(66476007)(54906003)(66946007)(8936002)(8676002)(6666004)(4326008)(966005)(6512007)(41300700001)(316002)(6916009)(26005)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2M6gEQU94b7V5jHJVMhLsRr++jr87EE9HCbJ2Ld3dv8WyKO20NgUSWj47ZKY?=
 =?us-ascii?Q?vMsi4xHXQGFy6MqlL/16/AEm8yQCpbtqYySLUM9FfRzlMeE7RZjx9KIK8LlI?=
 =?us-ascii?Q?gZtaE/X5XmcHi2+65wV2B52z46Z0ykd6Kb4A6yIVFV9BQm7KSaRAWAk+haM3?=
 =?us-ascii?Q?0OQXCX+xamg0SG3Hahbz2i64C5R7dI7J47TD2zGRduqwyuoQYUYsF1570FaB?=
 =?us-ascii?Q?8EhiBvFFEZZHXwJpXNAlPA4/oL4q3xw/IWqzIOdHBSrG2njcS8p1KRw3DnPi?=
 =?us-ascii?Q?C8NjED/3mPJzz+ehcvX5UcxcUj3tc08X9aefdvXp4iiALD3JlIoL9+KiiEpU?=
 =?us-ascii?Q?vhgdw/Fb5DtdOOpblx+XtHzqZ9+N8YTSGrHlQhz2/Vn0UJRu73+IbkzWp+yk?=
 =?us-ascii?Q?KLhqD81h0IOGgoyPUPR4RHBOzZsrqZYSs+uz+y0HlgcSTEXjw67sih4C4fHJ?=
 =?us-ascii?Q?6ZhdBANm8kjgRGTMJ2iQBpmGu+gue+DR0ZJCwByhv4sYkepIRhioHzmwd85z?=
 =?us-ascii?Q?R5NV2TsOr4hXOGKHG1lpodKA986/j/9n2DKzoF5nPoBBo6FyJ6AVkFzXFoP3?=
 =?us-ascii?Q?KeecPVWRTIigBbuDNlshJN1XIx0J2ySrNkijOWDgRSnhu4+JEo1QUSDJeXS+?=
 =?us-ascii?Q?2CZAs7nr7aXEJ0mA4GzYC4LaD5lEehFouP9uADeEUUaJDy3t2+9ETBIc6v7P?=
 =?us-ascii?Q?iExJagHNvxtRrqFsbMmcV6VNYADxl2HNM2JzezixBQ9BBcUueEV8z9Tofg/Z?=
 =?us-ascii?Q?mmwo6eHq0Y0HiLG+Q3l8wVdAZ3/kE/QnfUCahUD9OEuZ7ulndXc+o8pRoxaU?=
 =?us-ascii?Q?uhnC4t2NFDxEX2tJFpoiiVA7x9As6xlkNhjN/EBezOMRp5Wv5dvSWSki2Phy?=
 =?us-ascii?Q?p0sBXRDZv/esd2T9WMjXUfDrtW/bb5N1TpQo6+R65/ReuDlwAvbHr9oJ76xJ?=
 =?us-ascii?Q?BgEsd8sEYSu+N7NzFaj595p/XxRPhzUFtWibtsP3+FGt7YV8bRzgoLm4h0gG?=
 =?us-ascii?Q?IWqZ9lFkkrzYd8Q9hA1TdKl8TCMznCP123UT/fsDiLibYm6wjIhtjSziaGwm?=
 =?us-ascii?Q?PcD7IgieZelMgU+mjaHYO/X9DLjMkQyMkXBuzoEZMt2gsANSuZqO17WsypAN?=
 =?us-ascii?Q?/s+42JkSbDqy6t9WJaxaKe4+H6wSBmDtAmfc00e1VK/+ldUp/i9cRLL6tcCP?=
 =?us-ascii?Q?jR1oliBwCtmqSL/rzg0OXiTnEShgu6CVthMjaSkYyKK8oZdyVGMiYlHjAj9E?=
 =?us-ascii?Q?TIYFpNH8NVULWWlY/byELndu5qYYoayB+NViNvSMjVaancFiXaKjTs5VGwpA?=
 =?us-ascii?Q?Nl2eaoEYSuzF6Cx5yOwEpt6hgq7sUveEOAJCd1jm+jqgKdgWXt4XkMe8V1MH?=
 =?us-ascii?Q?K5PvTJdkmcoA8bf3TNSFSZNIF6Vwmmkw8TUK42sNOpPyTKZj6ZIXSihT+dGm?=
 =?us-ascii?Q?QTH4zuY3XrF9WejQt0t38pjq38hTDyQ4Ob9z8fw4wrzz+N6sjLycZ6+jrjDe?=
 =?us-ascii?Q?CcPapoYlwBfS2/TictHG+PpIvbtx1pN5W3ZgcfFHPO9CjwJTOgJoyNSU0jTm?=
 =?us-ascii?Q?hcBtaegNINn4a9+1rsPdhm4DHFXD6XWio/3qaj6aBN7B6VcE8ZwrCU3cy9xj?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dec756-685f-4300-aa8c-08dbb856beb1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:51:31.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsMnQYuFYaKVczTiulWTLVwOttSbJ6PYn0kBkQhc9gPauQSCom+phmgL8XT6IO2krppyznYxZa86HtaXn6vvG+34wQTl4DN4EwL9r3ZrMWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8183
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Mon, 18 Sep 2023, Greg KH wrote:
> On Thu, Sep 14, 2023 at 03:51:26PM -0400, Matthew Howell wrote:
> > On Thu, 14 Sep 2023, Andy Shevchenko wrote:
> > > On Thu, Sep 14, 2023 at 08:28:47AM -0400, Matthew Howell wrote:
> > > > From: Matthew Howell <matthew.howell@sealevel.com>
> > > >
> > > > Hardware ID of Sealevel 7xxxC cards changed prior to release. This has rendered 14ee78d5932a redundant.
> > >
> > > Too long line.
> > >
> > > > Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> > > >
> > > > This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> > > >
> > > > Link: https://lore.kernel.org/all/72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com/T/
> > > > Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> > > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > >
> > > The patch 1 and patch 2 have not been linked via email, so mail archives and
> > > mail clients do not see this as a thread. I suggest to use `git send-email` for
> > > patches. With --thread option (which I believe should be default) it chains
> > > the mails it sends.
> >
> > I have not seen any way to setup git send-mail with this email as git
> > send-email seems to lack OAUTH2. If you can set it up with OAUTH2 & O365
> > I have not been able to find any documentation or guides on how to do
> > this.
> 
> If you are using mutt, just respond to the first patch with the second
> one.  Otherwise our tools really don't like dis-joined patch series and
> I have to dig them out by hand :(

I understand. I've been doing that (but in Alpine), it just seems like 
it failed to thread on the most recent submissions for some reason, but 
I'm not sure why. I will take a look at the headers next time before 
sending the reply to make sure it is adding the in-reply-to header 
correctly.

> I'll do so for this one, but in the future, please fix up.
> 
> thanks,
> 
> greg k-h
> 
