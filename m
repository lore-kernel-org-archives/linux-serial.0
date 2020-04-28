Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CAC8300B
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E397D20B1F
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PIn5iHI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgD1VOi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726886AbgD1VOe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CBC03C1AC
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a7so55383pju.2
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olbDJB3S+bdQ1rHPM1o42dCtHB3e0ATdib9atqJ3CH0=;
        b=PIn5iHI/IwS+TMjQUsr/2rRfGrEiC7wLceEHu2VgewBRrHcU+2V+W+ZAiKrY1GySUm
         voM5jTx9zygH5APLxR5laFyA0OZJt/joPffylYulA5va6p0bqd8+/oQtuvMlQvPT7Iw4
         iOWldVK3Gzxz4MGAg0AYGRLa5WBTB28vN/Ofo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olbDJB3S+bdQ1rHPM1o42dCtHB3e0ATdib9atqJ3CH0=;
        b=YvOR0/I0cWJzp/+2GBjhsaRLJXPPyAzzJDncd+ahZjyViW2Q8VEb1cETIBhob+wklu
         MnQwRc7tIixzFIfJkHqfidJeLwSS5RjXKOHJumb9X/7HLHjEdBW3YBB8BfYaDYAVxlpe
         ofFit0uCgrrTMT4I+8WEb3ir8TBLtXNbE49yEee2KPnhHVjY29giZzZokp2vdxZJ4Qwp
         fEDK3k+fXi/XyVjCDshv1RUPQRnXjc5ob1NVCD1/X7qKatrdXuZMtkNFGOlqJMcfmbFP
         ov2/4yNDnyqA/AssQMp/BHAZS25lsRQPy9htrzOGbpCikjzWxJLUsy5VULZNVi17hrg+
         5lrA==
X-Gm-Message-State: AGi0PuagMbX1MV02NyWeCgWtwjQAmMpHc6OsW5plRLtAdJGf93ooLNe5
        ZuKqqoCfMq63BLqyIXRqZ8FUSA==
X-Google-Smtp-Source: APiQypLL7OQbMlCdHb2Gh/LCqBb1CYuqtnA3YYlHL+MOghPSzRephJ9LAeuBLX+kdzhTdo5B2mZSjQ==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr31679849plt.35.1588108473631;
        Tue, 28 Apr 2020 14:14:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] serial: amba-pl011: Support kgdboc_earlycon
Date:   Tue, 28 Apr 2020 14:13:51 -0700
Message-Id: <20200428141218.v3.11.I8ee0811f0e0816dd8bfe7f2f5540b3dba074fae8@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
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
2.26.2.303.gf8c07b1a785-goog

