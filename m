Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A473BC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 08:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8829860E0C
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 08:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNIEN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:04:13 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com ([40.107.7.123]:11138
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230032AbhJNIEE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 04:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE1TVf+ck2FbA00tTpTxqoHJG+W1I3Ujn/2S/6v9sQ8WWRvMpU+UlJchQZmfI6x8lmRteGc///2Z+LPho6nNw1+SI9Rq/GaJp4jh+BCIQCk9qscovBHp59dSMiqhrhwvTMcrNl4oGRb02khmFoJLHvHnFsa9oxeU9lD2b7kI8FxqPMrHPBZ7XQbH2NwPCoflGtMQQpGac2nEv7zYmnB64b9+CrvJ3mN9FlQBVJG6iX9lWyQF04ClmV7sxBhyzK3Qa0SnjN6E1XJ+Bq7ts2FxMu5PV5wAYfsaPGdoXvJ778E4pxhIwLHn0ihD6ralnwQYEKBfd0sjFewNFppAXtKorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRnlgSy6Yfb3BJQVY230zoPz4aPwVIbygb4x5FCWgkw=;
 b=SuPs7WBjTSXy39H57CEnFuSC04H8cBZXIW+LJM1zmPqipsgwd4tgdy260FlD0OkhkJ9xgqU+kK4AETn7PmF+v9FY8IWw63w2KGQNPz+mMWgXLfopMEFEE3cc5SmKg3FjPmihHi/Vx1ohvzuTZh8FeGwXtbV3ZhDlM10lkH3MJDhH/rOwm+1yLDBnfdzvUbUxaJOr9XWZ9tE65H8gHoTaEpYFopByufeQ5vj66S0DBh2dYwc7N+fCbBH7XQo5TCMwICVadLoMxE+ZkwwJHLsKQY4JJnltOhRBPht/DOOLc02TehgOIuqBAE6qtOTlszpGNbw4GL7h57uZCBp/0h99uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRnlgSy6Yfb3BJQVY230zoPz4aPwVIbygb4x5FCWgkw=;
 b=hgnuto9V22hHqP/tTg5TPMiLF2hthOcaWyk21v2kLtdu1zeEYcu0v2KJzLGX7ymB80UzKC9fqzFeGfFJlG8JgNWaIOJ94xZ6z6GGZYkJ5YrXbarYGP9V+NP87bLA1R+u6BCtC92o5peoOn1L9LC0GTn2WdisPFvi+wkMsk9zTwY=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR0501MB2345.eurprd05.prod.outlook.com (2603:10a6:3:27::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 08:01:55 +0000
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c]) by HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c%4]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 08:01:55 +0000
Date:   Thu, 14 Oct 2021 10:01:53 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: imx: fix crash when un/re-binding console
Message-ID: <20211014080153.GA554920@francesco-nb.int.toradex.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
 <20211014071053.568598-2-francesco.dolcini@toradex.com>
 <YWfdY/ws353nJEiE@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWfdY/ws353nJEiE@kroah.com>
X-ClientProxiedBy: ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::8) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 08:01:54 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id C563910A3840; Thu, 14 Oct 2021 10:01:53 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbbdbd71-0e3a-4e4a-ea15-08d98ee8e37b
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2345:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0501MB23452B746BF405CBC4FC94F7E2B89@HE1PR0501MB2345.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxm2TQc/e0CSzS9hMFWHC+J9H2kJnKO6U2TUCnKrj5PIcdqMh79viTC6z/2qooM8aeciWna0Q8Kkd1bAD0rbe1L1RNB7iywETj87hRzZPGT4o6TzG3Zgu6idFxg7U5iKseMJco/666fq2pBBPFJX7PBTUdQr2glW8l2hG6MQrg3A28+6+JA1TiGZN+mkiTPGUk1yBPywhI/HaWK3puSg/Frf1+VlPugWu34vaImMi+nKaLe27gCu/7fI+sFzy3WsvLpQ2cr2x0I5kDqAs1djlK3fmiXxD/B2Mqsx1zZ6Iq5wKhsBVjqHKRIiG/M8ToX80Z8t9k0cP8t99BLjxoLbqHwriCq0iEYmYY7jm+tIKSBLz2sviMyw4zyPqv9jnALCOT0vIMesSx1GoTkMlj384NbZgsQeI9maTdZPrBt1tP2G6KEsqn9YlDCIfrUbQiRpZBSxCN2woToQh2ySbw9ltFSpxKMBN9U9XbjOmstEH1w4DThaaiqwCiSy+TOFTaoyWa3oT0GftdlXzAhjaE8w4NR4aA/s/dXcVBIxQkGN96XLi5pq+kpBfC+7Aj13bkj0TIvPeCkCih7yn17pgJQPpVvef1RUvCe0WMB/CSUMwTWglosFp69CX1Cakjl3X0+Ui9tg+ViAqLtfGxD08zgN76QgwG5QUQ26TiR3UBTnXhoC2M1HXWK6YdFbipBs7+iNC7GKR1xIjJ/hlEWWWgfp/NI90gaZ0LtRP42I0j1Yao5ro2V9M8rf2VbofIeF2uy/Kgd/gW+OZLjGUKDOWERsXdtDr5Zjk5qlo3CmdN0+NvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(42186006)(316002)(38350700002)(38100700002)(5660300002)(6266002)(66946007)(44832011)(66476007)(66556008)(8936002)(26005)(186003)(7416002)(508600001)(8676002)(1076003)(966005)(54906003)(33656002)(4326008)(6916009)(52116002)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NoPPUwQescBsmErYGGxaZ1wTfGylAnPRAWwnT2LfH0tHifXDLHbhlIl2BgIF?=
 =?us-ascii?Q?/QwnFfRRHn9wL2AM5ANHA/9erTvGFpZ8RC64A+RsDf/XYHLbVkObwtgirBxw?=
 =?us-ascii?Q?o15J2JDlgtkFbIQGTV1Ac4h61g6o8KvjvU26Qt5wCs8iUupmUnhNYke27GVD?=
 =?us-ascii?Q?mDVqzSGNDlCblc1jCA4s/PpkLGGjJb/KGTrgHmWO7W71ONzrrFC13JafC4S5?=
 =?us-ascii?Q?d1GEqCTzSTLf8GITDdMZBrCit7KciEpXgnSwIksECu/D53NxuXHqeueyveJf?=
 =?us-ascii?Q?BNyMy/r+J67IGG1r9GsYkIcNNcH0bNxU9EW3IrVQZimM5Gjq23hqpG+od93d?=
 =?us-ascii?Q?HsVtN8dyfhrPHlFMp0Yq5ZGnsQIk+p1gwJVqFS6171pXuWCvHqPltF7LxEB2?=
 =?us-ascii?Q?vtTkDms/IG0A9wiX9uGEu2i5Hw16Qqm/M2MfYAwftTQ+j+XrNTZsRSklKaiR?=
 =?us-ascii?Q?rZBLL275AyyrK/W2SiwZlTHAeljTbjri2WHun0Hp4h8FlBGDgdwQwl4+PGRx?=
 =?us-ascii?Q?yz+9TZUDg4GtmEGcptNZHeYiAdXPhzdOG9GyKGpU1+Ymdkvj8oRqLMFxC2t6?=
 =?us-ascii?Q?tBbWc6lMDU10pwWnntNuRTxOaBlhEQxFJUjulVbTgW7fZIwH1X3cCGWp+cu4?=
 =?us-ascii?Q?/gf5RSU8JiKzqWqphkIhyzK4wpzz913LLvR2elrS895/XTTtW0+jd5CDG2+J?=
 =?us-ascii?Q?qM09TQOp5l+wjLdked3YAj2TbE/O7Qoy0ySuMf6PTzvov3DhBjiV3nBGurNF?=
 =?us-ascii?Q?Z8W7xdYzbwY1YvdeeTBV3swDLRhTFaMNaR256fWTiiwVicf+X57QqIooHay/?=
 =?us-ascii?Q?DufNgG4UBL9v6rEJ7QZYMMKNzrfouKPNMAgS36jOxFz1+jHpDSUIhoa1ZJ2R?=
 =?us-ascii?Q?tWhFMNBOR5q1Wp6u2NghuPSx/CXVC9I46LallQenhWczDO+Qu+2Is0VQqeP0?=
 =?us-ascii?Q?45abYcwIWjzhL3/yxVz25mQKWPZuj6HPG5sOudrQuMCL4puj80wX+KFGouWv?=
 =?us-ascii?Q?rheBqYeQnGzme8esrwzokkxAbvfpR246Q5hl8I41VPVnTVW1ICntJ9ibGCfx?=
 =?us-ascii?Q?IEp3gjC7ilZG+dE+ADI8qZeBNl1D4PBTfZVfuWcIdW5B0QkE2mWUmo42K7Oq?=
 =?us-ascii?Q?sycDYRcpGeJbAme3+7UnodHekgnlr7hLg8CMvAElTxyKMbAdWAdw3WvLNDP2?=
 =?us-ascii?Q?QGRIpdJJXHb6JMlhQi6hjTRcjyuxxIsE+pZGs7Sx+htSOOd5SDXAoKBWjhXr?=
 =?us-ascii?Q?fc4zNTpXE+ZKsGmyISMr/cJena4ipuX5+yCrFpis68oUKiF60ve/oxf++j6b?=
 =?us-ascii?Q?IB0JuslDvEWL5mJo1ArvxLxU?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbdbd71-0e3a-4e4a-ea15-08d98ee8e37b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 08:01:55.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzZVxX9Sxe2Bx2+EfxIeDMJs2Cmtb7QkVgim8DFwymUD7twUZ04xa+FgTAyrGIyE6Ny0KxlM9gJQkD6iIq+LbHWXWUnu4zpLhTyMPD/m5Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2345
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Greg,

On Thu, Oct 14, 2021 at 09:33:55AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 14, 2021 at 09:10:52AM +0200, Francesco Dolcini wrote:
> > From: Stefan Agner <stefan@agner.ch>
> > 
> > If the device used as a serial console gets un/re-binded, then
> > register_console() will call imx_uart_setup_console() again.
> > Drop __init so that imx_uart_setup_console() can be safely called
> > at runtime.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  drivers/tty/serial/imx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> What commit does this "fix"?

root@colibri-imx6ull-06746657:~# cat /sys/devices/virtual/tty/console/active 
tty1 ttymxc0
root@colibri-imx6ull-06746657:~# echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
root@colibri-imx6ull-06746657:~# echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console

struct console ->setup is called at that time, but imx_uart_console_setup() is gone ...

According to the original report from Stefan the issue is the same with unbind/bind of the console,
see https://marc.info/?l=linux-serial&m=154221779312036&w=2.


> Should this go to stable kernels?  If so, how far back?
This is present also in 4.19 kernel, I feel like the issue is there since it is possible to unbind
a console driver (since ever considering the current LTS releases?). I could
investigate this a little bit more.

We have this patch in our kernel branch since 3 years but for some reason we never managed to upstream it.


Francesco
