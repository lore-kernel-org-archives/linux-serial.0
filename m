Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9040C18E5B
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 03:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7443520409
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 03:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn1rmJdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgCPDOB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:14:01 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33728 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgCPDOB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 Mar 2020 23:14:01 -0400
Received: by mail-pj1-f66.google.com with SMTP id dw20so3502263pjb.0;
        Sun, 15 Mar 2020 20:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=khBuxhsfLtwkJbdKTmDzOvFGTSeMlV30RfTjpZu731w=;
        b=kn1rmJdjTdsBvzi0LDTmK5qUEfCtK9WakHtxi8Ap5Saruk4TTWNmKOmoPYgpPVoNRe
         iIRKrkxEN2QDuUJG4CFdNmzkRQsyQzwPqKknfvHnuG+0eN3QHTzcbCwPJz+i2BxtYgUB
         zOC4qwr3yAiRPQXOms9hObGNg6ADVyucZmWHM9UACsF2q56OzzyCr/gE9DoOEKBUbkWu
         LgBWJDNLwqm4LvFFn7BhIB77ylx4VbE8y0IuvX580kYEzYZ24N2EYbUDK5jEldiGVhbi
         H6bpFd5Dglggsk0HZJHwRu/Lk+Dlk0K28Obr/9sBfCjoPVUr57WAepWNmRHhibIep5nV
         hCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=khBuxhsfLtwkJbdKTmDzOvFGTSeMlV30RfTjpZu731w=;
        b=MqAoleXMFtLa1CfWdi3AT+14pExXkfPXyuIzQWU4zexb74Pu3eNGn6QbPiWICPvpvc
         q6Zj7Ihu36NSAl8mnrE3qcHMDNogpoc8TU837qVej9m83orqDyd8svq1VeM8WTH+334r
         mO10MZ0xqN8CCTfzgsxwmltT9RwXd/Ae357ymS0M4NnNRcUJOO30d82RWbNJiIZ0lmDm
         6wmvlcH37rriqrxMD2zoclKBUObkKWXNkqF0atkgWfkTEJ9xmhlZctN36g8wTEXszYsM
         7z5vVNwlnoEAv1J/jgDb6JjaJjEwUEt1sLtZM/pEcIaGfkzcWhkV8gTRRl/hctpKeJYT
         SpLg==
X-Gm-Message-State: ANhLgQ3Oi6259ZPqCA/vNiMlTRKblblDhQrSy/+3WL13o14FkGKvQOjZ
        dcsPKSFuglfP/U2C1joKKGaleZ50
X-Google-Smtp-Source: ADFU+vv0iMVJ6y997gl0WDsAS6Y7kFlu0SMT8wzHsJdz8FAeQKpXwcBhpv7tTWGIevKbzy+hwlxqjA==
X-Received: by 2002:a17:902:9886:: with SMTP id s6mr25001838plp.100.1584328440119;
        Sun, 15 Mar 2020 20:14:00 -0700 (PDT)
Received: from sh04182tmp293.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e9sm5143392pjt.23.2020.03.15.20.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2020 20:13:59 -0700 (PDT)
From:   Lanqing Liu <liuhhome@gmail.com>
To:     dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     baolin.wang@linaro.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH] serial: sprd: Fix a dereference warning
Date:   Mon, 16 Mar 2020 11:13:33 +0800
Message-Id: <e2bd92691538e95b04a2c2a728f3292e1617018f.1584325957.git.liuhhome@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We should validate if the 'sup' is NULL or not before freeing DMA
memory, to fix below warning.

"drivers/tty/serial/sprd_serial.c:1141 sprd_remove()
 error: we previously assumed 'sup' could be null (see line 1132)"

Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3d3c706..a223e93 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1132,14 +1132,13 @@ static int sprd_remove(struct platform_device *dev)
 	if (sup) {
 		uart_remove_one_port(&sprd_uart_driver, &sup->port);
 		sprd_port[sup->port.line] = NULL;
+		sprd_rx_free_buf(sup);
 		sprd_ports_num--;
 	}
 
 	if (!sprd_ports_num)
 		uart_unregister_driver(&sprd_uart_driver);
 
-	sprd_rx_free_buf(sup);
-
 	return 0;
 }
 
-- 
1.9.1

