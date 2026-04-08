Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013973D1CC5
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658074; cv=none; b=ZxxKHKyA8vT9cF4eH0iqz7Kcva44Ts0ks+8ysdKjaGzj1Kp+++wAkxS3fmvg1kg1POSbqbQfoLdAnYggABNt2E9HGJ8zPVE8m+fg9PtZYqpc0RvEeEIJGFdWEKGOMk5vQoUUzMPXgFenTuvjh+kNI9Ciyel7mbM9h7Q5wiXILa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658074; c=relaxed/simple;
	bh=ddrfr3rql9m/sbOnBCJC/YlBY3/WX7/HgB5dY7+ixvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkJjL2VX/9fYEWBMw8GBCFHAx5tobdaVGiuGYPmdIjq2OlBTRoBf51+2qiMyWCdppOwreND5KTpFZBLgC6S5B09B1Gzsc5S37RLWOsDFDPrcFUtUv4b2GnirshCxSv7ElShcBa2pwGOjYP6yg0l9VSUTh4RWEyHklwFRiqg1xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBVsyJrb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBVsyJrb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a041eae5so34080615e9.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658070; x=1776262870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt7/zv+UwHJyWIBrUUqp/D/ZXiUTMuYqdObuX9zLVHA=;
        b=BBVsyJrbKPFtcy2Rz7Hey1WwovPgkvZo0SNnfjnoz7ULn3mZ9b2p9FMFDo1ODG68pL
         kT0IRnGeh6RKsujwalXC79uC00tL4TBmRJ7GjNYBp7/7vbqOe20CGoClunKp8vh157bQ
         02Ult0lXYwTr/CxYzCv08r7zOBheaw59tUo9R+vOTUthMzKLMgwyiyzDE6rUhawQ5m1d
         f1GHt9tTcySsDNuAOtMKNkNA97UxQiV5etToZwM4SeCT+HaqUEtLMRKqeO586ltdG4eI
         M2hfYwaCQbYplzs8nSBUnEhdLRAf2HI3yjU8sf6QqtrcubFbyCbsg8CURLJI1YNM6d06
         5rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658070; x=1776262870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xt7/zv+UwHJyWIBrUUqp/D/ZXiUTMuYqdObuX9zLVHA=;
        b=GBzw0L54DGEYDMN9D4QGK+3d/F1JgHPmYhCe9elJnrJbBZjraEW5mdRddLofz1P9YZ
         MU70i0YI4b8DKTZ/5GyBQRQn0bwGDqCbNORpLzc9Qcmzb8A6sxOjNRxLF8uLSKr0apYc
         HklI4oZELphM1pmOotK9+mtWpE1fR7neDRAnq0NDigC1f+1S3Alxp2AzS6i1TmBHYwzx
         XUULUzHQkqae7aldyK53geWVjBi7QRyQkhu0/+I7OHJ55huDf5aDWn55l949XnENYdiV
         DCI2HIbeIhnjHJ92l8kP0wwBlYS70BVJeVbVcuA7Qd/xBWeYygX7XQvxGH2BagF6jzaQ
         4bgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1za2Ujcj9IURJsVPzaKoj+K/H293PRcz/WF1RG3KfBqG3h77QtqR1PsggthV9BVv9ogqKbcVYrww/DXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4s+9veL/jJVIQNYUPUMzHoM2Gu58o2FIlQ7Er9W/E9pbauOG
	Dsisgkwve9/ofupcCmknc/+dRpqlD+wqf/y6O8n2I1ypqW2Oy4EW7W4i
X-Gm-Gg: AeBDievSYDlbjYJUlU6ih8/+z07qyr2EbvzQwOQQ4sCrvRnN6YAxl9d1mp0mXLWpaIs
	5AbZTQL7h9MIx+SFdcT6e9gQsoR75/zW6dCnm6sSDxyq9F+bM6jsAUSMr9A42HZGZ5SdBDSvp4S
	jHUG9j53jjxQar0Rdcxa/ZnIkpZqRR9NwNYx3hurohiVoHp2WippasheTBadr9Ap8T2HdKbbIwv
	cz76z4Z9CiWgyaENk6CYVtSurjpIp0SS//4Mj1UoIGW5xWgUboIyslMt5kscvcVtgj5PipCG8+X
	TSmDoldWDNJG91UkkCez1fv3UwJ/Qu+KCpnZc7xDCak2y8CQlyPVzIYQ9YvQCIwBXR3cLa5hx8G
	fvpv+Hf0xVaM37d+8ufzDXicYRz+ydX7aHOAuRE3H1HZqYJnoJV2fzFZ4yEuVjFwfGBeIdZ5ajg
	jRQmMBdS3VG3RkJKTJdwglt1ZRXMaiXRJu86yFzobh/nJZqTT7pYQ2SuPq8Q==
X-Received: by 2002:a05:600c:a318:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488997dd54fmr202593925e9.24.1775658070197;
        Wed, 08 Apr 2026 07:21:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:f65c:8080:131a:202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm60474467f8f.0.2026.04.08.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:21:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH v2 2/2] serial: rsci: Remove goto and refactor baud rate clock selection
Date: Wed,  8 Apr 2026 15:20:59 +0100
Message-ID: <20260408142105.310210-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
References: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace the goto done pattern in rsci_set_termios() with a positive
conditional block. When baud rate is zero, the clock selection logic
is now simply skipped rather than jumping to a 'done' label, eliminating
the goto entirely.

Since RSCI only uses a single clock source (SCI_FCK), the multi-clock
tracking variables (best_clk, min_err, brr1, srr1, cks1) are redundant
and removed. ccr0_val and ccr4_val are likewise dropped, replaced with
hardcoded 0 at their write sites, as they were never modified from their
initial zero values.

No functional change intended.

Reported-by: Pavel Machek <pavel@nabladev.com>
Closes: https://lore.kernel.org/all/abPpZULsXhRmXTX9@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped the check (abs(err) < abs(min_err) as it is always true.
 * Dropped the check (abs(err) < abs(min_err) as it is always true.
 * Dropped variables best_clk and min_err as they are no longer needed.
 * Dropped intermediate variables brr1, cks1 and srr1; results are now
   written directly into brr, cks and srr.
 * Moved dev_dbg() inside the if (baud) block.
 * Dropped ccr0_val and ccr4_val, replaced with hardcoded 0 at their
   write sites, as they were never modified from their initial values.
 * Scoped variables err and srr locally within the if (baud) block.
 * Updated commit description.
---
 drivers/tty/serial/rsci.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index a0858bab0822..c2440fd5c02d 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -217,16 +217,13 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 			     const struct ktermios *old)
 {
 	unsigned int ccr2_val = CCR2_INIT, ccr3_val = CCR3_INIT;
-	unsigned int ccr0_val = 0, ccr1_val = 0, ccr4_val = 0;
-	unsigned int brr1 = 255, cks1 = 0, srr1 = 15;
 	struct sci_port *s = to_sci_port(port);
 	unsigned int brr = 255, cks = 0;
-	int min_err = INT_MAX, err;
-	unsigned long max_freq = 0;
+	unsigned int ccr1_val = 0;
+	unsigned long max_freq;
 	unsigned int baud, i;
 	unsigned long flags;
 	unsigned int ctrl;
-	int best_clk = -1;
 
 	if ((termios->c_cflag & CSIZE) == CS7) {
 		ccr3_val |= CCR3_CHR0;
@@ -265,23 +262,15 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
-	if (!baud)
-		goto done;
-
-	/* Divided Functional Clock using standard Bit Rate Register */
-	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
-	if (abs(err) < abs(min_err)) {
-		best_clk = SCI_FCK;
-		ccr0_val = 0;
-		min_err = err;
-		brr = brr1;
-		cks = cks1;
-	}
+	if (baud) {
+		unsigned int srr;
+		int err;
 
-done:
-	if (best_clk >= 0)
+		/* Divided Functional Clock using standard Bit Rate Register */
+		err = sci_scbrr_calc(s, baud, &brr, &srr, &cks);
 		dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
-			s->clks[best_clk], baud, min_err);
+			s->clks[SCI_FCK], baud, err);
+	}
 
 	sci_port_enable(s);
 	uart_port_lock_irqsave(port, &flags);
@@ -289,7 +278,7 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (baud)
 		uart_update_timeout(port, termios->c_cflag, baud);
 
-	rsci_serial_out(port, CCR0, ccr0_val);
+	rsci_serial_out(port, CCR0, 0);
 
 	ccr3_val |= CCR3_FM;
 	rsci_serial_out(port, CCR3, ccr3_val);
@@ -298,7 +287,7 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	rsci_serial_out(port, CCR2, ccr2_val);
 
 	rsci_serial_out(port, CCR1, ccr1_val);
-	rsci_serial_out(port, CCR4, ccr4_val);
+	rsci_serial_out(port, CCR4, 0);
 
 	ctrl = rsci_serial_in(port, FCR);
 	ctrl |= (FCR_RFRST | FCR_TFRST);
-- 
2.43.0

