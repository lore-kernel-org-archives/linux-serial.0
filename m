Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F815A842;
	Sat,  7 Sep 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707696; cv=none; b=JBdx+dJPYYeIFk26OqBpjrCTM1JSAVwC55g6lZCCLCuodRB7o3ofLlaSVf8X+6phPMhMEmBcZS2sCoSBp5Kk1N54XoHOzVxjg5dGwXWDlNenTpYkoBKJCne6tIvng7dVbgCHRqJ1Rs7ZlH8o0DpMFqPeUXo0i0aM/43S6krrkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707696; c=relaxed/simple;
	bh=yQn4IrX2y1gGE9tp496wGGts2OgOvzhAvr+Mlat6+5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpJ1mXkNIyuEUD45dB5PR15aZceq0n8XClFojPJ9XgXlqirGVtndtHdHdv0utRIdqUL9BYuB3TzflAm5rUJ3YNr/skqM+Zaqa4s2vDMCmQqV/1DsoE7KuqOVRBpjBL3i0mpriFWoEsZM64+3uYeeyLxGB0iQov1FPTJF1XRWLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdowAtO+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdowAtO+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20696938f86so26490295ad.3;
        Sat, 07 Sep 2024 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725707694; x=1726312494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+BuB4FjLqD9bjbDGs2bz07cEq00t/CZQx8ir7y0gU=;
        b=FdowAtO+kBpI51UtrwVs8V6GfiMfQpiQB0EmCE0zyllnfh592K1ecGLqJO3fKyvcej
         QdQWDw18XTnI+gp+6uYqBO6f4NZ6OlvhpOvresPvz6fnzPbYNBROXbWimNiJq7jSPZwQ
         Y7hvB0Xi6Fw0AxrPFkypmHbiyAs3OCaXRB+oGqOD/pxbJyxd8ivMW7TEa1niGI5zA0kD
         GVXhiKDMj1D7HkaEGrkLDAocaXPCvuu38/IxQKaxRDQF+Nq831CgNjinzVpgRPMGtzir
         /z0aiABoLGnj797VZCrngSk+51xpB2xw+GF/tpGhCVn3m9nqnjmT1EL3l50fCdBu3bde
         1j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707694; x=1726312494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3+BuB4FjLqD9bjbDGs2bz07cEq00t/CZQx8ir7y0gU=;
        b=dURTUUxSwknj/R8eqB1NN/tqB8UVvFayBcABlwGb+ENughj68IG/0Rr+YzMonL48cv
         o8rZTBL29vSeABon+6rOqUDIBaUKxonFFrSeSBnSeNRPv1POZjJgH37P6WfbBhvpAZvd
         ZawKITIhP/5RiQwYV2WA3V9al3uLcmzh2k4zyk9/1NM5GfGVEKzI1TkuhSD3teJ8AmZi
         V1U7YqBvWBCgpbtpydHkty401y8dDrHfOafXgIbmhbDWg/PSxiPoJLSv+iQnt3gANXaF
         Rv0jI3th6d/4q4j1QwrFqDbjlUCSZ7GCr2VNyfoNENbbe+9qgvf4F96d4tzijIpV5XNl
         E5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVTFHI6ElPjsVCD62qbW6DJRqq2DGxC5P3sPy1EOlYOmNCAW1z64PlGCCUA5b8+jPvv1ZgTHuntZ/uWeha2Bt1rDHo=@vger.kernel.org, AJvYcCXbF2BcWbIp1JbTj3PtWVHAj0r1TEVYcRGIJrwirMweLgVECMGUOpjitdYUYdRK4WKrDoxWxePvERYJNWs=@vger.kernel.org, AJvYcCXjuWYmHbCmePVwUJC079b3nvCIgn/+mqTUAdWpV0S9aVgmtBkoHKK2YkuMHKNVBHo9Ull1e60gspqC0+5o@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkxZblbmAv8ajHIRIFHc1f/0EdVgqY+f+f1+BL2qhdFBCuNVI
	Ix9mARnTru2gC2gSNJLkSgNi1l+pSx4ADUhk0gbP5VIZn0YSSCjv
X-Google-Smtp-Source: AGHT+IG+d/Ja+M6I/KKbLW1L9kR7tYcT+FpvaTcOzSQ8w/aHxuNDIEwCeGvjU3MYj7ZC8/xGYSOn0A==
X-Received: by 2002:a17:902:ccce:b0:205:8bad:171c with SMTP id d9443c01a7336-206f04e1a7bmr65926405ad.12.1725707693732;
        Sat, 07 Sep 2024 04:14:53 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710e1addbsm7186955ad.58.2024.09.07.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 04:14:53 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 1/2] tty: serial: samsung: Fix A7-A11 serial earlycon SError
Date: Sat,  7 Sep 2024 19:06:44 +0800
Message-ID: <20240907111431.2970-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907111431.2970-1-towinchenmi@gmail.com>
References: <20240907111431.2970-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple's earlier SoCs, like A7-A11, requires 32-bit writes for the serial
port. Otherwise, a SError happens when writing to UTXH (+0x20). This only
manifested in earlycon as reg-io-width in the device tree is consulted
for normal serial writes.

Change the iotype of the port to UPIO_MEM32, to allow the serial port to
function on A7-A11 SoCs. This change does not appear to affect Apple M1 and
above.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4f2ac9518aa..27b8a50bd3e7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2536,7 +2536,7 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
 		.port_type	= PORT_8250,
-		.iotype		= UPIO_MEM,
+		.iotype		= UPIO_MEM32,
 		.fifosize	= 16,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
@@ -2825,8 +2825,10 @@ static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 	/* Close enough to S3C2410 for earlycon... */
 	device->port.private_data = &s3c2410_early_console_data;
 
+	/* ... however, we need to change the port iotype */
+	device->port.iotype = UPIO_MEM32;
 #ifdef CONFIG_ARM64
-	/* ... but we need to override the existing fixmap entry as nGnRnE */
+	/* ... and also override the existing fixmap entry as nGnRnE */
 	__set_fixmap(FIX_EARLYCON_MEM_BASE, device->port.mapbase,
 		     __pgprot(PROT_DEVICE_nGnRnE));
 #endif
-- 
2.46.0

