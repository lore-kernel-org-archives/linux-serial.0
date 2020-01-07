Return-Path: <SRS0=kbyA=24=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B60C33C9E
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD33E2072E
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQpBpE9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgAGBDR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:03:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36891 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgAGBDR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jan 2020 20:03:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so8481129pjb.2
        for <linux-serial@vger.kernel.org>; Mon, 06 Jan 2020 17:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UgFg1/ut7QmIumbn1uU+fVt69KUfyjkEA95WzaJYXK0=;
        b=FQpBpE9ygbqx/N8KjD17p2R+ZIlx4O9I5XTpKq0lvNLP65RPv2ZCdaQ1WY6W6w07Pz
         nPrQ0zPZ0iVq7G0F8XO872IPKa0MfnTdhNi1IaArRzoYJfHVAMSEmOZ91DDyh5xo318P
         2dLr+WXhYDkmFbCwf/AzPGp1ByLJxT1zaKcTbJthK+8S1t++o4k7VtmJoBYFmsFhlJbw
         12KGzBd6bagKaeeYhJ/NMOVhZ7vQXkXeyL0YeYKD/iCvkjEwWf2HPeFwr8HeZS2Pj6GY
         Nzphvqy3kqCXveS9kb+/hpQKn45t2q4NaJlZ+/5HyAvhfeb8NuzV9NnevgwvRdUR9ssC
         ed8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UgFg1/ut7QmIumbn1uU+fVt69KUfyjkEA95WzaJYXK0=;
        b=UFeQs3qmIGfxiz1l5Qfc08Zo/FUqcDjpOquWwcbg9nT1g6eCFvAzyiPbzNkm/SDSdA
         VayrG7BeUqs0XT+jjdlPiVLvGBW9YDOW9b3aySVgvBvuhC79tNrfe7P4tWiguHwyZ2hi
         umsQJ79pE/tKWqWgYxeTn1PYA+UmvgfGxCVSG0DsISHltLK2ZMDYLp42/u49wylTvyJ0
         kKKMnoqsVHTyYqb5zxRsKWO6HY49KXIo0SssRy0+FSpucqdTNcKvsp5DNrNrqGgKgBhC
         wOCnXDULZ6wW2Jag7K0/j18ZCajSW0VTp5ZYoMgRgDB2bLuY8Eem96c9JznlDXn4GMAz
         u45A==
X-Gm-Message-State: APjAAAVfho++cwMRN2Lck/T94w4aa1cyS7LJPVVk5h0nmilEC2soTfNa
        ugV0QRMd3aRdAAVGYRedzp6N3A==
X-Google-Smtp-Source: APXvYqxJUhj7mmU7o7z8CZx/SlWy4uSKMEdT7kW4bx36vqKVdtainUKGfO1+HyhEMarbxgKqDeMAzQ==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id x15mr46917582pjn.87.1578358996582;
        Mon, 06 Jan 2020 17:03:16 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d21sm25361304pjs.25.2020.01.06.17.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:03:16 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 1/2] tty: serial_core: Export uart_console_device so it can be used by modules
Date:   Tue,  7 Jan 2020 01:03:10 +0000
Message-Id: <20200107010311.58584-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In order to support serial console w/ SERIAL_QCOM_GENI=m,
we need to export the uart_console_device() symbol so things
will build

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7c2782785736..7b87c08f5bcb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2603,6 +2603,7 @@ struct tty_driver *uart_console_device(struct console *co, int *index)
 	*index = co->index;
 	return p->tty_driver;
 }
+EXPORT_SYMBOL_GPL(uart_console_device);
 
 static ssize_t uart_get_attr_uartclk(struct device *dev,
 	struct device_attribute *attr, char *buf)
-- 
2.17.1

