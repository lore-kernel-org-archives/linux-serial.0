Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C8225DD
	for <linux-serial@vger.kernel.org>; Mon, 19 Feb 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329140; cv=none; b=PV/jZA0cfudNS2GNrejLIdFg13KW+F6HdnSIQYNv6TLV6YfgTGZU3dgE+v2+nTPEk6r2//trYmVuI3/7iBSploSg9CoIjKLt+zdTaPduL5eQWLylzI9AS1DS2GiD0nmeVWZDBAOwNhutQw7E0hYrkrcBateSAUKZxfjQW/TwXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329140; c=relaxed/simple;
	bh=wh4OmwcFRlWi/ItnT5ktk0oGxcFdh4oAYQhOp0nR3jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q2nd76ftQ+j1pl4B/JiNHRJ+MP90C9lj7Rl7+Pl3PKAz9d1zsplj2B6iGmAPrQoGJVuUS3Nh0QXsaDyn6oq8sscMrlE8HG+GxsJwSylVBuAPAsphMRyEuoZ+/WRgjpAJpUOe9xAIt0HhZEsZSVQQGd24buKS6Fy4/mTVVJeQHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zd0EvbRJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zd0EvbRJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41261233e61so4762615e9.0
        for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 23:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708329137; x=1708933937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/U/HLhILocJNKhz9qnNNoXbd+eRoVQ2PKzr45zesuc=;
        b=zd0EvbRJLfMdVnfiRKP4d75hXjV8wOf8Va1uUQi+hmBsJgAQBdfgphgJeEPKpA7qGW
         TdTRNwRysYM9PGz4OHhM9w1nhDJvYq0peaVthFjck7OEdy3v7jf1mHZhCoKukx9uTmoj
         JZJh07LhVle2YSfbvgF4r4FnUkqgt2o3BHnx8c0UK10VNkxu7xdeX9aJ/HInMdLelzjn
         v56/kFZjTQKPyXMRNmnHm6BuCATJUuggSXlGK6RBQ2BJfLGhD4dM5zfXjHucYXHf9y1n
         My93Lhs90EbWkjqXP0vb1mAJWIeb/HvYbQQUeVWVErtM3MU748LbQe5Mr5tFWLVfqLuC
         cumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329137; x=1708933937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/U/HLhILocJNKhz9qnNNoXbd+eRoVQ2PKzr45zesuc=;
        b=ngenG/9t3Tyl/essOFOTgvxSOkCmVqwMhpLbgXxn4R0D4l/ibp+hnrHZHfuHAULwe5
         OZpCp/x7DU0c1l9JBZ3uXe+W9Wk3PezpvdhBe23xOx1JU6UFRo3ave29mjAbUZ7qStks
         oJLiow/aoXWlJlUf///od4L72dumHt2g7K38IUrxc8SOUg3bFJmQk2BB4Sa96ZEyRbAh
         9q/vYOLx+VKDrRQFXNY6l4tkZqxjScbU204IZG5FmjsLcVV1e6UbhKdEkUh5WH8OksGH
         K2IcZkyCJv3vO2uob5G8OHr0hbBFE8Bt5Al6jbqszW3aDsG+E51rxOIMNN+Pu32mUWAQ
         VB3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfwW1VCusrJH6wvS7cy9pdi5kmX/eLyv4gqkJjwfXFDQlCd/nKK5ZLr2PFKxfxi2A6i+aYDz1zDnhs2jbTwtAfsd7wCZ4Diq9Hdaj6
X-Gm-Message-State: AOJu0Yy5f1y0CeTbBsiRamT2QRlsHWYkVqfWQzl1UyV9vqYiYqvZfcN1
	Qr9/zKzH8DayG/G/FVxQn/Emvx6lV8Co7BOxApTo7uRsuLN175GmzK5G8TVh5+0=
X-Google-Smtp-Source: AGHT+IHzFayj07qqwZEtFxSEIAhDseu8F5QgjmRm16RmLOnuksNhRFCUVwH+pJ4w7RfJk0af/ufDGw==
X-Received: by 2002:a05:600c:5486:b0:412:10c2:c73b with SMTP id iv6-20020a05600c548600b0041210c2c73bmr9996038wmb.1.1708329136597;
        Sun, 18 Feb 2024 23:52:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:88b:d6c3:a2f2:16d9])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c221400b0040fddaf9ff4sm10449287wml.40.2024.02.18.23.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:52:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] serial: st-asc: don't get/put GPIOs in atomic context
Date: Mon, 19 Feb 2024 08:52:11 +0100
Message-Id: <20240219075211.6949-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with
SRCU") gpiod_set_consumer_name() calls synchronize_srcu() which led to
a "sleeping in atomic context" smatch warning.

This function (along with gpiod_get/put() and all other GPIO APIs apart
from gpiod_get/set_value() and gpiod_direction_input/output()) should
have never been called with a spinlock taken. We're only fixing this now
as GPIOLIB has been rebuilt to use SRCU for access serialization which
uncovered this problem.

Move the calls to gpiod_get/put() outside the spinlock critical section.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/deee1438-efc1-47c4-8d80-0ab2cf01d60a@moroto.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v1 -> v2:
- initialize the 'manual_rts' variable to false as we don't always get to
  the place where it's set

 drivers/tty/serial/st-asc.c | 40 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index bbb5595d7e24..f184de6af313 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -466,6 +466,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct asc_port *ascport = to_asc_port(port);
 	struct gpio_desc *gpiod;
+	bool manual_rts = false;
 	unsigned int baud;
 	u32 ctrl_val;
 	tcflag_t cflag;
@@ -517,26 +518,12 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 		ctrl_val |= ASC_CTL_CTSENABLE;
 
 		/* If flow-control selected, stop handling RTS manually */
-		if (ascport->rts) {
-			devm_gpiod_put(port->dev, ascport->rts);
-			ascport->rts = NULL;
-
-			pinctrl_select_state(ascport->pinctrl,
-					     ascport->states[DEFAULT]);
-		}
+		if (ascport->rts)
+			manual_rts = false;
 	} else {
 		/* If flow-control disabled, it's safe to handle RTS manually */
-		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL]) {
-			pinctrl_select_state(ascport->pinctrl,
-					     ascport->states[NO_HW_FLOWCTRL]);
-
-			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
-			if (!IS_ERR(gpiod)) {
-				gpiod_set_consumer_name(gpiod,
-						port->dev->of_node->name);
-				ascport->rts = gpiod;
-			}
-		}
+		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
+			manual_rts = true;
 	}
 
 	if ((baud < 19200) && !ascport->force_m1) {
@@ -595,6 +582,23 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	if (manual_rts) {
+		pinctrl_select_state(ascport->pinctrl,
+				     ascport->states[NO_HW_FLOWCTRL]);
+
+		gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
+		if (!IS_ERR(gpiod)) {
+			gpiod_set_consumer_name(gpiod,
+						port->dev->of_node->name);
+			ascport->rts = gpiod;
+		} else {
+			devm_gpiod_put(port->dev, ascport->rts);
+			ascport->rts = NULL;
+			pinctrl_select_state(ascport->pinctrl,
+					     ascport->states[DEFAULT]);
+		}
+	}
 }
 
 static const char *asc_type(struct uart_port *port)
-- 
2.40.1

