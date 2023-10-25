Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA33EC0032E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJYO0j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345099AbjJYO02 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 10:26:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931210E2
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 07:26:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da05b786f1dso1200175276.2
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698243978; x=1698848778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6GAV3+HGX/GSuMk9leWi7r46JVl0NQ2JAhtg14sSj10=;
        b=uC+OcpNuVUcrcaigHU4roLYmXYrONduaPE/A7YesAErqV8JX5eb0ddpAcKj9dsjS1n
         GINsk4UipHmNxmY+sMyLDSaH9HyejG0y9twMSOEjYMvaiit3XahrrhNEYSpZ8QKB57w3
         0OK7seifXAJs0qZER7QoKNHxNcQnHDehniyiQQRHBw5ZdCa0j2vSQvBFwMuWmmhVcOLl
         G7pmjPB74kd1e/OEyPC0TI1trHSM86Wpy6WOMa2ePGQ50++rdieGSk+mu6YXPcY7hwmU
         RjC5urbynxAi3AabwmmQz7CLCxmMtZXRilvVAF3iPpcVx/Q9fPinWbfKhK3EnpnGi2cW
         6xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243978; x=1698848778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GAV3+HGX/GSuMk9leWi7r46JVl0NQ2JAhtg14sSj10=;
        b=er4t6G4Ruhzak/DMN1k9L3Vrm74WZ79jE4a5dW0JRkwkxS3ivbLEl8axyoAVoAZ66v
         kA+0gMd28+1JXGIJPWnUFFITMmjNOg+E934lC+XcLBXnAQ6wiBsiQ27qDV2ye6X7pk3N
         /gYEKiipfLen62UEhKoHZr8L1eSIq4FfPYUTIhmMS9xzYVIUv2BFFzQuq1oM6oDry0NL
         WA0fptLBMiqw5qxY+V0bv/JSJBABJSGuR9ioiGtufhij0+aLCZLBGTJ4aj17augT/y1G
         dkpcinUL7dHNiBgNO7KnGvk+fumZDufQZq/BFd9JpYCfUwI1tAvm3Y8JNwRXkPb/9siS
         i4Ew==
X-Gm-Message-State: AOJu0Yy25UYg0XIxSmFsbo3BoIjZ/tvMCRS7uaGdjwSsKWK+catyUFTB
        SHtLKUZ81BewzBXj2FhZAbYa/WvjufJYephLl+w3
X-Google-Smtp-Source: AGHT+IE8qkvhuHEwCdG/rkr7SGSR29nrcqu5lQD4EekiOS30hAPsOqt/pFLDJJUCH+3QM6yXxRXicgLxuBeYUP5/b+hv
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:211:0:b0:d9a:c3a2:48a3 with SMTP
 id 17-20020a250211000000b00d9ac3a248a3mr285649ybc.6.1698243978033; Wed, 25
 Oct 2023 07:26:18 -0700 (PDT)
Date:   Wed, 25 Oct 2023 19:56:09 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025142609.2869769-1-vamshigajjela@google.com>
Subject: [PATCH v2 3/3] serial: core: Update uart_poll_timeout() function to
 return unsigned long
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

The function uart_fifo_timeout() returns an unsigned long value, which is
the number of jiffies. Therefore, the function uart_poll_timeout() has been
modified to use an unsigned long type for timeout values instead of an int
and to avoid truncation.
The return type of the function uart_poll_timeout() has also been changed
from int to unsigned long to be consistent with the type of timeout values.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v2:
- unsigned long instead of unsigned int
- added () after function name in short log
- updated description
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..6916a1d7e477 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 }
 
 /* Base timer interval for polling */
-static inline int uart_poll_timeout(struct uart_port *port)
+static inline unsigned long uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = uart_fifo_timeout(port);
+	unsigned long timeout = uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }
-- 
2.42.0.758.gaed0368e0e-goog

