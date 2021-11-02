Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03243C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CFD60F02
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 06:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKBGzO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGzN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 02:55:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B6C061714;
        Mon,  1 Nov 2021 23:52:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v20so14503848plo.7;
        Mon, 01 Nov 2021 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pRVqNc+FppqVn66H2Dpc51B/il1e+yZxyBdV0UH4Zs=;
        b=RG/BlteOYWXybOs02hqOHcpq1fDM5XeLjlj7Lu4ZkxFkDwW8CX7J8l3qvuYgvJFJJG
         s55fLOC8sGbhISonZXtcVOr2sbr/C1bwRTbTScTxWNUBJGNcbfymaE+b+mz2N9XAA8V3
         Dvyd01ZDuo5IhX811DX7j0TTNjbFRWEK/bkosoTw5fWHkF/l6xx8u3QgOMzOSfxdop36
         J7kHx/k4VC0Sd4AsUvFJxQwhflQRQ88ooc/FDJUtquG4F58TVDnNwnXejr9PbJ4zdRPL
         Mr6Inm/4FW13eitCQ1k2BDvZn1aKLXSLZDPO9xNC4Uchs1AheHl+b0Ne1dW4Gkxx1Vdb
         KQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pRVqNc+FppqVn66H2Dpc51B/il1e+yZxyBdV0UH4Zs=;
        b=t4Nlb4jONteRWk2YEPK0GwrFeNP2uEQz4iHlvTDqUKhN/zXmNlwN7jTdBLZ7cvoEym
         /uTORoV3kUqSRSaZHfmORHcRYFCFApPDW2ecSZPgN+PFP57SLDEwyfXIEN1ByFbor9PN
         HomC/Hck+L5I8vGT7fu/RlG3K5xtMfscehJ2fJGggoR5diT+lxfZ/hQr07kJcG7MuRkN
         yHKeIDTR3t99B/awPQAfNg62eR+xSMEAgWQ2k9/e+oLH7OQcC/DmFcQIJnPLQKcvNkdg
         /Y1jS0GVyaqY376FQU059RXyIGWU4WZ0hJ7+jdMvYOT84DqAWI0uo8jmsM7mIh53mQkz
         1kRQ==
X-Gm-Message-State: AOAM532zPptV+KkGgbT2ybZu5X0gol6Hlv6Q4q488Ba6TMFaNjM5VASf
        ql+PvmHLbey36Yh1Egr50EQ=
X-Google-Smtp-Source: ABdhPJwutypiGSFCy4xX3wIj+HlbvMpiSRH8GieSPKc+6rONvCoHPF85T/iVkDEmMjNLS21M2iMSiw==
X-Received: by 2002:a17:902:a70e:b0:141:a01d:9d6c with SMTP id w14-20020a170902a70e00b00141a01d9d6cmr26762033plq.84.1635835954807;
        Mon, 01 Nov 2021 23:52:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id np17sm1461436pjb.7.2021.11.01.23.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 23:52:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     joe@perches.com
Cc:     andrew@aj.id.au, cgel.zte@gmail.com, fancer.lancer@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        macro@orcam.me.uk, pali@kernel.org, yao.jing2@zte.com.cn,
        zealci@zte.com.cn
Subject: [PATCH v2] drivers: tty: replace snprintf in show functions with sysfs_emit
Date:   Tue,  2 Nov 2021 06:52:06 +0000
Message-Id: <20211102065206.3368-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b42482be11d04963fed0903ce1bd983742efc5c6.camel@perches.com>
References: <b42482be11d04963fed0903ce1bd983742efc5c6.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..3d58f383152e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3099,7 +3099,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
+	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
 static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
-- 
2.25.1

