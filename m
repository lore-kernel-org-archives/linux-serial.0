Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02084C001DB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Aug 2023 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjHNECT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Aug 2023 00:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjHNECD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Aug 2023 00:02:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D6E53
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 21:01:58 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPLHT2hvbz2Bd1k;
        Mon, 14 Aug 2023 11:59:01 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 12:01:56 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <alan@llwyncelyn.cymru>
CC:     <linux-serial@vger.kernel.org>
Subject: [PATCH] tty: vt: selection: fix soft lockup in paste_selection()
Date:   Mon, 14 Aug 2023 12:01:31 +0800
Message-ID: <20230814040131.79439-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Soft lockup occurs when vt device used n_null ldisc, n_null_receivebuf()
is not implemented in null_ldisc. So tty_ldisc_receive_buf always return
0 in paste_selection(), this cause deadloop and cause soft lockup.

This can be reproduced as follows:
  int ldisc = 0x1b; // 0x1b is n_null
  struct{
  	char subcode;
  	struct tiocl_selection sel;
  } data;
  date.subcode = TIOCL_SETSEL;
  data.sel.xs = 0;
  data.sel.xe = 1;
  data.sel.ys = 0;
  data.sel.ye = 1;
  data.sel.sel_mode = TIOCL_SELCHAR;
  char bytes[2] = {TIOCL_PASTESEL, 0};
  open("ttyxx", O_RDWR) // open a vt device
  ioctl(fd, TIOCSETD, &ldisc) // set ldisc to n_null
  ioctl(fd, TIOCLINUX, &data.subcode);
  ioctl(fd, TIOCLINUX, bytes); // cause deadloop

Fix soft lockup by check if ldisc in paste_selection() is n_null.

Link: https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/
Fixes: 8a8dabf2dd68 ("tty: handle the case where we cannot restore a line discipline")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/vt/selection.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 6ef22f01cc51..9ba7f66fcf05 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -388,6 +388,12 @@ int paste_selection(struct tty_struct *tty)
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return -EIO;	/* ldisc was hung up */
+
+	/* tty_ldisc_receive_buf() will not do anything when ldisc is n_null*/
+	if (ld->ops->num == N_NULL) {
+		tty_ldisc_deref(ld);
+		return -EIO;
+	}
 	tty_buffer_lock_exclusive(&vc->port);
 
 	add_wait_queue(&vc->paste_wait, &wait);
-- 
2.17.1

