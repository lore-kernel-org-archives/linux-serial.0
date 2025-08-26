Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8371F4CB7;
	Tue, 26 Aug 2025 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196154; cv=none; b=h5nibAd8ardgQCh63K0H2Vzh+na4I0o2WIGQ+qzh6x8GhKnCLw29D1yyRNFzHq61VcHCRfC52ef6XgHQG49dRSypMt2CkmLaaqQOZ7Q/09VVUVmHChY9LDz9sRumbbmhcdzQZz9zV3g/ImrjLmjrUgQwGK89q3bnkQj0UyPkudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196154; c=relaxed/simple;
	bh=jF2eRaWTLzQVNN/wWhkU/56cdh7FxGeTbDXGW0K6zbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrI+0JpYotpbEUuootvaD7vzMNddpzjuZWoCdLnHp+VkrpRDqycis5IYUY2G1bURnQ8SUKitzaeAhjLMAb+QqU4DNRZkOlnoELhAHgnO+pzlMulHzcv9A6q7jXpDv2CK/WJqCouWDSsk6jFHgV6O4g6mQnKz4hThawm4pmn3gIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYKGcC4k; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYKGcC4k"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so5075004b3a.2;
        Tue, 26 Aug 2025 01:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756196152; x=1756800952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hyveAheAWtDLQRrsw8HdtwofT0F79u3HfS2Z0l05Gr0=;
        b=hYKGcC4khqGvGKbHwI8l96olUdC9cU0MqK7k90QqwitR2kt/xEXJ9v0vZzwTjrRe/e
         6mF6mVrOr7rc6veK+WsfxT6peiIt4DYutDMevZqzPEjFqb5EIeEOCqfy3zWl4w+yuZkM
         V1pRhXVtATtq5bBLV/nSpud4M0QHNtefj5V5fJld83Wq+dOCMmFk36aaMimYVMvBUvhy
         473Wzi+ULVzxPHjbZIZAnBwpBvKA4lmNxJfYzbWG1fUSegb1hdYfWfmAOP9PPWssCHFI
         J3QunLEAYbXU6o5PrNvB8FEysRwFl3X58CEYsj/Ghn8WzSNsVUrzj7ok8WKAMd4ns2W1
         RCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196152; x=1756800952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyveAheAWtDLQRrsw8HdtwofT0F79u3HfS2Z0l05Gr0=;
        b=agIVoMNjyb7MNlOZ/SOk7Ruawp509dTN3WTrY+YV/r1qcAG5HFiSN9c4NYuF5Is3B3
         g5MLCoSL1g2OTaEVRDd1h4zQ53q39CO/NCAdg6H6BSocv9jJdOznA7sTLvhPbcNZ5c9f
         1K3E5e4WZWhVjx7QDdaXaxDwkEW2sjxv28p3MkzLGmP97eTWNtcsVqTgHWZyvoN3VoKS
         CoXO4Iqcvx4NYErnZuz/4T4qewLVRyZb7n8o91Akl/HotjCdKpMLO9zzIr+QuguiWMWM
         Ea60zeslx/ZrKIU3g49VOWNidzklk+WCq+ig0enZg9sqrkEOfHa4uhaC51S/F8xmJq0D
         mhzg==
X-Forwarded-Encrypted: i=1; AJvYcCVJRlZDIOAssY/DnMv+j6bLdEtcgcZswhA7alm2RjhXa88DJQUikArs7SwA+7x+uInJZo0283yLGpqpSyoi@vger.kernel.org, AJvYcCVpDvsSuqKALggpbgcegO+jcFNZyobSaEsm0zTEkuUKtoIIyHym7WZTWEActhgUEAU28eInHwyl6U4xpi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OJbT+MawCOwlljIAjhcFPIbQ4w6C0ye7Zibq2FbVxB7Jfl+P
	B0rOHiTi2anNk/mxadujwvivkLYiriIlxgJUUCp8e+sQNwEtaP/boeYr
X-Gm-Gg: ASbGncus8NPoKLKQz2G16yqjHSCjjjwqu6ykriTOfdRBt1a3/TCeMkxmIOD7EmSkmvn
	dRB9IGg8cymnai/3vwzT1aGWNCRjGYWHmLzjfXTQqSefiwnpFuYyI4az2QpAVNlZD0plUJy9i2n
	hUNxDyhpmuVcNFkKWhwB6wFjWyrII4+K4zw/Ry3TzYiPeYmo1HE4IFc07thSYcZWssmj/75FvF7
	s+7kE2206GYwje8+9HYM8f8PxW+DgqJg7k7f2r5H2Y0mdKkROKtagvl6d+AwAQHElpGg81Eh809
	R453HcX40AZUkT2AIvCFeK6XbRMqoCMmV+RKLyQPnbScqrL7+1woqlmwobMtUi3ZmKasgJGJtt5
	tDBK2E+TUsU6LLKW2+mbBUw/rJw8gXKEj
X-Google-Smtp-Source: AGHT+IFIiLYvXzCV8qOlHzCvk9o2qk8e5IQODytBqijU6NmKdukcWk92g1zuLfH6UrRFzluufdVV1Q==
X-Received: by 2002:a05:6a00:4fc4:b0:771:b230:f0ac with SMTP id d2e1a72fcca58-771b230f427mr8262713b3a.28.1756196152295;
        Tue, 26 Aug 2025 01:15:52 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771fd80300csm399567b3a.106.2025.08.26.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:15:51 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] serial: liteuart: polling all interrupts in the IRQ process
Date: Tue, 26 Aug 2025 16:14:44 +0800
Message-ID: <20250826081445.505947-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using liteuart with aplic and imsic, the new interrupt will lost
if the interrupt handler can not handle all the data. This is simply
because the interrupt line will never be low, and the aplic will not
send the interrupt to imsic again.

Handle all data in the IRQ handler until no data incoming.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/tty/serial/liteuart.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 6429e8f11f36..436e8f06fb75 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -140,11 +140,17 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
 	 * irq[save|restore] spin_lock variants to cover all possibilities
 	 */
 	uart_port_lock_irqsave(port, &flags);
-	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
-	if (isr & EV_RX)
-		liteuart_rx_chars(port);
-	if (isr & EV_TX)
-		liteuart_tx_chars(port);
+
+	isr = litex_read8(port->membase + OFF_EV_PENDING);
+
+	while (isr & uart->irq_reg) {
+		if (isr & EV_RX)
+			liteuart_rx_chars(port);
+		if (isr & EV_TX)
+			liteuart_tx_chars(port);
+		isr = litex_read8(port->membase + OFF_EV_PENDING);
+	}
+
 	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_RETVAL(isr);
-- 
2.51.0

