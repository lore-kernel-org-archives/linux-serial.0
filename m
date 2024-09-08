Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178B1494AF;
	Sun,  8 Sep 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786600; cv=none; b=vF44vGFOYtuItP2+E/iRqRbgjeHWWAJ3cMaqSIE6tka4NStvzVGzyw0RG6SrfvnyOCrQVJZOCIVJLIA+ib6n2KbOq6m+JQfx7bhonqQX3XUUB7erW/80Gt0Qk9XJRPx6cg3Y5+D40N8jVt7rbn8JtFNhwwvAv8RB/SIsDYl1mus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786600; c=relaxed/simple;
	bh=jSOpOfDN75HGeuyyYM2GrqyjGgMd6FFLDiemPseUTAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU0r3fUBnd48p9UIAZeh1W30KGmjI4Cs0BzDE7O29g6IT5ktek9G8EXY+YeknHYBmcHFICJevCfDY8NUwLiqqxwh6oMjZiF8Vi/aHqpS312cNpfhcTtAkwgK18HG8vymd4H+pqFYyp/Sk4lMDnHk1HaWsgj5YWld3gmPh5VNqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6SdLg/D; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6SdLg/D"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d985b6bbso1731865b3a.2;
        Sun, 08 Sep 2024 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725786599; x=1726391399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbxEfKH1k8/Qf9uULVt+DX4XSTY5IQ75JiyMJ31UTKo=;
        b=L6SdLg/De4/cwzF/uDibvGccqFOyE+PCfv6RpHkAlnCT+d8G96xU/eki/wCNz4yAUz
         Tsvnp9D3aSgr1ZuSwtVLiYq826zZjtGqI/dRIGeUpreEChVw5HuWeEah3i2sz6ZlQE1v
         eb2io0yMAIUT/gNlLrB6ByyqkYokDuNQFYsPK0LYOl+lhisSnsZ/9WrQDixF19gpehPL
         gdudct8lPEiWRno0aj6tS4RIvnunau4Ya0kXasNm1g3pKGvjZpAdCRsSnYhc58up76UN
         0hB9NOi7183h8aaCGWFuPTTYp6iR+2St8UROWCgOvCrMMZMYbc64QxP71xT2tnxow7w4
         Tsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725786599; x=1726391399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbxEfKH1k8/Qf9uULVt+DX4XSTY5IQ75JiyMJ31UTKo=;
        b=J3W148V2YhxDkFckfNNd6geCdJI/fong7/+TGtfavutb7/xP0H7K+J7Pnpe3FFbhXy
         cJ49bbu7tMm25ANItm+DvIqewp1eG03kyB7fQ6uxhLjs3m9rtUTVLgbtVQc5Er+kMZ0C
         pvwHMuq1Pk6Kgcu5WPp4p6SJCOTl4AuvacwTpaPQQDJfYGxD+Un9eg23w7Ow0X6CzkUq
         Ehm3kM97bpk3RsS+RWQKPLhBA7RpL+yrei9QeAYrDcSv6okeut630hUL/7RADnQvUK0/
         NFb5hzEL3rGnZuet2I3YzYRwe20Qdkd7eNhAXGhtrQV24g9ELFWSG4PiSMzU19iKSast
         bz+g==
X-Forwarded-Encrypted: i=1; AJvYcCUVXExLrJtANGwG+IIYpA3CSt++WaMeGa5hKJD2FBUmMhLkzUSbY6RMagDMWcwd58UQ0/4y/tsMtJh0MNJy@vger.kernel.org, AJvYcCVhM3KnZCumIArh1JvRGdmwmhEDkoWNjDy+m4v90FOqXiN37ofqI1D1QPlrj7VMvPrsgo6ryAybx/HEAbhZKYSBwf0=@vger.kernel.org, AJvYcCXpxT2tdf4kogDhPdBEiEucV8Fphzorz2ZoN2KtnkryPDkud9d0icHTmGuMQHF6Y+RyKmmNLNFGWF/qc+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJvX6L3r/KiG1/s2Gq6zPRqxT8mnaGGPxxDk75TxBp+Ifzb5b
	JzYiMTQuK4awI3AihJfKmR7x93vEnmMJR7LMeVZUJdU1Q04IhoCW
X-Google-Smtp-Source: AGHT+IGD6//dNI4mvPIlr4luABmubRQ6n//3IEnexHIKQjRIoi8MgrkaWlu1RaMw3qxMGGGjDn9w4A==
X-Received: by 2002:a05:6a21:390:b0:1cf:3a4f:6710 with SMTP id adf61e73a8af0-1cf3a4f6a4dmr817960637.45.1725786598694;
        Sun, 08 Sep 2024 02:09:58 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5896e10sm1821439b3a.31.2024.09.08.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:09:58 -0700 (PDT)
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
Subject: [PATCH v3 2/3] tty: serial: samsung: Fix A7-A11 serial earlycon SError
Date: Sun,  8 Sep 2024 17:05:11 +0800
Message-ID: <20240908090939.2745-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908090939.2745-1-towinchenmi@gmail.com>
References: <20240908090939.2745-1-towinchenmi@gmail.com>
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

