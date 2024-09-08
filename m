Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948213665B;
	Sun,  8 Sep 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725782381; cv=none; b=PQIOn5hFiOq4GAu4ICCXjahjuJ+4flTfD/nI+6SBUPN9sjlgE/0rjihlD5xVZyk/dxY0RXIqnd9VB9uy+3QRzbyzH0zh5wVBc44iEzJiByL+y8hf8vLeuR+EGoAiB+x0EWgT5g4E/aOY2/nd9rbnJGZqviXYn/UbVKr0pndFOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725782381; c=relaxed/simple;
	bh=jSOpOfDN75HGeuyyYM2GrqyjGgMd6FFLDiemPseUTAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVy7LWrijKI5ZvpG/Pb1F5/qaML8k7j5aSf/0TQwd6MpNgrdyAO1B8usj1yT672E6emljjQbCCaAU/wB0yWhniV8ag2SAgenOpWUyofBQ9+DMb0UM1tD1ml1TLAuhRnxKNYwFU55O3KhM5OiKIHnucS2jeNXcCKZ/A5PDqWkiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUBjtAmZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUBjtAmZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e0402a98caso191313b6e.3;
        Sun, 08 Sep 2024 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725782379; x=1726387179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbxEfKH1k8/Qf9uULVt+DX4XSTY5IQ75JiyMJ31UTKo=;
        b=RUBjtAmZOYzx05sl//QVtzk324aDUIi1OMhdQj1Cil8zVTgkuFoZXOnJqU7EWh2SXM
         sG6P36zvPdZUXjn7CQbKZ9C4X2XopoZg2uMQcvvX0pd4kRkNjrO/L0vdYGPBuMaktOHL
         Y4/DJfVybTWLz7SzStBC0FdqFj5Q6YWlgyU1e1oFXaaH8Bl8UMZiJTtSia1jt+6zFoQp
         Dokt2QGBysq9q41TuFi/mcB+P1Es92nIUHvXLcfy5UJCmpfH2jx0Lw5RfHxOPDvSYShC
         fsv1CLbRuxiP2Mmj60cHFe635j+L3RLfTKZElhXhEYOW5CU5RjzTR3YfnQdPcAfC2glJ
         8bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725782379; x=1726387179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbxEfKH1k8/Qf9uULVt+DX4XSTY5IQ75JiyMJ31UTKo=;
        b=s6BKvJB2YOlqjFPArsiTE4rRzXroTSFQ5F+wMingIXKnbo+yL3SbKG3ccZQNQ80Tjg
         nezgbgvpJI1bZ/ermdYygDrXAIP5utZBp4lHhyPwHRxSDxml4JE3cGndKXCLOujIrZFW
         2XfUOXc8ldlFRyKAs2Z7gB666CHwB2tzDmn9PmNEjTYoCAbCvCpgfcPVfsT5rtfUp/sj
         0aNbK2MnK/lMQCuZ/Cmsc/BOZq9AJoWtSrFGDiJkmIyi2icv7MXd0brUJbcaFUmWxeNT
         3+XOsxOYjc8RBy+1KOCP3BKLs0gltXzF2wg4UsObee+edFhrIEZV43HWUG1RjIWB6sDb
         AqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNlwq1SSXcIQYSneuLllRol74Az5RZr/VxkXrM44iG/ieWLyoFnnV4iUpp/sPJhah5M6SwZEqgFC/ismzs@vger.kernel.org, AJvYcCW1ZEWe97pLoEFlW0B1LsrvoMAhETXC6yyXGmqTmvSl5+mL+5M2vJ15timfZvByzIY/ZglN0Y7LTgAUCubmiHHHGN4=@vger.kernel.org, AJvYcCXKa5UBXnMcp8VuMhfnvmYKSK9pQBLKe6QObT8L/DiP8MkZps76xnqx9BxPhkpaI8ti80QDDF3d9jLybUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OFmKCLAFNs7sJeRYlTUZssxz8b3RKTxd59wWCACFY1NaByPy
	f7634mBQPBeOGrsaGjh0CfDYei0/UuLgpyyT+iFev3g+evaesJTE
X-Google-Smtp-Source: AGHT+IEiYcVnzzd9XCs6BnPdnES4UAw5UPqZt8FYQLjQr9Z+xwCq74AYcx8uxESiYvlFIj/3jd88nA==
X-Received: by 2002:a05:6808:301e:b0:3d9:222e:40ac with SMTP id 5614622812f47-3e02a02eebemr6979195b6e.44.1725782378990;
        Sun, 08 Sep 2024 00:59:38 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7d8255dc1c6sm2012690a12.68.2024.09.08.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 00:59:38 -0700 (PDT)
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
Subject: [PATCH 2/3] tty: serial: samsung: Fix A7-A11 serial earlycon SError
Date: Sun,  8 Sep 2024 15:50:49 +0800
Message-ID: <20240908075904.12133-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908075904.12133-1-towinchenmi@gmail.com>
References: <20240908075904.12133-1-towinchenmi@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4f2ac9518aa..7574d4176e76 100644
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
@@ -2822,6 +2822,9 @@ OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 						const char *opt)
 {
+	/* Apple A7-A11 requires MMIO32 register accesses. */
+	device->port.iotype = UPIO_MEM32;
+
 	/* Close enough to S3C2410 for earlycon... */
 	device->port.private_data = &s3c2410_early_console_data;
 
-- 
2.46.0

