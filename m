Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC930F55E
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434615; cv=none; b=QxI4s7y3BO9Of94ISKVqJvslU9RaYhxXbjnvhlX123u4a2QZhT/u6THQoSKESAqr84xG4PT4107FOAVLHlYKA8uUDqefGnWNq/fqGUyVCtaR6WoDr5wgs3GkTRvC5VxBXXaSjmjAfhkT+npbZTy5XS0GNvJ6RYIfHIJ8vyKYPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434615; c=relaxed/simple;
	bh=B7v9qrW+paFhlhLozJ6lRj0AyNxXth9PHBmIByVEUjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiGFOAmonLFuksmtCbVHRTjoOoD+9FrHkpylacuohPj4JAVbpJAis7Ccl+UMR8jg4+Y7j/7QGaFn0e3Tl1Y10pFNXsjR3YPuXPWhIVBJKj0VgOmbpQpMnkkjrcbIzDq7jgPXNd0jXnKCmWgTjraE2GRNTsBdsgEtDWBuKvSmlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1xEiAYQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1xEiAYQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so169889f8f.1
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434610; x=1765039410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bPqYF9HDpkdMmik2D0hgGXuyr4x4ACsXKFxzvuy0gs=;
        b=E1xEiAYQ2C1PazrD72ycPw7SLh4D76mqE04qlL83CHBwHGDYC3W3kYCXQnXqOpb+eV
         mM3rYbDBLElRwLRIp2wUjuXRh9FkNhkLIuxtrDXVzc8q2NhNTLrTc7LCXB0cMUL7IVoH
         YZXzvYLzXJk7Gwqli5HYIKk1mAh8XcVBw4fJBT6Zu3ETbVt03reJf8QJwk8Ik2Pp/Mgh
         WMipaRZcy2m+up3oG7OMdTitxnL1jPaGlmmJm5t3FAZWJSd6RKPVF5j2BGp4LjFqAZA8
         reDoBGvLMjkI1auSb1vzhdMMnvWPtc6YNMl8KrVoe5zGsek5eG0RMHcu6vNreFBngUfr
         FMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434610; x=1765039410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9bPqYF9HDpkdMmik2D0hgGXuyr4x4ACsXKFxzvuy0gs=;
        b=h1ojROEKlNClL6ZCFGpPRWa4GeFikp6cq0UBcoUxB518TflwQI61lZh0oZMtW0WUtl
         AUNY+vpjADTGgxOOSn5iq/42EdG3fnRc03L7h0WBdt/dR8JJER0D+I8qptvp3IfjN2g2
         FgdKWnIqnZaJ7KtA5yNQ1ETjHdVWnO7Js48BKWI78t1tg4zl53diNVmbcCqhRH1frJuD
         wp5pquUDXPHpDbBLP+SnDEBixslnwaUwxM2MKb6y13kjKKB9gZNRw1fg/E3REvjayqU6
         EO6y8htds0IVk1f/XEcSm4pFpsdDj9cPKAYksd5JX4AOuuTDa2mV7gSI6KyyRsMjDB3g
         RdXw==
X-Forwarded-Encrypted: i=1; AJvYcCW2WRN+E1tAbrjiRMG9nyBor3Hs2OOXOY8gI+3m6ukcNHac40AcTaH499FxM5WjOvgY/cHUwdPeCgXto4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxNDnMy9wRG9f+470HvBrOJCXXIPbhlrgPT0FH3vo/jxQ6xGF
	5WGo71xxprO3F5wYmxWOOOgW8TEauoN2UWj+T5XPuY2ynkgPAzhH/aCx
X-Gm-Gg: ASbGncsXtR6Eh3o27Wq8Edt3eALMzKrf0WVC1/PZCIMysHYVqu6l3rqoXk/OVH0EihH
	Nlqq85SXAyKgnl0iwtjoqR5n2ycqGyqo00kVT5UvVCE2t+w5V3kS5vjsxni8qObx2yAwRaT+Lhh
	txUsjW7/Zephq/9CIvaBBTOIGwvv9lJcpyQfSImcRP3o7RAGwmB+ZN5/FN8yUPxU7UKPA2SVWLW
	xPl2CpzhS5SbH6QfYKbBCeV/+q40/kzExX2HjYFQsD6RYzd5HWOyU39qV9scpETK+ISMqiK2Q5w
	tqwqgXHfwUUTgFPcRHB1rZZmQBiO92W3ywFH+14x3I7jLe0aKYD4A/ZdyjHVQK5VfCBUr0DWEVq
	SQxroQdg8KUGeTeGNnrIkveClPh0J+hzVB+r8w9PeH13C0Hw1au1Tv03GOrg4PdM2YYsxOJ18B3
	gE0R2dH+QRfEx/f21Ro/22cMs2ZnOnaXczn+zegASKY6CnGkw41pi6cAPQ33v3Jm3Gdpg42wJ1s
	U8adqHISZ5jOT3G
X-Google-Smtp-Source: AGHT+IEEb2qZ0UYDHUie4Qwc62VO5FnkQXg1w3EqYcfeQhWXDStHqlNvLIDNuNrRiYbDT877KormhA==
X-Received: by 2002:a05:6000:40cc:b0:42b:3cd2:e9bb with SMTP id ffacd0b85a97d-42cc1d2e29dmr33566362f8f.32.1764434610050;
        Sat, 29 Nov 2025 08:43:30 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:29 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v5 02/17] serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
Date: Sat, 29 Nov 2025 16:42:58 +0000
Message-ID: <20251129164325.209213-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/T2H RSCI has 16-stage FIFO. Like other SoCs, set the default
rx_trigger as the fifosize.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Updated commit description.
v4:
 * New patch.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 53edbf1d8963..28d665a9861a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3330,7 +3330,7 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->rx_trigger = 8;
 		break;
 	case SCI_PORT_RSCI:
-		sci_port->rx_trigger = 15;
+		sci_port->rx_trigger = 16;
 		break;
 	default:
 		sci_port->rx_trigger = 1;
-- 
2.43.0

