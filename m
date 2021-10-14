Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6129C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE12D610D0
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 10:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNKaW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 06:30:22 -0400
Received: from mail-db8eur05on2111.outbound.protection.outlook.com ([40.107.20.111]:9057
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230017AbhJNKaW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 06:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFq5R0Y5jlTbeCeI5I10dRddxoFgTjxkIo/VUdjVIbC46hgx8IZ0w1uhB1DVK9IR4ZmxwLpg5p0UIE/4bLCMJ0vwH6ZxGyHW63ejvM9ZfohFGK8kZnEKI10abYDPGaoz+TS/muhVKBB8RLn402VleBpkRBFKd40iOh7tXCXQ6b8mF9aVKOpob2PWxXAnXDF22+wUdnKgDzG7lwMnhWEPVEeAbkhUbdNfmhQ9pWvC77jggSH2/l/iOaQ5JEaNy7NbjO489jguCH1+BuXRVrc4ZIQxoEWbBeHTLxthul9b+ht9SA4CMzRIqUD7w60iPQ2qeqNeBbDN08uhzmhHjo4IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgrkNPNWGKt1PIxU+CyUZN/ENms94mGLvHHk+voJGZs=;
 b=aQO5TjZyXSdyO1kjj+NuMsicKZsurpMih88RqKE63rmGKlUFMXSvPlRLlGli5s/Ef1gFtcoc1yIKdOnGW8kwuO//MD8c+1yvxFcWvhxfUFX6AEtRnOtYqnNM5F1EjRCS8M8aALVU0RpIaZS/3J4M0Qw6IriQa1VQxOU2a/R0T97uGn88koVDp6UmUKp2dXdtuLYxQ0QiFEZZaTOGjbGoX+6YVEKRyTp+oW8Wxprd+VlgOp3WJYsPbb90N/Cnqet2bl63gB80CFNOMbufanL2XhmWAdDfxC0/FegMsvw1d4iM3b0MTQTeJffqaP2SHaq2QvzyP/Bs2OqHhYejwsBC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgrkNPNWGKt1PIxU+CyUZN/ENms94mGLvHHk+voJGZs=;
 b=PN7zStJKMtsKQXwCWPEqaKPcg+RP9/5UlRn0q9azKadH9t2cCea0fQnPBLrePOSN3zHi8w1c8VxjtNnYbSSIIWx5uqhcCndO0/TTofgIdog1qzCmKnx/VlY61QbNpUGBCU67M/vT4Dy9X3qs7fsxNJTEY4trfbqssMDX4fV/R+c=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR05MB3243.eurprd05.prod.outlook.com (2603:10a6:7:2e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 10:28:01 +0000
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c]) by HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c%4]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 10:28:01 +0000
Date:   Thu, 14 Oct 2021 12:28:00 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: imx: fix crash when un/re-binding console
Message-ID: <20211014102800.GC554920@francesco-nb.int.toradex.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
 <20211014071053.568598-2-francesco.dolcini@toradex.com>
 <YWfdY/ws353nJEiE@kroah.com>
 <20211014080153.GA554920@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014080153.GA554920@francesco-nb.int.toradex.com>
X-ClientProxiedBy: ZR0P278CA0148.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::23) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0148.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Thu, 14 Oct 2021 10:28:01 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 21BD010A3840; Thu, 14 Oct 2021 12:28:00 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40941e55-ee68-47af-71b9-08d98efd4c81
X-MS-TrafficTypeDiagnostic: HE1PR05MB3243:
X-Microsoft-Antispam-PRVS: <HE1PR05MB324359FD232ECD3B0726195AE2B89@HE1PR05MB3243.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XLUiy616fh/09zpodd9DzGvEGVLWmTaQNYKlBNvjOZYXGkSwYGGrCPQGBa/ezuaNY3DdjfK7SOGzDVziAYl5myyJSEs7gBmvtGENngwLlsILyLk9dlLAi9mLkZfHWqHLoB0fZh7ZLWpMpvtRv9VBYzxgay1IsOkp9xMcO/0aafAxhNM5SvBT77wntKNuSydwvVp2Qv6/gWgLTiufqMNfd7KQQ0pX+liu23g1hfTzpttu5vYZW73TJrdwdjNuoHoIaS+jcGFhg5idTv0RIoIhqP/aO3OBku6ROMFFROim0YkPRXtFUEx6126rlQ+xyBrQBfYXBPKZ+QQA4fFt/HxNKcD1SO0g7wwASGq0y2DmgJ6S6O47c6Vh9WyoqPQpwTrRZOtzca4iGgHCfzmlh6XjM43ETcBgJNjpdB0P7YJ3+aeULDLod5tTdp6GkT287rCAeIDcm41m/5YYP+w6NAMDZzPpmkV4mTVTEQhhg5WzJMmtf9wpx4PJhyP5QM4FfKCcCnQ6bMa6sICS0qeWJupcntTY6FkVkLSjHwHFyDKQeyLGfp2x1vhjRaMVKgGSD5k3CKZEX9Wgvl2TAvVsgvQjnHq2io0bUluke0FHawKEXZ7TFctqokxPjfREomtAFZWmZiOsT3XfNt3WE1rAbvRv49PRHMufO4s+vSrzZUVmWibZkTJ6EdQ8lFuhMeOdE2BQRMLGhd/yjLZGR6Ct/JpWAZi3zZcvrxWlUG7nHhlEet0dazepIpzeUUsH2qTo3RdOyLnFmwCCMNd5LE3BiqoQBTqN8uApBRjS3bha/PQU90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(4326008)(66556008)(66946007)(8936002)(110136005)(44832011)(38350700002)(508600001)(33656002)(66476007)(38100700002)(8676002)(316002)(2906002)(54906003)(52116002)(42186006)(5660300002)(1076003)(26005)(7416002)(83380400001)(86362001)(6266002)(966005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c8gNge2IyZDlJUjs73E9DnMSF3dyG4kZ/m3KQ+zd+EikmVmbpDm1N//Lf5Ln?=
 =?us-ascii?Q?JY1zXwghBv6pUBQKL3qMRolQ+QVzHOsF22egMG/rFqwWJuimr+yE1RoU9gEA?=
 =?us-ascii?Q?VxpaZr6n6JFts8m/fLWnhxHzd/TMywzXBxaIN6oP/yr7hCqhS5RJxsBb5EB2?=
 =?us-ascii?Q?w3Y9SrboGrgnLyWhF2zuMV6DkyE2jcjQehuZLy0lM6zQ29H2/HzaqikEygS2?=
 =?us-ascii?Q?W5MZ183D579YjOCOBSJycIVx5i+ImXWzP3yFDSjhvGmNUaDU0U2/5zYW/ybZ?=
 =?us-ascii?Q?6xH8GKtoVcQ42WAf+bBTwece7HkGN8iHtWXpWoiCA0/JO+hIMq2IhYGfuj7I?=
 =?us-ascii?Q?mVMDMYXmrXkoDtj5IgyRufEfglRkdCMiziwTOD2RsXtXjzO9SS8v7OYfwZkk?=
 =?us-ascii?Q?jm4H22SJSyAjt0Ttvkt5GaoeyXGhAwIbmd4YPqQGcpUhzavRB8i7Tg8BuUwc?=
 =?us-ascii?Q?mJBFXrHvP6ic1gC5MMDwAmofVvF/TXB2xnJUf45vxg5YmD06MCw+bjTOkvzJ?=
 =?us-ascii?Q?94UbY6Q4Q7ejg09QyskCAsOfAuq/Kk5SxWCVUbrG7slsms/8e3D1jDFyUwuc?=
 =?us-ascii?Q?BnQvEDSh71r27q+H+JOZx4tUoKF8TR9Wszy1QQs7ManzL1yBq80I44aEfR3A?=
 =?us-ascii?Q?x0OYVYFTF1RQh8kqsOFyEEEYgOFcJiYdHI414t8iBRb2jkk9L5+geERQwvVl?=
 =?us-ascii?Q?mCpYSkRR/3gK13RA11i5yyvS1ruhJCOBkRB2bLKiEVjqhnzaKiyVAL/eOUem?=
 =?us-ascii?Q?FYvp4AdGqn+Jp+s96aTUG0ldjWsqzdJjwYR2ebjmAJbQ4LQPA1eZ+NKJXsut?=
 =?us-ascii?Q?otH9/J7iqQQvOlH34DgYGlDV6FcIQ/b36ncGlUDipcbNnpbsC0Mz6PiWDu1M?=
 =?us-ascii?Q?VlttugYszW54mw96GJpjY6yn7tks4yO9ZchfeZHr5VYTXAqSROxBtbqBZOGu?=
 =?us-ascii?Q?zfnIBvVFOyH7pNQv31yTA0e59SnccpZRx4+JW+hNitAfY72uTOp1AjNkmRmm?=
 =?us-ascii?Q?p0pX7cWK9QWC+IpyTEcDQ6vkPIEZ95X6PhIlHrZY2nzAf0HENLp20GLhC99l?=
 =?us-ascii?Q?VdqRTfKktfnXJz/tPOrf9ezdnvz5oc+IBqRVDOnY+ZzeYDXIsrseIXe2CBRU?=
 =?us-ascii?Q?kSCQUpTw8ELocMszKtEzXPy707uDYWSzcX25dt/Uj7Dx3uBNg3wlU8LN8lyd?=
 =?us-ascii?Q?SURUgPVY5xQt53aEge6TIduwsPCN2u9c8cd8lN2F0JGJ6ppjXb9Siljv9v0p?=
 =?us-ascii?Q?qid/2+PSeBmRk9ezuB+1xPBJ6jKw/BjBD5Ki98hzPwM8lLXF7VAWrd3ijKRc?=
 =?us-ascii?Q?zj2z36882sfH6BEKrgbjrH7A?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40941e55-ee68-47af-71b9-08d98efd4c81
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 10:28:01.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPhX5QsdLHTR8j2s2jPwJJngB+t6nVxmT0HS4g2aRkgpxDI8VQkjLe8fJE1fzjLugA167GnexVSELLJOv7s08CvPyjHOtlsM8WxSDh5cARk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3243
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 14, 2021 at 10:01:53AM +0200, Francesco Dolcini wrote:
> Hello Greg,
> 
> On Thu, Oct 14, 2021 at 09:33:55AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 14, 2021 at 09:10:52AM +0200, Francesco Dolcini wrote:
> > > From: Stefan Agner <stefan@agner.ch>
> > > 
> > > If the device used as a serial console gets un/re-binded, then
> > > register_console() will call imx_uart_setup_console() again.
> > > Drop __init so that imx_uart_setup_console() can be safely called
> > > at runtime.
> > > 
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  drivers/tty/serial/imx.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > What commit does this "fix"?
> 
> root@colibri-imx6ull-06746657:~# cat /sys/devices/virtual/tty/console/active 
> tty1 ttymxc0
> root@colibri-imx6ull-06746657:~# echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
> root@colibri-imx6ull-06746657:~# echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
> 
> struct console ->setup is called at that time, but imx_uart_console_setup() is gone ...

This specific way I described here to reproduce the issue was introduced with
 a3cb39d258ef serial: core: Allow detach and attach serial device for console

that is kernel 5.9+

(Andy added to to:)

But the original report was about bind/unbind of the uart driver, I guess this is possible since
way more time.

> 
> According to the original report from Stefan the issue is the same with unbind/bind of the console,
> see https://marc.info/?l=linux-serial&m=154221779312036&w=2.
> 
> 
> > Should this go to stable kernels?  If so, how far back?
> This is present also in 4.19 kernel, I feel like the issue is there since it is possible to unbind
> a console driver (since ever considering the current LTS releases?). I could
> investigate this a little bit more.
> 
> We have this patch in our kernel branch since 3 years but for some reason we never managed to upstream it.
> 
> 
> Francesco
