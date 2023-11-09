Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D435AC4167D
	for <linux-serial@archiver.kernel.org>; Thu,  9 Nov 2023 06:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjKIGeo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Nov 2023 01:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjKIGek (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Nov 2023 01:34:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8DB26BA
        for <linux-serial@vger.kernel.org>; Wed,  8 Nov 2023 22:34:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a909b4e079so7299617b3.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Nov 2023 22:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699511677; x=1700116477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2jeNRJU0TFD96K4lSEDdfn2J8CEyCQsEfZlnbJs/fQ=;
        b=J59rg+dsa94u9B4P3pkKLux7QJaxEA4cZVpTKwVqTgS/3ZJBj291p2ZxAoFL2PjHAy
         +zT5vgpu+0GxOYIIlPDOPJ4ABpcTcK2yU86jnL7LpIXuHS5n1LnrfJqg5WAipLmWxX80
         rt32Rs37/fTwR0Pom4BrUdsGJejntpOmiQNnPN69oaHfJ/15+3OmYuXE0Uq6r37pHr4S
         5tgXn2OCky8CfzbMCxLTAUQdILm7pU34roQh1D/YZgPL2OxzmA1QzUv3SNplz2LeIuTm
         7TxYtrmAUKHQIc1P8YdPqtDfIdx9LcWEBj670pMCeCMP9pZzvwnYbrVEdjE1lgyd9doI
         E2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511677; x=1700116477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2jeNRJU0TFD96K4lSEDdfn2J8CEyCQsEfZlnbJs/fQ=;
        b=s9JQ21E4QyJC1gRxFE9guX7Ly/5BOxZrq4KgmVxfOxP0YvCn0RSezMoUpxNfsgQ9/h
         TSxHSUpQzz19h1/3evYvgTotQusDk7gFIhJgtwjxD4atSyhaYNc2wgJq3gs8pWpwTnOv
         SATGKU+VCCGV+qdBSjdDU117UWQSmZFhtG/K9WxkJW7sIu3vmTlNVlbZHYbNX4P7DfAz
         e1/5LIb6sMA3j+5ye9EW2BnGAIuHFsdswNfqGxo6rTWU6dGZ4GGjt4V0fMxJ4x9O64b1
         0893VPxf/NDfmvlRdFxmFMpUoZz6nNyUsnGWxzFJGxOgkH8Kwe1nb2lL3EUU1U6phl9F
         PVmw==
X-Gm-Message-State: AOJu0Ywa7eA2OqaV8KZ59Y1DuRLHi5LBaozuyzqxHHiI+gAqCnBcogOP
        hJ/DG4Zq2mWmeYUTfwhoN0614ZHPHCuuB+2Wqc+Q
X-Google-Smtp-Source: AGHT+IFpLLF3700te+1leBboL3zkKzOivjeT5UF2frLwk+rOXmt0zRCDKRl5SE47mWFhfAeXcHQ/z1keJv7cPxycX4/u
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:9a44:0:b0:5be:94a6:d84b with
 SMTP id r65-20020a819a44000000b005be94a6d84bmr107029ywg.5.1699511676886; Wed,
 08 Nov 2023 22:34:36 -0800 (PST)
Date:   Thu,  9 Nov 2023 12:04:17 +0530
In-Reply-To: <20231109063417.3971005-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231109063417.3971005-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109063417.3971005-3-vamshigajjela@google.com>
Subject: [PATCH v6 2/2] serial: core: Clean up uart_update_timeout() function
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

Rename the variable size to temp and change its data type from
unsigned int to u64 to avoid type casting in multiplication. Remove the
intermediate variable frame_time and use temp instead to accommodate
the nanoseconds(ns). port->frame_time is an unsigned int, therefore an
explicit cast is used to improve readability. Having said this unsigned
int is sufficinet to hold frame time duration in nanoseconds for all
the standard baudrates.

Consider 9600 baud, it takes 1/9600 seconds for one bit, for a total of
10 bits (start, 8-bit data, stop) 10/9600=1.04 ms for 1 byte transfer,
frame_time here is 1041667ns. As baudrate increases frame_time
decreases, say for 115200 baud it is 86806ns.

To avoid costly 64-bit arithmetic we do not upconvert the type for
variable frame_time as overflow happens for extremely low baudrates
which are impractical and are not used in real-world applications.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
v6:
- Updated description with an example
v5:
- shortlog changed from "serial: core: Make local variable size to
  u64" to "Clean up uart_update_timeout() function"
- renamed local variable size to temp, generic name
- removed intermediate variable frame_time
- added typecast "unsigned int" while assigning to port->frame_time
v4:
- no change, not submitted with series
v3:
- no change, not submitted with series
v2:
- no change, not submitted with series

 drivers/tty/serial/serial_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f1348a509552..ec88cab2c8d7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -410,11 +410,10 @@ void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
 		    unsigned int baud)
 {
-	unsigned int size = tty_get_frame_size(cflag);
-	u64 frame_time;
+	u64 temp = tty_get_frame_size(cflag);
 
-	frame_time = (u64)size * NSEC_PER_SEC;
-	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
+	temp *= NSEC_PER_SEC;
+	port->frame_time = (unsigned int)DIV64_U64_ROUND_UP(temp, baud);
 }
 EXPORT_SYMBOL(uart_update_timeout);
 
-- 
2.42.0.869.gea05f2083d-goog

