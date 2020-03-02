Return-Path: <SRS0=YLjw=4T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A73C3F2D1
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 02:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E962468D
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 02:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBChR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 1 Mar 2020 21:37:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgCBChR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Mar 2020 21:37:17 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F3EF347FFB24DD8ACBA;
        Mon,  2 Mar 2020 10:37:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 10:37:05 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yebin10@huawei.com>
Subject: [PATCH] vt: fix CVE-2020-8647
Date:   Mon, 2 Mar 2020 10:35:53 +0800
Message-ID: <20200302023553.44792-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We must calculate origin buffer end before update "old_origin", or it
will lead to access illegal memory.

BUG: KASan: use after free in vc_do_resize+0x49e/0xb30 at addr ffff88000016b9c0
Read of size 2 by task syz-executor.3/24164
page:ffffea0000005ac0 count:0 mapcount:0 mapping:          (null) index:0x0
page flags: 0xfffff00000000()
page dumped because: kasan: bad access detected
CPU: 0 PID: 24164 Comm: syz-executor.3 Not tainted 3.10.0-862.14.2.1.x86_64+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 [<ffffffffb059f309>] dump_stack+0x1e/0x20
 [<ffffffffaf8af957>] kasan_report+0x577/0x950
 [<ffffffffaf8ae652>] __asan_load2+0x62/0x80
 [<ffffffffafe3728e>] vc_do_resize+0x49e/0xb30
 [<ffffffffafe3795c>] vc_resize+0x3c/0x60
 [<ffffffffafe1d80d>] vt_ioctl+0x16ed/0x2670
 [<ffffffffafe0089a>] tty_ioctl+0x46a/0x1a10
 [<ffffffffaf92db3d>] do_vfs_ioctl+0x5bd/0xc40
 [<ffffffffaf92e2f2>] SyS_ioctl+0x132/0x170
 [<ffffffffb05c9b1b>] system_call_fastpath+0x22/0x27

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8fa059ec6cc8..1d7217bef678 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1231,6 +1231,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	old_origin = vc->vc_origin;
 	new_origin = (long) newscreen;
 	new_scr_end = new_origin + new_screen_size;
+	end = old_origin + old_row_size * min(old_rows, new_rows);
 
 	if (vc->vc_y > new_rows) {
 		if (old_rows - vc->vc_y < new_rows) {
@@ -1249,7 +1250,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 		old_origin += first_copied_row * old_row_size;
 	} else
 		first_copied_row = 0;
-	end = old_origin + old_row_size * min(old_rows, new_rows);
 
 	vc_uniscr_copy_area(new_uniscr, new_cols, new_rows,
 			    get_vc_uniscr(vc), rlth/2, first_copied_row,
-- 
2.17.2

