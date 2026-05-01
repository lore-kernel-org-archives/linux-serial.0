Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D0329396
	for <linux-serial@vger.kernel.org>; Fri,  1 May 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777623227; cv=none; b=o9j9nLNZQU5PkTUzqOiGrxv7ig00e7vsTBOFaN4cJ1T/p0Kqu1hd08L3HgqNbEqGlWtgTGEIwOpJVD26EVPVgtf5l+GdjSVCkXOFUvcUlziVKHpkRs/RgmeY+Pz5PKC1KWopyy1KT2mnvPVO4kRoEpgyKXRlh2xc3hxwz4kJzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777623227; c=relaxed/simple;
	bh=AJwlfEaaX/yrI08IkxPQwsfMAMNkH34cz7SxpxQJIkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9T49z+6GhhY6IVXfmfKh2wCan4L5BnG8uGIUiqpL7NEmr3vcI9UYnrlREsIniUqb7A2c1tijHpcxEYn7+32PlXcB8byE0cGa6aO3FOcHpZiECE5yWXx4bqBl28ipF50r6c5zJZdW1OnVYejLHlYvk7rrqOxmQp7i8ArtwXpuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD3UqwgD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD3UqwgD"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso278055a91.0
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2026 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777623225; x=1778228025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJy9JRzzea0MEbuvCcgPyf18aJdET1ySFm9JDivNUQ0=;
        b=QD3UqwgD0hqVaJT4kTYUouennY45MdvTRp0LdwO6ig6DlX8asvWKirBvmWssMcQEzF
         62XRX4Xgas5i0+WhGpph+i0EqVTbl+h4XSJWXAjtnxA57Dx6huIzm4alqyk8Yv9HQ3ll
         PAVOnbN07m8b7Mb3/eZ4cdFL7D13VF4fu9cn9r9O89VOnU4hHkQec0KWB/mZ8ncAmQ+b
         eu/RGDiLHiQ0MSaLC+/haOgyNcIOqCWLwYu8hqvQoVx72sh0Lkt1/kfjNDe2TiKz5JvH
         BJp2bduBeE+JY9OItVoa6qMFHxxII1davL+Yb40jrPLPxoG2Up81KwapP5hYiueqC98U
         IXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777623225; x=1778228025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJy9JRzzea0MEbuvCcgPyf18aJdET1ySFm9JDivNUQ0=;
        b=Y+hHmnh1Rjtngo0LB/YunP+egAU1nIfOxSfcT+Dl7eWeIJ1VHJpAMvtR1XU34EzTBt
         2YLnAe7gXOI/vfrE0h7Iu5RtaazAxgefN8hqkmJGL8XlhzaSaxEdByDjooNfLcPhxBOI
         lmV5Q9Bu1QX8WQM4eQwoMbgYGsXVHEVjpzqB2vfgFaLYz5o9rCJImUENUKYismMsrdS7
         PxIbv4rICVGV5Tb0rOjz2puDa7sHNegwj5lhNtq36MnePZd39teEXszNefkXHE4FuB4q
         3ws3WsYScfTxtD+TZcYqc991jp00BsxNePR46T8n8YGso5KssSYDnXGUFxNPINdCAwLx
         7ywA==
X-Forwarded-Encrypted: i=1; AFNElJ8fE0slIgz10X8w8NQD5+CB45pqCRerTk11CRK4OPldcr6UBNQU5ZdUrnJN4Po9EKdARUw5kQoCij/34WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13fHlH0lkTgZqjt5ddTEpIh+2Ew9dE0LfkTBTKZWZxL/LePdk
	2JcHjk0jx4o6s5L/Uafh2XFd2O6vWZ/mn+L+0Z6tHBLjynzYQPgiuu2E
X-Gm-Gg: AeBDiesd+ULjihoaAzLx0bs+CKLbL0ALTIHHjF1xvHSZ4YXGxfuy1ywwjK39OFJZ4SB
	+NOejb7DBOtnL7Y1zcWEBNTUSHrasBsISjte+Q72cQ2ACbUoeQ5HpFCZAZ3miQ57Z1bq2D5inH7
	aB2XJX0GBfyoOTE20FIMAR2mNQ/u03uCWDkbL0YLucXaf3ecdpYc8S0JQF9zDOjPfTPa7aQHlJu
	dTunt2YtribJGSuQKJ63tkEzWw+tqFacfHQAZQbL4qZ4z+alEa53gMKJqKpxomtyqb6feBcRm/1
	UgdujKUHzNOnU45Tizgz7GAG9k5qOYjKzHfYweXu+vYZvwobvsBnFNtF9ZN7LELiwIau9c1NqIs
	l1LZxdkIZFWCr7s3VMYF2pmscrrl0A8SNBIMP1eTTAo2L12AN5FaB7z30G1pD/SdIxXPuLU1PS9
	wenco3uu/gZxbAvfRQe5WgN6sToFmBvJ2SczRKMSstW3Zh
X-Received: by 2002:a17:90b:3911:b0:35e:5929:d78d with SMTP id 98e67ed59e1d1-364c2f0a149mr7040037a91.3.1777623224810;
        Fri, 01 May 2026 01:13:44 -0700 (PDT)
Received: from penguin.lan ([2409:40f0:11d1:8c2a:613a:7c61:540d:f337])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec03c944sm1551734a91.15.2026.05.01.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 01:13:44 -0700 (PDT)
From: Rakesh Alasyam <alasyamrakesh77@gmail.com>
To: richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rakesh Alasyam <alasyamrakesh77@gmail.com>
Subject: [PATCH] serial: atmel: honor CREAD in atmel_set_termios
Date: Fri,  1 May 2026 13:43:17 +0530
Message-ID: <20260501081317.15477-1-alasyamrakesh77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignore received characters when CREAD is cleared by adding RXRDY
to ignore_status_mask.

This replaces an existing TODO in the driver.

Signed-off-by: Rakesh Alasyam <alasyamrakesh77@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5d8c1cfc1c60..5b062d8ccabe 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2184,8 +2184,8 @@ static void atmel_set_termios(struct uart_port *port,
 		if (termios->c_iflag & IGNPAR)
 			port->ignore_status_mask |= ATMEL_US_OVRE;
 	}
-	/* TODO: Ignore all characters if CREAD is set.*/
-
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |= ATMEL_US_RXRDY;
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-- 
2.43.0

