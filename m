Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FA26E6E3
	for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665993; cv=none; b=Xcw3N6mYGiXVSgevv0onMZtnVMbFquGd/iMaHPEQCIly93kJSsfB5eqfIVLL4SYcvbkrRjmUXaN3eeh2O8EhSv2bJ5XIe2MQ5288lH4He6u24i5641dBQUZAT3miLU8pCSafS8EZmnKzocj55pfZglR4Obgg+45SkcwGPsz1m7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665993; c=relaxed/simple;
	bh=kuspQguKDMN2QP07Ofn/e8FxPXEd28GZFNAFhZqNgXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/qnSCaiJauG950g67dA1lm94g0K4rvD+z78wnfOdTcNvYp/puzIv1V2/H1yugd33Q9AM1N9p1swlAKXg5EUij46UjcuaPMqVvcmhCGvpW1/iM1sR4IEqd58zsumSXprQLc01+Vf0keOw5+xS4AlBenY93hC1O6BnHytELsygoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu; spf=pass smtp.mailfrom=iwell.eu; dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b=JRsbc8Lz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwell.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b="JRsbc8Lz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07883a5feeso1206323366b.1
        for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwell-eu.20230601.gappssmtp.com; s=20230601; t=1758665989; x=1759270789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZoDAc2wyhln1U3oJuCYDkDreDeByhBAvuQoDZOwjao=;
        b=JRsbc8LzoWJwCsKiJq4Aq69W/JIuo33PBqrfTpNfx+32JmAtKbPlVWMWe6D4teO6kn
         pBHwwKy3HtAV/okeLhnLL9h6au0bllR2l+/KYhtOq60kyZ7If7zWhTDfyvdE9tFv6n3s
         SjB0SuhZXL+JWL5svwkTl6s1ObPklz6g4n1ADBG3BUFWaZyT0wwxYA52xTYBWBxNnY8C
         cIzAw+6oIIClTziHnqDwkivpdezua40Q0ZPk4YY9bGT44vRRN65H16HQZlnj2l/Q/9kK
         jia88MzZgdA+waCml5wolfcL5pWZ6JmYkBKZQsWSJSke6gV0tcqRLsLjWbCGdb+ZFnY4
         /Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758665989; x=1759270789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZoDAc2wyhln1U3oJuCYDkDreDeByhBAvuQoDZOwjao=;
        b=mPax/hrVTMCyRY331esq4JeIaD9NG9D8myDaU6lw9BbtQb0d9zgF81YWDxf+Rbu/I/
         nQtlgJJd2+BddAsm782qlAcGQVNVglHaqfsNZ0aiEv3HtoOpPWk8hCMpUkdi1j9HqmY4
         w8JNzcBQ+sxTGITsp82vD88KrOyAF78TK6yHlYcmp7/8/WUwMADvffIDfME2o4idEagq
         ACLT2ZJZDmajBP7R5opTruCJcoOvleMI38R4AsL2vmC+xp3FW3ESbDfyX2FgyyWqNFU0
         xGhpr8zL89112m0cfXeSGuqfDOmmCRFzIlnmj6EEh0hVn2Bd3bX3d3rmuJBpswoQ2Kgl
         NBLw==
X-Forwarded-Encrypted: i=1; AJvYcCXQn4WTS8TBfZiwHrdPTp51v2KBN407E9TI/Lxdl/OueEOyLy7HTO+klFe7NUVkT71FggwesIeYxhMW+Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWB+ujlOjxGOAcHrmToKNOWpU9ui5ZOLMaB0i9qDF3/+YOBJm
	DArCll8R0Hv3NAdZttjqg9S8Fh3In1nobqPG8OgL+ID3qP6sOZOh9ibWnVSGoMbd2fQ=
X-Gm-Gg: ASbGnctZFENDVE0ym1UAwK5NDygRFnSSwwoI2j5Kw/WxEHWC9XFtbBk+t3G5UCHPKEn
	w8kefQLckUJKEJ2SheaHNwTsSyRsGTNXT6Er7J2SJjywuaAZ896gBk0GDRLPsU2PQXKCoCDmTU1
	ZGxUTVk5ERX3z+tLMAz8FInCeLRONsPPuQcioCVYiOmWCq1gR7eYxumLSUGLCL+hVhPRKHobWW7
	AyK1CVOO9ci+tkJfJEM/QTNlbkXc8Dse8ITbvCWqKLB/rw07q7iuL/E6PGlrppe7IwhieATHR+J
	ZxUfzIobrMVgKODECK1JcH8B+z6sclOZtVmzLRZpBDa4IixF6gCO47VNOpsqBIONNYIE6vC6tey
	jXhBVL1vZpc4EdhU9J0+uHD3FjbuW4Uwd5MglxCWxRpFwhP2TQFrE7reK
X-Google-Smtp-Source: AGHT+IEzCEwbixWOf1mAG9edDAoF9t3pu71R6SaOM3SQN+LM7ZMPhOBWU5qdpOcyem+S8HdoFV3sDA==
X-Received: by 2002:a17:907:9627:b0:b08:85d0:3d8b with SMTP id a640c23a62f3a-b3026e7495dmr394989166b.21.1758665989378;
        Tue, 23 Sep 2025 15:19:49 -0700 (PDT)
Received: from localhost.localdomain ([178.224.220.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2c56c2389fsm581187066b.79.2025.09.23.15.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 15:19:49 -0700 (PDT)
From: Marnix Rijnart <marnix.rijnart@iwell.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Marnix Rijnart <marnix.rijnart@iwell.eu>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [REGRESSION][PATCH] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Date: Wed, 24 Sep 2025 00:17:33 +0200
Message-ID: <20250923221756.26770-1-marnix.rijnart@iwell.eu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")
introduced a regression making it impossible to unset
SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
unsupported. Because these devices need RTS to be low on TX (fecf27a)
they are effectively broken.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
similar to commit 068d35a.

Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..a9da222bd174 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *term
 }
 
 static const struct serial_rs485 pci_fintek_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	/* F81504/508/512 does not support RTS delay before or after send */
 };
 
-- 
2.51.0

