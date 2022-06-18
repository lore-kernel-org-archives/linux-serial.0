Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB8C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 18 Jun 2022 06:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiFRGKV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 18 Jun 2022 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiFRGKV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 18 Jun 2022 02:10:21 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 482082B1B4;
        Fri, 17 Jun 2022 23:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fZqfk
        Q6nMqZ+XNOx3ols19yCmb0V1DuDOmxfZXOmwfo=; b=BDwaWrtJfj5EhZlQAA/Jy
        segFSLTbJ8wSH5LEEzprTkOmmHqXpz5BrUVM5T009iytcFSwlFsJJ5689E2lj+lw
        fNfhqlldlwALEDQRYLLGqWs+5HyZOingZ/UbS6cPaGalnVHvg2CkZpuGTeS/LQw9
        /oAWTdGk2HFVXrV1Z86SQU=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowAC3wgXza61iZ1BsDg--.24049S2;
        Sat, 18 Jun 2022 14:08:52 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     timur@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: Fix refcount leak bug in ucc_uart.c
Date:   Sat, 18 Jun 2022 14:08:50 +0800
Message-Id: <20220618060850.4058525-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAC3wgXza61iZ1BsDg--.24049S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3tw4kXrb_yoW3urX_CF
        97WwnrCr1UZF40gFZxZryY9ayav34UuF48u3Z7t3s5XrW5ZF4rXFyqvr97Wr9rC3yjyF9x
        Crn7Wry0kr4v9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMFAp7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AQkF1pEDvpQjQABsd
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In soc_info(), of_find_node_by_type() will return a node pointer
with refcount incremented. We should use of_node_put() when it is
not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/tty/serial/ucc_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6000853973c1..3cc9ef08455c 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1137,6 +1137,8 @@ static unsigned int soc_info(unsigned int *rev_h, unsigned int *rev_l)
 		/* No compatible property, so try the name. */
 		soc_string = np->name;
 
+	of_node_put(np);
+
 	/* Extract the SOC number from the "PowerPC," string */
 	if ((sscanf(soc_string, "PowerPC,%u", &soc) != 1) || !soc)
 		return 0;
-- 
2.25.1

