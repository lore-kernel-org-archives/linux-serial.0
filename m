Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DAAC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1639F60D07
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 10:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJ1KQw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Oct 2021 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhJ1KQv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Oct 2021 06:16:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C2C061570;
        Thu, 28 Oct 2021 03:14:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p40so665603pfh.8;
        Thu, 28 Oct 2021 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGRFFkbWPTpn78tArCV7l81qRRNeflw+gfeWzgd3Hsg=;
        b=AOCFHTvxB2nikILO2omNQt5gXOpPro5gwBYzusab4FwTwq5bh5BY1w0XHmZbX2KNcc
         ezGnMbIC8G0V4A2FtTUQ8WZYZgPJFf1QasqgKO3DS6YMsHqLdlFOPIwuRDG8f5YH9cqv
         YxvOU2rjuiXlBib160jJnV/TORTJ16c/Qj9ovOWb2fl7YSJ4gBWE9qa04KFgcJFi4uGd
         AboAe0zGa0SMsyMeFTm8F8M/7IJIIq6gTeft0mxT/HSVLEdN8yt/VbH7IrR6XwZIyk+U
         VSXst6JBK2pvKVyJoboL4Eqf2oh1R/yTTZSSddDwwgpFnJR5AypDCtuNws81iExCyF0U
         URsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGRFFkbWPTpn78tArCV7l81qRRNeflw+gfeWzgd3Hsg=;
        b=73qJnnxwUKGA7u+vBTSoEGxega2LSr1ujgX/LtZ2PKGP0br5e2TGTF/FPMD/dRWInr
         zNxrdKijm2OQgYl9mze+d5+jT/VLwZHJNWtnG7z/T6bvOxOV82q02S88v1kFJVHT05pE
         mnTnwWnpgYxybpBeH5Dk45PsAQRYHg9Ioa55yraWZrgt/iSYtRqPp5MNg7QgbRoe7ohi
         8isa/7DIL5Hd3VifhkNiOZzBd77pg9X/zrjmzC0UwUDbEt81YuPx/xe7qg7K9HzIwVhF
         vKfn0EnIUYxq0R6kpQdJX1dR1z+PWTqBSCcVf7Bc2G85B5lnFktia3YN5syyoa9sDwT4
         FhoA==
X-Gm-Message-State: AOAM530NG/7jkQ1j/80YuPjbIpJE2rJ0SS0Ntl68P7f9CrDSnGwNKvF2
        GXV30ugPN2uksPTdv+xl+xA=
X-Google-Smtp-Source: ABdhPJxJQcPt7Q9aPbVzsGu3HlkUvWz8Yz+Slvx7rw8A2GPzAYj1+DfzTQkNBysLCraz5+bwNT4TLg==
X-Received: by 2002:a63:85c1:: with SMTP id u184mr2481407pgd.243.1635416063677;
        Thu, 28 Oct 2021 03:14:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mt16sm2468674pjb.22.2021.10.28.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:14:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, johan@kernel.org, macro@orcam.me.uk,
        fancer.lancer@gmail.com, andrew@aj.id.au, pali@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers: tty: replace snprintf in show functions with sysfs_emit
Date:   Thu, 28 Oct 2021 10:13:50 +0000
Message-Id: <20211028101350.14172-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..557e8b13b5c1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3099,7 +3099,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
+	return sysfs_emit(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
 }
 
 static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
-- 
2.25.1

