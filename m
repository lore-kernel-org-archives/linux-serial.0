Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA7ACDB465
	for <linux-serial@archiver.kernel.org>; Sat, 14 Oct 2023 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjJNKuW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Oct 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNKuR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Oct 2023 06:50:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5616DE
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 03:50:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a39444700so3462928276.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280615; x=1697885415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYCXn3ElgcmgyYLbM76CHob0tkZSwXwvOlTaEhXB7SM=;
        b=etTkr53JSOwwe+9PYrUPt0fKjQzkeRwQurPJYvFu50+iJS82nIAp2OZH0BGPIDKSte
         wzXIM+FLJpCsDRsWttk2BJWWujVK9/25j6b156OUkm048163j6yefEzyTrg+qveQQYqC
         3Qg07eYL9toqsF4l6ffl3K25Mz18P4/JFfUWjSnYCIzmHmLINxv2WZ8o9kgb76HyQLDt
         p2sMbBJWwGReTttyu+gJPJc5DmMCGzClQWa+oimYx2iFZ1taBk2haJvLSKb5zS4qQKQO
         X1o6zQ93FKkn8PEDfJDF+d0DzMp4Y9SD0YAS3aCq9erFGKfAnMhDXYBPKmjat7aCtStn
         sxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280615; x=1697885415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYCXn3ElgcmgyYLbM76CHob0tkZSwXwvOlTaEhXB7SM=;
        b=UMwS6N7N52YC85iBVjkz4KXUjuKt6ryoB1PrQKuiTR8g/O5Ij38Fbk9+0mw42/rF41
         HtGGvHajyZnSPYCIgzUjAcXeaCKOZGCs2H/ECls72fCCrkB6Z9aKphazaJXWGdeumdAF
         yi5lCH/znvU/6lO586NfR3tJ9M1ZQplvVfi73OsfDUWthdorNBizOTEm9AyCy9ZEW7Ay
         ljFy5plO43SdB0NH/4h6LOgasXUMuv1wjF5DSJvp/1tUDKlrKwMrlLNeyGWalCpblxD7
         kE3AS0gozxhM1n1DXvTUB3BzfPW6PFAD/uhmofF8qp42UbIBVeQ4xmFjXADhvAgHk1nI
         7rMw==
X-Gm-Message-State: AOJu0YyoL+BXJUNSw76dg9Lzu0Ks5MEtK2p9n5yny+tGKA558xAvYXX2
        ufWcZLxmfPGH9Qp/H6GGQHI1Cm9zEM67oAs6qto9
X-Google-Smtp-Source: AGHT+IFVE7RAEJUGf8YGFcAVvRgkulAAOaL0R9FyNAXbNStbKMo++OMbut/K3NfJyNBOOqWXBW0gNNZv5PLmsODNykx3
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:aa83:0:b0:d8a:fcdb:d670 with
 SMTP id t3-20020a25aa83000000b00d8afcdbd670mr78496ybi.1.1697280615084; Sat,
 14 Oct 2023 03:50:15 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:42 +0530
In-Reply-To: <20231014104942.856152-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-4-vamshigajjela@google.com>
Subject: [PATCH 3/3] serial: core: Update uart_poll_timeout function to return
 unsigned int
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

uart_fifo_timeout() returns unsigned value, hence the function
uart_poll_timeout has been modified to use an unsigned int type for
timeout values instead of a signed int. The return type of the function
has been changed from int to unsigned int for consistency with the type
of timeout values. The result of uart_fifo_timeout() is cast to u32,
indicating that the value is truncated.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b128513b009a..445a1ff7e502 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 }
 
 /* Base timer interval for polling */
-static inline int uart_poll_timeout(struct uart_port *port)
+static inline unsigned int uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = uart_fifo_timeout(port);
+	unsigned int timeout = (u32)uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }
-- 
2.42.0.655.g421f12c284-goog

