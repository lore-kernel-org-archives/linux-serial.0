Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF3125C2
	for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902692; cv=none; b=MXS5WWiySIproCkVAaqb4fc+hjqqXaIatVYPOPuU7UTvLA7fsEiyI+Is5Ztpmf2lgUGInVtjIQz9UDhK5K8KWSlD3w+GZoz7t80Qgjp4G2wCN5HMoOKwQfy1qfF0K8IX2lZcxxZI1Z/10KEau9Q02Rmj4jw6pPbBbqWlFFcnP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902692; c=relaxed/simple;
	bh=/m6rCOBVM9runoz3Pj1rAUMrYscnZqle0dzyZA0rr6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yz2++hmHDS3/B4A6ba8AQW2Ked/BLSGeg/1v0WKozHMoBIUSfVUNjJXqL7DfkytpPAZuDU6EKu34SLM1Bt+cMh7CVmTSeYnIA3NMqshBg/3mazgrlWnDm1yXyeLapdg8BC0agbxCP36K5QdoAbYb7IXcaHEKxHPC5p4YaT5xY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Rh6Ct7nc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Rh6Ct7nc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411e71d8a2bso2940245e9.1
        for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 01:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707902689; x=1708507489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/VawfV3/1Tia6h+B0jEdvM/GHLbKTQGOHVDuUn/OA0=;
        b=Rh6Ct7ncm7/Be0NMnTpj3kdIgh0Cmni6Npau+yreSgJANWc13Vrbf59qIGhf1FPKX7
         NFYqTH8PdHWNhKNWMd4WveEv2DaDBN8Tuv1zTCGdv/MKdWjzgJ4OLya8Dfz3XEHJ58NQ
         BGOpvL2pSdxM9ElkGTVs5Kd6iO7Gz00HohcFsDcHx+Gozb7HZJ7fZwmrcBOkCCU+s3Iv
         3BVSm+0b2xx6diLIoXbVsvPDxUUeNXf3buMrgj5PM+qEAQleJxHiCpRISayHb8YckSB4
         wzYBgFRzD4LF4dFoskTQsoEfI9KWZ+rhuH3u+lHt8Q5TwJc/6jhK8/aPcrGZvjOv6IU+
         7pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902689; x=1708507489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/VawfV3/1Tia6h+B0jEdvM/GHLbKTQGOHVDuUn/OA0=;
        b=i+6LE4vvDu3DILPRIhseV27qkPmmY/1Gld/723HsbAQPFxMTDlQU+MotT1CeEUXqCt
         U8V/8LoxDP0wlOFPT4QsGtO7ykoyJnwTfPYcMPiiQszsj3z27ko7Qx+hI1uGT1JQVA2V
         4r45gWoh4oEyR/Owtc7gr1hpMw3CCI/ijw+XFdsGKvSM++lxNS4+++oQMYi10HHQfJ+l
         dgwGW1PqjbVPGFtS/n9jPNk/3ORj61TPa8tqc7a2Eivl26IJiiCan2fF5cwk6sCf+Yah
         ACiTBMyzphUtD+IsEW8KY0fvsmVxrZd46O1jp6oGgLTkUrG8vXFC91go/OoPr++x/KMk
         mbqA==
X-Forwarded-Encrypted: i=1; AJvYcCUARQazNNlpusELu6MM61c6fiQOCLhykuEESdanL0CQ2WJ/46y5wOxuJnIeg+5BOiYqv2aVZ47z+YHottixioBue/YaYb7upuC1TgBC
X-Gm-Message-State: AOJu0YxjxsZhC1xGLmM/oKdCiakZUZFqviyO902o1wmnAoe86pReKyZy
	0OE5e7GRjAPzJ4Sia2+wdf5o4Q9nP9tju//JUDYHUOucr30JPw6iuY7F2bSzKOKYkSIE6VqwQmL
	k
X-Google-Smtp-Source: AGHT+IFjXbUGJ2PmUGzhBywp0qIdFrYDA7rkVO6JCMpvNf/RMg+ClAFtBFZChYJ6wm5lSW/xh4ybDg==
X-Received: by 2002:adf:ee8c:0:b0:33b:4838:a23 with SMTP id b12-20020adfee8c000000b0033b48380a23mr1240259wro.29.1707902688721;
        Wed, 14 Feb 2024 01:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLmtx2mrXUFZclfNkMiRaHwJMG3IjpvutXBS5vR6JlDfkSfBo9bD6f+2pWgnTMwvP4v2svAnnZOzAQ52da0GbSyhB+C0lOqG5l0wVU1ZoBTUdhko4EDoAQr7DgseP8FOXRJ1BxwAh0F/SV1Ux1mh4X9/LYJ63/LFE6v4t1JpqQFXGN5X1IoR6ntXBpf7M6xlFlF6FCkG9qE3hnCHj3rkgsA9+tghykXIqEjW0wsppsTYRmp1+Q7FJai0K5Z4ynJPC7U2/mVZUCTwtAr6WC6DkDbTc=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:cfee:a5b6:1f9b:9c9b])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm12100905wrb.20.2024.02.14.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:24:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] serial: st-asc: don't get/put GPIOs in atomic context
Date: Wed, 14 Feb 2024 10:24:38 +0100
Message-Id: <20240214092438.10785-1-brgl@bgdev.pl>
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
---
 drivers/tty/serial/st-asc.c | 40 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index bbb5595d7e24..52a20277df98 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -467,6 +467,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct asc_port *ascport = to_asc_port(port);
 	struct gpio_desc *gpiod;
 	unsigned int baud;
+	bool manual_rts;
 	u32 ctrl_val;
 	tcflag_t cflag;
 	unsigned long flags;
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

