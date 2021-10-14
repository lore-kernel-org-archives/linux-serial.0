Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5303EC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7B2610F8
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJNHNN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:13:13 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:50863
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229912AbhJNHNM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 03:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xig5jn343TBe1MOwjmXuOPjos81vTywMbaGhzhVDVPG0Dyxe5Hjsjxi498+jt3s8GxgR0bYd4Wz1Cfjhj7TnhIwG4I15EUVxcdymrJsOYmPkoJOHf+3xtMFbtgVkD4GuFByi5qlvsZpxYH0bKA8P5+JS0M0SLXzW7TajZH0JEIq6TDbDuQ3b5p5bv+SeBPQEz0xTUOHGhow0qjz3TagUV06/ZcOcaRyqhGPBIfjc1z54sBxrQhNin+LPPPtlmdx9S5n2scXjcA7ozdGdIteqrke7YUHGdYyKn0dhc7Q+Kbuj5GWVJvMwXdkFR1pyX8O0CnTBupjpXyLadmaCEEyxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJDjCZmA/Q6nkzTkCuLd4EngQ8xNcAeD+kZO4enuJYk=;
 b=DE8qqMhA77ooHb9FUZwU1xFnYqLxPbYsCZH9If2pTgsIiUjQugaeRATfBb+K4inf7gebPA32quCpvtHNbdP+P+ihi1Q9VMEex2YLynl5ZBhsL59YsWVUqLlcpBgiKXa8Bf/q9ygvBEuMqTeg3pLnUhXAIWjQLnlJ5/VhXX55jlYDGPejjGifnQJWiyRK9h1uM/vMwNmm3zRadzAGC69Iue+8XCYrt/V10Y0suNY5odYFqDQeRa+gedYOgtAvd1S8GPqvBi4jzcpjBWoOkWfh0qYBRZeZA/g+9wvp43HmdzvlWckYdOJsj5tdThym7cY3t5D13DAZl01MrKSavLcjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJDjCZmA/Q6nkzTkCuLd4EngQ8xNcAeD+kZO4enuJYk=;
 b=rgKa5ZcWEOTYnYraRhZHjLZNYqgD+73MPkyEL494LSAqpBXdDU3Y2LFh9F3ZnIjsw8FiSALiXLm/Qx0v3RnlINrce7TP3ehsVL5zbkMIf00Rg6ROJhn25QtnrylFwqu3j7cVNISnfJyYqaxEgkkujsIyRfWFu2x/7tpCfIpWbBs=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR0501MB2780.eurprd05.prod.outlook.com (2603:10a6:3:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21; Thu, 14 Oct
 2021 07:11:02 +0000
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c]) by HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c%4]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 07:11:02 +0000
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
Subject: 
Date:   Thu, 14 Oct 2021 09:10:51 +0200
Message-Id: <20211014071053.568598-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 07:11:01 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 7CE5010A3840; Thu, 14 Oct 2021 09:11:00 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6afd91f9-3c67-4077-f6ba-08d98ee1c781
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2780995C2BE059A13B6AF99BE2B89@HE1PR0501MB2780.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1bm0V7hBQ3YQtmpP7imnMiOELtghkIuYzQVamNZpRIX1fk7JM6vThxsy336Z4XylU0qCEh34DM0laJ3TAKkrHd8JapT0tAWRqMaTME9ID+hjIRifqIcwGy77ez5znHJPN7LdGb4x1er4Yxhy/6cWZxMiZ2Q2IcuuaYvhhEGOKBNk2rG1z4ooCKUiLCceEmgSfa9AW31mZ11Qf1rXXD8+XrqCpp/txeduZHq8neiCWEAjwyIy2i7XBpmop5htXAkhkjHC6Bn6AB/Wr+mpeqYVxWo9oPwTMGBgKNmHuc5qWuDI3U7vGX4kQSAY+68/Tf5emp2c7web5ARtkA9eHvJITt7te/ag2oT8bBIawRXYqv86SWVSZKPGuw5U+HONkJA5rRJTXeRnXUTZB24c6TSARm6g9vNKBcy/IBbakh3sVUIVWYU1UzCdAbCtJugix7pT8JGZcPbTBxCtXYc+Y1+yCJhwGpXLcbHMHL7YSggSIctZUYfebtm0Dd241V7Twb2rnhs5LzXHaeOAqYg6NaGCEIN73JiDp06BC5WQqXHnNvIYIWGYn5h4f2/CnAjY6OdaUD9sS5TGhnMQQwYkX6WzRQA3oqSmYkcoe3tFbUpvywTlk+p8Zp7q74WSViy0hJVuxqgG+lP28miW0GwZOT9AaNn+R0IHEGWsNECf5AFpr1H76WzjeWCZywQsvIyTmJZe75gjzO1m86YaCo6zajfCCsVnIiIFjPcxlKL3IhtKEKAEGC0ud+VT2r+j7reDebrY+lM8USuCJK1VZxaVo5ljp/Fe7tpZaA2BQW5cDz7zXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(36756003)(186003)(5406001)(52116002)(26005)(316002)(966005)(86362001)(6266002)(110136005)(1076003)(508600001)(2616005)(38350700002)(66556008)(83380400001)(66946007)(66476007)(5660300002)(8936002)(6666004)(42186006)(7416002)(38100700002)(4744005)(4326008)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?minLITZGRZKFr1C4o4fsNJ+t457TPapEUvAS3J9bQVJ5HP2JM80aFmc4VTdo?=
 =?us-ascii?Q?ykC9PzdMhS/EbDF19P/8a5WJfnVFv82X2nPaHoTBTmal36WSmWi3+hUhQHXb?=
 =?us-ascii?Q?rdNx5XClwyrSabuGJJAarBKOJvOWk1E/8g6rk6bP4IFsWBdl4kbFRbYJbh3x?=
 =?us-ascii?Q?MW8GqobvblAr+0Swye6g9hP9+w9khfbrmzv0WZe86SFPwg83sb21g3AqKRUA?=
 =?us-ascii?Q?F1HWHv9VWHsd072XrY36ezS3230EzMNzurnAjPy13Zaov8rnQzRHQYhOZWJK?=
 =?us-ascii?Q?pps3zujCQiAxNmrV/aCDpjfRT9RTH5ccZou0P9iRsdFb8IOL4VNjck9Udjvk?=
 =?us-ascii?Q?SgAfkoCb0jnBnJjFGHA8Ot/6E3+l6gnPrqrGDJOYfVzVCylml35rnduJoAaW?=
 =?us-ascii?Q?J/yJ9lfh6IdpvgKbonCo6WSYsxflKKAfLa2nrQBrqeTBMNUJRrha8OIz5CNc?=
 =?us-ascii?Q?mRjM9Ms23cnUhDfkXCNH4UVDX0B6XjrEAq3NbcgEnBQwqc1ZJPGzC0Fp1CV1?=
 =?us-ascii?Q?S95FuhNTr4/itFZhoApIhbfNz5gB8kg+OrWuyHdrEp7zaNbYOKtOneewjiKg?=
 =?us-ascii?Q?20UlJ6wfL+staW18vGcwDYJg03bLsIY8D/NNG3CSuFBYukVbY7ijmeIVqbe2?=
 =?us-ascii?Q?P8nMJ8KSKVsoqudbDgLg3Jls5hhPg357KYP9mPhWMXr7b4y7GR51fwd2ZYah?=
 =?us-ascii?Q?FZAeAxOzbvSlkrm/ac4eQ6GASWcFNopL/3sMs4x1sZnXNiPc7UWzaucmb2cZ?=
 =?us-ascii?Q?5ITmDultHCEA0pHOO5PpXa+i/H41TGv0Wia2/r+64rxLTfpYq6I/RPJOtTh+?=
 =?us-ascii?Q?QXG9ccAHM09SZ7Dl0DTIdSlzLGCeKmRbtFevATpoXg2H2AzhR1lGQjooj/3+?=
 =?us-ascii?Q?QhxGY2XXIZwkBq2g8XzvRq/r/IIqTjUVMTHBtX8wuoLFmGntrzGnjFCQ3DeD?=
 =?us-ascii?Q?2ilgAaTOEi+aEqyvz2PUDl95fAs1JuOVPPp1Mz9JXwqtamgFMKOgfWk2tGFz?=
 =?us-ascii?Q?OAIwYsQCD9UQijODbxjDPCcwvCSacdpHMUCuzhOyF8ZvQvHx6AD/FxXkoFFT?=
 =?us-ascii?Q?xXOYmDBUVPgtg+U0rOd2zEjC7/GhY06e2PsFBMB+/fZPAqEjOsTZyI8BX+BP?=
 =?us-ascii?Q?3flE5bt8X6AvzcaPS4rNH4qt4WVPmQhCjxJeZtuh2yE/nK7eXqfidOAEoZz6?=
 =?us-ascii?Q?VX/Hj4deFM4Ijqkebh2ZuZ6cGB3C9wjuC+DvLlELXE36Lcj4Wlf6u2+PFjVu?=
 =?us-ascii?Q?PR/u/p07aHXPSqg28V9mFsXNutp1W+QZcr3CMrHp85sydAhDlRgx9UmbfyWx?=
 =?us-ascii?Q?Oq36rSWEqMBM/Zc5n9C/YfgK?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afd91f9-3c67-4077-f6ba-08d98ee1c781
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 07:11:01.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9jPYEQPuTUL8mx9xX35P81FHxT+4trR+5FpN5iXvsHRIlhD2ZU82JhBuoJJE7dfWuZ4zC/8TtjZwn3WbCFi62Dx28Yz8elJYzEGw5+zPW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2780
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Date: Thu, 14 Oct 2021 00:12:55 +0200
Subject: [PATCH 0/2] serial: imx: fix unbind/bind console

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

