Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FF1E3DFF
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065044; cv=none; b=uqDnx5Hue05NuCvgxidBOqnVKfxbUOpFR76ezbkhD5Vqpfs9+F+wBYo812FRF4vwVjabn8K4PmKQhrbMKx2ZL61EK1As84qKAg8SP3icQQ7GPxjm/yiBYVK6rnTYvI4gaZvW0erbWDaE/e45ZwRgAZ4G9lEDxWx/cqVDefWxPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065044; c=relaxed/simple;
	bh=Hg9luVEPDNEyrEB3D72f6ILBx2FRij6PelggGUIez3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB4hfMpgOzyu5TmJZLVHRYLIQMc+eGD6DZBPgDTF6M4ME095UEkHWOlTVmOovdVku+1Y/rMfwsIoHiJXISMsB8BaPy78wH7oPmjAz3xbnNDWk/dTGWLlCzj7ouMKz383r/YGroIPXi0YUotSBeu2ewTF3G28tVASbR+eRXAMnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bC6Uaeco; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bC6Uaeco"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315baec69eso18242835e9.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731065041; x=1731669841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnSKG3TH+X58AcZRDigmrjfJlOAFQ9HXiZWebugh1IM=;
        b=bC6UaecoBSpprY5fyg4OsKrxS6tZUxU7WWayjsHxmsS0uUMbwssisoK6vW8jhm224x
         OfA7SYAh51VpoQwHU76IyVTfZd5ONW48KIdKCn0ne/lvqUeMSwXcoTp9leRWcLYJcKBt
         JTKdZ4k1bJaG8X583pPOUJqPC0MwF7j2Er7TUD2JuVl0Gplht4yHGVXQM60k4kDhuMhJ
         Y9ZHuP5R1nfhqAlse4bdEL35T+FlJ/0cmgKXsPRm/PBvoqanbnuWxCdWsH3LtXYYSnxb
         Wfcs2KXJPnUswKpdjbi31K2772SvTxY4o8iI01S9Rqpx0RCox81lOzbS2tEt91WeDZ9D
         lj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065041; x=1731669841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnSKG3TH+X58AcZRDigmrjfJlOAFQ9HXiZWebugh1IM=;
        b=jHu2TMHSGe3R2TZWl80xZRJbl2sTI0x2XUcB012ZJ3+xFqJDWTNnZRUwOMq9YI5eM4
         NcuvCck5lW9EEq8niu+35peD0chk3e8V5tQSh41n1xVKfXjg5O8Vpz2Km0sq6qmJ6mbl
         y9uxoGZf4x1FKXDxhnn6MvpyXWDNwgRlDDBhWBX81UcdKyFIDHF6CbM+oLKBeTx0Ey26
         6RGnsuRQ9dV3aCZ/Cw6hduGQqqE4yFzD4TzUrB2Noz/R7DZ8v/nYi5w0DiTyCMhO9oni
         XoiFbej9hoyx4tc5roTVsjWU2rbRcN7jZGK04W2g1Rpc3R48aRppUnrshR7BNGt4bc+N
         6pBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+fxgcle2c3NfEWS5suUrr1ul/St0w1nxiLC69KgWUlgZ3DGtSiTyIrDPGY5WowddYgsrCzi9qQrSoO+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGg5fmgFQfPXg4KjcSxrj5zXHifGIoJv3xxIwIhfIK2f8O+8B
	tTbKcDI1W/Wx1WT0K0gl87DtN6m+tv7V0FkjfEm3NR9h0/lSY/i580dj9nRmUQU=
X-Google-Smtp-Source: AGHT+IFhDdWJ9/nrt/S8un2QtY9kM8UUNO7BtPJoNvy1L5IL1cpiKGJx6XnADmahjiBUVox1mtdnAA==
X-Received: by 2002:a5d:5f81:0:b0:37d:5232:a963 with SMTP id ffacd0b85a97d-381f1866f10mr1897932f8f.14.1731065041488;
        Fri, 08 Nov 2024 03:24:01 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm4281443f8f.10.2024.11.08.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:24:00 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] tty: serial: atmel: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 12:22:36 +0100
Message-ID: <20241108112355.20251-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108112355.20251-1-robert.marko@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel serial, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 45f0f779fbf9..e6cf20b845f1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.47.0

