Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00315149C64;
	Thu,  5 Dec 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409040; cv=none; b=OcZyCgOcrKRN8V2sJG7Ionr/+C6vQi9wsGydSS2l2NIE75jDHOt1M1mP6PTjlVljdkce1YbhBVBcYD8Bn8pMDGDSY/Rt0U250Bi6gg0ivWrEL7xrGPBsfHn2WObrY6LbOYK1heScj5M0P/zCJS1ghQ9Ah0pXyPXLJnIwtcFg3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409040; c=relaxed/simple;
	bh=OiwgSxQfHlmQ6tROXTRNVk6s2AZzWxI+eoVvuLTacg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nw4xYOnOgB6VXTRJpxzD2Rd8wxg7T6hYGmWfwvgJqxIEhTKrDlQyQyE98qPGw9As65lsfEdVy3J2y32z0s9PDI+J2ui/P2UhrY22v7N8sNl70dtYU9UNkz+w55xhAhe2UIZj5pexTEmT3XP6IjGUfkI6wLvj+UBDs6+dc30reIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arn+xJxO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arn+xJxO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f42c1c38so874955b3a.1;
        Thu, 05 Dec 2024 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733409038; x=1734013838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kthHmfOrOpY4URMvESIeLk3w0T43oHDEXmAro9LffwE=;
        b=Arn+xJxODQisZOp5jmJ5toIQChjEXrDT3ugCt9L85abaRbpiNaHcqZ1IwK+agj4a89
         VBfL0iJn9weoAbOxgDlix/ozR1dsziuR3jUtpEUG2xBQTlItm1lOEZKxKwXBxcDoH+cp
         xmcpH/ZGhDHmB3cynDpBLjVsGYtvEVxENTYWHEruXmTVREn8Et02h/TMQ/WEyfNVwyvR
         IOjmQBHs4PKkWpIDzC2oy9iHppQFIJNLyM1XSiXNo5BzanV0LGO01uBgoIjnAD4ivKg/
         rh9jS0adljLDAhGAe+ALMIG3YHh25GkqupKRYMUO0LDtXDKoTj65+ArRIyMxTRJMBEEJ
         BWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733409038; x=1734013838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kthHmfOrOpY4URMvESIeLk3w0T43oHDEXmAro9LffwE=;
        b=FRmFHKST+eJ66stQuC8/gWuCMsg7ZUEDR9sPwwsJ5TLr800Qo3y01AteWCgGvsBnaB
         b4RxUu0idz+PJi/KBIP7q/DAg1PHi80AhHdGqEQpyp+pa7L+J7/xjfeH6O72z8jxjFFd
         I7z8V2eSGGoAe+2d08K/cV1to7JxPdIEwIs96JGZqz6Te6JbeM6evqmm5l9Zav/8fIQV
         4jAMM0yz9qKg427xS2OOEA4h3Uvn31UCUnmUmZtwBXb8+sxtb6etqAY74Z9EEKbth5wl
         +xgS0QEWvDU2EOmyAcM6s6Btg+Pi60dwMegx52tsTtk2HSrr9RWa7cNJdIy9aMtd/+TY
         LUcA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDJEY7jhbohTvvQfHGowlyodJM4c41/KnmUg2zICNxc3qehnuTvt2Calr9YEro8zJKcgMRlNwS5s1keM=@vger.kernel.org, AJvYcCWEUpiMY4lpM+IaP/AEfJKYvp6TIkDOIaQVlRDL3HQNhicchRy0LXnFzBvR7WHbwhOFlnCOGamHfUBDjAoz@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVgDex8eJQ9/bBT6uHSpTtZWcafQydzBUKI3wv/RSNO7mIhp2
	BUI8QRfG4tRR0EV9uNFQQf3LvXxDU8oL9U2KT7UVWN5J1WEOQQpt
X-Gm-Gg: ASbGnctKsSsip0u6y4yGTN0mgZct0ZdkA+oxZHJmrVtPwU/QqSKx3ZXjx/P9Vihnukb
	neQLAzpN/U12KaDFw5GdmYmNlfhF2hjZR4+xNclQwThjkik6GZ7zqzf5hOgxedVXDLMxl+uYT+z
	5KayJuicdtW3UJsvjJy39v9qd64uV/gFUmp7RIKtTf6yAuLPnS8qhonxlbrX/z4Jvp9K6etaMOI
	IozulehAOXhxdvTjrJ+N5KtHlObWxWUtF2v2sFFlI2TfxPDb5nsxyJxZswhUC4=
X-Google-Smtp-Source: AGHT+IEz0yueMzMGwJH0eHaYecCvXG3wej4zZ73Uo2vwFp0/q3L22SojfbiYhciElgDy6oXiXyZvNQ==
X-Received: by 2002:a17:903:22cb:b0:215:6e28:826e with SMTP id d9443c01a7336-215bcfc4b83mr139711555ad.6.1733409038046;
        Thu, 05 Dec 2024 06:30:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f31857sm13205655ad.253.2024.12.05.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 06:30:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH] tty: serial: Work around warning backtrace in serial8250_set_defaults
Date: Thu,  5 Dec 2024 06:30:33 -0800
Message-ID: <20241205143033.2695333-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
triggers warning backtraces on a number of platforms which don't support
IO ports.

WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
Unsupported UART type 0

The problem is seen because serial8250_set_defaults() is called for
all members of the serial8250_ports[] array even if that array is
not initialized.

Work around the problem by only displaying the warning if the port
type is not 0 (UPIO_PORT) or if iobase is set for the port.

Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
A complete fix will require a sequence of patches, which will have to be
tested thoroughly and is thus not 6.13 material. This patch doesn't fix
the underlying problem, but it is good enough for 6.13, or at least not
worse than 6.12, while at the same time avoiding the warning backtrace.

 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4d63d80e78a9..649e74e9b52f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -467,7 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
 		break;
 #endif
 	default:
-		WARN(1, "Unsupported UART type %x\n", p->iotype);
+		WARN(p->iotype != UPIO_PORT || p->iobase,
+		     "Unsupported UART type %x\n", p->iotype);
 		p->serial_in = no_serial_in;
 		p->serial_out = no_serial_out;
 	}
-- 
2.45.2

