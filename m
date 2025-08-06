Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B82BEC5C;
	Wed,  6 Aug 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511029; cv=none; b=SKGSQ1cyC0kyRTmb969yDTIFAwMTrA/alxUVNBLG4Epr2FL5+PzpZU3Y2z0VsdPerJJLXFKXYg0PmH5uLjUE8X1xkOqcAiYH4ReSiWIS7scXNevkXv8iWdT3Wyx067O7lOCBNcN/zH0DTDOAlZCcODDIMUUBURAAutw991yTjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511029; c=relaxed/simple;
	bh=2ufBNWYs+35cWUzKeUrvzmdJhWrAueP76qfzYop9QD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LolPOkpzOjgTDfmPuAnEXYAt80shT942W+78YsDfHtCE3Odp2BojB2eLFqCZk5vXsmiqYzZxiOYsKIIsGhzC263opXO/F01wY8J2lqmViq7pPUBl3UtNiQT3y59C1AqLpSikYXhaVqiFsNCKNrSC5xHyQpriaJh+gtffdiULH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqRAv6Aa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqRAv6Aa"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso433434b3a.0;
        Wed, 06 Aug 2025 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754511027; x=1755115827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydmjZ9RYLGtHRppDnONJgSJ5hx+juWz9zVI4g4InwYI=;
        b=lqRAv6Aa1r33fG+je8MwZig5jJuteScXMntzkmV0mi4eHdJK0B1zeWJ/4yuQf5Jama
         hWXlh7PWrihk0lV1FO4cg/KzqkYffL59LW+brDXNhjCw7eleXY0aBX5tZX6MYOcaOFPq
         vkE5vNN1jt7CFgG6CAFbLsGbO+dZ6Q7Itr/Q01ljXCRB+pKXnC43SMNHB9ihb/oAtsVp
         1aGePah9V6ITsnTHxcseu5Uy3rcX6pE96MxKs4U1c09O6iyNw4fvHckinwnTITabPikx
         v+FqOCkxacvGZykUDHfttSnyCcOkD9Pg3DffbNEKM5+4klI/y38AVk+lZFE/2Om0y+db
         CHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511027; x=1755115827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydmjZ9RYLGtHRppDnONJgSJ5hx+juWz9zVI4g4InwYI=;
        b=Ty3Y9S61FCorbUDhHLNKRSivqGe0Ue+x4h9tAFivNrZpW8ZenSjqn17fWvgtOLhEWF
         n6yJqgGstPUqumxduUIGBQ5dG9GtajNNu+Hgb6iqKeIavpD2jg7anSAHDRPWgJBiSFxJ
         08gbdTnzX1ihhUMu+Z7LX+fheXvlpQwOFK4U8dK08K4kOEt+4AniFmfoiA3QulcLNFGm
         5qtpdte5EAhul6AIQluOCiLDpGbbVd0JMzfg15XO++Ow/x9nD7rBtBSoapVyNQ0Tbfsd
         mCFbBt/DcxPsWdy0/wAD0+fyB90YW+SJiUy/x6QP6PDr++ho1bjAEkC8qFsk2o2peb4B
         AIwg==
X-Forwarded-Encrypted: i=1; AJvYcCW36nU8lgi1YejmdAuakFJkuENPbZFxO6XixBoquTtxWHWfP0RXH4B4EEzRiWvqrq9ogATXKN1YYzRdzS+A@vger.kernel.org, AJvYcCWKZgerUo0vVDM7kH5x/3w25FmC6vCkur1kK7VEludZGfZcR5ZOglCl7WSNhhiwJHpKZm2o9dHqrz7hYYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/+tW1O+WrF2hYXHY6wB1zSIqjwiXJyh0tzyLMmmW1PM6d8rH
	fU30ir+/Ird4p6tqiTybG7NmJ73oWVqFNvOAEXV1d0YGoOSNJofA8DkS
X-Gm-Gg: ASbGnculHiLRirnC5vgSFZbQoXBPB5afb2FtzusuW5PztmHRh332HNdG7aNMGEy+Ee/
	mJOWh9KdNt+gYfqx36N5vpgaYroCMGBkef10wYksQZjL2vayXRw7Puts+n9TJKjRsgx8sc9yjxf
	hXC8ZAm03prgmfUrSRuQ9/Y+0g1SghjuynVYoU4QshqbgcZSC2bGDGr6YT5zz7jOgOgMowjThZ+
	LQtyS0mydzveIct5QBkkX0hf8gCnO3VoHQqI7KPsNg+DqV18EBfqfXTQ9XnHpJXnQevq/zI+BJv
	2DxL7TELoPRQxBAgGLn63d71YGhI4gC0FY+VrjyuGPnf7zU4p3ArJvF90Ubjt52Lsoe9y28Semj
	wUelp/wOjHS0OBsFdqGP9MLh7tjfvMsxx
X-Google-Smtp-Source: AGHT+IFa+LT4nT8mGbefXIhRnJ0TvHsxP7minFFuDUw99xXbGKJ1oPCY8nNOYpFPwK2H1DyKzXPnoA==
X-Received: by 2002:a05:6a20:42a3:b0:238:3f64:41a4 with SMTP id adf61e73a8af0-24031453fcamr6185329637.44.1754511026524;
        Wed, 06 Aug 2025 13:10:26 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c397b87d5sm38882b3a.96.2025.08.06.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:10:26 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: abinashsinghlalotra@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v2 1/2] serial: 8250_platform: Reduce stack usage in serial8250_probe_acpi()
Date: Thu,  7 Aug 2025 01:40:46 +0530
Message-ID: <20250806201047.754240-2-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
References: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
 <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The function serial8250_probe_acpi() in 8250_platform.c triggered a
    frame size warning:
drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_acpi’:
drivers/tty/serial/8250/8250_platform.c:152:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This patch reduces the stack usage by dynamically allocating the
`uart` structure using kzalloc(), rather than placing it on
the stack. This eliminates the overflow warning and improves kernel
robustness.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
 drivers/tty/serial/8250/8250_platform.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index c0343bfb8064..50cec2413aeb 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -110,9 +111,12 @@ void __init serial8250_isa_init_ports(void)
 static int serial8250_probe_acpi(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = { };
 	struct resource *regs;
 	int ret, line;
+	struct uart_8250_port *uart __free(kfree) = kzalloc(sizeof(*uart), GFP_KERNEL);
+
+	if (!uart)
+		return -ENOMEM;
 
 	regs = platform_get_mem_or_io(pdev, 0);
 	if (!regs)
@@ -120,31 +124,31 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 
 	switch (resource_type(regs)) {
 	case IORESOURCE_IO:
-		uart.port.iobase = regs->start;
+		uart->port.iobase = regs->start;
 		break;
 	case IORESOURCE_MEM:
-		uart.port.mapbase = regs->start;
-		uart.port.mapsize = resource_size(regs);
-		uart.port.flags = UPF_IOREMAP;
+		uart->port.mapbase = regs->start;
+		uart->port.mapsize = resource_size(regs);
+		uart->port.flags = UPF_IOREMAP;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* default clock frequency */
-	uart.port.uartclk = 1843200;
-	uart.port.type = PORT_16550A;
-	uart.port.dev = &pdev->dev;
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+	uart->port.uartclk = 1843200;
+	uart->port.type = PORT_16550A;
+	uart->port.dev = &pdev->dev;
+	uart->port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 
-	ret = uart_read_and_validate_port_properties(&uart.port);
+	ret = uart_read_and_validate_port_properties(&uart->port);
 	/* no interrupt -> fall back to polling */
 	if (ret == -ENXIO)
 		ret = 0;
 	if (ret)
 		return ret;
 
-	line = serial8250_register_8250_port(&uart);
+	line = serial8250_register_8250_port(uart);
 	if (line < 0)
 		return line;
 
-- 
2.50.1

