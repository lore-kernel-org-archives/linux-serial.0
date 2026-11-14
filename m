Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697724;
	b=v3g5kcb4kDW0bppFj5C7AnqF6zRO/3EWiThsGUmUTuvU/8HwVVbgybXw6654wskKlpBa
	 VEQMCIDOj+gt4daxQHJICAdAzTzuqn/sLVeiCxqhoLthYKIiQ4dqZIdRKPn4TnZIBwRrC
	 3KrZf4VxrO/zMxpz1eP5U5db3RlmJ0b8PQgCgQ1l6zl7cBlsHgUgVRfXdQM7sqYJxReZ4
	 8tzIAKAJmp8D7o9mjZBIZdawO530yKGS9A+op/AtFFp4glHXvTyX7wGvnOhKddZ59nI3E
	 iXlPMkxrgJL8u2LKVykS/E+/HaDoaL2cjd+8pPXEgB7F6aEw/FBFenEkIyh7MYde1xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JLvJHlJfeScNlcpPSvtEUe1uRcaagWsVvGbZJ4zel+M=;
	b=g/tyxIyXEjXdn8nYgK8H+uY/CzYRVzlJutSrO1QxUi8kjwS45BpsTTdE/Th70dTLpRZR
	 UYpz72ZH3lVVnW5J1NA7Fnjo8vuFIsDzerOuLQEvwmE2Jn7FAk8CqB1o4Ih5fy58qGKNF
	 HIqFd58OmHuAL+O7eAvcfEuErVFWlcSdCzrFepXYhUBzp0BaLwb9jric8dwfghwHPE2D+
	 jJNb+rng8L2HZ75VhWZ9s4q66bcrKbzqQfl2yJ/UgWFW+uCm4MU6KWleOffgRlAG6JO3n
	 JwkeCEgKAFt5wbmW+/HvkHni6CU1bQ0/ZagJCCLHBz5iebqEuQLL7vyh9cR8GCa5YDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYTO+cjn;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879260A3829
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6879260A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYTO+cjn
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e10a70540so1130648f8f.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697723; x=1795302523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLvJHlJfeScNlcpPSvtEUe1uRcaagWsVvGbZJ4zel+M=;
        b=nYTO+cjn6IYSwqypc2xC8sK0+w6AFP35t9ZaRRMbtZvGkHzpf73l8bxL3pdJMhLhpG
         FleA9hTBT/eSWzr6jIvSvWwn0NmsfdiOFQGmSYiGCz3WGnn+mbvaLp7Q4jfgIW8DxwTN
         eWG7lD5GK8DC0AxyN9zOJ8YlVOh+yDpgv5YzN0ZTdMvdP5rEWTHDJm0yinoSJb2FCIaa
         y5fxoZ/R8gDMJUDy5hSoBXwfO7Q5HGwGs8Sik0MbOGNi7EJLvh0IWWBz4C85e2jhnziJ
         mnDtkk6AKvg1GMeruqnjsN3l6vTkvCOwEUmCGanAAdyDKrf9cErGTM5x2WEjLmPrPLSr
         8ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697723; x=1795302523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLvJHlJfeScNlcpPSvtEUe1uRcaagWsVvGbZJ4zel+M=;
        b=ZCGK0y+gI/JuMn7WOFOjrYIUYrmgcxi4Yt5LRzw9aP8i/wm0j0IjJJi8sYyli4fvoW
         FQvolw7bNLvsVslQN+K3IW/wuo70M55LtvYOrNeKwgT1r1AieDEtGAwXlICrdImNa6bT
         iXbkgruWI+Q3il+55XphaOFX1KyXBE+jahPNfWGXXj/njDE75ElKTqeebLFjwSRnRHee
         Bu5WOo9raOlsQLCr0TNhhdoEKjbcFGxt4cY33dSmlI6HLXeoQJ+0KaWZmvFtWqaz9n5b
         PZNiCBmKtucml3JpLODTUNnUyzC4UskF/I1znDV1Qz8TAoVZj5xe8j1Kq4m+iShe3igK
         QmgA==
X-Forwarded-Encrypted: i=1; AL+hErEUoUOSWGjK0JvT14rh4ZHw3RrkppsVMlTWLdzf26UGVwvzyYBesM5O1LawP7Zvr5aAQaX+IAXUXZ6pHY0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/XGBYsz314Zs7U649mm9jF7f6SbVESKpukwtLe8N3s9+mMrOk
	8xYWLYTiLzjYxsPIrmrDqotGbE6PsJJkBz4VEqXwvXCuq1lnPms4j9e+
X-Gm-Gg: AYBFou1KqGKy5aJpkBix9UPAsMH2itf3sK8HxnnpJSF+FA+ThZUUntS7cRoHRTmpbDN
	We/4A4xyAP/+SeUcAiSmyeIgeqn5zS1b6NdJUcgUwL9izb7FG5aVJ9DzH4iv6s6RImlYf6UFg1A
	vlz1aIshBWxAf6xd4/r8GMTcftxvWTPc0rJ7/Eq/cyzLyT6INGSMGZKMYooHpjgm1asNIWkm5cZ
	5Ypi+ueCcVzwCxoo8pVchyUubkOQFcKoEDx56fHRFThrV/5/JufHdi3rii3nUSdxJEAKfnAsaop
	XWyz5xMITUyPA/ZpF+asYlWOAdo6UuW9YH22wl5lkfMGq2mwj4EaFt44BgE8l3qG/R3tdDa7rgX
	9VmHiuVbdt+pgqTO0gQS4prOUf1eN0XasVrEpYHbUmvAlcXrlZWLxZgbUdPsD41Y4IzIfyQyngM
	SGJ9j+uBrNAlJwchQvDNKfY/AOGFLWIZ65Mu9ltcS/DMJQyRJdadQaN4/cjHDOodTPNqi9BAixB
	aAsTP2svMTFI7l3i4GNTvRDpgdDH07XmYtT+WzRMGPeuG+4kfevg2lguiVa81+oao1L5sshWFg7
	4ezRCvxnpKu9tHZjBleUxSzMrJmG
X-Received: by 2002:a05:6000:178e:b0:490:ae2:b841 with SMTP id ffacd0b85a97d-49c73a05d9amr13948843f8f.30.1794697722659;
        Sat, 14 Nov 2026 15:08:42 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:42 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Sun, 15 Nov 2026 01:07:52 +0200
Message-ID: <20261114230800.1344401-9-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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

Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
can drive DTR/RTS when the modem pins are in GPIO mode. This enables
programming an ESP32 over the FT260 with esptool, which resets the chip
via those lines.

Set up the gpiochip and the sysfs attributes on the UART interface when
the chip mode has UART, and on the I2C interface only in the I2C-only
mode. Before, the choice depended on USB interface number 0, which is
the I2C interface in mode 3, but TIOCMGET and TIOCMSET run on the UART
interface and need the GPIO state there. Add DCD and RI (GPIO4 and
GPIO5) to the GPIO set of UART modes 3 and 4, so the mask that TIOCMGET
and TIOCMSET check covers the two lines that TIOCMGET reports.

The RTS, CTS, DTR and DSR pins are active-low, so TIOCMGET inverts the
sense of those four lines and TIOCMSET drives 0 to assert them. DCD and
RI are not inverted. Rio Liu found and fixed the polarity.

Keep the errno from ft260_get_interface_type(), so that a failed
status read does not let probe succeed after the teardown.

TIOCMGET and TIOCMSET work only while the modem pins are GPIOs, and
return -EINVAL otherwise. They check gpio_en under port->lock, so that
a termios or sysfs change cannot switch the pins to flow control
between the check and the GPIO report. TIOCMGET returns the error of
the GPIO read. TIOCMSET builds its report from the cached GPIO state,
which it copies under the same lock.

The tty hangup does not wait for a TIOCMGET or TIOCMSET that already
runs, because the tty core handles them without a line discipline
reference. ft260_remove() sets a flag under port->lock after the
hangup, so it waits for such a call, and a later one returns -ENODEV
instead of using hdev after hid_hw_stop().

Co-developed-by: Rio Liu <rio@r26.me>
Signed-off-by: Rio Liu <rio@r26.me>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Polarity fix folded in (Rio Liu).

Fixes for the issues reported by Sashiko:
- The errno of ft260_get_interface_type() is kept, so probe does not
  succeed after the teardown.
- TIOCMGET and TIOCMSET return -EINVAL when the modem pins are not
  GPIOs, and TIOCMGET returns the error of the GPIO read.
- TIOCMSET copies the cached GPIO state under port->lock.

v3:
Fixes for the issues reported by Sashiko:
- gpio_en checked under port->lock in tiocmget() and tiocmset(), so a
  termios or sysfs change cannot switch the pins between the check and
  the GPIO report.
- tiocmget() and tiocmset() return -ENODEV after ft260_remove(), so
  they do not use hdev after hid_hw_stop().
- tiocmget() cannot run before dev->gc is set, because
  ft260_uart_probe() registers the TTY last since patch 2.
---
 drivers/hid/hid-ft260.c | 168 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 75ba68e2e8fc..d795355fc26b 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -16,6 +16,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
+#include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
@@ -183,7 +184,7 @@ enum {
 	FT260_GPIO_DIR_OUTPUT		= 0x01,
 };
 
-/* GPIO offsets */
+/* GPIO bit masks */
 #define FT260_GPIO_0		BIT(0)
 #define FT260_GPIO_1		BIT(1)
 #define FT260_GPIO_2		BIT(2)
@@ -213,7 +214,8 @@ enum {
 #define FT260_GPIO_UART_MODE_1_SET	FT260_GPIO_UART_DTR_DSR
 #define FT260_GPIO_UART_MODE_2_SET	FT260_GPIO_UART_RTS_CTS
 #define FT260_GPIO_UART_MODE_3_SET	(FT260_GPIO_UART_RTS_CTS | \
-					 FT260_GPIO_UART_DTR_DSR)
+					 FT260_GPIO_UART_DTR_DSR | \
+					 FT260_GPIO_UART_DCD_RI)
 #define FT260_GPIO_UART_MODE_4_SET	FT260_GPIO_UART_MODE_3_SET
 #define FT260_GPIO_UART_DEFAULT		FT260_GPIO_UART_MODE_0_SET
 #define FT260_GPIO_UART_MODE_1_CLR	(FT260_GPIO_UART_RX_TX | \
@@ -223,6 +225,16 @@ enum {
 #define FT260_GPIO_UART_MODE_3_CLR	FT260_GPIO_UART_RX_TX
 #define FT260_GPIO_UART_MODES		5
 
+/* UART modem control GPIO offsets */
+enum {
+	FT260_GPIO_UART_DCD		= (4),
+	FT260_GPIO_UART_RI		= (5),
+	FT260_GPIO_UART_RTS		= (7),
+	FT260_GPIO_UART_CTS		= (10),
+	FT260_GPIO_UART_DTR		= (11),
+	FT260_GPIO_UART_DSR		= (13),
+};
+
 #define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
@@ -449,6 +461,7 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+	int chip_mode;
 	int iface_type;
 	int iface_id;
 	struct list_head device_list;
@@ -480,6 +493,8 @@ struct ft260_device {
 	struct ft260_gpio_state gpio;
 	u16 gpio_uart_mode[FT260_GPIO_UART_MODES];
 	bool uart_dcd_ri;
+	/* Set under lock by ft260_remove(); tiocm calls then stop */
+	bool removed;
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
@@ -1111,8 +1126,27 @@ static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
 	else
 		ft260_gpio_en_clr(dev, bitmap);
 exit:
-	ft260_dbg("%s: enabled GPIOs: %04x\n", dev_name(&hdev->dev),
-		  dev->gpio_en);
+	ft260_dbg("%s: enabled GPIOs: %04x, bitmap %04x\n",
+		  dev_name(&hdev->dev), dev->gpio_en, bitmap);
+}
+
+static void ft260_gpio_output_cfg(struct ft260_gpio_state *gpio,
+				  u32 offset, int value)
+{
+	if (offset < FT260_GPIO_0_5_COUNT) {
+		gpio->dirs |= BIT(offset);
+		if (value)
+			gpio->vals |= !!value << offset;
+		else
+			gpio->vals &= ~BIT(offset);
+	} else {
+		offset = offset - FT260_GPIO_0_5_COUNT;
+		gpio->ex_dirs |= BIT(offset);
+		if (value)
+			gpio->ex_vals |= !!value << offset;
+		else
+			gpio->ex_vals &= ~BIT(offset);
+	}
 }
 
 static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
@@ -1161,7 +1195,7 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 			rep.gpio.ex_vals &= ~BIT(offset);
 	}
 
-	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
 		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
 
@@ -1419,6 +1453,7 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
 
 	dev->power_saving_en = cfg->power_saving_en;
+	dev->chip_mode = cfg->chip_mode;
 
 	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
@@ -1439,7 +1474,6 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 		return -ENODEV;
 	}
 
-	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1947,6 +1981,91 @@ static void ft260_uart_set_termios(struct tty_struct *tty,
 	ft260_uart_change_speed(port, &tty->termios, NULL);
 }
 
+static int ft260_uart_tiocmget(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+	int gpios;
+
+	/*
+	 * The modem lines control via ioctl is allowed only
+	 * when the related pins are in the gpio mode.
+	 */
+	int mask = FT260_GPIO_UART_MODE_4_SET;
+
+	mutex_lock(&port->lock);
+	if (port->removed) {
+		mutex_unlock(&port->lock);
+		return -ENODEV;
+	}
+	if ((port->gpio_en & mask) != mask) {
+		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
+			  port->gpio_en, mask);
+		mutex_unlock(&port->lock);
+		return -EINVAL;
+	}
+
+	gpios = ft260_gpio_get_all(&port->gc, FT260_GPIO_VALUE);
+	mutex_unlock(&port->lock);
+	if (gpios < 0)
+		return gpios;
+
+	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
+		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
+		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
+		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
+}
+
+static int ft260_uart_tiocmset(struct tty_struct *tty,
+			       unsigned int set, unsigned int clear)
+{
+	int ret;
+	struct ft260_device *port = tty->driver_data;
+	struct ft260_gpio_write_request_report rep;
+	struct hid_device *hdev = port->hdev;
+	int mask = FT260_GPIO_UART_MODE_4_SET;
+
+	mutex_lock(&port->lock);
+	if (port->removed) {
+		mutex_unlock(&port->lock);
+		return -ENODEV;
+	}
+	if ((port->gpio_en & mask) != mask) {
+		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
+			  port->gpio_en, mask);
+		mutex_unlock(&port->lock);
+		return -EINVAL;
+	}
+	rep.report = FT260_GPIO;
+	rep.gpio = port->gpio;
+
+	if (set & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
+	if (set & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
+	if (clear & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
+	if (clear & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
+
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
+		  rep.gpio.dirs, rep.gpio.vals,
+		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
+		mutex_unlock(&port->lock);
+		return -EIO;
+	}
+
+	port->gpio = rep.gpio;
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
 static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
@@ -2027,6 +2146,8 @@ static const struct tty_operations ft260_uart_ops = {
 	.write_room		= ft260_uart_write_room,
 	.chars_in_buffer	= ft260_uart_chars_in_buffer,
 	.set_termios		= ft260_uart_set_termios,
+	.tiocmget		= ft260_uart_tiocmget,
+	.tiocmset		= ft260_uart_tiocmset,
 	.hangup			= ft260_uart_hangup,
 	.install		= ft260_uart_install,
 	.cleanup		= ft260_uart_cleanup,
@@ -2171,14 +2292,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 		return ret;
 	}
 
-	ret = ft260_gpio_init(dev, cfg);
-	if (ret)
-		goto err_i2c_free;
+	if (cfg->chip_mode == FT260_MODE_I2C) {
+		ret = ft260_gpio_init(dev, cfg);
+		if (ret)
+			goto err_i2c_free;
 
-	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
-	if (ret < 0) {
-		hid_err(hdev, "failed to create sysfs attrs\n");
-		goto err_gpio_remove;
+		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_gpio_remove;
+		}
 	}
 
 	return 0;
@@ -2231,7 +2354,8 @@ static int ft260_uart_probe(struct ft260_device *dev,
 
 	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
 
-	if (dev->iface_id == 0) {
+	if (dev->chip_mode & FT260_MODE_UART ||
+	    dev->chip_mode == FT260_MODE_ALL) {
 		ret = ft260_gpio_init(dev, cfg);
 		if (ret)
 			goto err_hid_report;
@@ -2326,8 +2450,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = ft260_get_interface_type(dev, &cfg);
 	if (ret <= FT260_IFACE_NONE)
 		goto err_hid_close;
+	dev->iface_type = ret;
 
-	if (ret == FT260_IFACE_I2C) {
+	if (dev->iface_type == FT260_IFACE_I2C) {
 		ret = ft260_i2c_probe(dev, &cfg);
 		if (ret)
 			goto err_hid_close;
@@ -2366,10 +2491,19 @@ static void ft260_remove(struct hid_device *hdev)
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
-		if (dev->iface_id == 0)
+		/*
+		 * The hangup does not wait for a TIOCMGET or TIOCMSET
+		 * that is running; they hold the lock while they use hdev.
+		 */
+		mutex_lock(&dev->lock);
+		dev->removed = true;
+		mutex_unlock(&dev->lock);
+		if (dev->chip_mode & FT260_MODE_UART ||
+		    dev->chip_mode == FT260_MODE_ALL)
 			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 	} else {
-		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (dev->chip_mode == FT260_MODE_I2C)
+			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
 	}
 
-- 
2.43.0

