Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722E299929
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534903; cv=none; b=oB9ucIFoOHJYzohBheuRH9r2fbPpYjPL42JCn1PRlSxJojG0CGbPUTaMYgCv01Tfmc5addVEmEbry/wCJh8Np6H5dBnfoCQhy5GvzX+qTB8OaRXjKkOrImTXSyuHvuuRUlIKgOBcbLmnLVXlX72gnRYWy/L1IBBKAtwl7XYAfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534903; c=relaxed/simple;
	bh=rFESBZS8oBmN4KtDEnetLPMoMiqN5IoQHsJGinzOPDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebXEz0At/kH8VaXfY8nPjeVoXr0uuAGr1vPJh3qWUWpatUq4R03TEkv72izN6Eltby3rlN6eet/SmhcgPGdf99pIyQaVze81ZbbU9h9PXPvuw9GpI5b08tbrB5KxK601avIRrY7YrG+CMk0ulRqQWg2hwoOdomqA5TjzuAaUnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=phdyIkX3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="phdyIkX3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so75089735e9.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784534898; x=1785139698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=glqO23LkKusi1AVKCVzG0fh87YP7xeFRRIHwWTTcU78=;
        b=phdyIkX3SxaVTdSMhY9b4a+w0+ABiFc38mBXVxMnXEPRmWWia62bGrNbrZ3iMkfVrT
         HxL9ttWYfoI98Oxa63xOcKjJRXj9ZynKPexdPLv7BrlhG7bAF6aWCdOKU4GkUswMpH/T
         8BLdWUXvHxwKdHWGRVhRkqTP6W2q+Igy9US65M3o9hh1AHmRFaObzsX0giqvgHLR0GGR
         7Rw873LiPicHOCzpqQHcH58mN2AoZrQL1bXLo8OiVZqZv4MHPcrr1LKXucetMMKK4ISf
         JuqnI/qjpkAKUB6UY2msalW2RD7PC8b9M2U73kE/LpUAdoPFM7p7mU7Zq9vqNo+OKa9g
         EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534898; x=1785139698;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=glqO23LkKusi1AVKCVzG0fh87YP7xeFRRIHwWTTcU78=;
        b=osqlGy083GuiTsqXE65lYCHHH0rlBDbiXT58V5pk4jmnu4sJELuz2YvOmYqso31GlL
         0ZaVqCON7NYpwMvqxt72YiHFkVfXOSCWCR/+/BCXmYAjRe4K9d0CwqlOr/eGSOltlpoe
         ycZDL4R1lOKUrRhFawE5+GOjMOaDo1GJoZaex9aH17R/jY0evM5M3ebXLgbz+W5SbSqG
         FQCIeZkw/BiMPMF2nBznj/VYG1EFoLtyqM8K6wULpaexAirSypGoPX3wEFhaa19m73Wi
         o/j0RC5NV+Gt4tliQ8ClhYqgsWXjOnQvUYYn4t4oh3ACMztiJ36q2W5uCYs+9kaYqor5
         sKrg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+Qps0cr0F0ZW3Lj/e4E1PvT+op6GEv7Ex/KHE2WThoT44NGJTdyDjEm6GGtGiIIO8pBwap4xM/fN16ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFr3Y8vqMULmj69g1qAlG7ryUOhhBNyotwqQPGDGHVCaIRnLf
	qEjMca6d30CZ2he0xBPeLu6FD9eM2N9O4/gCcyGDx8nsAZ0c9aIxsUG3mAXugTvF16l+Gjc5FdM
	O53cy
X-Gm-Gg: AfdE7cnXBIvlUGrQqFSifDTAbQtLrkE58OzhLy3X9Bllyez10kxpY5bW/uXHAxqpCdS
	eQBlVyDT7lNb9byHb38uiWu/0WBH3WD3qc0PcPunved78AMgPLSUmb4dTPY/pspVDjD2guTr32q
	ADJia7jNAroAT5HJMTWMTiLHuYdrGu5Q/oomhzVzwTbQBCvDClooXbHzuQZBtneSD/BqbNHKUjZ
	cZW9geGL1Q4QtUoGaZ4j74CtyXG+kNPn3XCGoG6o97NpV35lXM8qTuGik4E+r55YeBYbx7h+lGX
	BAeGps9dQoZe0tYwVakdouXOJPlA8kozqEsCkrWs8th4FT5K2ALDhcOPdcbxhUjOa7GrSYillxM
	UaJY3pWbnguNrkq7uqQvXLttg5q6Pab4e9Jh6qza96P6LqJ7zAsXTUxto9bh8QnO4AwLfhwApsr
	tPI3XBi1oKpQ0oUQBxWTQ7bE14ja5BRLXYouN+OgKVelJSePtthWvINx06bRAFNXMr8Q==
X-Received: by 2002:a05:600c:1906:b0:495:58fc:ec0e with SMTP id 5b1f17b1804b1-49558fcf831mr60436695e9.23.1784534898382;
        Mon, 20 Jul 2026 01:08:18 -0700 (PDT)
Received: from localhost (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4954a2edbe4sm281923235e9.12.2026.07.20.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:08:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_hub6: Fix double definition for hub6_match_port()
Date: Mon, 20 Jul 2026 10:08:12 +0200
Message-ID: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=rFESBZS8oBmN4KtDEnetLPMoMiqN5IoQHsJGinzOPDs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXdds5bsGFYbJtaRlsFDhXY48HyxIPtvAHRR7s Ix39RESGTCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal3XbAAKCRCPgPtYfRL+ TqXfCACi1799LIO2MZHO4ArEYpeM/4zZJwTZXyCEPQpNBq2jIcM/l4EcISZVbJ+VgXnV/BW3Zck h01rbtzSbxoHKyQ5mpOCp0X3P0O6jR0MUEWukPh0gIt9p/3QUJ54HJmmZucXV1y0t0h8D2dtr39 bzeIM+WhhH92ea4zLR1XNwZoTxnDuy/0NyE+hMnuOtUwYSCO6LiI0o6ZfwxEmbTkCeAbQU+MYo5 5icVKNJBq42Skemaaiiudyp7RXgbi2VogKl93o/HE7o7OYYgkJVdy8FEVuPbCnJMDc0mu9JMxoq j/X4Z1DNLwezX8s0w9V3X2EKuVHNkWUASb7HF8BPYLTqcSQx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With CONFIG_SERIAL_8250_HUB6 configured as module
(CONFIG_SERIAL_8250_HUB6=m) the cpp symbol CONFIG_SERIAL_8250_HUB6 isn't
defined (only CONFIG_SERIAL_8250_HUB6_MODULE is). In this case
hub6_match_port() is defined in drivers/tty/serial/8250/8250.h as static
inline and in drivers/tty/serial/8250/8250_hub6.c as normal function.

Use IS_ENABLED() to also handle the modular case correctly.

Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9d1068d0489d..fb9a7117d145 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -334,7 +334,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
 static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
 #endif
 
-#ifdef CONFIG_SERIAL_8250_HUB6
+#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
 bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2);
 #else
 static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)

base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0.11.g153666a7d9bb

