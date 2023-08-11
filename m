Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59707C001B0
	for <linux-serial@archiver.kernel.org>; Fri, 11 Aug 2023 03:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjHKDMP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 23:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHKDMO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 23:12:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C472D65
        for <linux-serial@vger.kernel.org>; Thu, 10 Aug 2023 20:12:12 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMTJm5g0gzCrXd;
        Fri, 11 Aug 2023 11:08:40 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 11:12:09 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <hedonistsmith@gmail.com>, <daniel.starke@siemens.com>
CC:     <zhangqiumiao1@huawei.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH] tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux
Date:   Fri, 11 Aug 2023 11:11:21 +0800
Message-ID: <20230811031121.153237-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In commit 9b9c8195f3f0 ("tty: n_gsm: fix UAF in gsm_cleanup_mux"), the UAF
problem is not completely fixed. There is a race condition in
gsm_cleanup_mux(), which caused this UAF.

The UAF problem is triggered by the following race:
task[5046]                     task[5054]
-----------------------        -----------------------
gsm_cleanup_mux();
dlci = gsm->dlci[0];
mutex_lock(&gsm->mutex);
                               gsm_cleanup_mux();
			       dlci = gsm->dlci[0]; //Didn't take the lock
gsm_dlci_release(gsm->dlci[i]);
gsm->dlci[i] = NULL;
mutex_unlock(&gsm->mutex);
                               mutex_lock(&gsm->mutex);
			       dlci->dead = true; //UAF

Fix it by assigning values after mutex_lock().

Link: https://syzkaller.appspot.com/text?tag=CrashReport&x=176188b5a80000
Fixes: 9b9c8195f3f0 ("tty: n_gsm: fix UAF in gsm_cleanup_mux")
Fixes: aa371e96f05d ("tty: n_gsm: fix restart handling via CLD command")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
---
 drivers/tty/n_gsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c7a787f10a9c..b32d91ccddda 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3042,12 +3042,13 @@ static void gsm_error(struct gsm_mux *gsm)
 static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 {
 	int i;
-	struct gsm_dlci *dlci = gsm->dlci[0];
+	struct gsm_dlci *dlci;
 	struct gsm_msg *txq, *ntxq;
 
 	gsm->dead = true;
 	mutex_lock(&gsm->mutex);
 
+	dlci = gsm->dlci[0];
 	if (dlci) {
 		if (disc && dlci->state != DLCI_CLOSED) {
 			gsm_dlci_begin_close(dlci);
-- 
2.17.1

