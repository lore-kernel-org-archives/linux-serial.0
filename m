Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7666E5E8
	for <linux-serial@vger.kernel.org>; Sun, 19 May 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716146477; cv=none; b=rU/ebymAs0Tsup4EcG6E0agFVnQgQ97m6ZxgiJKN6Vpyznw/5kysAnOltIWpFPEt1H62/QW52hvkVpIkRDyXg8nO2ClkuiERRRgZfVwzBX+6NPFwVRgsZfehkA3TGOlK70tB0p1rYIrtbxOHcSV5t1/znXL7Y5tXCEf0ByRyy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716146477; c=relaxed/simple;
	bh=8hXNbJhTAeQjCMforQF7Q2/T1+r1G2XoU+zifxnTS3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IjnwZoPczV2Ti0KLodO9pZVOPXGQVJ4lnvwxfE4Nvq9qt9d7nBLMchH8Xy0Bm7NwrFseDvPB+3i3JhifFm72YZ7jALyxN8Ol5v8a7eWOWPdWzsik3cDGGFmj+53KCcHHndc5bMMwEvg+uCy/u71L66E64AbptGe2zGKpxwpP5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=Hshgo2eJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="Hshgo2eJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed5cbf7b49so7975395ad.2
        for <linux-serial@vger.kernel.org>; Sun, 19 May 2024 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1716146475; x=1716751275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecHhcTmhYTKY0bJxHABrceSaICBBAHlemUfSqvn00Os=;
        b=Hshgo2eJo2eVZDH273cAV7h25vF2MYlX1uBMfgRe2pM15SuHUT4SSrg1AGOpTGW6Qg
         gQQfNkJyTzMwXTF/cqlSARAf3pu6LwqMwycvlqKR/SWCU80YxpWTEn+gEi21bybD6XqY
         uhPqirWd4owIbQTgHwXUqOluc0kyVyENzzwqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716146475; x=1716751275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecHhcTmhYTKY0bJxHABrceSaICBBAHlemUfSqvn00Os=;
        b=YG5JIPcxoLyrKpNuVmr1IPPlLO5R7YQKMBnMTGqkoT8PUh+MJDNq9IDsrnGKEajDSf
         ma4E5DzEo1F64mjO/iIMqrM9vylfFquraNzVlzdSwxrfW7Nu637ub7ZWPKZrNidoopN2
         0DtT2UEywE6P/AdN2vuFU/SJf0Pl0hVf0PSh/EKz7C+k1CnqoyB5Z0saTDkWAgqjUVkS
         bQo6sX5VSuQy9DlAckwy2/cwMGIo0yoY+qrNDWpbR/Gfxtc3j9jA1Wvc1lzTOb5dWAS4
         iimOr/BCinA3I/WYLY5j2tjlKITVbytQnZRNkyGbmjzoIraVAxmeoUhkVc/F3XeNm04a
         TDMw==
X-Forwarded-Encrypted: i=1; AJvYcCXxO+vIPy35GhA5tCstyFmq0vh47kO6UQ0S3XuCll5XAySl3vEAxtXXJFooTgD/mrgEDA15RUY2iNeqfk/eXfdXYUkmh2bd5J4UTC9B
X-Gm-Message-State: AOJu0YwNcdK3E4/y0ky03OCYSnLO74xbhaz9cD4NU9Ibw5BVmNteoQ+K
	xTtY+AUOoBrn0dmCm3vY8ivfXv6BsBkLqTx+9um3Oqcf5H3NcgLcadW5rgS3L/Y=
X-Google-Smtp-Source: AGHT+IGZU3yCMwrQfjWc4pTx8/QVhx1AVPegUyrluJbhizDt7qQYVpyqBfFB6QxgaAHOObNL5gL5NQ==
X-Received: by 2002:a17:90a:e2c9:b0:2ab:c769:4e65 with SMTP id 98e67ed59e1d1-2b6ccd6b6d4mr25108989a91.2.1716146474463;
        Sun, 19 May 2024 12:21:14 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd7a0867fcsm913149a91.29.2024.05.19.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 12:21:14 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Sergey Yanovich <ynvich@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level
Date: Sun, 19 May 2024 12:19:30 -0700
Message-Id: <20240519191929.122202-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FIFO is 64 bytes, but the FCR is configured to fire the TX interrupt
when the FIFO is half empty (bit 3 = 0). Thus, we should only write 32
bytes when a TX interrupt occurs.

This fixes a problem observed on the PXA168 that dropped a bunch of TX
bytes during large transmissions.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/tty/serial/8250/8250_pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index f1a51b00b1b9..ba96fa913e7f 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -125,6 +125,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.dl_write = serial_pxa_dl_write;
 
 	ret = serial8250_register_8250_port(&uart);
-- 
2.34.1

