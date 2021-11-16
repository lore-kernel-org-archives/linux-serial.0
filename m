Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B07C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7500961C4F
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 10:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhKPKhY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhKPKhV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 05:37:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C93C061570;
        Tue, 16 Nov 2021 02:34:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so15380157pjr.5;
        Tue, 16 Nov 2021 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sbnnlZw+9ULD6WGIrHh2ju30Rwtd48avD7994Ytg28=;
        b=NRYpPIKC1HXpt0VN7zdUNuWrXbRE2Jwe/iQInn/3ItqXN0IW8LQRQ0CNujo2nfOIrc
         TQdXxf9lESW9dkBWtYu/UUuijBtqZCZQu0xVjyM0IbJZ0CtHXOXeek0whBjwTM/CsJTJ
         yeJhO+0W0xWJ0rlvJPqvNdlvI0agwdWXPzYJaW5oTc4QZH0o27nKry3M+UDNHvnfa185
         R55ftwZDgEpijHF5TDOmzWZOq0gyp3X2mEaSs/fw82nSP8iXPCI0BnsXLCLEbMkKlEj7
         5bTthjKORcMfKuVONDtu72gBbUzaRZZm5XwU4wbyTvzyAnga8UUfqQF04884vUH8gFWY
         LFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sbnnlZw+9ULD6WGIrHh2ju30Rwtd48avD7994Ytg28=;
        b=lZOP1lucxGmfiYeMshbcpleGS0oHphRfSL2NBCMuew3ZfuBQ1f+m5Q7fQc57BQ/ARc
         VLTngQUcwUdT/v9/NP0LAvTwB9EpPVkm7zMUIJUhM1t+F+1AyL4Oi0I/NN4C6s9g+dFt
         NUCl585HI4S+RZrXMe72Dyu76BdjQ12ZrJmiBve3bLEUrlBaJxvodsb8JHup9Ntfk9Px
         zAH27Nr8Hr2gCccwUqOzyw3HXxw4T9kKnsdUhTWSgUm50N+Ezn0CghuuUVkdyes0h3mz
         liII5hN17XAUNZt/OwY/1elFEpLqcatsjZ/kmu8pGy4v9a6MVjV4+q8KuNU2l6bH2ST6
         IkRw==
X-Gm-Message-State: AOAM532NQ5lEiRVXOlsUm7ITWV8+Li8EhFy0ad9CHP0scOQCtkmIU6+K
        qNiBj6hJdZZkSl0xdIm6hkWzs1rRnnw=
X-Google-Smtp-Source: ABdhPJzo+L7IMl9q9krDr5jLPHcBamRuFmBfCW8NSdiRVQ2inXGr+ShTGKTWo4Hu9Wc2JRVnkSQzDg==
X-Received: by 2002:a17:90b:3ec2:: with SMTP id rm2mr73366796pjb.1.1637058864095;
        Tue, 16 Nov 2021 02:34:24 -0800 (PST)
Received: from fedora.. ([157.34.191.12])
        by smtp.gmail.com with ESMTPSA id z7sm7407301pfe.77.2021.11.16.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:34:23 -0800 (PST)
From:   Sahil Patidar <sahilpatidar4051@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sahil Patidar <sahilpatidar4051@gmail.com>
Subject: [PATCH] tty: serial: jsm: jsm_neo: fixed a conditional statement coding style issue
Date:   Tue, 16 Nov 2021 16:04:11 +0530
Message-Id: <20211116103411.71987-1-sahilpatidar4051@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Sahil Patidar <sahilpatidar4051@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index c6f927a76c3b..9b828989d13f 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -668,8 +668,7 @@ static void neo_flush_uart_read(struct jsm_channel *ch)
 			jsm_dbg(IOCTL, &ch->ch_bd->pci_dev,
 				"Still flushing RX UART... i: %d\n", i);
 			udelay(10);
-		}
-		else
+		} else
 			break;
 	}
 }
-- 
2.33.1

