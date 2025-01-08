Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CE1FC0E6
	for <linux-serial@vger.kernel.org>; Wed,  8 Jan 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341860; cv=none; b=gfYrNsSxAaHpFMRwaN1SL2FlT/7AEyF3mSP5FNJ0PgZxSJ0wEcZe8uv+3aBVNJx+UfXyzq6hopOCh4ymiv33pP02fnhX3w/YcdyPMThmyzRWrg7K19KxGjrqLeqQ2nK4hMwEcpqlVeybS7oQA1xTWevI3jZT+pJE+QWUh3KbYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341860; c=relaxed/simple;
	bh=oIyraJtt6eJ8oH2IUTQP3/uGfilGWY1D+3vWNioqWzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUIkAE0AOb2DceHuDoYy/BvBPqahwrK/v1sXDKbmM7MtdE3QhFlAWczZ3m2Dx7xkCXUjOF2uvVf/a8VzlJ/I84VfL0ZPNzE9jWZ/2U0vFlglTF4Ss1XyEJ6yhYHZfKK9tCXZuvNxsXmL+nV40sdZLu3pKnpYDC2j8TUylCKdTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UJ1KP9wQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UJ1KP9wQ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67ac42819so2431377066b.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jan 2025 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1736341857; x=1736946657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN0yPpMIVUvy5dvr2cl4F1PFjMYUc3POzI2oD6FyxFM=;
        b=UJ1KP9wQWY3nYll2nnh5tJdfRAhrV3oY/55foufrg0NArm04Mp5hVwif3Louh8XmTE
         PiM9NN51c2Uu5WVwnKow5dnjZmq3sLOPsStUuSApjuuxjBTVn3sE4w3IWy9y+NoB3E2E
         m06b5e0xBlyD8aFi+H7Qu+xc/dJYbZaeEJvaheG3qQsb1B638s6X6Vscl44J46GaWQBp
         vvBBoJXMEXES+WI92U2pLXBKxSffxf1GwY1UrAPWtJnl+6I5QrDKJrUQHR/7yJeR8S9m
         WmPonyks83JLGW0iYo1CiGds3iqWEw8c07kriBEuyuicuQtTPH+WA9e4fbfo8n/Map1/
         PiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736341857; x=1736946657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN0yPpMIVUvy5dvr2cl4F1PFjMYUc3POzI2oD6FyxFM=;
        b=f3wRD4VN5YcfpCJkQcjmJMz/3GA6oXU1Q3W4fo/b0fR6W1kpE7tGscmC4R/6XQN3aB
         mZpFE5ZYr1r+GrUF8qAqltzcASA7wXx4A0hF1XuftUG/E3S70lHuTHC6Q6KyEj1rtKZu
         pwHA/D6kc2u8lpSWl7g9C5BwQ7LTttxJhwM3JOP5oWi+uMxryJW8Sw5a+S+V782whF/z
         pof3EnT2Vsiu4zR+YlJoowo4CSxWhcWuDcdgc5S43UyhrGl1QteM5R5bM3MfF+b75aI9
         DgyCOOhRrh1ZdBB/Man/GMoU/qGp4aT2/8SDyM8WrzlR5jDBrnA++CvWDLMAuSkIaxDr
         V1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXpu6cWLI/obLN72CaU1MbGxGIy9HFcvvfNeSsUJP4CwncEQbWYI9R8CufdNqWwXQnnZPE5hvaEpyKKvEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pLSLATeAcnBpcJlMEXVcG6FEzKZ5euWn22BZGbSmnZH9FBbF
	vamSVvILc0TR6JAqvFPBYcCoA/atvrXsPbjsLbTgBvS3ZjzGjXXfXvZMfkaK1eI=
X-Gm-Gg: ASbGncs5eSajq4T4OqkT1PY4ef7AxKrI2z+Sc9Cby1yE/Cm/SPmC66e+Fythr1FtVwW
	YwZhRu6UgBdzPc0bKwmJmTjPGeDm+hO3l2vn5w8iLSuTl5Es4lCyESTuu7Y5UEKjVRS+VFTMLZ9
	z0aMv+UfxXJwgzkmk6aZ4XRgJmc5hQgu/7FpyDmtvxVpcKocWPyOdzB3I/Or70nDzOVHpa6e7du
	npXDPv7uEzl/0NYR7h5nKsODT5tNj9MSkz6rCSQdLYiBnWGuT/Nnv8jcabh/Lc733hSLRTVLthW
	Gg==
X-Google-Smtp-Source: AGHT+IFJ8uCXGWMcgCcfG2AE5znWZEYmo36LP9wm7sevnVR4LMZzKP1YIGgXKdylu5CEr8OTPpTy2g==
X-Received: by 2002:a17:906:6a26:b0:aa6:a9fe:46dd with SMTP id a640c23a62f3a-ab2abc6de7bmr196044966b.38.1736341856895;
        Wed, 08 Jan 2025 05:10:56 -0800 (PST)
Received: from fedora.. (d-zg2-023.globalnet.hr. [213.149.37.23])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedaebsm26159761a12.57.2025.01.08.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:10:55 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	lars.povlsen@microchip.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	daniel.machon@microchip.com,
	Robert Marko <robert.marko@sartura.hr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v3 3/3] tty: serial: atmel: make it selectable for ARCH_LAN969X
Date: Wed,  8 Jan 2025 14:09:28 +0100
Message-ID: <20250108131045.40642-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108131045.40642-1-robert.marko@sartura.hr>
References: <20250108131045.40642-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel serial, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes in v2:
* Pickup Acked-by from Nicolas
* Add whitespace before COMPILE_TEST

 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 45f0f779fbf9..976dae3bb1bb 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.47.1

