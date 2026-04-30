Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8B42883E
	for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557508; cv=none; b=hU+B1qcIiUuWd3TC7AFsB+HjDmCj7MI9hGG+TPMLiUFO8/EhHweMN9EOrUWTJJZrLjkSfRiKT4rtHhWKP2pGBLXjXf0nDnao2wKNTYWeaf9EOtf19tPf2vSaXWTbAr7TjxBnJyZEwVr0FDrMZG+48hH0sEInOCzbRAs4bjPI750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557508; c=relaxed/simple;
	bh=pOdPCL1Bg9xU7MgPz8/AECassS1kFHw5MwQsYrydPIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXEtpTdNtHfPf77g9kd6wsjYn3WAQOixkwU6+c2wZ4jxqYEbqHvrsKHPGGT/eY4uFTPW84QvOIF4j/OFhUjbwMoyiM5no5qkSFSjG+l3U9jmNs7HXLfc6lyVnkasndeAIoC4PvYCAVQdfofH+FMXhLAjZOTdfoZTpmUSuj5R9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l72txFPV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l72txFPV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so6471385e9.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2026 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777557505; x=1778162305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JxVUEJoljlNO2K8l74JzqDUlYOIPe6Aghz5xDGoW6k=;
        b=l72txFPVvQ9MVeWIxSp0EgJ4cGkWPvoHxkSvyGJgsRjGmSWLdKz7IUmKPL1mhu7l21
         BxXN7QGxQ37tmt7rOCx02povKqHbVv4MrKH8cZAHqhsZzdf97+vjw3xnkxrIYgLQ0oCR
         1vhybfFXJj1jfug+U/W9+/pui6MuaimeONyslFc8unffD0bV4MPYoPlm/eMjnahNHeVq
         GaUjsv3u5OspCTilwM75vdRYLA/IEFJLuMKWuKJ2YQw1I7073pOLngUVtODEtYC8jI0D
         Z6GCPblDlgB7p0HwInCRVTSWWgVnmbv2PIitrQFXm/z5j6xafCpO4DeUnfR3L48IcQuQ
         jkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777557505; x=1778162305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JxVUEJoljlNO2K8l74JzqDUlYOIPe6Aghz5xDGoW6k=;
        b=eUdQjTh1moh1ejx/Vjmq8ye17B5fxJeoVg5SiukoWpxm/IjFPKiESx7riegihyPKR1
         pZ6eexcW1rYJA/3ubTaRR7zfJHa2jc53Yy9c+kbFvKv2kACnp1ipgq7hqOoPGoYJ26rY
         8Qyj2eUmHIBZefmKjb0MBcm4MutMUm9BeSJ8lvw4KdY8owfmoRJJY8zDotnJqxLuKlh8
         Bn3qxphfKlxEBoe9vHAcZNo7X57mRoR2ZKNRpQuaTtuw+bmrPUQ+04JI33FqoPq//7tx
         U56O+eqZUZ7lR5HxZ9U6jXcnZnS2mHHjG/5lEN/KZB5xNJT3L0xSdb+tfVBen0Us/OvT
         LFxQ==
X-Gm-Message-State: AOJu0YyY8JjOOeoFHk9Dkhyns/qPUWeOWk7UNP1iIWa/NByRCiW+nxhb
	+AtV6iWPSUxugPzIISkYRYo/HzQauVovynJ/kGBYcJkWqePS4q3RaYMI8jBJcXswCB4=
X-Gm-Gg: AeBDievI1cZ2Rf7geTmluFHSV7kymOAJBUT44dToqzVEQ+A6wYCQ6E2Ccqev4wTibKu
	v1eXVmxqTFJGw21GkB6q20EbMrvETX+ppykX1rxJiOTgeRbhbdx/FXsJLMJuMJT3cEZTA7mrU3x
	ddcnwokX7zgUtfitWhRLQSnoX2QsD9YzzpW/F8XC4hElzpghhtSnMGftFdZ2F2pdzxiwouPi72W
	QWAduTYNdkkMPzLlYIettTQOG4j7OUCi5GRX0Oyl1qcrmrc1KQgH+LsiD2duPSOeF8bdP7/Cesu
	hR7jekTwfqWVJCe+ES/S5tkn+J0RxVYs1dSMvKmirfCQh5I+udzSjVO2Z8YbNJnBX4NmpXMW9sT
	SccoOBhqL6uImJzQpYdQRfnsK2ODZlp/mK+vmXRDGYJcRO1+en9BysRBVn4PFTXjQtYABMU19V2
	zKlJOsmoB0WDXPr4rcXopNM6hdIfoMIBBIP5XTkHng66TGciPf2fgchl4F3txRPuzavrWCBBU=
X-Received: by 2002:a05:600c:3e10:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48a84456732mr50513585e9.12.1777557505268;
        Thu, 30 Apr 2026 06:58:25 -0700 (PDT)
Received: from flagship3.deu.mlau.at ([2a01:41e3:5046:e100:70b2:5191:4c6f:1cdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c30571fsm43893445e9.19.2026.04.30.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:58:24 -0700 (PDT)
From: Manuel Lauss <manuel.lauss@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] serial: 8250_port: recognize UPIO_AU
Date: Thu, 30 Apr 2026 15:58:22 +0200
Message-ID: <20260430135822.905035-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My MIPS Alchemy systems generate the following warning during
probe of the 8250 driver:

WARNING: drivers/tty/serial/8250/8250_port.c:462 at set_io_from_upio+0xfc/0x124, CPU#0: swapper/0/1
Unsupported UART type 4
[...]
[<80521d40>] set_io_from_upio+0xfc/0x124
[<80521dfc>] serial8250_set_defaults+0x94/0xe0
[<80520fb4>] serial8250_register_8250_port+0x288/0x51c
[<805214ec>] serial8250_probe+0x160/0x1e8
[<8053b5f0>] platform_probe+0x64/0x90

The least invasive fix is to recognize UPIO_AU (type 4) in set_io_from_upio()
and do nothing, since all parameters have already been set up in
8250_rt288x.c::au_platform_setup().

Run-tested on Alchemy Au1300 platform.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index af78cc02f38e..02e6cdefdbac 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -458,6 +458,8 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = io_serial_out;
 		break;
 #endif
+	case UPIO_AU:
+		break;
 	default:
 		WARN(p->iotype != UPIO_PORT || p->iobase,
 		     "Unsupported UART type %x\n", p->iotype);
-- 
2.54.0

