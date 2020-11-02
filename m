Return-Path: <SRS0=k0O3=EI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61934C388F2
	for <linux-serial@archiver.kernel.org>; Mon,  2 Nov 2020 12:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05817223AC
	for <linux-serial@archiver.kernel.org>; Mon,  2 Nov 2020 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OER6ydD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgKBMH4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgKBMH4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Nov 2020 07:07:56 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E51C061A04
        for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2020 04:07:56 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so3331032pgg.12
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2020 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFM6/afG6N6GkffE6RVsA6XQhyhMXSUQ6Tq0CrN9TdE=;
        b=OER6ydD30mEycoQTkeJ2IEiFZdYdh0NneHHHSB7KDLQJaaFrFNIHAk7YS3b99bIBqf
         CY5P3j+LjyDibyo6PH6yMuXRpQ7mGTtlXVUKW7EjBLFMhrrAU0dIKL732N7CSpkrDwSg
         JyBBMOnObcDhu+y53bZi+INnV6NUX6CI2ZIJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFM6/afG6N6GkffE6RVsA6XQhyhMXSUQ6Tq0CrN9TdE=;
        b=QJpUaEJ95pF2fvHA0d8yQvg8O4oHCnnrabcgG9iE93BNQyeJCJC6HVLVgo8CNbbKaC
         2Yyq9n53WThy4bvJ8D13uDB0ZoGD3WxbbMB9yKZuRqqhwZrVxfT7Ixy0fuOpNMe481eJ
         sfR7hvfdESWAzkh52UKqxmdjU6JeMsyh+0iYRGziCVW/t2QwxkTuq2O1cpDfJHOo4gLN
         9R+s6265lP7qJYSsbLd8EJwWyeqVNzsTwpB7zHYBZVUox3Zyy3lffle9i8TWQRs6ay8i
         C1THAA+vQW1zwEzlg5JlpWQbFhuhoSB4oS1q7UBtg3KB4RO854K7iYcPhXYUvMCcovhK
         O3hw==
X-Gm-Message-State: AOAM53362jA5Qe06miSZUl9Avmob/uYFcRWmisli/4ygzY6busLzx7ka
        gucvrPOABsv34rkSf8S+6TDpeA==
X-Google-Smtp-Source: ABdhPJwK6F4gpRDNplhBJ76hPT238QfpHnacXB+pi3j8WSLJHBoyl01NGnhMR9ZQeZeIkxPlSSGM+g==
X-Received: by 2002:a17:90b:30d2:: with SMTP id hi18mr5754162pjb.186.1604318875646;
        Mon, 02 Nov 2020 04:07:55 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id h26sm11675226pfq.139.2020.11.02.04.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 04:07:54 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     eddie.huang@mediatek.com, hsinyi@chromium.org,
        Sergey.Semin@baikalelectronics.ru, changqi.hu@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] serial: 8250_mtk: Fix uart_get_baud_rate warning
Date:   Mon,  2 Nov 2020 20:07:49 +0800
Message-Id: <20201102120749.374458-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Mediatek 8250 port supports speed higher than uartclk / 16. If the baud
rates in both the new and the old termios setting are higher than
uartclk / 16, the WARN_ON in uart_get_baud_rate() will be triggered.
Passing NULL as the old termios so uart_get_baud_rate() will use
uartclk / 16 - 1 as the new baud rate which will be replaced by the
original baud rate later by tty_termios_encode_baud_rate() in
mtk8250_set_termios().

Fixes: 551e553f0d4a ("serial: 8250_mtk: Fix high-speed baud rates clamping")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 41f4120abdf2..fa876e2c13e5 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -317,7 +317,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	baud = tty_termios_baud_rate(termios);
 
-	serial8250_do_set_termios(port, termios, old);
+	serial8250_do_set_termios(port, termios, NULL);
 
 	tty_termios_encode_baud_rate(termios, baud, baud);
 
-- 
2.29.1.341.ge80a0c044ae-goog

