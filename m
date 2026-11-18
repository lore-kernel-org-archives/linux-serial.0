Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000536;
	b=1idqO1Tf0GsyQPYVpmfnkLHDj4YDC6ulux9G4+gkZ7czC7rl38WAL2GWrjXbAGQj7jVF
	 QaLrfhI7O6GAmuTmx9eZpRxX5XsYHOOOM4on65pwgirRUCMa+GrP+7ZNcUh31fr8c4DB+
	 p6vXo0o84SV0sq/rqHSTFayHAqFSnSoOOeOR3psc/SlAIouG5dIrJciLG5HvXrJzZCK9n
	 UNL8c4LaHXt74KGDiFOe5TJn01rLUG0h338jpEERnR5KhSXArOuwVjscRx/v40A3VB4eT
	 g1foX7I9l0lWo0POKrnlYAn8JEGTpDD47K44OXfO9PWLYvSUSG7ULpGsdW6cdSv0eyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SXeroM2jCfcBKXV1NOSG1sFarrMqehRN66QskO8HWNg=;
	b=ZGONJLSdiAs+NJjVvkzLrlul2ywZR84VQleedNoBbkmR/3rO4g9vO1Cl6fpMpJG8N1jp
	 Mvob8VqgEghGi9HFMBSA6cCFCgSsYzpiX9wLKmg657xxJhyb+FAULLksK5ovTP+LgQ8hj
	 wVZUXSQrrBOxamATr23MaNybnNkNDw6/oJ6b/35ens9tIVta3C8n0TiRJ5gp8jiySgmfw
	 bZw5ba/h8bdm1uzbEjsKP5hGvtw2j9s8Shsrakoc/jHQyAFVMc6m/x8GFoJpZB62V65Da
	 j+QXw4eBiIqbIshFyA/SZf1wWZIKaNCCpd8N3ctM/iah05yEp+t1QWpdp7jIQ8KraMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bHdFKU/4";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E460A260C
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 11:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5E460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bHdFKU/4
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso489899a12.3
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000535; x=1795605335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXeroM2jCfcBKXV1NOSG1sFarrMqehRN66QskO8HWNg=;
        b=bHdFKU/4t+asVDt9njDBPNmVxH74MFAD4wsINbAc3XgW5M2Fv7OJDVzO3vtyztUnoQ
         mcxDv7NtU3WYasfNf4dk0z5bnPThVh+BfKP/wO6jgOyndTDeqNKdFhVtubTrRWN4pkqb
         J4vteOADSYMAGg11dr3R0zuaHd723iRHYSCI1YpBi3Fz+Y11hzi4HWc0LjB1MOHkbOMA
         zoWrtzVqfwlMnv4lYQRDjUlFN+XFBp2vUyodeKo/IZC0Qr6dT/2gP9C7UnPJ/o9YSBq4
         isvbbwrs4K/WEN5Rk+roENzMi0YS1j5GDXnLThkMUOLP0Eh9ZL2fUpDmHyHilCkDn/Gq
         mxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000535; x=1795605335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXeroM2jCfcBKXV1NOSG1sFarrMqehRN66QskO8HWNg=;
        b=wMpkbCmzDKri76jFp/Dst61C4Zds9qlUfCxzrODnUj9UM3v5ucybEBLIwWS0cda/5F
         UvkIccOQt9iQgxlJ/o7Z0yHIgotIe50ywNhuJrWlEXV55C7vxyYKJtVMpkDdhx93raVK
         xaD0K1P2m8Dc6LS4aJGgwNO6hEgirjfrWq/1YfBFUkVLIa572GfSICyGx2sSYtkUZK/4
         KZsepe5nmCYy0ogPfQpMN7/bgm480qLVDtr2BXlmt6idGTwRyhjpA2r18E/fTPh6wcF9
         lcnLVOeGEFFJv1ItpGS2ib4ua4tjAtvLm0m9QHwsgeq3TW+1U35EhJeimpx88v2d/Z9W
         /WbA==
X-Gm-Message-State: APuU4Z8VFvkKB/6GbtGUuMZpzh0En75ag9zC+2rFpmExtalrS/Ge+SfM
	SIlL+VQmyki2PAGdlKk33I/ikq9/+QMu/OG+vOtzEhue1AD872NJM39I
X-Gm-Gg: AZFdTZcEZXzkxMSUYKxrDkOhWxypTcJDc0nRlMNl0ecjIIBmrZjfNYOG9MkC73Azr0r
	ESm3peFW40e4uewpG4SPTHa88Xee2MS7UVH90yuTulFTqU0vU1qo1XCo3Mm0Sss5fTHffjogVEM
	VjzHBkF2I9GerXqkNX3Y8qqA8h2Fx9IWM+PknG3XUXiyCbdVoZHMe9Bf87kPz0O6rhYeXyLuw7S
	de16k1ZS8zqiZwv25qHbOl6hCHPZr0DTnO5s/MzKlLw4aNdCKjg+ZzQoo+Zd5IWSd38zx6lowBJ
	deGzeoTPNrdrIPw1hpiAxcjQIPCNi4spERyMxevXTP2/f4DIxOLbyDzPmJ6hfHFKGB7stlaGSvK
	j8hOoXoSn1i3XoxjD3XKjcmurY8YIC6AS5n+eBg80nm1XbE9xtqtLeDANXXJMtZeYMJNgsW/zh6
	3y6iEc+b2Ckr0smzfxYaRKd2A/ktrmAXNO8QnbUaVsyBWLeBswAnIWHTdkInebUWKX+wqkJZu3h
	9CZXIELfBXGyuKAVPPnrbbpxkgawq6TU5URkwPU+GYiviAETHjWVos4EJAgnf5gYQiWsVHLMxWO
	jAQ4jBqghPs/q0uIHkGaLm8QwK2oWH4k9YNM06YUnUVqLqDn
X-Received: by 2002:a17:90b:3c05:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3b3d07b8f81mr2204159a91.23.1795000535203;
        Wed, 18 Nov 2026 03:15:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm8796941a91.5.2026.11.18.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:15:34 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] serial: pic32_uart: don't enable clock with interrupts disabled
Date: Wed, 18 Nov 2026 20:15:21 +0900
Message-ID: <20261118111521.1003717-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

pic32_uart_startup() calls clk_prepare_enable() with interrupts disabled
via local_irq_save(). clk_prepare() calls might_sleep() unconditionally,
so this can sleep in atomic context.

Interrupts are only disabled to serialize the UART register
initialization that follows; the clock must be enabled before those
registers can be accessed anyway. Enable the clock before disabling
interrupts.

Fixes: 157b9394709e ("serial: pic32_uart: Add PIC32 UART driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/tty/serial/pic32_uart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 8407f85776c0..a8010d6b65ba 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -455,13 +455,11 @@ static int pic32_uart_startup(struct uart_port *port)
 	unsigned long flags;
 	int ret;
 
-	local_irq_save(flags);
-
 	ret = clk_prepare_enable(sport->clk);
-	if (ret) {
-		local_irq_restore(flags);
+	if (ret)
 		goto out_done;
-	}
+
+	local_irq_save(flags);
 
 	/* clear status and mode registers */
 	pic32_uart_writel(sport, PIC32_UART_MODE, 0);
-- 
2.43.0

