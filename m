Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF61F8691
	for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727864; cv=none; b=LBGTAA8/i/xSgHyAHdi6PxKN67TelVVoISwH0iCwvoPfFyxypnug961WDIraGufWdWnG3NKrCtbok2LJmwwD3DE2GuIKfEpSR8ENEeq13EireADx/sXQyAItfsloHGgsFkmC3I875v58/Gt9vE14n/tSFYYe71b/fjc8jT59C9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727864; c=relaxed/simple;
	bh=RFpJhMAb6/Ac+KBvN35HZ91d91NxXCBSgq6PhNGSrX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPLYIh88AnWTfaftcqlgRIm+r4DWFBC7SX+lhLWQArUiuMtAvmV2WwX6ylu3hXInIBv+zx6TPRE+BuUTe67gzi94684CqLilOIhQyVupAgEsv3VxAIXKKVfI1fTDPrAlWA7US1bq0WaDqMVZs7N+PS0cWeCKY55sPQ2x1cOeKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoweUjS8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoweUjS8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so81627735e9.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770727861; x=1771332661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6yRaye4NU1tNWHdTJrhyOl7EJkeMFxl5/8ShVwQDe4=;
        b=xoweUjS8Ht1KWpKCMF/uLfNAzL3yf36wtV9rPgEv6UsrLyxMryiMYOvs/ML5l9CUkh
         J8igY2CxzFyP5/BmtTO9W4LlMDPohniRz8GK7bMACIFysgb8M2UjFe7rO62kE2niC7Yi
         8oVwVlu08Gntl3KXQi379616Mvo6f74yjCAF2bJF/Oggbo3EvbFBHNwsEzUfa77EKKJg
         C6a7UZj7Hzo8QDL9zz3fBIr5xDmKyrMDpq6Ff43TsL9DEbnqNQVDlrIm/LkIV7ZWz8YF
         YUaVGLrLJFdYB/A/jQ1nyrlsG24l0IiUPiY/XS0PE3oMYGr2uOW9msfZ6EDrVZp02yKO
         S23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770727861; x=1771332661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6yRaye4NU1tNWHdTJrhyOl7EJkeMFxl5/8ShVwQDe4=;
        b=ERh1w5sDxU7YTmXPHrBPs0OlgyUs7INn1ubmdgQ+uxZCBsJbfMCCR8OYsNkxZMmAo2
         51W9vTXWFlI2vW96fpvaiOmo8wGIQnzFlEwKLYrqre4hGe3GeylBv/ytT/5XQ9PCIujY
         vByJplT5shiAaashvq4aP9/Vz0sEqsuv5EWIWUcYiMy89rU4iUZqxYWr7EidGodvZ2qh
         Xr+eD1spd6V4UqtqGsa/TzqbbC08/SfUCMe1XI1uVPfn78NIjpKXALA3u5/elm7aFO8/
         JL/EACCt95kN65Pqd2tvRESg7bV2qyNGm/WkgHwQP3mYoJ0kmi1i5pSmpCLypU9YYlM8
         /I9A==
X-Gm-Message-State: AOJu0Ywh13KVYp19BOuEvjN6rcd/+Svd1au3Dr1LxQHA3MFNd1FCXG1p
	DPSjFWyPDOgEB+goezr8HctI6rOakEH9qmdgJDwjLWCOUs9yCd+LdUCJT1NMG98QL7n8nu6t7Zs
	tqNL6
X-Gm-Gg: AZuq6aIx51bS9/ptsqo54U/JABzFl+xzesskcYmKbDitKSZ1r8tNNT93dXla27WVXBl
	+KtxbN20NPFFCY9iwnu/aXcP2RDkqo3muQniuBBJ6vmHvfwXxbwfjakaQbAR7BF4Iu1xNM5V5P+
	6WLEcdv0bZQu5M5zmBM2wCYoH1/HFDAj9z+IRMt/dQUNLSvu80THTW2TwK+BnaArcpmWLUN8ic0
	xcbDlviL9RxQIhWew82uC+TwiPrHIjEByR91J+hXr3bsjU2OXICibdjOukHicAIBigNUTBH8oum
	LW4nLeVJ6G6TXqpXx/j4Wt56PKcJqS+GTq9WOdkfojNW9dyOsaftIn1FoUv6QJLHLlVg1+VFY7e
	HZb4qtjoUG/WYGE2cxxHJH2R5NVWFRT5vo8Coav2o88FvIvrPBfGTerkLohV32t3HxJU66xnf3d
	vFkW3rnQyca8O2hfqvpCVfpKP0UO3TwgNr9NuSy+hMG67gM+4x9RstMzzTHEkKW8T0b1AM+UyCX
	RjpjpN+ASwyHAS3gaiCb2pDuRYCWKo=
X-Received: by 2002:a05:600c:8b0e:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-4835081ec9cmr31161375e9.20.1770727861521;
        Tue, 10 Feb 2026 04:51:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209c1a64sm114179175e9.12.2026.02.10.04.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:51:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH] serial: amba-pl011: Enable UART in earlycon setup
Date: Tue, 10 Feb 2026 12:50:59 +0000
Message-ID: <20260210125100.223138-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the PL011 driver only enables the UART (by setting UARTEN
in REG_CR) in pl011_startup(), so if it is used for earlycon it is
relying on the bootrom/firmware having left the UART enabled.

There's no particular reason not to actively enable the UART before
using it for earlycon, and the earlycon handling for e.g. the 8250
UART sets up the UART in its setup function, so follow that in the
PL011.

This allows use of earlycon with a UART that the firmware hasn't
already been using for its own output, but the main motivation is
that QEMU will otherwise log a message complaining that the guest is
trying to write to a UART it never enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: I have tested this under QEMU, but I do not have any real
PL011-using hardware to hand to test with.
---
 drivers/tty/serial/amba-pl011.c | 35 ++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7f17d288c807..462a8c380059 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2700,6 +2700,37 @@ static int pl011_early_read(struct console *con, char *s, unsigned int n)
  */
 static int __init pl011_early_console_setup(struct earlycon_device *device,
 					    const char *opt)
+{
+	unsigned int cr;
+
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = pl011_early_write;
+	device->con->read = pl011_early_read;
+
+	if (device->port.iotype == UPIO_MEM32)
+		cr = readl(device->port.membase + UART011_CR);
+	else
+		cr = readw(device->port.membase + UART011_CR);
+	cr &= UART011_CR_RTS | UART011_CR_DTR;
+	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
+	if (device->port.iotype == UPIO_MEM32)
+		writel(cr, device->port.membase + UART011_CR);
+	else
+		writew(cr, device->port.membase + UART011_CR);
+
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
+
+/*
+ * The SBSA UART has no defined control register and is assumed to
+ * be pre-enabled by firmware, so we do not write to UART011_CR.
+ */
+static int __init sbsa_uart_early_console_setup(struct earlycon_device *device,
+						const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
@@ -2710,9 +2741,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 
-OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
-
-OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
+OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", sbsa_uart_early_console_setup);
 
 /*
  * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
-- 
2.43.0

