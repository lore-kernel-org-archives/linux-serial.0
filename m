Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78856C25B67
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjJZN4j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZN4i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 09:56:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBF183
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:56:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ebc70d33so8847287b3.1
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698328596; x=1698933396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y4G5FMWajl/F1bjn3WpqChw5dodQuAFRVzNXYVASYSI=;
        b=VSvoXAH7++daBy6NrFerw+gKsLPPwo4kNGmhNln4C8ky04h4BmcIle4+KWNx8AQdIf
         hBLz1LeVcbS1VLBX5vVbdLi25u7Fx6T/OSlcN1bl5/L00aHKSF5ESFc1ATOELpoGuhe+
         McR7wwtprYfW11apDvQTZ9qpiN1xN+P46mG0DyWgd+RW6v/sIB9gF+RjMqALrAXoEy5W
         tnwyPgMS3NY59S0EtdDML7KJb9t50Z+cyt305PU5JSaudP1Pn0JDk7IRGzHzgyTlT+ad
         iCTFBfCaApAc18NMLKC/4odM0L0ichbOSVInb6XU3X5flqbp8xr1WnwlfZw9gn0gPHQh
         Gvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328596; x=1698933396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4G5FMWajl/F1bjn3WpqChw5dodQuAFRVzNXYVASYSI=;
        b=cgEjLEO5gCcCwP6xf9e4us6Z/mEUvIpaqD5D+3KxQBhsT0TqvB3mdZuyPo1imqiWF9
         mhJy9JqXn9Z1msh77gEKOi6oBVYATpHS7fUyMjRsFHwOzIdCnBajNMpNfcfZ9027BLsb
         vjvo0XHAOATYRZ5QrvGRYkJEElZudeK4sBq39bCVh1LlOHZJMRRFjIH1xqEQG7hE6iV3
         07CP3sj7hmpZjiPxXeQrmHIP6dytf1XOKPRnjTFZHTD1C3iobM1j5u843hXzr+sa9mF6
         BuLAoIVXn/pNLYrIqO5owJyravE5lnDTOHehfrrOwWg8x2Q85H+B6ubD+nRzjb60dBdJ
         otZw==
X-Gm-Message-State: AOJu0YyGdC7HoHtsg03DWSZSxJFARPhrTqyeYhFbOORaiiSwEQ1zhQX+
        E3lW/sjSlZyt7ZCAT/rsaHe2gj/HJvZOegeUNZ/s
X-Google-Smtp-Source: AGHT+IFllLZZWFPHJxYpVLdypnKl5L3mAqv6xeGBFsLONOqGPVp2InTyca0HrFY4WjdMtw+6+LgnjkhlVrQ5/7vYr3qb
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:48c9:0:b0:5a7:db29:40e3 with
 SMTP id v192-20020a8148c9000000b005a7db2940e3mr420178ywa.7.1698328595848;
 Thu, 26 Oct 2023 06:56:35 -0700 (PDT)
Date:   Thu, 26 Oct 2023 19:26:28 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026135628.2800617-1-vamshigajjela@google.com>
Subject: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function to
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

The function uart_fifo_timeout() returns an unsigned long value, which
is the number of jiffies. Therefore, change the variable timeout in the
function uart_poll_timeout() from int to unsigned long.
Change the return type of the function uart_poll_timeout() from int to
unsigned long to be consistent with the type of timeout values.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v3:
- updated description
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

