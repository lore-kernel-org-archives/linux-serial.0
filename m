Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440439;
	b=Yy1dAHzVoKsfc1/MkyTgMjW8tJ3dA3yXzw8quI5pkxmtPFEBns9CMeVbul0vAY1q3+S2
	 7pltVMx/firHq6/2SehXYsJ+Lvh91ppxR/Isp32RXKQHQXsU+XG5IZl+OPKk8tBUE8wDv
	 11GkmKvP8yBgz44dt3mPWTKJI9iN8TGZvAeqxHkmA+Os9isNpcTgIX2gfPJYPAvDxDQKp
	 Aj9DN1kYqXh3E6WCQMvQqUS8lAYHviK/Kg/32SCnR/DlrCi/V6F0Rk2fZ/AY44d1RrlNJ
	 xvRBPOchsB6trCfXjN32g0xva15PvahT9OStLoPe7QDRupbH+NVmtcPZ8V0VP30WIfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YPV1ND+Y5cr1ZRV7QTF9T5CIKQmib3RaWdAMyy6frHc=;
	b=tUZpcxwE6Eotg7IatwnIsHNlIZKNWAefJXy3xDx6COxCSE/a5VZtTTOA9LyhBJQbBuRj
	 0XRfDYJBcAQQKmu46cVcBK7oeY1QEp/eQ2BQ841VywQLzThWc7ZM1Sbml2dypZwx1LYPt
	 F5sdb0g+F3gAsmXzVhCoEtn1vnz5L5qWrH2bRXVBoBQswJd+3IeTp9lYoEPFqGDepcZhD
	 uNbpLzIX0YMcT1c9bNytGMHrdIL0nlzAkdAEJuPHjB0SA5tHItoPTcpD0HlnCT3QqrXlv
	 nyGuvvcYX3JGh7nOYqw6s+ESKhOMPKF/fGhqZTa4yn9oRmeKZX8vroScqvoLjtDDusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l69kuM9n;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE1606A31F
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBE1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l69kuM9n
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5e948e56af3so831793e0c.2
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792440438; x=1793045238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPV1ND+Y5cr1ZRV7QTF9T5CIKQmib3RaWdAMyy6frHc=;
        b=l69kuM9nBsR+l0ZfD1qjwGocl2TfXqkwPRTz9QKrnRXYHyEZEaUQB9/V81hETBJtTy
         qELQXTDhgpHVOiISHZ2PVXDIQRTw81JGSlXOIVsuMspQX00wJKUe+YOL0slnZdSnuInZ
         m4dUeryDiyUV5vu5zV83G79vFU3kAG9iMq0gpiQdXinEf+gV0T1zL1Xthi4IZ8wWH9G+
         ZHGcU3TQFPp0rkjpcKCUiNeSwMjTzG0uSbVVFM91nSVbuX/2wmK9L296XET3BfitHEGx
         INGY13UsZ1Zo6h2wy2kqU3D4axkdLslMai/yZ1G4bYuxDyYZm7Wn6C6wnEW5ZUAc0bV5
         8Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440438; x=1793045238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPV1ND+Y5cr1ZRV7QTF9T5CIKQmib3RaWdAMyy6frHc=;
        b=ZK3f/SmJ4MQ3j7TgjJNccv9mF2DbE3Uzgnm2it3NwhYP0Df6sB3RCRS2t6xpesqERg
         GJK08OtnMXPdDWtH7Tlb3969Ps9kwQkb2eL3wZFePp9yzgK64ChWjA7+jAkXqKCd5B2e
         0gRLpxIOdb6n5lOi7IFHRQEqx1gonnDRBZyjKJ8JiPJGB9jvmcEoF5hA9bCY+JHZR3D9
         FGRIpuzrZKZYCuyAzIScZp4XjB99sVypLaw36MSg8yQZTepOn98kwxo4bW1hnwRpEVCM
         mPlqCVPHCdgndpSVxE0J8IjXKQkI8Dd9xOkmSy4D4o7LCOT9QzpUTc1ZDJATHNbzVb2J
         HKiQ==
X-Gm-Message-State: AFq9FYLKAPPALHbmRiUofbWOLcnth0n5WeoTstwG/I2+zpNOW1SxZpDJ
	95Ydb7pe2MdDillV6nmvXi7Fsy1Vcv/xvDe5pvTO0diqAIxj86K/H8jsvUYT8qKmKZaF3w==
X-Gm-Gg: AYBFou3bfEfaGlir2wKsxpn/27BIrayKphduqBJ3TaZVu2qdk3toHT1bb8ApOqGgd5A
	HV3SBchn06Z2YARyYspzPDnYanBZWmNW+mobpw5Qj4ObhZiX8msIKVaNWjvpwA+kc5LMfAxPz4l
	9nOZtyhxXB2qRDick2E+2hdFlkLSSg7TQEjaztQy7IOzvopacAcSFRZi5ZAsyXZTmPHwzKU/KUY
	4D5OH/jbI3edNB50VYi3Xmm4FDPZeqrYBFSwE4VpMBzVo8ceMDAMqsFK0iARevolNvpAiimFZ++
	5ywlOzg46C37+zxAqpwcdajpdL3pa4MK6tCfpLxCJkvFf4chfgkAHViqdYtVpnXWcuhGx3eVkud
	krq3Ch8zaNekZMuPwCiNMumkWqK0HmN8RFfCwq5k/+x88OyIhHGf+fqJ+e3jl6X2mIJ1MIylYry
	ImOhHLVs+sEeX3VeQJt11Dfu/D9kfc5rBYVNTJSJ/nqgPVuoVyPvFa79eT1f5VaBvpxnqZw498k
	wCqNey63QGMrOmNT03Zh4lfaGSfZ3lRSVwgehbf6JgsSHcASskQipFiKQAETMOdqEggaI3mRrIl
	cMCqlvuqO7SsF9Abzg==
X-Received: by 2002:a05:6123:12d:b0:5ea:c214:b5cf with SMTP id 71dfb90a1353d-5eac214b927mr1447944e0c.1.1792440438123;
        Mon, 19 Oct 2026 13:07:18 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.244.163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4776b5sm10451611e0c.3.2026.10.19.13.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:07:16 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: [PATCH v2 4/4] serial: 8250_dw: Add Allwinner A733 UART
Date: Mon, 19 Oct 2026 17:06:13 -0300
Message-ID: <a3505ad8e74a08faa270881f0efbfe0d0d82d6e0.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the A733, dw8250_set_termios() stops the UART clock around
clk_set_rate() on every termios change that reaches the driver. If TX is
active at that moment, the character being shifted out is corrupted.

No baud rate change is required to trigger the problem. Toggling only
CLOCAL or CSTOPB 300 times during continuous console output corrupted
bytes in every run without the quirk and in none with it.

Use the existing SKIP_SET_RATE quirk, as the JH7100 and SG2044 UARTs do.

Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 4c86aaf9c121..718ec44135e4 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -906,6 +906,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "allwinner,sun60i-a733-uart", .data = &dw8250_skip_set_rate_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
