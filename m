Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F66C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE10B60E74
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJTT3U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:29:20 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:39809
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhJTT3U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 15:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsmtMYi3rhlesbOG5bxA/kEnLiuipmsBKoZUcnstcrVeF/ybefOPTfCsHGA5K/Aa9x/Op/6Z+4W3Pyo3R9jsEzCtScwSCLRLwIcJa8quSW2vSXm1NkHiMza83M4kYbNIR573v28QuiQZ4MXk3k1iA98C4Ot+44pvHYWJdEAS3a49gspP9b3wZ2BOmzNEzgZ8xw6N6V0lLoOQYb06ixg4rSWp9TXEJNj0FWIQqiLuN7Ypo8h8g3oq4w3KcqGayE3eFKLMEKXCnmKOJw/IfQZGbasyFHajeIv2n+tTDcL+C0cn/Xe48lLZN46ra/Q3Yn6LBE3ltCGFgGH8jdF6WdRwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc87Kk94kEjAHOPxaBV7NNYnRvwV3gaEvrsmBabUOew=;
 b=ZoSJ4U2a6Q9wMqH2PJK4aB0cXRTxEQwiEWBirPQAlplSJQIkliqmCdFG2Y+fNHru1T0CCEhuVC0NrBLd+X5LQ8u7397JyjMVwMknzuRBKxyex4qNSOCXYi9EFyOSp7Tp3GakSwWozeADqLWeGQ2Vav4ZjuuNLAWMy+PFhPqt9F1KCtd00KLSLbI29JKFcluq4rVKlAGiwHBDDht73pGkLeGOfRwLz1NH6gTdI+jv1E+aYBOWvekMcCvb4BoylGC+iyPVvPnjsI/kLXGJAuHL5SbmQbJLFEjtJukpogBpCbv2GueO8uE2OyC41vmnNje+bnifOMn4i3Q5zfvaG4CCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc87Kk94kEjAHOPxaBV7NNYnRvwV3gaEvrsmBabUOew=;
 b=YlWRXeeyV3ccB+anfpTaj8WBBd02lbRuiXLbnZYDrD1AH2Bw1V4OeHlS6W9xzZ8lTcvtI4e4dp+qBWqqrXP8OSK1Iq5/GwimPMlb2X9eoSp8mheXTDmp/9Wrap2fXprS1Tr+6QwhVFubSa5gZGjuyaDObi0eVqO5HCaoPOhXklw=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DBAPR05MB7032.eurprd05.prod.outlook.com (2603:10a6:10:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 19:27:02 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 19:27:02 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/2] serial: imx: fix unregister/register console
Date:   Wed, 20 Oct 2021 21:26:41 +0200
Message-Id: <20211020192643.476895-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::21) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (93.49.2.63) by GV0P278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 19:27:02 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 3899C10A393E; Wed, 20 Oct 2021 21:27:01 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ca5afc-286f-4095-5d67-08d993ff97cf
X-MS-TrafficTypeDiagnostic: DBAPR05MB7032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR05MB70322F85B1486D08F6F6E47EE2BE9@DBAPR05MB7032.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpXfkK2Ghr8rRFnD1S9hSw7sjxaipqFAea+M011DRZDWh1PyOrUTXn3EKMKqZJLrLbMgRL69L61+/mQfs2NJp2Rd4I+vDZQZ59gGGmhaHr+JFC2eTanxr/CDgK7ksLRJn5BilsRhfe0BY8l3sOHIvMwTsUWPSdq1hP2R8iSOgGvH7oPHUbrOf6i5W2CXNjAjbq8xbz6lTAfkiw/nRG0gucs3MTFczheeDfOndSxiNwEP+xL87ZxkaaAnIGZgooOggHb8WinD00L5OQk4PlOvcb/jGYEw3JXBSuCTJlvZ1jCrXS76unvXVt/zId3tbUTpOH3Gt42fdaNWq7XT2XthiN1b7xCxTBwLehIo9xGmUHaONvz56l1yVuxphaEdho+tEMkFXyCaXGtYcslVQqZ4g+hpiYxbDWjJfgakDUcP22BS1PQ32I+/85Ol2ldRphol0nZNGkQncd2I33nyr1W6bhX1NDexF4USsCdPhFfHMTF6w+OZxZaVVueqs5BYB4o7A29uF7LNugRtWXGkVEF7HeRhMmtRNgWlCiKHcrF2T3ovnyEPqE1prhIvQ9aNoeb3san+N9xZ34wj6g/cfUjNnDP17oiZoXxHiYzu8zlQRkJGVA0A9OaZCa5AUHoLCqeXq+7xy0wvzDOo38esFN3CgUJlmaIV9XylgxbPdYB/8YH7wWtCb8exAmE9467NXZQEJXwE/fD8sdEMHSiUKl1K63wuDtIChwLGhdSohhpw5y3kUYKXwhJSnrJrLmO7y8xMw26UVyX9PpXhD196DTew0Lh7BxVjX/cAxQwhCpu4bbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(42186006)(8676002)(966005)(38350700002)(52116002)(8936002)(54906003)(7416002)(316002)(508600001)(6666004)(26005)(38100700002)(83380400001)(2906002)(6266002)(110136005)(36756003)(5660300002)(2616005)(66556008)(66946007)(66476007)(4326008)(186003)(1076003)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0V9olVlzwv19mW40ZkztAaDxYEqIwqkEAS+5wEyFt0G08g7fm17MU8J7y+Ys?=
 =?us-ascii?Q?bwTtcX+50cjlvfUSsFPepWzXd/BthJAZAuAlDA1R/zVSKzP8PWaTqoz/Vmng?=
 =?us-ascii?Q?CdBTXdQIP3C88TcTChNE8q6p0bsHG6LwTxrXLLXqMud4Zm53xHPJJ3JDa+7/?=
 =?us-ascii?Q?Y6fDR1FlcD5POAhZJ+pBkO/thBZ50R55tci9xaSDG5yLP+HXGbvv7SGRv8s/?=
 =?us-ascii?Q?YPekDdkh+zzuspDfbsKakiDV8aHKeCB/3xgixQ/1xxKCU8l+WAHPQPpleRBt?=
 =?us-ascii?Q?ILBXS/CdIyI4D++c5HS8wIB8itMm/F+YbIvvjExDhoWRUh9LPZCgy3/PUJ5z?=
 =?us-ascii?Q?99CBJ+j2oRJqOp9Z7ggW1wIPsmzUAh5lKFT2qHWjrfRjqBHKaOY6CYsEDlW1?=
 =?us-ascii?Q?MJKpN8IcrNoOp9rXcv2dp7ZZ5Q55FRAPvOzwEEbooIdyltqy0GCDC9JLbPfs?=
 =?us-ascii?Q?ngg4x1XuDP4GgfVoRMmOhqUwZ5PNZZiDrvdttP962eRazonUYhKQk273RtAm?=
 =?us-ascii?Q?FIMF25MW/u1NRWFCL7clJB3WFXob73swIn6iXIGXqXOhotmpaXM1xm7aSVWl?=
 =?us-ascii?Q?6lE20QHpsbMQLRmmQu7FRw3ZjOlNM4eWoQzFHpyBvsMcYkqwF/DweRe4STlC?=
 =?us-ascii?Q?gwA32EeBpweQJwMxY61UwiXGTxrgKtiUZ2onXxLAxKESVnGmCdneKSKh0bIs?=
 =?us-ascii?Q?VAeg5BDEkqub4fJcTKZeMkFpaCLfqCW6CpRrWdUs9Vzz1Jli5p4VsCgCos9c?=
 =?us-ascii?Q?Iu5ipJcjafwWocMDA0haSiXn1/wecpqUEbtQwY/lrv8CL7LjGbiUBk7E0gpf?=
 =?us-ascii?Q?WJ8tgNLwYKS7QDRCguMSdhNlzQQrlhSD+aoemb+vdXxNL9LRf1Ni3Yyj0fvH?=
 =?us-ascii?Q?TM4oxZhxTOy/KI9EWZqUX2eyRK6e1uVBmZruoCPDK1l/dgChYaUSvCdXeYlw?=
 =?us-ascii?Q?jIgPuvsLbw1L+e3z3R6KJz61GErY4Ib7yfmSOsct94eg8F5r6CJoKz8Qd163?=
 =?us-ascii?Q?3GXr4/IgzDxeqKbQXxdEtRf5hYSbuSod7wI+2tsEOFetJGyOZY4puoiGTJQr?=
 =?us-ascii?Q?w9TgvK1eA1p9r3ZSSFxafDdteSa5cT55BnDY8cRzTszWVYggFQwZNIDQyJSV?=
 =?us-ascii?Q?9pELfKlUUaRcBTrGBPoQRueyRQNWqpW8x+JcnSNdDD+kdH/J6zTjqtmmznf5?=
 =?us-ascii?Q?3iS1hVZXkJEDls/CFOqNgNhshHXEEztVu6xZ+4kUa4cSQ5tVK8t0UdF8YMi1?=
 =?us-ascii?Q?3KYMVHxE6GwFdRwWL47Mvtkh9FnYzI5fMiBZas2eNDI2xk/FG5ll3WXRDuFP?=
 =?us-ascii?Q?HZDLg0mrU0j9eMGh0YX0rXW6?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ca5afc-286f-4095-5d67-08d993ff97cf
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 19:27:02.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhljivYMr0Rx0GFXEkidzzaNMYwtrqCYVoj/1EMFCkw1wy1NfVkc+WQ/Ik2NUmCGw4pUYriwizORfA3IhxCCqKU8dNwxcOg2Q9eUmgd2F5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7032
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,
here a couple of fixes to properly handle imx serial console
unregister/register at runtime.

The patch from Stefan was already posted years ago but never merged [1],
however is still valid and it's pretty easy to trigger the problem. We have
this patch in our kernel tree since 3 years, but for some reason we never
managed to upstream it.

As correctly wrote by Uwe [2] this issue affects multiple drivers, I could
provide a patch for those, but I will not have any way to test it.

The second patch is required to have a balanced clock enable/disable
when doing console register/unregister.

The issue is present at least since
a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")

[1] https://marc.info/?l=linux-serial&m=154221779312036&w=2
[2] https://lore.kernel.org/all/20211014081028.xafpuzrxk3jvv5qn@pengutronix.de/

Changes in v2:
  Improved commit message and added fixes tag.
 
---

Francesco Dolcini (1):
  serial: imx: disable console clocks on unregister

Stefan Agner (1):
  serial: imx: fix detach/attach of serial console

 drivers/tty/serial/imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.25.1

