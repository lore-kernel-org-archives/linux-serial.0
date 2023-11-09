Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E36C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  9 Nov 2023 06:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjKIGef (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Nov 2023 01:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjKIGee (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Nov 2023 01:34:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DC25AC
        for <linux-serial@vger.kernel.org>; Wed,  8 Nov 2023 22:34:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da1aa98ec19so647485276.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Nov 2023 22:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699511671; x=1700116471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abQd08PQRsfE5cNpdzo6Y08BdXBRdYZxGxWuQAVeJlQ=;
        b=VV5aNk9eFj5dxt/XGhekyuDvcYyQJzT8PUehzAe+uiJynBDlXGoELBvWIu4P+rhybl
         ub1bFdk0waxQobl0VxUoaqiGJLslgisslEHvrlYmUrkECr+0b6/pQThLBc1D/piYYfvE
         vSgAmcpSGSA5rl+Wl3m77Uh6s67KNmBHVUxAJQYmJDPYrCkjUx3iNb1Mzj46MMDZCIo3
         HpQ6gkObKMy142a28eAQZMxxsfaPLD3ncavDZ1G5raDJeIx6AuF5tLfUAtG7M9fwl84T
         wYaMsKTPZRmbsmdt6NZNXHxwB2ul6k9IjxCcjZkrw72PAxoAD4hzndQxVrbaqEWGnswq
         rKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511671; x=1700116471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abQd08PQRsfE5cNpdzo6Y08BdXBRdYZxGxWuQAVeJlQ=;
        b=ryWI4d2DMOU96JSk6w+Ukvnst5Xd0ePnkee5Wz/VPREyZfdAgsaKyv1vXiIM/WxazS
         98PVEUu+07jxC7qHVphTO4kuqxWPtQMx0CmJZy+EYu4qsdr3v5UIMrSFRn1/SFmwj8LR
         1JU8DJP++VQm7a4QS3UhHmUbC8zjnak48GlyzpIYbSsXvtgAMqNP0mgoik/+0pqa22iP
         AQ0toG8SfJ4fPzFqKRrCwHzM5Cj4dI98a1sDNEJ7kt2gHNzrUDjtzglro3pAN494Ax2s
         L4xURx24ZGQwavsmO7AUutcPINahx31mfJXcYTHsCjALYyCh7f1ZIw1IbH09H59bB1+g
         GOew==
X-Gm-Message-State: AOJu0YxF0xhwxzGVVrh9kZ8glkMM7xa25hyNSoFtUaj9IQdUsFOalM76
        EBHC/qONMdktg2gDjLbuqe+/0hvmQ7nVekMlPsSs
X-Google-Smtp-Source: AGHT+IEU2smaVjGLLIZVWcgVCGcNyec2JpGISmOH8iPrDt7/4Yl1c5ncoNDa6ydsYIZnBK9pRwB+YIrqPbG/0qTkgLHr
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:5053:0:b0:da0:5a30:6887 with
 SMTP id e80-20020a255053000000b00da05a306887mr94006ybb.4.1699511671351; Wed,
 08 Nov 2023 22:34:31 -0800 (PST)
Date:   Thu,  9 Nov 2023 12:04:16 +0530
In-Reply-To: <20231109063417.3971005-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231109063417.3971005-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109063417.3971005-2-vamshigajjela@google.com>
Subject: [PATCH v6 1/2] serial: core: Update uart_poll_timeout() function to
 return unsigned long
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The function uart_fifo_timeout() returns an unsigned long value, which
is the number of jiffies. Therefore, change the variable timeout in the
function uart_poll_timeout() from int to unsigned long.
Change the return type of the function uart_poll_timeout() from int to
unsigned long to be consistent with the type of timeout values.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
v6:
- no change, submitted with series
v5:
- no change. Consistent version for series
v4:
- author name in capitals to lowercase
v3:
- updated description
v2:
- unsigned long instead of unsigned int
- added () after function name in short log
- updated description

 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 89f7b6c63598..536b2581d3e2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -852,9 +852,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
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
2.42.0.869.gea05f2083d-goog

