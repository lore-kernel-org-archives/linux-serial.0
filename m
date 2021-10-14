Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CCC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2AB60555
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJNHTk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:19:40 -0400
Received: from mail-eopbgr10098.outbound.protection.outlook.com ([40.107.1.98]:41903
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhJNHTj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 03:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+tqgqatX2BQd9q4UN6BJv1Aft3SsCHv5NGo/7cvblw9NOUxASAzHrdB3RQpo+9aDDaw59b54lt7vbpGBOLeAt9Kktq4ZRnlXJjA6tIdeY3vf52MfYdrr6brofFVMcNHYiRao/G6aSC6DlKpZzL08755rIN+Ftxb8Njzc+/F5y3+uyeQroE8vr7WO/+N2J4rGC5MSCm3E/8PLo1tUCt4DPPp/KRd6IU+9scBTMVXF+wN0Wzr7Eizf99xyyUJ9gH9w/ty1B3gcnDUmqAwQIvqF1mXTld2x/thFwVvWkE5QjXrpBfy+HKTVk8Mg78bwBBgHW4LgexvtgmtxTOYMlO9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSsGIKkFxeOns8BHzLdsuKkKP3fLASrc5ghUnZ3D70s=;
 b=RneuNutXJJvG4SPJa1kSDYHLeeQGEau0cSUJGpLzL/45XuiGosThHezDYbEbgAA1Ap2NBXTkqbufwzA5hkxRgXksvFaxyl5ILIWdSzxCcBoyoqtDdWI6aQ2ZexiBHMREuh3oz0Wmkttaud9A8XLhEf39LRdAVSMTj6+LkhMUQRORnvY4l74R9TaMicboWRYsm2wqMW9TAEVh4BGkGg4nbL1dPE5FVzchEqiYmQi+yVHoOrkpO6dRWrAorYUWx8dXrbQLy7qsOEQChOtig4aDJkJAxXZnQxen/FcoNOMkrXidEwHuNZj1Z8FgqKYYRCdvEwI12tit76SWurrpvT9W3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSsGIKkFxeOns8BHzLdsuKkKP3fLASrc5ghUnZ3D70s=;
 b=hLZlprjJ80HPuGCTc17c6wLIg/arsOneP6NIhF5IPbWCNEL6wkZGzOuom1pivkpaxb5A9a8/tz8vvp/kr8WFNGE1+H8hseD775JkekW/wJV5M/FRj7G7RUaB7tYfQERc+uGguq+t74KLhCC+xpo69eQO2HuwR/lW1+MBEA1JKbI=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR0501MB2409.eurprd05.prod.outlook.com (2603:10a6:3:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 07:17:30 +0000
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c]) by HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c%4]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 07:17:30 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: imx: fix unbind/bind console
Date:   Thu, 14 Oct 2021 09:17:11 +0200
Message-Id: <20211014071711.569157-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014071053.568598-1-francesco.dolcini@toradex.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::7) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by GV0P278CA0074.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2b::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 07:17:30 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 49DDC10A3840; Thu, 14 Oct 2021 09:17:28 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 652198f6-3ef3-4cf1-e2cf-08d98ee2af2b
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2409EBFF33F94572DB184F38E2B89@HE1PR0501MB2409.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLd8XEVlVfKnDcnPORImTUqoFQORwC64HjsYj61tPN4koa4la9p+wqhFVyA5jRic5m/2BhgWFamKijzlGTVqsjEsRECCB/d0lB5PgolhhBXaEzUalbLjzpFXAiwXkm5jO3CpTTt4gwS5dpBIL/W65Hhts9K3B0W9FDg198srpT73rOToADUdV7V+K+Z8g9UcETY7WY+/A+K/Iq72Fu7cNa5XgqZCBWf4KqfZ05RXWm1Hzdw0WTzRyOa11Oojr1AU8AE9eehbqBpfZnvQAb1qtdUV2LENcANcl0UbQ5DDddRUBs+s7hs4JzH9e0QekesyGaej0BiI5bvr1+OiaK46Y73DUChlSohw3Oesy7kc2sMtQwnB2zKyYTQcUedAtES0b7HjdRcm+gXNxHqzxfV+lqtLNfxAl+J+meixZZ1X+cyjputew4qIRFo/FXFu63wVGqUuwfIIt/lPbtFMLr+EEXjr1y/ga1paIju6ozWYfi6Yvor8nnmY8FsojVsxpi3pncHbEURmdXBG8W9rBcA40n+LHQMJwksPNgR1LivDZ/ub89qFhgqHv8LW61aFdcqTGNAYTTatJRZXQ1qkHIscvVjqEfTggKtWnEkoNcX9a5sTY0gP4hR2Ej5rmuGkntlxWNi+T9CYs9IGW7TCcyIhwsGvBHmgpISu7jEF3+eQt1zdHoe0lrTZJkfUVAuoAcTcqrFC3YPi1lpS5uLZgWdgkgtvCDq0nXAMLQVVhIodkSRYhX24XmHh80FjpbuVxpf8azNyRrpUH7j2vxT1BbWc6KtnSpg560RcqovPcHUCAOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(1076003)(508600001)(83380400001)(36756003)(6666004)(966005)(86362001)(66476007)(2906002)(6266002)(110136005)(44832011)(66556008)(8936002)(38350700002)(38100700002)(2616005)(8676002)(66946007)(186003)(316002)(4326008)(52116002)(5660300002)(26005)(7416002)(42186006)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dpKO98KJPEpVOmASL8LWp+tBvyXvaXoBRw07ddbbB4BfBbnj4z2vLMLF1SP?=
 =?us-ascii?Q?v5//L+ZuKmoUoR/W+mfZ8XOB0WGQWQHEKAhG3GOl35iw+8i7OdFQtokVctrp?=
 =?us-ascii?Q?hZ++hRn5+h+hzHjTXf+rHmbChDDQGDFBz8qo/L2Y1EYUyes8eLcGorZlXkGj?=
 =?us-ascii?Q?cnN0xa3Rk+TeReRJT8fqVjQ4p4SBZDeSrQbTAhSdvQ3xU2lysTIZRlJyz5l/?=
 =?us-ascii?Q?Piy4AdFOOuEykSnqJu+Ga3tf0qpu/P3i7l2HmoUbN8ooz+vWevwjC8QAcDQ3?=
 =?us-ascii?Q?b4w0nDMTcYnPRaTuIPJqr4KrKWOdkQf96NGUtVKkxHb2MJJU0HpH3KkrvqIU?=
 =?us-ascii?Q?n3zKZVdDzvFcfkIeKYT5nFNTfBhO8iJfjAc8Ak3EQwOSODee7u/LC+mLN8xx?=
 =?us-ascii?Q?EWKzb6RsYtcDfWP8TctD9+1F3xCMGsOmzO2A42+6i5BC3lGkDu8lW/CwfTPa?=
 =?us-ascii?Q?9KXf+mAxTRneY5T6K0bK2xtOKJnSJSrI7vHFJpQ7JXDi+AXZ8eSas2ME/JOp?=
 =?us-ascii?Q?71IDSesms97idZBYWZZcSwbwUal4SBGISP1m6/08ZJ9U8jIduLpSN/YJndus?=
 =?us-ascii?Q?g88usHGDw2Co9XntM+ik50WWRfmsCWakSEV61WbAfquD/pK4aWrmKWiY+/5A?=
 =?us-ascii?Q?zsSPQfvwEOPYQLBSu9TvFOsoGifOwTdgqKfZv7lOu2c8d2yL3Qle0iCsIUgA?=
 =?us-ascii?Q?B5DYFNtKa/hg9vsbAC0xhgjDaXVyDeKqeoFoJId1xqt9PiUDzfUEIgF4bf4x?=
 =?us-ascii?Q?RzJgZftWkiInkpTZXuMikiu4GXHAW1BWqii1gKKYJ/fdrChhIVij08gc/YEE?=
 =?us-ascii?Q?5FXpbJJhj/BuplL0lLZb7S2+qYnjI0AMmnyGBKu4dQmuLNK1Dp5SYP3YU9ne?=
 =?us-ascii?Q?QIurMMBcvUi7diCv6S1+v2gwjfpxcJyfjpHsQo/OEsKMmth0cFr7MLbnuJzM?=
 =?us-ascii?Q?dFSSSEqzM4sed7y6oQYLjxfWprRwjyeRyF0eZlwp1A9l3OStNLoZ6xkp90bH?=
 =?us-ascii?Q?thXMsR090dThnrOdI6q9Wn7pQPgbABCvpyXcTF5Q65ag8SLAEqWedcvlHbVr?=
 =?us-ascii?Q?BXclGvt6sO4RegvhfpReCGQblwTaD6A3xebKOwNsR1fENJ96w5D3FR+SwI1j?=
 =?us-ascii?Q?WRCXqXsbDtTTARqkNbDsEy1NfGoiuAF2PY355iMkzN/ruPMiUOKGTDvKJLZE?=
 =?us-ascii?Q?GYeaKfb3YbHvMcFKVPab6inLs2a3I2O1AnG9i1t+SqiBb0vF9yngVrSNy6wq?=
 =?us-ascii?Q?CQUV7IvbaFz8vLG4NJCx2lyQ6qFmY4rVMTwR1j0LAtPtByAG/396WpkkbFkV?=
 =?us-ascii?Q?hk2AlU8wytnRvSDbwvgsgVx7?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652198f6-3ef3-4cf1-e2cf-08d98ee2af2b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 07:17:30.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWWcIGID37h04C79kW5Mzp3Jxu0RqS1X9srGm7g1zBxXkOne9i2inX+6bGXmUW/tIB24bk0tnvv0587o5SdBrnoz8zNM+BDIj4r1pTgkW9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2409
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,
here a couple of fixes to properly handle imx serial console
bind/unbind at runtime.

The patch from Stefan was already posted years ago
but never merged [1], however is still valid and it's
pretty easy to trigger the problem.

[1] https://marc.info/?l=linux-serial&m=154221779312036&w=2

Francesco Dolcini (1):
  serial: imx: disable console clocks on unregister

Stefan Agner (1):
  serial: imx: fix crash when un/re-binding console

 drivers/tty/serial/imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.25.1

