Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F8C4167B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Oct 2023 07:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjJ3HgH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Oct 2023 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjJ3HgD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Oct 2023 03:36:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41CBE1
        for <linux-serial@vger.kernel.org>; Mon, 30 Oct 2023 00:36:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afe220cadeso28312427b3.3
        for <linux-serial@vger.kernel.org>; Mon, 30 Oct 2023 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698651360; x=1699256160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJYRMGz5Km6YdZ6S41UQtlr9nImkATltc1KA9WGy+hA=;
        b=yI67vC9fqrQEeXKZsIIS1FL+y29Hx2GYVD96oofZiRfIwyPbry7HG7w5KQqvm8TtYG
         d2dYUpJfgL7nZvgsJ6Yvl1n1BfHIfd4NLC7l4tJG/E0n3XyBy1OHSXbqSkqejesnBgpS
         61OvFzVx+v9TH63rL/bOtCZ8ujOeDhVbnm1acE0YidnFr+AHx6SQUsHPv49k8j5Ky3a9
         PHGc+Iytv8PXBACnIPRGj/jc0x6jqXFQRTw0SfMz7GXFjAcPtc1NyPogYpRz3F/zEa3O
         7U70Pkr8/jjEBz3LeNu46vA7C7wt2ZJ9P39lWq7B6seQz+pITVm9jta4cmNPU0AGqs7d
         AGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651360; x=1699256160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJYRMGz5Km6YdZ6S41UQtlr9nImkATltc1KA9WGy+hA=;
        b=U6mxUiM1esoQAllVIKSfJhHPz4n2T76xt27fqI4L5Xrx6tCZ9hM/ij4l4TBx72uS3X
         mzHTUvM4uwflkZE2kNQ4tOiWaKlwVVTALyqt7W81lVCEewbMwxB9uZTkCaySI8RfoXp3
         hnyPRKnhKoa6qPHwMlwINb4yo+i78eP1M98EU3J1ky4J7x5KAQGcZi+lA0zoiCGt6X4J
         iCGlvLZt3HT9jwB4DpJPGSEhCekgIoPMJ5JCIcaVAyhF+BwYD9xf4Am12ebq6rXDJjMu
         6O7Fbw3riZr8NpwROZyZnLCxHAcZcu3wpzKTCNutbRSLbrih2Bz4jW3QnSiEnZDVEMY4
         D0kA==
X-Gm-Message-State: AOJu0Yw/uhiEkZaXIKTa1DYLkplOn6bttd17QC04NlIIT+A+btqqUIvb
        aVKv00orP6v8QPXCkqGf3vJlJOvOuiU6X5PzPRRD
X-Google-Smtp-Source: AGHT+IH43k6QWEJV2RtBgKwWnWVAcIXj5xEnffXwHQsmz+m5ajj1E80bw/CPBrQ699JZ3HJWOMm33zn6gH7AL2HWwX8P
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:2a45:b0:5af:a9ab:e131 with
 SMTP id ej5-20020a05690c2a4500b005afa9abe131mr155448ywb.1.1698651360172; Mon,
 30 Oct 2023 00:36:00 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:05:42 +0530
In-Reply-To: <20231030073542.251281-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231030073542.251281-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030073542.251281-3-vamshigajjela@google.com>
Subject: [PATCH v5 2/2] serial: core: Clean up uart_update_timeout() function
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
the nanoseconds. port->frame_time is an unsigned int, therefore an
explicit cast is used to improve readability.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
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
index 7bdc21d5e13b..21d345a9812a 100644
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
2.42.0.820.g83a721a137-goog

