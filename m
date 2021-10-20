Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE9FC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2368560E74
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhJTT31 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:29:27 -0400
Received: from mail-eopbgr130105.outbound.protection.outlook.com ([40.107.13.105]:49824
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231607AbhJTT30 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 15:29:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIJeXsWuvjBrRNVJeSWJqhf2yWsOfCKqDr4OSXwjPnl0XbBOeUh5nj5SjRCNUb+jnQKwh0gQdt4EVjLqB+Mm8eNAkVUXyx+SOd3MIoL+llyUaL1ea3oZ5E7WKve1QIP1wZECoBZCACixdt1Z4Lwa+gxGmi7AnmWTtCeQt59sKDflGh5EHz0tCOzqRIh4VIxi+xqKitM2j36nF+Syq4b1dsIQeaHTyMA8KR09aa5fi+Xjy8gjOtjeDf6DXARvfgsqwmPEqcbhrCYP/IX3buarWAxse8IVIdF2Mnq7CfLy9p51zqQtv2l+Ks15w0TqtEJQua9Z/Hsx8ji5C2UsQzoEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTTCLCzfeeMPb581lZEqzPxHYrDOhuXAn38aWuYNxeI=;
 b=MfD0dXv1PvsAmNy1zTP6kLBcoYtpKoPFH11Mr+DD/pSwAVIgYicjCqtG1V8zQ4nNu8ueFsd7S3u0s04FeidlrtXPWt2P7ifyg6ulow2f/4STgqmv18uqMrVqB7Q/7VgMrSRQ1Q5L1hjLHd4noXivdOausr5kZv++rVz+osEv+AMe2R6FO4Lx613Wo6kirnkmhK5M8Y7FeV+lh735GEAg/kaEby4Ezal7/ck5CTC+6jWxHI0XIG1vM+HSibxSorCZzKyRIIiNVB1+vEyIbIX5LXv6jU7OH1r7dXOSfMit+hZoz3z4uHhlKrt3Du/vE8Hb0SCXnmaBV2fN74oK8z70HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTTCLCzfeeMPb581lZEqzPxHYrDOhuXAn38aWuYNxeI=;
 b=lXPd7T3ZwvTMhMPrpZWRVKPtDx/T0ytXkivUqXXmMyvpsH90qXkzR9xsy3tvJibfb6QgA1gL1SVkmm+Sp3a442rcW2Ls3rWBsGlSyTRL6fo04usN8pVUlcrmF+OqgYQHfTeakwJtV+uBsdbcrIgg4Kjo+AGtP1beug+hQeHSSJA=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DB8PR05MB5947.eurprd05.prod.outlook.com (2603:10a6:10:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 19:27:06 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 19:27:06 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/2] serial: imx: fix detach/attach of serial console
Date:   Wed, 20 Oct 2021 21:26:42 +0200
Message-Id: <20211020192643.476895-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020192643.476895-1-francesco.dolcini@toradex.com>
References: <20211020192643.476895-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::10) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (93.49.2.63) by GV0P278CA0077.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2b::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 19:27:06 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 9E3DC10A393E; Wed, 20 Oct 2021 21:27:04 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e2b8b0e-bf6d-400d-1305-08d993ff9a21
X-MS-TrafficTypeDiagnostic: DB8PR05MB5947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR05MB5947141BF5F86AA198885927E2BE9@DB8PR05MB5947.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wvnjnIuIhrpjMI+qG/y6qvVZNaZusBApu2LjrlvVjc1lgbCMi3bkToQvXANlC17XRAAzMb1+sXAJwHa1n41afvUMfR7i3yDuWx7QQFbx8HVHy+j6VKkDBC7wp08Lc1x82jQ9dPBmxvBvCxFAlDumgxiAXb1rzg9dRfo6fJk9+KkF8Hy3QZ03qtB/G5RLE9ngm0lISfEmXhnUpVbakVD4o8W+Y4al67tEK0TTKhyh21le/yjl3mpjf0LzAQivR51NtlYNlK/LND9Qz0hOQ2tdy8XNkMCGDncHKt/lJkei2XWFtvQKs1LGQOtWR4h4R6kaLOh1G1rf6ZrgukEhGVGpRgxRwKOslzTo//z784thcUcWChX3r+tH/rCiS53AhkwLhZHe4EF+zXWYG5yXseTnTqvCIQVlZyTx9cnr7mSrct9xZmq7eITQPdIFgkuHnzWAKpzIvG2EFaWu60nHP2GgH309Pupg78D06htbAn0Yufaz9kChPad44G+8LizCM3n/bRDpW5EIjgq0nmB5Mzzcwz2KRlkIcp8AOMBuxVSSomRtc4vFTn8sNBjTpx9pgvt8CpkF1J07u9Ivf5uJ18d1m2m0emgALc1qkgM905+QMjF6gNFwHZqIIyurQ0MjTzTBFDdYoBoGYkpSxhSgMwCXuWbzWiut2ZfNANxpWZdFwZbN5q1mwGILsikDH2dF8lMT0M4SW3xGQNUxL2LmqqHZBKXJGuP+dy5q+o/d+WqaOhLMCkbzNnYwq7coWIHcsJ5X5csJ/cMzCye2JfCH8AJO8t/XTKMAHa9iU2Hlh2yzSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(6666004)(36756003)(54906003)(8676002)(66476007)(2906002)(4326008)(7416002)(2616005)(316002)(44832011)(5660300002)(45080400002)(1076003)(83380400001)(110136005)(38350700002)(66556008)(508600001)(86362001)(8936002)(26005)(52116002)(186003)(38100700002)(107886003)(42186006)(66946007)(966005)(6266002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGH058uz8VqPa2JLn8aqDoXmtMdFAvxajVQMhh9A9THlhf1q0YjWhHaJvl7r?=
 =?us-ascii?Q?Wcscqmka+9X0ZOVsM7Fb/jV6x9Ib70shj3uBj+3jDdUsQtbAML0sohpUqopG?=
 =?us-ascii?Q?c4tjYpLKLVp/ZaqCWnKGMazQ8eDhQzeYtMh17uAbqLpkr7W3MeHJC/hIWbWs?=
 =?us-ascii?Q?VIR3V3eKvSwVseVpsRBbnhrqr7YYPvufnyDiMAfd7NNkrHP1K81wOFFAaiya?=
 =?us-ascii?Q?Vvuvrs21bgUkHKe3CB1wjAHon1uga0pi1V6sR+Gl3MgUo5cSHBTFvLDj53X9?=
 =?us-ascii?Q?qRV+8jpWbS2CIoLK0Sx412R9XXaTqXwS0FuvNz5pt+B/BLPaV08+FS3Tjrsr?=
 =?us-ascii?Q?Hlb0MjRqhrjCf3ZrB4uauLbDnR0ihOIBSCEd1fbMcAGqW4mIQN8XNTy8xyIF?=
 =?us-ascii?Q?2tsNJwbbOTQqX124gUpisiy9bao9DJYBpsn1WIe3r2US+AKKsVZwaqWJY8QE?=
 =?us-ascii?Q?1IigIWf2RvIUaYokj74lYwou1K89UpuAT1h75Wce6dTsI8M01wlC2VsKYRMw?=
 =?us-ascii?Q?HiJu4mZEDBrZ84uwVW2EcJhT7t6BWBxncykeU9Wl83+cu9uz2v3dqC1ouXhI?=
 =?us-ascii?Q?8FzTg4L4eik0XnR1V4wP6XZ/Z+96yo5j4NaGLSf8A6fpHwN80Cvk3eHNiL1u?=
 =?us-ascii?Q?/60Ak9ufTYw2QBYr52BmV1peMvFLW547NzPoVysmPXExYLFmv6tfPYWPl4Px?=
 =?us-ascii?Q?NT8thQqbQzccIQqb6edB/USuZ5aaMBm2ircDXoNYFCeUILG0dkpUgeB5iijC?=
 =?us-ascii?Q?k/M1HH68MPV/5tRKU+ReB00xlEYn3eFJsT3GTLpgFTenqi+RAyB0QiQqJJss?=
 =?us-ascii?Q?kPFXCrIRwCInkU2LtwjczhqGQupnOJBb4p0/O8+BxVCjve2fZItua4guR+H6?=
 =?us-ascii?Q?NKFILVIvh47TyLJzZ04GbcJ9g8i+nyL0Yh+NRc4y4CRXwsLvjv3XOB+B4Xt0?=
 =?us-ascii?Q?Lm4NQT/15g4rsxWenQ4OVz5A3v86w28lYSI9AeyGsMYjnaKpSnIV1NiJadNG?=
 =?us-ascii?Q?fAoutu1I7BpvdFC955UI6ds9MnqYZwMwbz0b6rpOekM4jFF3j0WQ6yYIfZxR?=
 =?us-ascii?Q?GOL8hx6eOphQw13IlJ/rgkl8UHrPGjS/IPp0l0ytmXaGozQ/ufSl8BArFZus?=
 =?us-ascii?Q?pm51AATnaY/F8WCGqt99KUhNlAJi7k+ZfvnMUlJp3Mji4f/YI7+16E076tnk?=
 =?us-ascii?Q?uTvw+Y8TPAPQ1hAZd9BCtVoWdR7BamHwKPNRJhw8HrAIJG/eN+beMZHGwW/y?=
 =?us-ascii?Q?tSHX+zy4m4trc/Fz3fM5AV57Vq68MqNnL1ar0vsjCuwypEWYcoPf+911Wb7V?=
 =?us-ascii?Q?hHLYpxhOFFhn2H1J3I0hzrBE?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2b8b0e-bf6d-400d-1305-08d993ff9a21
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 19:27:06.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HSwQIGZTXr72gtnSnNsE8KB+mUfE9/rXNLeXql4DUgeiNHbcJF0YBZWFw7CMvjdL9v8ZycAClxDoSS71auu1bNXAKEQIplg5FfugNceLm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5947
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

If the device used as a serial console gets detached/attached at runtime,
register_console() will try to call imx_uart_setup_console(), but this
is not possible since it is marked as __init.

For instance

  # cat /sys/devices/virtual/tty/console/active
  tty1 ttymxc0
  # echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
  # echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console

[   73.166649] 8<--- cut here ---
[   73.167005] Unable to handle kernel paging request at virtual address c154d928
[   73.167601] pgd = 55433e84
[   73.167875] [c154d928] *pgd=8141941e(bad)
[   73.168304] Internal error: Oops: 8000000d [#1] SMP ARM
[   73.168429] Modules linked in:
[   73.168522] CPU: 0 PID: 536 Comm: sh Not tainted 5.15.0-rc6-00056-g3968ddcf05fb #3
[   73.168675] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   73.168791] PC is at imx_uart_console_setup+0x0/0x238
[   73.168927] LR is at try_enable_new_console+0x98/0x124
[   73.169056] pc : [<c154d928>]    lr : [<c0196f44>]    psr: a0000013
[   73.169178] sp : c2ef5e70  ip : 00000000  fp : 00000000
[   73.169281] r10: 00000000  r9 : c02cf970  r8 : 00000000
[   73.169389] r7 : 00000001  r6 : 00000001  r5 : c1760164  r4 : c1e0fb08
[   73.169512] r3 : c154d928  r2 : 00000000  r1 : efffcbd1  r0 : c1760164
[   73.169641] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   73.169782] Control: 10c5387d  Table: 8345406a  DAC: 00000051
[   73.169895] Register r0 information: non-slab/vmalloc memory
[   73.170032] Register r1 information: non-slab/vmalloc memory
[   73.170158] Register r2 information: NULL pointer
[   73.170273] Register r3 information: non-slab/vmalloc memory
[   73.170397] Register r4 information: non-slab/vmalloc memory
[   73.170521] Register r5 information: non-slab/vmalloc memory
[   73.170647] Register r6 information: non-paged memory
[   73.170771] Register r7 information: non-paged memory
[   73.170892] Register r8 information: NULL pointer
[   73.171009] Register r9 information: non-slab/vmalloc memory
[   73.171142] Register r10 information: NULL pointer
[   73.171259] Register r11 information: NULL pointer
[   73.171375] Register r12 information: NULL pointer
[   73.171494] Process sh (pid: 536, stack limit = 0xcd1ba82f)
[   73.171621] Stack: (0xc2ef5e70 to 0xc2ef6000)
[   73.171731] 5e60:                                     ???????? ???????? ???????? ????????
[   73.171899] 5e80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.172059] 5ea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.172217] 5ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.172377] 5ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.172537] 5f00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.172698] 5f20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.172856] 5f40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.173016] 5f60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.173177] 5f80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.173336] 5fa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.173496] 5fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.173654] 5fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.173826] [<c0196f44>] (try_enable_new_console) from [<c01984a8>] (register_console+0x10c/0x2ec)
[   73.174053] [<c01984a8>] (register_console) from [<c06e2c90>] (console_store+0x14c/0x168)
[   73.174262] [<c06e2c90>] (console_store) from [<c0383718>] (kernfs_fop_write_iter+0x110/0x1cc)
[   73.174470] [<c0383718>] (kernfs_fop_write_iter) from [<c02cf5f4>] (vfs_write+0x31c/0x548)
[   73.174679] [<c02cf5f4>] (vfs_write) from [<c02cf970>] (ksys_write+0x60/0xec)
[   73.174863] [<c02cf970>] (ksys_write) from [<c0100080>] (ret_fast_syscall+0x0/0x1c)
[   73.175052] Exception stack(0xc2ef5fa8 to 0xc2ef5ff0)
[   73.175167] 5fa0:                   ???????? ???????? ???????? ???????? ???????? ????????
[   73.175327] 5fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   73.175486] 5fe0: ???????? ???????? ???????? ????????
[   73.175608] Code: 00000000 00000000 00000000 00000000 (00000000)
[   73.175744] ---[ end trace 9b75121265109bf1 ]---

A similar issue could be triggered unbinding/binding the serial console
device [*].

Drop __init so that imx_uart_setup_console() can be safely called at
runtime.

[*] https://lore.kernel.org/all/20181114174940.7865-3-stefan@agner.ch/

Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..51a9f9423b1a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2017,7 +2017,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
+static void
 imx_uart_console_get_options(struct imx_port *sport, int *baud,
 			     int *parity, int *bits)
 {
@@ -2076,7 +2076,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
 	}
 }
 
-static int __init
+static int
 imx_uart_console_setup(struct console *co, char *options)
 {
 	struct imx_port *sport;
-- 
2.25.1

