Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF0C352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A241120714
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 06:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMhVRzlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgBKGVj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:21:39 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:57934
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbgBKGVi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 01:21:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cloR8y12DSTUif+vuMTiKCIibxo96nqIB7tlTNYZ29r2+Ujno1tnhnOkWN9FJSL+5KEKaqSG+Dzih8f2EhiN8Lo9KkEcrrtuhML28zh4MIhX2AVXCnxHTFLXaQa53JmLTjixK/qwDW1w7VRGyddUBx3ICg6g1N34f9pR3KWYiOFyRVKFkVVGlefQAALRZmyZAj3XAbm9STZ/sQybVDdGX2QSKz2NhYfJl4ROmW/2vxm6Z0oYODp+54/COwnEBU3PNU3IghsbG2OQkXebXT8uPTS2bvFgw1v8D1C1Xj4bXcOTgb7/x7bOTc5BG5dJOyXStzS7Ef0k7LzB+iIQJPsvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rlicczrEB+HK7pzWeqti46+9AgFPGa/2GEf0S/LhLo=;
 b=TU6cdgcr7fVhZVg9ZtIAbWGKKvCHmmjkUT+dOYrhVkiTpq+eCdjXdiJZdjoFOJVoXgmgDJlt+1iAgIeAYOIXdpGsfvO6NRe2r2wKNSmF08+N3oQzD2xp4qJ0QAgh5hDt4teohAWyPfimo2nrPcxcKWGg3FsrpSjcBPcGq5X0KCkprucjOXq+Bd2MzGMNQNLwUddu4zBXY4my6Mn8H5XIvcBTV+1m3t3mcJxyJN74k+YRNylYu4rJvEzF62+3hxJ9jU+dXA7ZjPn1S5tqV19QbuUCv4V+uG556s3+Q+TenKd/EYZ2U0cQJLo5WSrM7FVtMnWR8iibaYEbuxtaX6jiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rlicczrEB+HK7pzWeqti46+9AgFPGa/2GEf0S/LhLo=;
 b=KMhVRzlUGkDEt7w2qFnJXtbUTUh7J3WyNQS+AnpX51zG32FPj66GPYYuVcWep0/PgzW/sjnfCxV97Kozw5mYH24FzfCzSJi+8ZCGBz7wRD7AjbV/wLe8IZ+Bg2nbk1QzgzedNSfVQX3o9kPt9e2QbTOZCCdf0v40zIUsYXBoWNE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB2766.eurprd04.prod.outlook.com (10.172.255.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.30; Tue, 11 Feb 2020 06:21:33 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::18c:4d15:c3ab:afa6]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::18c:4d15:c3ab:afa6%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 06:21:33 +0000
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Subject: [PATCH tty/serial 1/1] tty: serial: imx: setup the correct sg entry for tx dma
Date:   Tue, 11 Feb 2020 14:16:01 +0800
Message-Id: <1581401761-6378-1-git-send-email-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To VI1PR0402MB3600.eurprd04.prod.outlook.com
 (2603:10a6:803:7::18)
MIME-Version: 1.0
Received: from b38611.ap.freescale.net (119.31.174.66) by HK2PR02CA0143.apcprd02.prod.outlook.com (2603:1096:202:16::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 06:21:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c04bd32-3b3d-4025-0eff-08d7aebaa407
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2766:|VI1PR0402MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2766D14182B311FEF72192E4FF180@VI1PR0402MB2766.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(5660300002)(26005)(4326008)(2906002)(6512007)(9686003)(16526019)(478600001)(186003)(36756003)(6916009)(6666004)(6506007)(956004)(86362001)(2616005)(6486002)(8936002)(52116002)(66476007)(66556008)(66946007)(45080400002)(8676002)(316002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2766;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/S6jgCJ0Ixz7jpGNnnnWqRiJaZ8uHKI58LUEmGU5uILCzUXn3COqehLGgmAWQ/tRDFQTMGGaZR7NONMSqm5UxpqhbSbhzj2CNuG+QyBvl2hN2518qmSTVSRzwQXV1wKaTv4gLtBIyyhfoJcpi0ExQWmu6puNU9HuCmrXInymIWnvuYm3mQ4zIi7i+LsKnyrtsbO70rZ9ytu7FasMY90x4jqecL5XadHnYyvCOqGVu8F17b1TjTCY9Ym7eTdjmlZ5E4NdDRPc1CFavendsQpiHIvhBZ6DjoKzRmUkj74Jg3w/UurRIbAMe4nCOYKHy67wfKOOT9N2o39MM5U8klGY8IYxHUdMHihHly0NLbbdQI4DCKGfSdl8EpyqjIO1KunPk0+va200uykp+oTQ5HosmFh5wWGB3Bv4WWS3Dy4qQ1PzoQjLYZoOYdAD57d3als
X-MS-Exchange-AntiSpam-MessageData: k8uAYIDsDOACyVrzMLA7+cK3zW7MUFhaa33pcm5PXaraMtKUiF1XiwE5+2GT9avovnC5liUkNSmSN6gXbd5/eWzQZ6+E6GCMwHBab8bLPofIzZYYEgUAFcchnqRxANZGqfnoAqmQhDzvuHg2qLcqbw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c04bd32-3b3d-4025-0eff-08d7aebaa407
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 06:21:33.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkpVQ5z9Qb/2Cjtjrkxu+gdGEsMjAJSdRmzwZwVXQC6QwlZeIKTxfhqfDqL+GLSqw2gCMrd3KRWctjaP3bzUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2766
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

There has oops as below happen on i.MX8MP EVK platform that has
6G bytes DDR memory.

when (xmit->tail < xmit->head) && (xmit->head == 0),
it setups one sg entry with sg->length is zero:
	sg_set_buf(sgl + 1, xmit->buf, xmit->head);

if xmit->buf is allocated from >4G address space, and SDMA only
support <4G address space, then dma_map_sg() will call swiotlb_map()
to do bounce buffer copying and mapping.

But swiotlb_map() don't allow sg entry's length is zero, otherwise
report BUG_ON().

So the patch is to correct the tx DMA scatter list.

Oops:
[  287.675715] kernel BUG at kernel/dma/swiotlb.c:497!
[  287.680592] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  287.686075] Modules linked in:
[  287.689133] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.3-00016-g3fdc4e0-dirty #10
[  287.696872] Hardware name: FSL i.MX8MP EVK (DT)
[  287.701402] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[  287.706199] pc : swiotlb_tbl_map_single+0x1fc/0x310
[  287.711076] lr : swiotlb_map+0x60/0x148
[  287.714909] sp : ffff800010003c00
[  287.718221] x29: ffff800010003c00 x28: 0000000000000000
[  287.723533] x27: 0000000000000040 x26: ffff800011ae0000
[  287.728844] x25: ffff800011ae09f8 x24: 0000000000000000
[  287.734155] x23: 00000001b7af9000 x22: 0000000000000000
[  287.739465] x21: ffff000176409c10 x20: 00000000001f7ffe
[  287.744776] x19: ffff000176409c10 x18: 000000000000002e
[  287.750087] x17: 0000000000000000 x16: 0000000000000000
[  287.755397] x15: 0000000000000000 x14: 0000000000000000
[  287.760707] x13: ffff00017f334000 x12: 0000000000000001
[  287.766018] x11: 00000000001fffff x10: 0000000000000000
[  287.771328] x9 : 0000000000000003 x8 : 0000000000000000
[  287.776638] x7 : 0000000000000000 x6 : 0000000000000000
[  287.781949] x5 : 0000000000200000 x4 : 0000000000000000
[  287.787259] x3 : 0000000000000001 x2 : 00000001b7af9000
[  287.792570] x1 : 00000000fbfff000 x0 : 0000000000000000
[  287.797881] Call trace:
[  287.800328]  swiotlb_tbl_map_single+0x1fc/0x310
[  287.804859]  swiotlb_map+0x60/0x148
[  287.808347]  dma_direct_map_page+0xf0/0x130
[  287.812530]  dma_direct_map_sg+0x78/0xe0
[  287.816453]  imx_uart_dma_tx+0x134/0x2f8
[  287.820374]  imx_uart_dma_tx_callback+0xd8/0x168
[  287.824992]  vchan_complete+0x194/0x200
[  287.828828]  tasklet_action_common.isra.0+0x154/0x1a0
[  287.833879]  tasklet_action+0x24/0x30
[  287.837540]  __do_softirq+0x120/0x23c
[  287.841202]  irq_exit+0xb8/0xd8
[  287.844343]  __handle_domain_irq+0x64/0xb8
[  287.848438]  gic_handle_irq+0x5c/0x148
[  287.852185]  el1_irq+0xb8/0x180
[  287.855327]  cpuidle_enter_state+0x84/0x360
[  287.859508]  cpuidle_enter+0x34/0x48
[  287.863083]  call_cpuidle+0x18/0x38
[  287.866571]  do_idle+0x1e0/0x280
[  287.869798]  cpu_startup_entry+0x20/0x40
[  287.873721]  rest_init+0xd4/0xe0
[  287.876949]  arch_call_rest_init+0xc/0x14
[  287.880958]  start_kernel+0x420/0x44c
[  287.884622] Code: 9124c021 9417aff8 a94363f7 17ffffd5 (d4210000)
[  287.890718] ---[ end trace 5bc44c4ab6b009ce ]---
[  287.895334] Kernel panic - not syncing: Fatal exception in interrupt
[  287.901686] SMP: stopping secondary CPUs
[  288.905607] SMP: failed to stop secondary CPUs 0-1
[  288.910395] Kernel Offset: disabled
[  288.913882] CPU features: 0x0002,2000200c
[  288.917888] Memory Limit: none
[  288.920944] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Reported-by: Eagle Zhou <eagle.zhou@nxp.com>
Tested-by: Eagle Zhou <eagle.zhou@nxp.com>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0c6c631..d337782 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -599,7 +599,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 
 	sport->tx_bytes = uart_circ_chars_pending(xmit);
 
-	if (xmit->tail < xmit->head) {
+	if (xmit->tail < xmit->head || xmit->head == 0) {
 		sport->dma_tx_nents = 1;
 		sg_init_one(sgl, xmit->buf + xmit->tail, sport->tx_bytes);
 	} else {
-- 
2.7.4

