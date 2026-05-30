Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7B25B084
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121445; cv=none; b=q9J2FVlbuJAAURfycOXmJSchrCgqCiuAHO7YLIri9Pb0N5hWwL9YeyOylEhowacwYf40AxIgPF3hYTyHXfNPkiiubbcVFjJmpqnBc1coaUi71wSj4x3OXpUkLISzYJQeSZ5NUw96M2FX/L+OvWkWgfOPdX6a+SkV1fdX/aBvzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121445; c=relaxed/simple;
	bh=4BoNj0omLorUkq0FrOs9cIK5T0toqS2TaRGY4KI7WUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNgmlNA1IUN1NspZwhk21gGKq//OVcaXi5ASMmgwGj20v7sSAQyObZ/bE751gE8i/AIjg4G0gPOv1Z4P5liRjD8VBHnfaY/vWgf/4NH4z3XLPH6mrQT0bK9oYlnZn225ou8k7/6H59/cz4IW0suzo1eKvxpGT27TSudgnY44Tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFc1oz6u; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFc1oz6u"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842358aaf36so9023b3a.2
        for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780121444; x=1780726244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67B+WOBRgupGSWBJ83j9RAvz/2qIYBW7PxYCF5qx9Sk=;
        b=BFc1oz6uiIwcNBBbrv4YZFB2gHmfm+CYv9bwJZ0uLycP4JzXvK873m0BUmDeETMKMU
         Wn89ZnqjqoSSyPp8Wkk55zZ6l1vmPGrw4CLwLIByJtXQsI9Umc+87eFK431knedXr4nV
         LXvrH32ChKGtapX8Lk9DRZkjLt8hGBidguMC3YTL5jTjwvsBRADoy0Fc77BAf3QUlK88
         LF6/FaLAckmh5WVyo8UWTfFWdkGIh6KS/jzr20ipofO3BavA7zeC7KRBA9wn43eqPEih
         0oyhNFAB90NHqy8ex+n7Zn27U8mhJ5VLiS5oZrbikHSKud6kP96QrEiFKOkz5I0wdCR/
         FglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780121444; x=1780726244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67B+WOBRgupGSWBJ83j9RAvz/2qIYBW7PxYCF5qx9Sk=;
        b=MkK39crohG3nWPD5i9cIFXnptsLPVxOgj8itUjropu4/DviUnacH1wpHFRl7yXxUdD
         U/wJNAVQXIB2BqbBU+Z8Wajhu1E/Z7bCKfK3ghEde5dng0WzWMwQ0WVI0bW4VLwueCXP
         QdW3RzgD8/s2SwQ8eCyxE/R9jqDIDvb9HCMyauAj4RVypHb3luod6fdoN+OM5zrM1ToF
         c3ltvGYZJc2oAiGbRFdmwAG8lailzoejmFDgNa5XmcKKs4xVLbyC1wjtNCHlgle6dC5Q
         H9FI0nGV3w6kaR6HW7VxiVDWSCWIcs/jQrpmHvxo7b6p3lPVnIiSNb0vp7K3xRjuVNu+
         IDbg==
X-Gm-Message-State: AOJu0YzH3XqM8sagH+y0MxBoNjhKTWfM6KXR6k07La7XT7G17dJ9M6kK
	rZev7wctZM7lPQOFhET9wluUrWiaFj+8kW30CRbPYRQ+9WbtMqoBgsr1zUcpJto0
X-Gm-Gg: Acq92OH28EPHl65rhcdSVic0R3OjvwXtM5dn/KUM1VSmbqDxR11lRHKtnv3IN8N+ibK
	UGr9rMb3IgO09OMO6UMrBjOjMx5qQJMUum14CrmHbYdDs5ps8d9pB4GcOy8FeHqaibliOYOUZI+
	k6wnVYrib0FdUQOjIW7MXkT7HuhfkZUNRrnkuXD+UHHk35EwS2bgqyhYm94Gj5lJZTW4axxRpot
	KYgEUwO4HF+Cp7+vHiIAKH5HDprmOiFcoLdpaq5tbnNpjGROL4BorTGiVbpCbSk4goTD+07L8ea
	hLZOILsqk0wLE5+aW2q3urqhhMuUgwnq5G/IKu1lKm7ZpCWUA4FaAtfzIskfc7CwLGrXo+eS0di
	TSPoCxm4wnP312WrWwhkqG8mY+9WdkDqjusLdqrh60i7yf/7XhoUKIBMN5zw8Y7tCWv/o5+NZ5p
	wrAzibkftiQP5ZBq6SBowv4E4VibFLAtv1+ID7lwuKSXbi2kCvsGQCJzzDYxteyliw8yPsiatNm
	4VdxcF/i1CFFlWRmKBZ+DW9Er7fr3rspdPlQU+etVSuEA==
X-Received: by 2002:a05:6a00:44ce:b0:841:71fd:60c4 with SMTP id d2e1a72fcca58-842253d0440mr2655843b3a.4.1780121443635;
        Fri, 29 May 2026 23:10:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214ced002sm3894438b3a.56.2026.05.29.23.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 23:10:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] tty: serial: mpc52xx_uart: add bounds check for psc_num array index
Date: Fri, 29 May 2026 23:10:25 -0700
Message-ID: <20260530061025.11625-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psc_num is derived from port->mapbase bits 11:8, giving a range of
0-15, but the psc_mclk_clk and psc_ipg_clk arrays are sized to
MPC52xx_PSC_MAXNUM (12 when CONFIG_PPC_MPC512x is set). A malformed
device tree with bits 11:8 >= 12 would cause out-of-bounds writes
in mpc512x_psc_alloc_clock() and out-of-bounds reads/writes in
mpc512x_psc_relse_clock() and mpc512x_psc_endis_clock(). The same
unchecked index also appears in mpc512x_psc_handle_irq().

Add ARRAY_SIZE() bounds checks to all four functions before using
psc_num as an array index.

Assisted-by: Opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 37eb701b0b46..b566206f42a2 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -645,6 +645,8 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 
 	/* Check if it is an interrupt for this port */
 	psc_num = (port->mapbase & 0xf00) >> 8;
+	if (psc_num >= ARRAY_SIZE(psc_mclk_clk))
+		return IRQ_NONE;
 	if (test_bit(psc_num, &fifoc_int) ||
 	    test_bit(psc_num + 16, &fifoc_int))
 		return mpc5xxx_uart_process_int(port);
@@ -663,6 +665,8 @@ static int mpc512x_psc_alloc_clock(struct uart_port *port)
 	int err;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
+	if (psc_num >= ARRAY_SIZE(psc_mclk_clk))
+		return -EINVAL;
 
 	clk = devm_clk_get(port->dev, "mclk");
 	if (IS_ERR(clk)) {
@@ -711,6 +715,8 @@ static void mpc512x_psc_relse_clock(struct uart_port *port)
 	struct clk *clk;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
+	if (psc_num >= ARRAY_SIZE(psc_mclk_clk))
+		return;
 	clk = psc_mclk_clk[psc_num];
 	if (clk) {
 		clk_disable_unprepare(clk);
@@ -733,6 +739,8 @@ static int mpc512x_psc_endis_clock(struct uart_port *port, int enable)
 		return 0;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
+	if (psc_num >= ARRAY_SIZE(psc_mclk_clk))
+		return -ENODEV;
 	psc_clk = psc_mclk_clk[psc_num];
 	if (!psc_clk) {
 		dev_err(port->dev, "Failed to get PSC clock entry!\n");
-- 
2.54.0

