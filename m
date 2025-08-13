Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7A29B221
	for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107274; cv=none; b=eJu/O5uCsAn1ojkwqPx5QdoELtEwzB7kOXzyAkqkUmT/3Nc+HaNthfOKD0RWHzlWHpW2YTJrut2M/kwSXkuuoHCLDiBMeAOAnRd/V4kBq7Mi3WJl7/eI/HiPEnbr4sbPDHxSxiji9/vxOhGG6k/SFWsN8/4zItsCFH31U+/ZAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107274; c=relaxed/simple;
	bh=/+oZqZHI1h9WgghpCqBvJzy9LGRR42vTOm/KVnlDk38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgsJS6wSxrglLBUqE7dMwBWF91hjER8WI9BDC4Juzxx0Se0z4hkebJ5enUpVaMj7Y+K4FnDgiWkq/tuALOyRBl4t6OTxuURaV4/keTtQk+WePgouIH2jQMWSDvxRTVQ5fUizSN7OOMrnKttB41QUPe7jkelsPrGx0ncsAte/QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=kFW7/Cap; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="kFW7/Cap"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e87050b077so8359185a.1
        for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107272; x=1755712072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHeBX+bcrAsO9afYXWyPr7+HVV+gOxB4ZyOYt9ZHb8s=;
        b=kFW7/CapgBjqXy0radKy0GWHUNIVOiivw2/rsDNMRsE3FQ8/ZQsZgmwWXPi+eTFNES
         x659WxQMaAe1C6C7XMajkIdnQEU8QWR/cR++KYKluRQxkNqwpR3PxG2WFSLzDsdphcP7
         6jxGxViOSo7w0vwxP3U+GEjPpK1m0NfSD/0huhESrALNBYcLgAmp5DRelfFTwVp4VwsX
         dUsrv6C52NWSNFQjopefpKwbANhUU4nzRUmnyOu0XlmWV6BQYqQGmuYDGwykI3VKOcWU
         uJzqCWcGbGnZQ94hNMtn8+8cetmvqgMPKJEX+yCX4Ftt/SUxA1RFdsbDEklI4ILZ3nQZ
         eP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107272; x=1755712072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHeBX+bcrAsO9afYXWyPr7+HVV+gOxB4ZyOYt9ZHb8s=;
        b=wUV1Kjj1czWcvkMBwQMol5W8Y4Btc/xUd7fY5LbyChzkjDDO6tT6ZGTykprv25iYcl
         tPKhR3/ZV0L05Aq4F9t9nsG6+D0ZqQxIt8LWNL2GbX2f8e13eaLvTc9I167Ss1pfXDKi
         1fgy24ZrKJzomyIx9KH0xN7g7DmnjKPDdBvuY9a871ajWg5ml4LcC6hGmop9wTnSoujA
         QhOMk3atKURuVparBpsTp6axAV0XDIQLlpUZgMzBnno8UeZcuJe81SqZ+yjoSiScjcCW
         4XwY3FTGoHFRVz4+Blb/pA5UcSU39UBLgX8MLp1W+0Hb16GgPHpqopCq9aLrTzo3LCld
         HOZA==
X-Forwarded-Encrypted: i=1; AJvYcCUoxHW5vLrpRztOZHqpAAD+GEkYULtKw9hvXtkuV3QgwM+noQ694Q2gDFTPvtEs9ZfKBBjrR1o7aN65VY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8s/LBeLlboMFwQPK1wI9qVqquN/5CNORnDWereytrWIiMQ+t
	z5gT1ckkZ50yTAF7/J+bppP4qvA3axd/dQEvpzNo8MlYrop7/jPQd8GKy2Dc0eK/7QU=
X-Gm-Gg: ASbGncvfyiubFHF/LYzaUGE4VXxNlAK5M8Sm/JlTxmpGZBX6KLdgXgsHEAw2F7S0zfB
	w2XojgnB5xIFhB39VGu2xdeFPNuqObn6t/mV+96ObNo18vawIJgRsi4dh4mr3vE2RkkpKePHAey
	XoBY/NYmSmbzHXS0mQHDxc6hwFXs/YeYj7C/U2RjlNSpfcVGQv7WRoGWnCScEcDqZJtl1+Rh1E9
	U7hKK0GMdFE1eKnmJga6JYGYliKkR7A7obZVpmU+r9Iifm6j/Kq4zFszrkzNbpoC6dLWWQzZ5Za
	TJ4esUYhcCL/EBT/TWRoPlCuHhS6KnuivQkHY5iQTjzBRvmPQW1GyDyOG5RKAezxXwko9GaWkBv
	gkv5+mYLetAtihUHhFZ1p4Kz7H9pZzXiJpZ/g2n0cZ+aCeQ604XmCqSQjTtfYfns=
X-Google-Smtp-Source: AGHT+IFBbRD05COD+4uOC97ucvpHyx0jBQqfnQDIsz8+GmCzNdE1TPU770o9CrOuegUdmCbSDq2ITA==
X-Received: by 2002:a37:f50d:0:b0:7e6:5ef5:c7e4 with SMTP id af79cd13be357-7e8705d2e04mr26126585a.64.1755107272247;
        Wed, 13 Aug 2025 10:47:52 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:51 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 5/9] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:41 +0200
Message-ID: <20250813174720.540015-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel USART serial, so make it selectable for
ARCH_MICROCHIP to avoid needing to update depends in future if other
Microchip SoC-s use it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d..724ad4f3cbee 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.50.1

