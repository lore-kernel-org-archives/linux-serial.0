Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173D428479
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515350; cv=none; b=gst5GLyYMwRQLwsjTqMCv/uB81xqXkGqMTLUJ14cNOVY+iJ8iDKhp6R1Kh+askVXVrKS82VZIQOHYY/Hh04bg+q0ZGoBd5CbK3iXYftfhaYtigtpHwJN1vvKG0pmNkJrzkJz2DXs9K9jiT77i1YvZmgiN9s2DKW/UpUmr3aQE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515350; c=relaxed/simple;
	bh=t/P7Z49j7jC2N+nDAB92iUJa4lhWPeZSzCHL+GWIaYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4t6+Y0w9eoLXkc2UY4uSVso6IOYt5Y+LS1kddfltvoEQ4l0RmawnzTwW0DGbb3PInI3Ir+BqFGCey67j5lQ3V65r4ls7Sz7Xa0z2/tnzgc74kM+rNnuH1wVWcPLNqDrErdiU7wkilRY/lHtVLiAl1mtiiVaeBDzTcWjN1duVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA+7X2j2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA+7X2j2"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8028fa6039so2887868a12.2
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515348; x=1779120148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x/mOaa1dJhywLuUhoro4xsZpsIwTtvbqXZ9jlO2CSA=;
        b=SA+7X2j2hHpcmlyLyUbwYdZzq8r24toSnS2KrEyYauLLleSI0AuAm11KvRww3nx9iQ
         vu78qk3jbvXxra+o42MT7wN9TgfbMHLU3D7TZOysPvYQPp8wq32NJcODeGacwaoLciwB
         juQLx3jRwoBcLNxr3uvpdS+bOVrOwf6VDoMHqyswg2EN2cbCkNztkIWEhf106+SgOECZ
         3uiFNVlgDgzedD05ehHdbga/5huQeS/CN7dS3zy2WoYBalvhHvKVtMHzt/fp7UK4T/X7
         3OjPsmo63ltE6PVRNSC8ljTMJJcMuZgtx+ACBWaQFBUw+9NtyUp6y+0G6rDM893miYcp
         ed0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515348; x=1779120148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x/mOaa1dJhywLuUhoro4xsZpsIwTtvbqXZ9jlO2CSA=;
        b=NO3yrsea0XGCzroHpNFyXbE/g9SFywPZlt/dC3rOOaZctQ3OKQc5XMoFqmXMNYXH28
         sQEiYrqyk1/SHFfW1o1VuvjUfvMICWzREMnWaEduOIohCyYrAe+b1frvQIrZuLSuhLxM
         sYtVDzZcAO5p2QA3ph3QUPSpm3VCxWNJl/PNYG9++uB6J0DxBrmwFfc+GgzDnjGdPmFy
         Yicx6FRagKYiLOfgrnKmvnyg8lvUHbLs77hXhNzM56pBGbj6KgjeU1fsmsO8LBsQRgMN
         HUrTrnIJ61tKc1T+O19BS/t59DqZt7P4jwcS2loi4a7WLss2KAldjLJjXkSzPbWFhIsh
         W0Mw==
X-Forwarded-Encrypted: i=1; AFNElJ8yxoJawBs1D30hs1TgMrrmD05b9iHlK+yO6yowF5PkEauC4t4Ol2ENFOiAzGjzqircYg8ynbp2wLqfAfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9ohNCO1QkcbnhztKc6wtzjV7GiiloIu9PiJ+RNOi+PJrD+8e
	hT17q0CGNGoSXEIGIpbm07Udhr51NMYBMfOhX3VdA45Fh6LfaEB7tGRe
X-Gm-Gg: Acq92OE2qbu7aaalQlN+hocZ8jhfDYL/xSWjQviOhaAqH0op1fnbbGeUBOVx2eqes2h
	3yRAIt1D8Leflv1w1TM/OvRvzwwTyczuQhTVA0I44Rf0dCrBARdtmoxtLb/calizAExzJMqpyr2
	PHmZ7dZmsWKuwFeStPZBhQ40STLWxOPoB5IRRczCUKlWLjLny1Gqu7LGa4HqgJgQQmoE0kit0D0
	2jOAV2EXQ5DN3hFCpofJL23JY4HUAx0qHU9XPu7SaMuAmIug3htEFjNPpJ+bq3lUC+dVN2gRB/4
	0lp9clYX8Bx4g5a5MvCOyw8Cq6aWt465y059dNd0PGWeWI9B7hwXp5U5Ai24O+YuP08F0P4DAZA
	2An90SBTXeWI/zin3+BbgFGFW/jEQgQP8lzdWjV/Qh5Jyf8XSrm7h/i1dWcx2UlYRgCd8DqZC6U
	BYV897gu/636z9fI+/24EIQayD/YEs4g==
X-Received: by 2002:a17:903:2904:b0:2ba:85:5827 with SMTP id d9443c01a7336-2ba798d3e99mr180279745ad.26.1778515348035;
        Mon, 11 May 2026 09:02:28 -0700 (PDT)
Received: from penguin.. ([2401:4900:cbde:8ff:92b4:bf0c:6a0f:7ccb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40a65sm108036435ad.20.2026.05.11.09.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:02:27 -0700 (PDT)
From: Rakesh Alasyam <alasyamrakesh77@gmail.com>
To: gregkh@linuxfoundation.org
Cc: richard.genoud@gmail.com,
	jirislaby@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rakesh Alasyam <alasyamrakesh77@gmail.com>
Subject: [PATCH] tty: serial: atmel: Ignore chars when CREAD is cleared
Date: Mon, 11 May 2026 21:26:55 +0530
Message-ID: <20260511155655.26435-1-alasyamrakesh77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026051106-obliged-dismount-d85f@gregkh>
References: <2026051106-obliged-dismount-d85f@gregkh>
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

Tested on hardware.

Signed-off-by: Rakesh Alasyam <alasyamrakesh77@gmail.com>

---

v2:
- Add blank line before comment
- Tested on hardware
---
 drivers/tty/serial/atmel_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5d8c1cfc1c60..5c756dc904b0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2184,7 +2184,8 @@ static void atmel_set_termios(struct uart_port *port,
 		if (termios->c_iflag & IGNPAR)
 			port->ignore_status_mask |= ATMEL_US_OVRE;
 	}
-	/* TODO: Ignore all characters if CREAD is set.*/
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |= ATMEL_US_RXRDY;
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.43.0

