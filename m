Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E0C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1A160C49
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 09:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJNJOt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 05:14:49 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com ([40.107.20.118]:45665
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhJNJOt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 05:14:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnsdIJStLnPaUvzIMMRL0QwMR2lX81ZQ8FSLR++r9axnaijFpVk4Q59vKDnmbmhpK2HnPAcOLp75BElXVFB2m4vkDnlQCHsolKcXpvVZdhUoSxXKsLK+Y6Wquxxkzb1UQYcjNnwrjbMq/BzHacQyZbp++rykiDM11V29f4TesaGKEiWH5veBiGYRhUC12gx2fFJARuV2xzuqhu7EzLcfJE2dMQ6li4ziN0jk+goRZAlI9tQtyBecaR9p7I2RwvErFtiLmLRxQ9FkfOp7sJZtUzBTgmJh/rVIVGXGVQ+2e67Od9lYplDlNOsRulqhe9sH1X90ttRKzTqjXaBaCY2gRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlSqpo5ZbCTFf1mw+JibKsseS5XSSvIInmNcZWCjsRc=;
 b=bLVZTfpzhu2G0G2bdGoP6DkFhKdfYIQI16hYEX+hcJY31yYKsZB3gFJ1Q53WslWY2bSPu0jR0off+QZqzMUHlTrX0PS9lxUciDWCSzfrDW3woffox5c4PJi0hYSFf4CG76UOLMDOPiNxQKHGmTru6fcBrF5mwI9SYjRgAJWlLM5R7k3AXnXdJy5DRSaU8B3OKnvO2H4fj1SC9WLoBDo1CY1kjCNtvxqii4W1E7gvdmDmfcZLhwjfP/Q/asXiJJmbf7tB7JxRwQzNUiOVT56eSZdfjl27UGRJ2hsbTXe/wGrdbIbqRMpfaqjlbqYYQtOqyk2riF6IXj59mcyux9ZHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlSqpo5ZbCTFf1mw+JibKsseS5XSSvIInmNcZWCjsRc=;
 b=eQ4meXrCPMiuCo4nSB6xDETjYnYdxoUuwJrrbjCl1r0FclgjEUm0d8kX46gGO0ux/q1IZv+AcIWNDKwZlDCa7ODx2EEwhrxe/H6s5gUzHpH4v5ULHKpwDHi+eAAAy8IcwQm5yLgrHuOd+PidFoSvFPPG8bwXQzvvV+tf5GNk2tY=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR0502MB3772.eurprd05.prod.outlook.com (2603:10a6:7:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 14 Oct
 2021 09:12:39 +0000
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c]) by HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c%4]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 09:12:39 +0000
Date:   Thu, 14 Oct 2021 11:12:37 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: imx: fix crash when un/re-binding console
Message-ID: <20211014091237.GB554920@francesco-nb.int.toradex.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
 <20211014071053.568598-2-francesco.dolcini@toradex.com>
 <YWfdY/ws353nJEiE@kroah.com>
 <20211014080153.GA554920@francesco-nb.int.toradex.com>
 <20211014081028.xafpuzrxk3jvv5qn@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211014081028.xafpuzrxk3jvv5qn@pengutronix.de>
X-ClientProxiedBy: ZR0P278CA0141.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::20) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0141.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 09:12:39 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id E4E4310A3840; Thu, 14 Oct 2021 11:12:37 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9c76f7-8fe3-4c40-16a5-08d98ef2c552
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0502MB3772C360E54947D0A17E4BA5E2B89@HE1PR0502MB3772.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1Wrv5fhuu08G/Hzx0DoUbDWjIMoKuT3tMm30WibnLiEh9UC/vNjjARfX6TOrC0F/QKG3hJTpJsv3EOw9E4b3sUQUlESu+tGpJkAlOZfZchWC23ME6AJzC9v0nKcmVJX2Vycr8iYsVfCdXie9I+ZSqcRwl4j9i7SXCljw0gbvJqcqS4qiqPEytK33N7c963o4Yc28XoC7yxK/te8icdNusDhJ2uuqFKSKdCRjRrEI2INQtNmcafZ2uqiNEf1W+3b3x5AEsqbakywSBiQJSAAutucMZRj5wEHsFXlXuP70o03Mn8XL/NaVA6PlY6fHkGpH92iFTjlJShQEnyNLddTk+0k5/I4q8aMAnLHjJy09JHD69yxRzeEep8UpBSZu6vVlj6A9316YES6V5aXGtXAd029OyCb+lpYTW9Wf8s75TSpR39FXagvoxbxFybM9mBPHIhi7ABBE17kfi11enIBKY62bZBVfFWNvuPps4GQzCmHNiT89MG2HF9/AJpXgOoxIskrz35il4TbqSuh6ESVgpsmZkjx3D5o/xVRF301gont7vZJW9Sv/wznA2yyQM3bRmAGNWPhi+09HrdDqfD3dMbtiTPWwIlovSuyo4gdkmHZy+eqkf/uH8dEdzRDuMQfd25gxpv4sKntWCBE4WNtqVNBQKfoDLdJ3Rzmg2MKiCTpE3qWFaCekb7uNLwgi8DJS7qA0IpKFtrPfr1bzdwH34YeZ0IOtzTQRGCLd3THbhmR8oK0YOWMEL7eESSnxxN6shkRAUATY9H/Gy5C3BhkH3rMTymmhyV6mFZqEka2m7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(1076003)(6916009)(2906002)(966005)(7416002)(66946007)(66574015)(86362001)(33656002)(44832011)(8936002)(83380400001)(54906003)(66556008)(186003)(4326008)(66476007)(6266002)(5660300002)(38350700002)(8676002)(508600001)(38100700002)(26005)(42186006)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5j7llpGGOpAbCexcBbJj+Qe9/d7Kc+4qen72JH/Q1Z1hxCIBPZ9AdNhxpz?=
 =?iso-8859-1?Q?ERN/vLJxF3SDjMTX4XBqeeR2l8IdXzWCqmV1IQCCNkNbtuygdQo/TCt/Zn?=
 =?iso-8859-1?Q?b5qwg9heyGhQzeOk7LrrJdlB4t+4qMhHvmvB5VsdutRnTUj1hMFwHu9vrp?=
 =?iso-8859-1?Q?l+g8/qspq7iClKb2aiRfhtyhNV0w5Sjg98lwmh7xXDyDrLA8O0lehu/91/?=
 =?iso-8859-1?Q?lNaFh2VdJBsVxf33oLlRHCMPzXUbgEfrrNSVJPjIo0WGcS2/TSazlF6Knf?=
 =?iso-8859-1?Q?HapNWBmbDuTTr8zMjNxvzEH8XvHN95ClC/n8UhuTNXiugohioABiszd8Tj?=
 =?iso-8859-1?Q?0/36ggT5f0JioTS2dysnzjP08JwghBuC6ybRyK4qJdSKUr5By28MTt2Xcp?=
 =?iso-8859-1?Q?rnVmaz9cy7tyMMdNN5syRJpql4K0uqpO481H6zqB80fIj9LXvruMqDBdDX?=
 =?iso-8859-1?Q?39LPOGy63L/UnUHa55w0ZUH6Es9YtzsiGrUS/+8B/JWSKihvRyWfqN5qz+?=
 =?iso-8859-1?Q?3WBne4dKWQyI7bg2Bo33FG4EqrBusBFG4Kl2H5P2878fEB8xOsRGsr94r1?=
 =?iso-8859-1?Q?dj0GnfLOqHp104KDPLSc0jL82sd0Zlj+LaPQ+H8Fob+4gcd5TjDCyU+uhF?=
 =?iso-8859-1?Q?VPPr0G7njJ6o7+/iLNAafiffQC9i9MIA0MCPptAhDUmVdp5GKNhwvJPdnP?=
 =?iso-8859-1?Q?oVupL9rni/9iOM4wmVsCu5aRP4iC9AY2Xo/iyoz9affBVRfK4ycfxEEOZR?=
 =?iso-8859-1?Q?1cFdPtw/QCjwPR0HDzAeoDTIyR/6RpnlGB21P/I2Av+dHDTM2qzhMLhRLa?=
 =?iso-8859-1?Q?fJrpQ90n64moO8VKuQnX+7FyHO+YIJDO2KSDoyHbhCQWoNul99pjS/pd/3?=
 =?iso-8859-1?Q?n/4Ufw589pNDodnag8oKMbz8qzWFl7fKU1SiK0EW4yLD00UKN8vczjNFh+?=
 =?iso-8859-1?Q?EWc22zsNXFpO/zkb09DvEEqX13GupWSOd/DQzX0YGGjQ6GHGFj0LH81buh?=
 =?iso-8859-1?Q?JWiivR0p4YuLdDbk/0q1/PrVMTvBLWa5zyPXBX2aZaDWiUmUZatDBp++Fc?=
 =?iso-8859-1?Q?w6pPaWQeDP0kwuNFDtU7kXM0CXdLSpqeaaHCXCmkVGLUGbw8mO7n87ymp6?=
 =?iso-8859-1?Q?MKqTObkYYaX/Xs5kNwMb/63xB2jP2zrTKC60zOmZ09MJEbz6JP7To1F+lT?=
 =?iso-8859-1?Q?0n51poT7EmBoqbbKFPWJe0FscyjUcsLHKulAcPm3SMM3eHHLiys2i/3pCa?=
 =?iso-8859-1?Q?0Uhb9MG6JuYsdwnP2Q6GhJO3ntkOtE4AtbwHD8otOGExtWiJLlKBiFQTN2?=
 =?iso-8859-1?Q?lH2gg3G/hKg6vwkhd6p1czQHBvYz8vdalMKqMshadybrbtCYXq4de3aHH5?=
 =?iso-8859-1?Q?20WnfIt1wS?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9c76f7-8fe3-4c40-16a5-08d98ef2c552
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 09:12:39.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWgwPoumfOMzQMcOvVutvRoMev0mwV2GuF4XWfzNwTYuQocFN+nfrl0jMMuF5nop/0Wi6Fmel7qh3aEO4XDV4rWYrQYVff0ZZfpoF/mBxFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3772
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Uwe,

On Thu, Oct 14, 2021 at 10:10:28AM +0200, Uwe Kleine-König wrote:
> On Thu, Oct 14, 2021 at 10:01:53AM +0200, Francesco Dolcini wrote:
> > Hello Greg,
> > 
> > On Thu, Oct 14, 2021 at 09:33:55AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 14, 2021 at 09:10:52AM +0200, Francesco Dolcini wrote:
> > > > From: Stefan Agner <stefan@agner.ch>
> > > > 
> > > > If the device used as a serial console gets un/re-binded, then
> > > > register_console() will call imx_uart_setup_console() again.
> > > > Drop __init so that imx_uart_setup_console() can be safely called
> > > > at runtime.
> > > > 
> > > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >  drivers/tty/serial/imx.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > What commit does this "fix"?
> > 
> > root@colibri-imx6ull-06746657:~# cat /sys/devices/virtual/tty/console/active 
> > tty1 ttymxc0
> > root@colibri-imx6ull-06746657:~# echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
> > root@colibri-imx6ull-06746657:~# echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
> > 
> > struct console ->setup is called at that time, but imx_uart_console_setup() is gone ...
> > 
> > According to the original report from Stefan the issue is the same with unbind/bind of the console,
> > see https://marc.info/?l=linux-serial&m=154221779312036&w=2.
> > 
> > 
> > > Should this go to stable kernels?  If so, how far back?
> > This is present also in 4.19 kernel, I feel like the issue is there since it is possible to unbind
> > a console driver (since ever considering the current LTS releases?). I could
> > investigate this a little bit more.
> > 
> > We have this patch in our kernel branch since 3 years but for some reason we never managed to upstream it.
> 
> I think this is a bigger problem not only affecting imx.c. Just look at
> the output of:
> 
> 	git grep -E '__init.*setup' drivers/tty/serial/

I agree, but I think that all the earlyconsole stuff is not affected, so the amount of drivers
that should be fixed is less than it looks like.

Apart for that once you fix this issue you need to be sure that on the unbind/unregister path you undo
all you did in the setup, maybe for most of the drivers is nothing, but for serial/imx I had to
disable the clock there (see patch 2/2 in this patchset).

Francesco

