Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4475391854
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328385; cv=none; b=P/He6QqJ9IFYnelJF7og1y2oA5TGtChxgcGba3NyO041xPkZGZF2L1KaAgKNSffHcXb2PfEFpCHHvKD+g0vdRvE1WQNTUQVNZAfunJ5bwfng1Im8AnaN8LNHPMnqSNwKjvpUMHpKQ3a94A7e4xRzrWqibeXsimb2MLatCVhODIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328385; c=relaxed/simple;
	bh=A1fxQVZSsEx64SGWOmsIpHCEl3H8zC+buug9pDZnkOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xs3p76B9/p6GUumjHBvzqQ3wKI92IShWRMiaFsY9KWAFTHKoAbF3CfcZxKq8AGM9poaA8hn0h86t/zvVYBb4x71ZWCjgMwd9t29ISpUhlIDvsYD8cHTWoQ1S7DnRAl8KyqwUw8gWMjrwD/fAmLLfQxk1fywsLo//Lm2t9g1xOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWBPS1+J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWBPS1+J"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso3756725e9.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776328382; x=1776933182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8KwIRBAxcL/Nko4wwgY9WARhqxl2Sh933ZVC+mUoA4=;
        b=eWBPS1+JpqSr5JBBovqdarFwURoJ35YWYAC6pccmzup5sUX4ooIt/L4TVsoTCp4jT/
         ul14k88jNA7cM/cRE9fyOs1WiCz7z0no6Zq7XaaKxmSHGWflA++C+O4c8+zxFJeUvOig
         JMsWXby6d8ibTm0Uaz/jNxtXfhy9jgXGsrXQ4ZiAq89kgL4beRbDoPkP+OG6WLxi+o1C
         YYatYS5hxgPyP0OE5+eK7qpWwxGLFOpcAJzNHhJe/R1pUaQ4w7WNQ9qWrh82AH9kM0Gr
         pF/qqYjluqqEVCwR0GnPsSjCwHqzjyzsCHZxCCEWL1rlQbeuWfYBdThe7uqAl6fa/Gvq
         G4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776328382; x=1776933182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8KwIRBAxcL/Nko4wwgY9WARhqxl2Sh933ZVC+mUoA4=;
        b=gGm4Tns64D9MnPUnCCuqbOIttqWzcMnK36nJhtrgoGpMp45jsmY+7b40LYfBm+uS9W
         OrpQw3CoC2NnBkpjegW8t4DFIft4SQN8gMp6d8mO7HbI9HFEIk917IFq4BP5TOnBXtNP
         nTsTBcsrxkYquvItW7zdEgbatbLBnsjaE5Uq5IHcze9Iej88pAFgfQ8wkAtYd/wE+1bn
         WOxo/xcy6kShn//ANRPDHAaXXQdBI5A1WVudE8G7w0xUnU7QcMIT2yU9mo0chvkRCXwQ
         INaIyEMtaHsd2dQiYfF5vowSlr1Eudmu7UuRPz7ly3YhLkrGWcm2cHRdZc6+gavGNSfS
         j8Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/12jk2l79/baIm7LMveRAHxnr0/lG3C2jIKn/NTJwiPAZ4zVsSTV9LFg4+Z3srpsLfA8PfjZsvC4jSD5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTC0CiLga+6xWkvaxioZb0vyxXy1WbuYTbEXoP45lscytKDH9x
	qJHit5pZFXmUAtuPVo/vScFPST44Y+MN8KdfscvuT+WoMN/vNbUd7WSA
X-Gm-Gg: AeBDieusaxjhRk9IkKK0VoGC4drJwMredWuXgzti34VUlaYxTbuty6P/JQvQ8vjyjel
	DHaHz7/SA/j+oWwawDTqg5rXKgU/lPmxXdVg3sN+EQNVs347HUiCaPaA20YN4KplJC+NpvNJSxL
	hFaAiorH45mih5uJFg2COIZmdeiyqpOnorQzUTRTEu5cPzUh+r8d9etyoH8y1gdlTdZgQzB4gx7
	WJ8MSm1N1ND8Is43ejc5/xQ+TzSLtT+XeU6GT+khk3KSZX9NeXuwCeajhUDGIpFf7PH6QFkODEA
	ifVlEskPmxY5Y+sdbtb9xlWBfZkMXlwYmZjFv6xpPdQV569XCWWg2HflkiNwmvvSn1l9XjhW37V
	rzWCoqUET5u2j2GXJuoIiM7HI3G+5DYQV/Rf1uGrNAhaVMw2hg2Se95XR0+Yo3e43f5ZkzEV6nv
	a5v4uGfzweuWNXrzt4bbA7raNNrMyrNw==
X-Received: by 2002:a05:600c:1549:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488f4823c3dmr34362705e9.13.1776328382058;
        Thu, 16 Apr 2026 01:33:02 -0700 (PDT)
Received: from fedora-dev ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5854097sm41107735e9.12.2026.04.16.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:33:01 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH] serial: mxs-auart: Compare the return value of gpiod_get_direction against GPIO_LINE_DIRECTION_IN
Date: Thu, 16 Apr 2026 11:32:54 +0300
Message-ID: <20260416083254.1798-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO_LINE_DIRECTION_* definitions have just recently been exposed to
gpio consumers.h by breaking them out in a separate defs.h file.

Use this to validate the gpio direction instead of the hard-coded literal.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index cc65c9fb6446..6c6df4d5c21f 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1519,7 +1519,7 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
-		if (gpiod && (gpiod_get_direction(gpiod) == 1))
+		if (gpiod && (gpiod_get_direction(gpiod) == GPIO_LINE_DIRECTION_IN))
 			s->gpio_irq[i] = gpiod_to_irq(gpiod);
 		else
 			s->gpio_irq[i] = -EINVAL;
-- 
2.53.0

