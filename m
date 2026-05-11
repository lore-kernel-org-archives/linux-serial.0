Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF533FF8AC
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518823; cv=none; b=e5Oklh8CZ1daivZk/wsF56RAgUMxT+1okY+7E/DAHHBZtUnNZ1uoeQKi6a9fYlJrHG8/BE40o77OgzogHzf6fVst1EjH39pO385Denae+qNIUTAicdZHkqaCBUwhZ4mgo47EulYWiZeSXk+eEWluLMgfJZGy10QK1Lb6i/Ndexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518823; c=relaxed/simple;
	bh=t/P7Z49j7jC2N+nDAB92iUJa4lhWPeZSzCHL+GWIaYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBoD2nDGNm2ee2pHTPUCWme2OrnBKO58hEi2c36ehU6MTum2u0qmTaC4lCdibN1I2m1ipQw4kaBTwlwuhL00gcKctjvLZ0yTdyV3pTDDcM2VSYDQsybR7HPC2YELVuydOISv+ulP32hALxupQUR8rgNLCpsVJW2h1hwxH6MqAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSVsNYmu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSVsNYmu"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so2311973b3a.1
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518821; x=1779123621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x/mOaa1dJhywLuUhoro4xsZpsIwTtvbqXZ9jlO2CSA=;
        b=YSVsNYmuvC5zYGGRmWSywccN2sIPfZ+wOmK+82tBv1b0Q4vm/aITy1lW2/6wcaEdvq
         dZCHi8l+3oWTrtHpyv7qKdKaa2+1P7peDJAL3NVR1HdEeQWrm86AlUjoN06k3tRY1qm2
         l7VdHsUz+nbTchvKd7Tbb5jUpFZbk2cDg8UQBvfG+xPq0/E8ajU0965kWjMFxhFKhXTh
         L3WlAi4onKcOE4d5IVWxrsTc5qWbXtf5cJJSrWzuS880iljAc13mS3gzBeVzOYO1u5CJ
         acWvzSEBtgDLyx9SyKlKc4Rz14cd9B6+G7IDGqEGx8akSLUKOZQ8ZPrEtv2r2v0CqNys
         4/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518822; x=1779123622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x/mOaa1dJhywLuUhoro4xsZpsIwTtvbqXZ9jlO2CSA=;
        b=XV70FD/pyokjR94/YkCHvSJfueXUwfDOw1ah2sBVSn7MxWZ/Hn79t3i2McVFuhhlaD
         OEQAPZv90v+hujV1gbQg25Cu6h/aHqOo0wS6q59aBIX53Omu44SSjaXSJbvTAxkn8V77
         ojyUD1C0sLJ7rrSjBP1dXOKpvk8LgTIFhyIcSp4iyjM0s1aH5ZqBFUTrQnj2Fp7A9KpD
         jYFLZ6niXUZk9DxLCUjFI4OumDWFyj+pAEVAUczr/7lNyMzRy7szp5RkKHo/M3HOrKI1
         u+44tMgJ7t6hd/tyJwDe4vC/Gec4YaYmw8pDkP5m/hJHHdpqNFDfJL5sdnMkbhf9f0ih
         WKTA==
X-Forwarded-Encrypted: i=1; AFNElJ/FXrLm1qa+W05QykAlwNBz3BgGnPR9BvZtvG283LMRGqjH+vjBBtey2MknLVnkvm4OFnUKEWDGfwkKR8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxzUqbYD2XdYMMzSXF7bzSrpa4upwTTuvJb1otz94ZPx0lkFG
	lcETADUlqC/t48pYJJ4edeDRZ6B8g5wG1pItjPgMi74svLHSUCfpmTtn
X-Gm-Gg: Acq92OEcKBsRD8GKSXHvRStZzml7hYLkZ0W6JoFf96idzJx98QTxQmDQ6IAuNLzV9E4
	XnTaLeyu7MzqXGP+B5eUI+HYMMIz6IZ9aU0QBoQoIsgfGBmiuCRWetRZW9d08K4FpdqvE65WHza
	w1nPgIdxMpdIEhOqheb2FRCw/j1TBVQhoi9HSH0wYsXfq7+IyQYpSrGTNTc20cfr91oSpJjFUNx
	U5hmAtot4psJfV1GlY6iBmVOW0FZoM2uL9Xosq5dPCYdjWzd3V9OZY4TI797sr9dbLLFGeB2un4
	CvBt90klMtZ818beiAdlc7wcWA0cFp8suMdU3ENk9V8oW+sWrqTPC/xhQTiu8CiEgcOoJXiE37/
	F4J6NVuj4ThXH1CDklG+c1eTzEcbttirg24l55pMe07Soas7BBsYd9JAflg0f9rwTEytkSElW10
	D9KWOkaKLZK6TwFx4LOWr24gGtK2invg==
X-Received: by 2002:aa7:9316:0:b0:835:36f5:17c9 with SMTP id d2e1a72fcca58-83ee82d6185mr306041b3a.2.1778518821369;
        Mon, 11 May 2026 10:00:21 -0700 (PDT)
Received: from penguin.. ([2401:4900:cbde:8ff:92b4:bf0c:6a0f:7ccb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm26491381b3a.16.2026.05.11.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:00:20 -0700 (PDT)
From: Rakesh Alasyam <alasyamrakesh77@gmail.com>
To: gregkh@linuxfoundation.org
Cc: richard.genoud@gmail.com,
	jirislaby@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rakesh Alasyam <alasyamrakesh77@gmail.com>
Subject: [PATCH v2] tty: serial: atmel: Ignore chars when CREAD is cleared
Date: Mon, 11 May 2026 22:29:13 +0530
Message-ID: <20260511165913.36467-1-alasyamrakesh77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026051106-obliged-dismount-d85f@gregkh>
References: <2026051106-obliged-dismount-d85f@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignore received characters when CREAD is cleared by adding RXRDY
to ignore_status_mask.

This replaces an existing TODO in the driver.

Tested on hardware.

Signed-off-by: Rakesh Alasyam <alasyamrakesh77@gmail.com>

---

v2:
- Add blank line before comment
- Tested on hardware
---
 drivers/tty/serial/atmel_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5d8c1cfc1c60..5c756dc904b0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2184,7 +2184,8 @@ static void atmel_set_termios(struct uart_port *port,
 		if (termios->c_iflag & IGNPAR)
 			port->ignore_status_mask |= ATMEL_US_OVRE;
 	}
-	/* TODO: Ignore all characters if CREAD is set.*/
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |= ATMEL_US_RXRDY;
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.43.0

