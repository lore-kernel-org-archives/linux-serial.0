Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED3C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 08:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6677920753
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 08:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALo1XGWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRIbf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:31:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35325 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCRIbf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 04:31:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id u68so13513514pfb.2;
        Wed, 18 Mar 2020 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHB3l8FsE+LhxKZQn0f4F1vqZvR7CPFOK0zbS6vTqdw=;
        b=ALo1XGWwXk7vN40lY1PZ6tnhbwrLthpwOD9FQRuwF0ljeNBAKHLtXFC9d7LPjRnxgG
         b1LY2vmae1xwGXTRPZ6A7WKo3z30M+piOhkujzMtVuI4XCQLEMmYYi7eg4nsJo0oD6H/
         o6R+phnQP/mQdKifoLRE9KRJlGqEVI/nGKyKwjfCSa0C7BsW/XbgUeXvXM4mHs5FVOsl
         AasDkOwCFUk+LWPnrwWto0JhcegPWKDCl3e+4QL5AvPEYtSf2uyxpRaZZGd5IZfCP2rW
         Py6JJwrOlUzL2PjN6HUslshrps9OiI7PNeCTRIKRIRJ+b0POIxoyymYWqZnAfFQaEzGZ
         6I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHB3l8FsE+LhxKZQn0f4F1vqZvR7CPFOK0zbS6vTqdw=;
        b=HowVWxCNwQLdHCeuTJc1MxtEyJPHVMfHbyMEcjXHJON5xyrshSHBYrZ6sdQVtcYRTU
         5fK0KVRKmYKo6/QkFbHxYsLmEV+S0aVu4NpAmtM2bG0ypHhKfLwD297kEsZW1CfnOSQm
         VqFrz2qRMlqKuHbkmVjGyPaBpncBrQpd9pvNiPVGHseY4Hzcr3sN9SMsuxAxu+PJI/Ht
         PAeDgS9siVyPvspRyjznG90NqiRygqDjm2B/L94aFj9FcmEzRJzGf6XB4Jtm0hVQkUMw
         W7IW109Z7vj6vrbuK7iydsNvZIuifteJanksW2jfM6rbATWDrsqicuYIvHQgQpQbmn2T
         dv3w==
X-Gm-Message-State: ANhLgQ0QZq5Do9/vWt2tInUI420f3tTFk06lCOTp4hhvnr/KqhY1KLqd
        CH7cWXhFW8x2ZrbAR1pGi6RKG4ZB
X-Google-Smtp-Source: ADFU+vtApML+V/3vxjxF3BAra54kfdgDHHoOaTiGNKk5jZynCUQKpeG6Z6bC0P/qMA0JVHPLxmHUIg==
X-Received: by 2002:a63:2323:: with SMTP id j35mr3403406pgj.440.1584520294426;
        Wed, 18 Mar 2020 01:31:34 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c11sm5894326pfc.216.2020.03.18.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 01:31:33 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
Date:   Wed, 18 Mar 2020 16:31:20 +0800
Message-Id: <20200318083120.13805-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318083120.13805-1-zhang.lyra@gmail.com>
References: <20200318083120.13805-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

It would be better to cleanup the sprd_port for the device before
return error.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 9f8c14ff6454..54477de9822f 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device *pdev)
 	up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
 
 	ret = sprd_clk_init(up);
-	if (ret)
+	if (ret) {
+		sprd_port[index] = NULL;
 		return ret;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.20.1

