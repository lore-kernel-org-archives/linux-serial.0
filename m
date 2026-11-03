Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736807;
	b=BhFT+AHJ9zYwu9AQyrVq8nwgV73b+V45sWMPzJpLC7kBxIs4nY8+5MDVQoih0symKOWP
	 oJdyngu+gjtfdVcdSnjYMslc/TcnFVoFxsUO3ZKpji4QNcPzfAt2Mq++KSXDpzz5EqBoh
	 yf4xKN3PLKXe3+ITeqVrTqmm+tPe/WGZVzQJiRpH2DoHfDWV5i5/e/+rnchjcglGeVx+b
	 tNDHDiltwYmMx2FKXP3u+m4b2yzhGgpJT/ycSW6iJQUkM0BWj/Z0wBY9CMDNXE94amt0D
	 fyg/c8GU4dNVRbCREyvk2PfeqOWjdWrV1niLJxT/AR4Odh4NMIImzsvsHFY7Fm2zUDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZIrDJV26wJ6cu/ZJewuMo3vnvvL3TeoGYe/qcbbz14s=;
	b=chF0NcWCXvvGdDVf/Y83btZNp6Im7XILCw+JSvkSnfJOuRu36MvxBbrHPWOFt9R/J+lg
	 7GoIQyO/rktpIIZxbSzykLEAgupXDHp+3r0ZMFfzrl6Kel5e02Hm9yq40711I5MELfbzq
	 cUAoSrTA3ja2LmJqLNMgQoT3CwEQYgFu1+tt/NVDGHYbri3hrf5TD+WXy4i6rwcZLrChg
	 Twrd/Jhhm4tZF/tQ3ouBnshPfyse22Bo1CtTrs5rf2ZDGOe9uqgXLrFwH5AKoK1neHhbK
	 TCaTRKf/xYuvMEQTgsXqAnDGTrlU72RCm0B8aNj4Izf3hPpfM3SbkOqWO2wcjfh3eHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBrU2GFf;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CD606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 20:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E02CD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBrU2GFf
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48bbb06e746so2327736f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736804; x=1794341604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIrDJV26wJ6cu/ZJewuMo3vnvvL3TeoGYe/qcbbz14s=;
        b=oBrU2GFfmB3nL5yO7RsgyKgCaaFokAvEZdeOTaYCxyKSvGvsHCR9Eos7CpSavnCCZz
         vUe4MvnC/C9+bDVSGDXq9PZCdzlDH0o8J0wauP6lImBLVCoROJ8QNahdvhvp2lqwgsEL
         gf7G29OZWxdyQn7FkaMivpApWukvlj/hCR15eQhb2VXcQQ57qnIQMsO9rOF4l7mSWjRA
         +PzN6GlUpEitzmkx+MrE/x49KfnzGUwLze8paxdd37bTTgsEwN8pA6MBKsTDh/p/hJ0d
         RcHAz6Cw2FrLK7TqRtHJisagMYVJsNGRNpgraJ+xa2Rccg/KimDG8YrQRe1VJOLlKaX/
         8tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736804; x=1794341604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIrDJV26wJ6cu/ZJewuMo3vnvvL3TeoGYe/qcbbz14s=;
        b=bmCImjOnOa7VtaYR/LkNc2c40PhAFSQJ+BJziSd2LPRrfBQEnnm2fQeG0QFEGQhhjX
         vJthilanFv2xi/QJ1X+vPDuP5jzPWZAqPEh4K0W3nM6hkxzALqlxvNsEDbO+SkD0PpYN
         6670lK+wY6CjIonRFBuMq9VIEkOAcrzwmETCZqv8eAswhK+7rWspbZt9RxXyLQlPqdTE
         j++2AZREWbiUiF3u1sSId1hdlXoA50CRpokBfFnjF18lFp4UY7vA+nKg9UDGJMQay6j9
         5Bv+7lv7UZVExnx3OQXRAWGRjP0ATH0npdb2C/h67MfJi3hWZKqP+LSZGcX2RjrTB+1z
         xGQA==
X-Gm-Message-State: APuU4Z9w6Sc2MU6FoQbNUt8AE5F4TDvJTno4aqbTdpIoL/x0zdQIXv9k
	098NmiaYKZk8wl4XJDA46QPeoHcBzNCCvVh9Rktbt5JZMIr/IwB/TQs3
X-Gm-Gg: AYBFou0V4uN/q8Wgtp4wAJlazdUzrgq6iO57BuQnXtS4Tfxvuy9bD2JpcXydCGGACum
	9edUHiRAQUoeQqX4Czdgpf5UP31VyxegkppTkw0kghyI0kLAO3RuJKUvgIajmW9FFUjLg/aMCSD
	j860qpF7uJWS9riyaTgVvotCVNOq+5yAXKo4w3WlC/+qIYB+RZYOAVE++n6248llwlnQOmjbnyJ
	B/aWFm5q3Bjjki6a2YTlJUH/X7qxEc4LBMMN0RxWvqW1mMWBga8VWtUoBuiwffk+YatrgjY9n1R
	ItIBBUe9TQcj5krP+TDkQjb3prBxF/Qrcjn/mS5v5uQ6GFEwa8EZ8q7oBc8ECHK/hHdWs204Qbn
	FEBbvfOchRqDDGUIoKlYrRzmGHGcmXCuY0WWokSp7UAzR/EmBWF5d8/fbIEZ7ywTm3hxxyZtwwb
	d+g4jzQp24hmkXW58Uv0DowYbIZat2cKJqSowRIefLZ50gTsKU4USxQNkMImDvuGPzTbCrxn0KW
	OOZLjCaFWmbDiyFzWStHVU37xxAglcZ0mWYwulo4pjAXSK5L+ILucYaqtpfPq/2n1i/aSW5Hoxm
	w60D77GXOAsdZ1K0YhBC06LIcSXZR/jGoi+ueEDi1y4=
X-Received: by 2002:a05:6000:4a19:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48e6e2fce72mr30237604f8f.22.1793736804112;
        Tue, 03 Nov 2026 12:13:24 -0800 (PST)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcc5b1798sm443240f8f.29.2026.11.03.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:13:22 -0800 (PST)
From: Bramwel Barack <bramwelbarack89@gmail.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bramwel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH v3] tty: serial: mvebu-uart: use device_get_match_data()
Date: Tue,  3 Nov 2026 23:13:05 +0300
Message-ID: <20261103201305.18963-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modernize the driver by replacing the legacy of_match_device() call
with the modern device_get_match_data() helper API. This cleans up
the boilerplate code by extracting the match driver data configuration
directly.

Consequently, drop the explicit inclusions of <linux/of_device.h> and
<linux/of_platform.h> as they are no longer required by the driver.
This allows us to also remove a now-redundant forward declaration and
 drop the problematic of_match_ptr() macro wrapper.

Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>

---
Changes in v3:
  - Removed the redundant type cast from device_get_match_data() assignment as suggested by Jiri Slaby.
  - Marked the data pointer in struct mvebu_uart as const to match the return type of device_get_match_data() and prevent build errors.

Changes in v2:
  - Dropped the redundant forward declaration of mvebu_uart_of_match.
  - Removed the of_match_ptr() macro wrapper from the platform driver structure
    to prevent build warnings when compiling with CONFIG_OF disabled.
---
 drivers/tty/serial/mvebu-uart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..fcb8f3d52df8 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -18,9 +18,7 @@
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
@@ -154,7 +152,7 @@ struct mvebu_uart {
 	struct uart_port *port;
 	struct clk *clk;
 	int irq[UART_IRQ_COUNT];
-	struct mvebu_uart_driver_data *data;
+	const struct mvebu_uart_driver_data *data;
 #if defined(CONFIG_PM)
 	struct mvebu_uart_pm_regs pm_regs;
 #endif /* CONFIG_PM */
@@ -859,15 +857,12 @@ static const struct dev_pm_ops mvebu_uart_pm_ops = {
 };
 #endif /* CONFIG_PM */
 
-static const struct of_device_id mvebu_uart_of_match[];
 
 /* Counter to keep track of each UART port id when not using CONFIG_OF */
 static int uart_num_counter;
 
 static int mvebu_uart_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match = of_match_device(mvebu_uart_of_match,
-							   &pdev->dev);
 	struct uart_port *port;
 	struct mvebu_uart *mvuart;
 	struct resource *reg;
@@ -919,7 +914,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Get controller data depending on the compatible string */
-	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
+	mvuart->data = device_get_match_data(&pdev->dev);
 	mvuart->port = port;
 
 	port->private_data = mvuart;
@@ -1016,7 +1011,7 @@ static struct platform_driver mvebu_uart_platform_driver = {
 	.probe	= mvebu_uart_probe,
 	.driver	= {
 		.name  = "mvebu-uart",
-		.of_match_table = of_match_ptr(mvebu_uart_of_match),
+		.of_match_table = mvebu_uart_of_match,
 		.suppress_bind_attrs = true,
 #if defined(CONFIG_PM)
 		.pm	= &mvebu_uart_pm_ops,
-- 
2.56.0

