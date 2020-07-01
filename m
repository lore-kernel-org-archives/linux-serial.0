Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F61C433E0
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9332020748
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAUGuF/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGAVNu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGAVNr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 17:13:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B002C08C5DD
        for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2020 14:13:47 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w27so18053191qkw.2
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2020 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=quzZPMbm7PpMHF0Uc8MBUiav44rFFBJoy1a7Ni+U048=;
        b=cAUGuF/bBZXzPwqEA2KmnUAiIBZh74Axkc9kR9B2TU+pfmr0Ih1xclQdRWGsusUH4P
         aQzareypjNzLHXiV125/yObqrFXl50tJFV/rUKCZRWbD/D/1d0v4lzxP6KOcZXlgjjmi
         sgNNbvNdLJJHNlKCd14hQXkgYAlLrBsKFbkHvUNF/F6nxwrpT8jdvRZYXVdR0PC1eAI+
         4S16qlMArXxPc8oAS/ZA1yBh3hZnNw3KUW8jxg5bA8R+t6SFI15vBdFvk1Iceo4cfGw7
         X0DgYL+QU5n2iQQVkAwshCPeU4e8v2RIOl8RM6la4Auqki927z9rPEsuDYZvWCyThq2u
         QdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quzZPMbm7PpMHF0Uc8MBUiav44rFFBJoy1a7Ni+U048=;
        b=DGlY5Fvf+mHZFwmaDHrWU3XgEloxf2TZTryQrCr2YXRwUQQASYgdIm6cxnPeTfaoYW
         vtK9hzuk1M1i4MHgrC2xgo0WGDBmYrl7MsaaMc+NjI/0N2Gb593fdf21upnazFM7z4Bw
         Rnzg0sRLpfeh5rooue96KdufkUVyL+Sf+kUow/T97hX2SpHqOcH3/VoNcq+9AP5FbENg
         xEciAty9XhM0Nkz6CawGdQpe4ILqiUWN7d2cXvI58nfEJ9tkOIdundpLappRZEuO0fQq
         JjYyfC/3QQNwxj1bhbj4n4JHvGVYrXv4LoHyFU3ukLyNlyys3RaHumtsEkS5ntIztoAY
         VMLA==
X-Gm-Message-State: AOAM532fNO/eAnUcl84IHPijVLBMfkedxTfwLYmCWGdKbfyZDCCt4fNV
        KNoSUE7SYYsy3T1i6jcYQo8+I+K7vLStXbp+NfuXeNx6437sijB52I1qjl3yysOwRtL13GLCIFz
        EYDSuaTYqMWU/BZa1iVMLJlAop+Kp98xAHn2lAME9Zpz1JNg+VD6azVE0h5WY8Hbqo6jcuvd5P1
        4Fl/sWfPCCrC6+
X-Google-Smtp-Source: ABdhPJweymvrG4WnmmEfQGpTdGKKPJnK+/o6UKqXb9nuHShRn93/877F29RoxTj0lr9gwAW3khi4TR681cXl8z12ryNZ
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr25772358qvt.78.1593638026665;
 Wed, 01 Jul 2020 14:13:46 -0700 (PDT)
Date:   Wed,  1 Jul 2020 14:13:37 -0700
In-Reply-To: <20200701211337.3027448-1-danielwinkler@google.com>
Message-Id: <20200701141329.v2.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
Mime-Version: 1.0
References: <20200701211337.3027448-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 1/1] Revert "serial: 8250: Fix max baud limit in generic
 8250 port"
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        stable@vger.kernel.org, abhishekpandit@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 7b668c064ec33f3d687c3a413d05e355172e6c92.

Fixes: 7b668c064ec3 ("serial: 8250: Fix max baud limit in generic 8250
port")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 drivers/tty/serial/8250/8250_port.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1632f7d25acca..e057c65ac1580 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2618,8 +2618,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     struct ktermios *old)
 {
-	unsigned int tolerance = port->uartclk / 100;
-
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 * Allow 1% tolerance at the upper limit so uart clks marginally
@@ -2628,7 +2626,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	 */
 	return uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / UART_DIV_MAX,
-				  (port->uartclk + tolerance) / 16);
+				  port->uartclk);
 }
 
 void
-- 
2.27.0.212.ge8ba1cc988-goog

