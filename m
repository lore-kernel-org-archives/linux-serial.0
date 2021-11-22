Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B78C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 12:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhKVMOg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:14:36 -0500
Received: from buffalo.u-blox.com ([195.34.89.137]:56572 "EHLO
        buffalo.u-blox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhKVMOg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 07:14:36 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 07:14:35 EST
Received: from mail_filter (localhost [127.0.0.1])
        by buffalo.u-blox.com (PF_LO_10026) with ESMTP id 2D2803A204
        for <linux-serial@vger.kernel.org>; Mon, 22 Nov 2021 13:04:13 +0100 (CET)
Received: from ASSP.nospam (localhost [127.0.0.1])
        by buffalo.u-blox.com (Postfix) with ESMTP id EAF0639E54;
        Mon, 22 Nov 2021 13:04:12 +0100 (CET)
Received: from unknown ([127.0.0.1] helo=anyhost.local) by ASSP.nospam with
        SMTP (2.4.7); 22 Nov 2021 13:04:12 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXIPpSGqMlpyvBqMJiSoB1JmNeYSZaRkovqePWSS8T//cbRLPo93ywAn4SmGlcLwmpilPTULUTVCPEdlwd1FW7g0jZC9+NDZduOq8OwdJaEqYepu4she5ufzK7eh0oT2TNqTX60J6Ityq6WS7Kjb97lfTBi2fTyjLp/jxWSZKG19tE/LdkQJdJO1A9DJ4V2Wym63G8CO6+wdaruodWyE2QxTg18X9ic5vUrs17V+KFqerLo1B1IOLlp3VP4F+RQIYvqjc8eoKrz+hcE9nRO3ZFQlHBMunUX2Gyxmdo7RhliwDnIX9T52i1MdA65EqXMao1b4ZV1TzzAzT7P0h9Ledg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmSXeDFDHvEewL38BwV+YtLlmh8gGTzc6zw8ZSH7WK4=;
 b=Sy0kkVuZuuS9XOuuhBVqG3bETy/M8eLQ7j/iEUsAuY315e+42NI+qtNd2wjfT0xU0z8GuaQNQXIJWgaPNUHRSEZ7Hw1ARUlQefGGdK6HlQdmR3n+y+HQzV7gEJKSa84rlfnq/p2ieOe9V3DKp7welmySWxToEs5YFTMW4DXRhctyiKmJlVgwQD1zFk+Xg1PN6H/usP6aqh7sNb0hg7knNdxyCxCT1S2VzV6bEQQvVNuT0mBdH/hamqaiCjeoN5vMshMaTQAbjs/L+DRfAY4woZJ/qWAZGtLDsjQyZxJ8yiqkLu8CKXBH+3aByEcSa+iV5MSALTE92+1zuFLD68XrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=u-blox.com; dmarc=pass action=none header.from=u-blox.com;
 dkim=pass header.d=u-blox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u-blox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmSXeDFDHvEewL38BwV+YtLlmh8gGTzc6zw8ZSH7WK4=;
 b=l9lCptFcrPqcyea/+vk4/au4r5DKqQQ3JqOFd7dCRJh+31dhsFcBAq9frumP9YSsncs3YKnq883HdeX2xUscsqYX/heCcSe+emYRElh13FEwPfYtio+rlbLYTIxTxoE34DgkqazjocRO2Xg0EtoS+JsEHv5Zf8HVuAC/8IQ421o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u-blox.com;
From:   Patrik John <patrik.john@u-blox.com>
To:     <gregkh@linuxfoundation.org>
CC:     <ldewangan@nvidia.com>, <linux-serial@vger.kernel.org>,
        Patrik John <patrik.john@u-blox.com>
Subject: [PATCH] serial: tegra: Fixes lower tolerance baud limit for older tegra chips introduced by d781ec21bae6
Date:   Mon, 22 Nov 2021 12:59:14 +0100
Message-Id: <sig.09604dbdc3.20211122115912.73522-1-patrik.john@u-blox.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::26) To CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:7c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 887d736b-7063-4cfc-c446-08d9adb031d4
X-MS-TrafficTypeDiagnostic: CWXP265MB3973:
X-Microsoft-Antispam-PRVS: <CWXP265MB397362F470FAF80A65FE452BCC9F9@CWXP265MB3973.GBRP265.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhLNhx9d2c+zAzOdEKiBQR4TkN6OA6Ev1lwgcqT8pW6z+jq8/CSHymkhNCNOm0f4K8wAXD4f553PPJ1MV5mFQLp9uVwBGnAGWhmW+jEMGGFRRxaNBong1VwB8c3xvmHDBF4Zb8JhZjRfUH/IaZIeKo4zFCw6rNjNpGHDoJwiCpzt0UBZ17BgCu2ccwq5t9+uTzQ/+6gm0eloarACcCmAIL4E0IHDjgIq1YBq5HlxDRZnH2ZT2s5pPLrwbriCpo9JzMjp2meaf5qJkcl+fxm++Q4UdFnS9HIohfyoianX6grsu//WUBRmtu8J6qHmwqiPE0maIhNO0bb7312YFitNSv6Y5tuBx+E2jW+FTAbYGKd+r8ZjeGJnfKcGQgvx6eye07tUbTrnysy9LbJSToZLn3od4BHRa41lqYCo827pyU0I4JTaM/XsO8EBaIwQH01WcuKkJbY2Ao8dgNTAS03HqC8URwtOpm30pS/emZWOaFk3l3/mvZK8lLg8WJiFEI0PVcIk3NmdZi8rYVokgwpdkPHfexHHJWF4YZyDrgA2TIBHEDhdV8Zsm+qP+vh8YraThNa4uxfx5J4l+RwO/yAIaIgn6JNOl5v4MJANOm6sW+OrGxMR6spkW6UfMWFSb2jO3Fdz+/AzLQ91lHyxsSW/zZE08HsmB3DelhzKIt0Mjt2aDIzp/1/WeNu4EN3IYK02Qk73skidzz4PnxKll8zoR6JhIpNpgM3gDysmpPg1s8trHt6t2VDKzRXYLlC3Kz+NGrtnn4vUBvdECftiEU26s9rnNvyAIQ2szmgxkNSuk/rs2am1YmlfzQGv/l2TzM34+s6rceyOV7E/wRM001OqBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(44832011)(1076003)(107886003)(6916009)(26005)(36756003)(956004)(186003)(6486002)(5660300002)(2616005)(4326008)(83380400001)(38100700002)(2906002)(86362001)(8936002)(6506007)(966005)(8676002)(52116002)(38350700002)(66946007)(66476007)(66556008)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uw0Mx6F9RAu0Ltcnx4u1Q9oBcrGMqUZefyn2KK6EB4xZnaDKYeEWnV7uDtYL?=
 =?us-ascii?Q?yeuHTiabSu2Jvf3t5kJqIwvd9KJP8tfpmK5qNb0JaB90XYC1BX9ChGLefTRr?=
 =?us-ascii?Q?Bs6sLddzoN3ClY1MLpE62PMQN4O1HETcQiH6PnWV8FwK2MRkx4MYP5UlyJlH?=
 =?us-ascii?Q?JpOM3cpMJm+loLpjbsrOa4Jx0yKRMeOOSTNdX7RIKt6RgAdT7yUBCxJEAde5?=
 =?us-ascii?Q?ZcjscGG2YzXvFRDrG3gSiB4gVr7b/NeFM0mIQZIhN4AniH6z1ZC1qoWKSZBu?=
 =?us-ascii?Q?tSwt9y1HKjL1C/ajzJqGc94WKrVjcc4C+09JLEGhd+vNjTJwOx2n1vFrZsuW?=
 =?us-ascii?Q?MIg1ptAQYMIKrdR7Rjy4mwgFw5D2RsrBQHWhrUERkHvKnJkffMZiiVcAGsa5?=
 =?us-ascii?Q?KI30kApyRWg0SxfNI5QXnsjXmLgJTQbxQZWeFtw9LprY3RTGBXYCelOlmz0F?=
 =?us-ascii?Q?Q1uYyPFKqSwlj4QmSc3qIHTg2m7dgY3U0c/S83NZ+bWznGFZXJZ4BeUpQAqC?=
 =?us-ascii?Q?B96mqXbVhutsOsUuxFKHzDESRTjaXfUBG+U7JzXSfYyiOhDpJ7gQS9Dw7Jv/?=
 =?us-ascii?Q?yaBFfjZwMq80rVd5ITexUz1Nh4IrGrMyhMXDYpXvIbjInSifIToGI1fpWwAt?=
 =?us-ascii?Q?1m0+ekWC2m6Y9mT4Galf8rc4RXKiptkm5J2DlCqjoWfX9makhbfW8s/M/xh/?=
 =?us-ascii?Q?0A/h1aRpfWba9zIPLTP1AAOTZHKRnUxK41A/tv6ZsGrZ90kNjDMRtKWTwghr?=
 =?us-ascii?Q?HIk1GTwHFYD6b0xKLbG33pjuDmT8j4NNPJV1nQd8g03iv8nRVJJiNnj5TflA?=
 =?us-ascii?Q?dr8vsUfBcT/hjBIv5RMcnN3KghV1OgelpGDgKypLFDBOrRS/6ne470MrEBf/?=
 =?us-ascii?Q?eaSFDiyVzwUOBwORSD+adj9OZRMXOdo5g3Der4wq1UpR25dmiPKFnw2AODx4?=
 =?us-ascii?Q?1dtgFyWjlx5/56K/GNDu7Lo3EEpYqbnB4MU02xHZFbDD5h5Ty83FZJasCqrj?=
 =?us-ascii?Q?g9aTdaKPcMOxJBelNuYJMg9WFmIyjqe1OQWkk800VbNz/g30DEx1vb7q0Mss?=
 =?us-ascii?Q?v5ZHpEnkAmDnKDRwjEpfLDOu96Am4T8s9dwm8u3aTiPGAO6bXuahSjp8mp9n?=
 =?us-ascii?Q?oNqyoiBrtLiQKCvqGKbelU43idsiuWFB3Elr69dA4t3J/CMsHE5pHKbsM4PT?=
 =?us-ascii?Q?+/DE2TJK/SlJ9pG1oMdQtEa4vP0dV5oczBNRxtykfYSQq6uZDXpLqLBQzMGz?=
 =?us-ascii?Q?kQTvU4FGd02A+YpL4mlu1Ogpmz6k92HpDkHiYVOtTtL3lCUuKG0GjTvDbRh3?=
 =?us-ascii?Q?O5bf0omJXrBXwh5BEValmlbcn3VXYvrECRKLNundek8UZXi4DzorcC0YAdd1?=
 =?us-ascii?Q?Q216WaopDgWQYx5v9Tc23BGG+xRYuhiYJ6oy2ao1MTgvDbU3ci1Th3eadL6G?=
 =?us-ascii?Q?1wDDNqP57IZU96N5T3i9yH1uYi5iyNg9GwaJbCmvcgTL6TVbNXuHH/e8Buil?=
 =?us-ascii?Q?GCMBoW09gdWR21okn8t2E1+DLX+A/GD/yZTYJ810UJLXMWUfbYxXsiIUBAHl?=
 =?us-ascii?Q?xuCqkpcXwbDxfJjv2uNbso0/mPkO6ouUJXr+TKCeMOJzxbRqnIf4iXOpHMD+?=
 =?us-ascii?Q?/AwiKSIUbyjobsaAEWXwHnA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d736b-7063-4cfc-c446-08d9adb031d4
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 12:04:11.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80c4ffa6-7511-4bba-9f03-e5872a660c9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kEBSgxkIPTNiYu9tdcQA1Pv0xdzu0aFq2YRnxwXUcoE6C2CtXTToqkn9uyA9UA2iViBBS9af2yf+AAEYU6UNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3973
X-OriginatorOrg: u-blox.com
X-Assp-Version: 2.4.7(16004) on ASSP.nospam
X-Assp-ID: ASSP.nospam 82652-20168
X-Assp-Session: 68A0092C (mail 1)
X-Assp-Original-Subject: [PATCH] serial: tegra: Fixes lower tolerance baud
        limit for older tegra chips introduced by d781ec21bae6
X-Assp-Client-TLS: yes
X-Virus-Scanned: clamav-milter 0.99.4 at buffalo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for tegra chips other than tegra186.
This causes issues as soon as the baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30 as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)

The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).

The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.

static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
{
    long diff;
    diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
        / tup->required_rate;
    if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
        diff > (tup->cdata->error_tolerance_high_range * 100)) {
        dev_err(tup->uport.dev,
            "configured baud rate is out of range by %ld", diff);
        return -EIO;
    }
    return 0;
}

Changing the lower tolerance limit to the actual -4% resolved the issues we have seen with the Tegra124 and should resolve potential issues for other Tegra20/Tegra30 based platforms as well.
---
 drivers/tty/serial/serial-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 45e2e4109acd..b6223fab0687 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1506,7 +1506,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
-	.error_tolerance_low_range	= 0,
+	.error_tolerance_low_range	= -4,
 	.error_tolerance_high_range	= 4,
 };
 
@@ -1517,7 +1517,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
-	.error_tolerance_low_range	= 0,
+	.error_tolerance_low_range	= -4,
 	.error_tolerance_high_range	= 4,
 };
 
-- 
2.25.1

