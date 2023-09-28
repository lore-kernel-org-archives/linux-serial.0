Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544F1CE7AE3
	for <linux-serial@archiver.kernel.org>; Thu, 28 Sep 2023 02:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjI1Cn4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Sep 2023 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjI1Cnz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Sep 2023 22:43:55 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3D122;
        Wed, 27 Sep 2023 19:43:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vt.rlIe_1695869029;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlIe_1695869029)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:50 +0800
From:   Yuanhe Shu <xiangzao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 5/5] tools/pstore: update pstore selftests
Date:   Thu, 28 Sep 2023 10:42:44 +0800
Message-Id: <20230928024244.257687-6-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Update pstore selftests as pstore now supports multi backends

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 tools/testing/selftests/pstore/common_tests | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/pstore/common_tests b/tools/testing/selftests/pstore/common_tests
index 4509f0cc9c91..f50166f59ec4 100755
--- a/tools/testing/selftests/pstore/common_tests
+++ b/tools/testing/selftests/pstore/common_tests
@@ -73,10 +73,6 @@ rc=0
 prlog "=== Pstore unit tests (`basename $0`) ==="
 prlog "UUID="$UUID
 
-prlog -n "Checking pstore backend is registered ... "
-backend=`cat /sys/module/pstore/parameters/backend`
-show_result $?
-prlog -e "\tbackend=${backend}"
 prlog -e "\tcmdline=`cat /proc/cmdline`"
 if [ $rc -ne 0 ]; then
     exit 1
-- 
2.39.3

