Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65791C54E4A
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C609215A4
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GzcY94Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgEGUJa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 16:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728688AbgEGUJR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 16:09:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EC2C05BD43
        for <linux-serial@vger.kernel.org>; Thu,  7 May 2020 13:09:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so3133682pjb.0
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnBeK10KzsaeyDFO2398m9/Skswi+j6FYU/gKr10cks=;
        b=GzcY94LdE0hSxHNb2Ie4O6ZGy7FUnmfrizHDOWnagUu/3DoRcnlASU4EtxJamQJf5n
         YInSK43rqVxNgmqEJyLE1V8uoQuK711LrzZzl6Jy+DwiB3USC73zDvfsnly8sf5RE3MO
         gJ0PUw1ZkSRig2z0wZbVSdLbZCRY0xEmG2+0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnBeK10KzsaeyDFO2398m9/Skswi+j6FYU/gKr10cks=;
        b=OivLLKTc1bLcWxPhjwbvOkHWWVxIvUqNslrZYYnJTncSkV+n4Y8jKoEq2gXKPAjGCT
         N71rs6D+8AS+IKrCjGJsi6Sjc34ohjuGlvuC0FH/AT4KtoYsYW9OjFCx9uycihrHeRwb
         pl5PDI23wGuSWPzqQvDNvXlYzZMZYMws4/E7gC8zrVKN2sbmlaxvIW6hLK7KgVm6w/OK
         ofuQJ7U3hPCvay4BHCQEnzMbuHI/jEkOlmLVvmer6SCuKxgfYFnqpAaa2S7VAodqlu6w
         sWBVo2D8n3t1NydWVDVBmfLbkmh59l7rwFJYviwiSswfZgAKwLPPIXMG5AASKAsQI/KO
         QWEQ==
X-Gm-Message-State: AGi0PualG8GDFaeyi00VfCUm0qNsaITu/mesgDNqnk5RWlYvjMLfOn/r
        ZJmglen0VNFNyfm3Ni2hKxlUyQ==
X-Google-Smtp-Source: APiQypKbwI7JzsjlGczS2mRvFdtUhbrL91Jdr9XjVjfScPm9ggnNRqUiKjXSnHdXQBa+ufgliHhpcg==
X-Received: by 2002:a17:902:dc84:: with SMTP id n4mr14949596pld.281.1588882156436;
        Thu, 07 May 2020 13:09:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/12] serial: amba-pl011: Support kgdboc_earlycon
Date:   Thu,  7 May 2020 13:08:50 -0700
Message-Id: <20200507130644.v4.12.I8ee0811f0e0816dd8bfe7f2f5540b3dba074fae8@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Implement the read() function in the early console driver. With
recently added kgdboc_earlycon feature, this allows you to use kgdb
to debug fairly early into the system boot.

We only bother implementing this if polling is enabled since kgdb can't
be enabled without that.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- ("serial: amba-pl011: Support kgdboc_earlycon") pulled into my v3.
- Renamed earlycon_kgdboc to kgdboc_earlycon.

Changes in v2: None

 drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2296bb0f9578..c010f639298d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2435,6 +2435,37 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int pl011_getc(struct uart_port *port)
+{
+	if (readl(port->membase + UART01x_FR) & UART01x_FR_RXFE)
+		return NO_POLL_CHAR;
+
+	if (port->iotype == UPIO_MEM32)
+		return readl(port->membase + UART01x_DR);
+	else
+		return readb(port->membase + UART01x_DR);
+}
+
+static int pl011_early_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	int ch, num_read = 0;
+
+	while (num_read < n) {
+		ch = pl011_getc(&dev->port);
+		if (ch == NO_POLL_CHAR)
+			break;
+
+		s[num_read++] = ch;
+	}
+
+	return num_read;
+}
+#else
+#define pl011_early_read NULL
+#endif
+
 /*
  * On non-ACPI systems, earlycon is enabled by specifying
  * "earlycon=pl011,<address>" on the kernel command line.
@@ -2454,6 +2485,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->con->write = pl011_early_write;
+	device->con->read = pl011_early_read;
 
 	return 0;
 }
-- 
2.26.2.645.ge9eca65c58-goog

