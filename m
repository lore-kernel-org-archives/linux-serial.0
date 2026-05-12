Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B144345752
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569336; cv=none; b=MReeks+tKcNTtp7Fa5H83N4tSzABsMadFLJvfxqZ5wZuGFXZpk8CE4ZQKmLSegyLsUtoRzJuKNARIAZ73oEz37HTqtF2VlvUrAe0G16HkAZnnhNzLr4rtn2LZ+PDtwQuifltnY7AihSOVQqhudhzfbJ8WBLh4TLfgf1sU/HcJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569336; c=relaxed/simple;
	bh=zt0B7Jo7Lvmb5XTSLfP5bdnMkYALGEm2GSCOl0p8A4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PD3/V9N+XlO3c0vLnwGv8SOIS91aO5FxTmhtrb0nWTe2DsF5mnKBOYQXxD1DXQLXsl16H1keOk4mnYC5srhxJep5uRn6GYsL/Fegpg+0sZ6BfempNTAfSwjfS+xN0D5Eo7Lm34siAeN/VcKZTuPgCHg1I+y6+U1y7x7jwAkaiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyMb6y0W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyMb6y0W"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaed195901so25167995ad.0
        for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569325; x=1779174125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3qKjhd1X6fafQ8IlizL6dqyB99X77F8kgo/x1i07BU=;
        b=nyMb6y0WIrb0a/Bke/CvMo/aWn0ReTMevtDlGCp2QmlBfoDmLzTYF51FGtP91poSpg
         DYeBMIhwnTbuW0EhxUk9x2+aJ1mp/ZIMoX2W533CLHNt43xnQ6X+ggAC7wavvo00CHi2
         CTqTo9Okc9ALQ9o8Y78M1xtpgezN/RQPPiPQLEQdBkVMQ43GctduC4oSqYosJ1Vyk7Q3
         RRjIlJ+QkE61A/G495Uk0uvQsmzMGQivBMxG+y6S1fQNyB7AVaIrmpGqYf0M7ZEE/phI
         RZamUgbSPgeR0Z+LeZiMduGgdV+4ti+6cpgMqAkA9kwIykBX20GFgVCCsxE52RXIkImW
         CAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569325; x=1779174125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3qKjhd1X6fafQ8IlizL6dqyB99X77F8kgo/x1i07BU=;
        b=tVMFMUwHxqTtXNiZw4rtGg6Y3p9sBZ2Xjy43Mzq9FogY8XW8dCR5brdF8JUquy5SHG
         Ub91APDAd/lEIu0A/oZFOV6AQf4J2Lf8T2sTn735T/cSxCh99KOGhyMQ/S46P+bvUqTp
         mF+S6809IWqmR257bnbHcbwxsindocItE2KcmCKw7ImDMPS+dU/Z4MRP1JEWRkxrT+nz
         9yOtMXOGYHsyLs/8RncI7aSP4pICxXkxvbJUjdHSrhnp1T2ve++zdbe7wcBzrtPrntkJ
         oyh6faaOAGI6LL63mBwJnJ6Hi1JWJyLDKZXhBx3WYyWrLiwt6X4C/XL+OAqod+pC6U8x
         kVmA==
X-Forwarded-Encrypted: i=1; AFNElJ8Pqas3XNb4MfyWESG7jdJsQWe1zR9fTI6Kv6fZ/lSoF6XKSdnp74jDM0cyBTj5POMUyRJMjhx+o0FZjHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0q9p+67hOzeUsZ1/9uhXSGJpq8AewXVX+7P30Ezm+HzyLlBL3
	ISAiLfLmOR2am9vU226oNiwklpQIAdEEqHxtfCLacHmvW/psMT6p0cw=
X-Gm-Gg: Acq92OHMKtvogVp+NefqS0XlmjVDUKIEjCToibhzZXlpHwcyTQnJBvVznJbaja848rG
	kHQAfMaoKWyvFZJjd4rxSqQPQjHUSw8EeR1i6Xuzv6CfjinKDtXw3OlX5x1QK+Hr6fRcqIltjRT
	PCuoaly6iBZePaqbgBX837Umemg9kYBCYE9TkcQt44S5U6d9CtJWwE0xCMSEhujkfO3DMw+XlVV
	JlRS9xqVYojgDxLiASkCFC/TvNAGwpY27opmoCTtmfTaPdlQdN6DfPj+ugOf2tjBpvSTy/QGZij
	Uk4XORujL0Upy1Wl9rk5RTitXLB88J9EPGhj++1CcG7p09+F0pZfoe+dUDs+QTmnsXc3WFpowRF
	jDq6qYjze5KT8qtKikzOBDX8gqEAlFwzPftav2YrY3dh+cCQ61jr+gxFqR1dSZSOr+meamz/RYg
	uYA/hx1mQEfgF+PV1Y/0arVQZCwiDiFGo55/53WgvQY4KCIkyhXT8h/94rOSjC7A5j/TKOV4WST
	g==
X-Received: by 2002:a17:903:283:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2bc7a9c7762mr131236155ad.15.1778569324707;
        Tue, 12 May 2026 00:02:04 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27254sm123293635ad.4.2026.05.12.00.02.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 00:02:04 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tobias Klauser <tklauser@distanz.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] serial: altera_jtaguart: handle uart_add_one_port() failures
Date: Tue, 12 May 2026 15:56:57 +0900
Message-ID: <20260512065837.79528-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

altera_jtaguart_probe() maps the register window before registering the
UART port, but it ignores failures from uart_add_one_port(). If port
registration fails, probe still returns success and the mapping remains
live until a later remove path that is not part of probe failure cleanup.

Return the uart_add_one_port() error and unmap the register window on
that failure path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5bcd601049c6 ("serial: Add driver for the Altera JTAG UART")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Drop the unnecessary port->membase = NULL assignment.

 drivers/tty/serial/altera_jtaguart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d47a62d1c9..20f079fe11 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -379,6 +379,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -418,7 +419,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.47.1

