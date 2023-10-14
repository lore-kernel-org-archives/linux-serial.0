Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45BCDB465
	for <linux-serial@archiver.kernel.org>; Sat, 14 Oct 2023 10:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjJNKuP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Oct 2023 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjJNKuM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Oct 2023 06:50:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8162AB3
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 03:50:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a836d49eeaso15407757b3.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280609; x=1697885409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0MUXgCgPp7gRv8+WcNEgYQP5+7MSeABFPYxMKK1EzU=;
        b=FL36PbjdncuCHtvIiTjirmj8Y1uHygRUSEiSeK5NjGaW8kAni8c6BvB7VTxYgtO3GY
         mzzL1GlB7/TlqO/jV99WqnBvAt8nm1wBKYUwLZz1CiBCeD/oT8HQWTgtWKW0wzTNaqvM
         MKEh7aczALaYKVEMwOMq4hIrfdhPorxcAyvMV61i5+CCOIO86PbJG7EfkpWplE4GWkle
         3OHU1MyjtgDDdxc5GH6Uc7vOcMd7xT+w8Rm9gB733C0nYG1qf4YLn9jd9Eut/37YdaDG
         Lp7rlqLFOgoQ2pCRBuJMDkkNl+Fq8u1V0c9MLt3/+gP7odqA/QMl4AOSsUXYnHb9jmrK
         5u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280609; x=1697885409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0MUXgCgPp7gRv8+WcNEgYQP5+7MSeABFPYxMKK1EzU=;
        b=c1vEp8iSJ5R5KY6aJGOSwNnlg/DZtkwguOTxMC17OURC+F/XIqNGws8XMpJcQR/WY5
         DSBCXimehiKKQv7PxDWtcAJn/ZVlI6UwVGQCuLQLsy84wZyIPZmVmzTNW8ioaA90stDu
         pHN/NYp51xhIsU5alGoHuxtm1N5msNTg2TUJTw/4arSLvi9z1D3dUHzW/xL4wANgU09H
         Mf5xiJGF507oUb4/e98IxoC7hdsu1+RBG0rrAUNTtkhFPq/I6wxBrnym/Ib99NYpcTQf
         GegTKGvDcT+WvanWq0Ad7YeiHHMhnuRkXkanFDLZev2jlEDce7MQOJkzE448f6586oPi
         tzKg==
X-Gm-Message-State: AOJu0Yz9B/+xwfv6x2jJaCBgMSBgnzWpRBfbNLPDPUa+2W5COMx8FvQm
        Gq28uxHF4mhqkNZzNhdtv8BA4jQdFGW14qE8D0YA
X-Google-Smtp-Source: AGHT+IECLjqnFxKwrfPtqN+hEWvDFTlsXiuek3R1asZ71+QVKuJMwQOlvflW0rK1xzYnt9ijnM15rGIZTBn4lcBdA8Wq
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:4086:b0:5a4:f657:36d9 with
 SMTP id gb6-20020a05690c408600b005a4f65736d9mr522763ywb.9.1697280609769; Sat,
 14 Oct 2023 03:50:09 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:41 +0530
In-Reply-To: <20231014104942.856152-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-3-vamshigajjela@google.com>
Subject: [PATCH 2/3] serial: core: Make local variable size to u64
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

The variable size has been changed from u32 to u64 to accommodate a
larger range of values without the need for explicit typecasting.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..fb4696d17a8b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -410,10 +410,10 @@ void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
 		    unsigned int baud)
 {
-	unsigned int size = tty_get_frame_size(cflag);
+	u64 size = tty_get_frame_size(cflag);
 	u64 frame_time;
 
-	frame_time = (u64)size * NSEC_PER_SEC;
+	frame_time = size * NSEC_PER_SEC;
 	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
 }
 EXPORT_SYMBOL(uart_update_timeout);
-- 
2.42.0.655.g421f12c284-goog

