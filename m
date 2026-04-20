Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D9363C75
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693875; cv=none; b=gn294SvHksw3NMJDZtdmv6tPi9ZxouIBzN/4FaWh7WP/+yxaKJqF/77CMjjn/pbGG48VyssDW670ZHVA1yqiGcddEZc/HY/W01CdREHEuNgLy0FiMjId/YQP9g7ULc9qgpjtQGQR+1n1S45T2yc9jKykTPdEFbTLENm4+rciv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693875; c=relaxed/simple;
	bh=WhVlfvQ+oUYkxqpp/mJeaygvYrQ033hUNsGCTAFD55A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5FugXQg4bUZQ/avDfCJXa6Tokpzk9O9nJSitT7g0pD0ptcbS8ZKhiXWGzqB2KkIIaSMhN3iewBmE6qEY3IacWaljmcgmfs1dworaHbzAheMvI43Giaafzre/xyfd8jXyxWNBDTsTRxmvInuKUcgqTdOFeep2bDTT5lgsJVTZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EunOhYiy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EunOhYiy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7645adbdso1756142f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693872; x=1777298672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xlUWWLG1M1rjcikyRUpJDrhDMsJpX4br6B8/dQ92cY=;
        b=EunOhYiyMSQjLBm5v5xhbAxdCCA0xi3+1DsqZfd1YqUsWURKfjyWnv/+hndysNpxnZ
         +UfBesEu1IbF3DadOCBbsIdUhyAcvGHfaeA77TNl0G7o1ik5vvUX5QMvHAYFzC9mDTw7
         arhifiXdtAsXIiUgLniHIHYWkkQ+m5SO740okipcU2bs3Q9VbqQnsI0uUbWMFv/mdlRL
         ZBVIJhycT0r9inUUvIiyBW/ettLQTcX6Lj87y0yye0GOP3JMUZO9T4BPrxjmSOrTkFcq
         lBkZRPubX86b75cnVnMj+YZ6c4gt6OQdj9uiJv+0Cj+o772U9Fps1Fpj7zQLCMoVHwyA
         P0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693872; x=1777298672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2xlUWWLG1M1rjcikyRUpJDrhDMsJpX4br6B8/dQ92cY=;
        b=oKBYvSkbtu7U1JteHIR7mThcSc6aoXE4qncOVj7XsnSO65+Mp1BSVVGt3iLuzYTrC1
         aw93+2Ezt2d1O/tlVP2i05HkG9KBVYlrybl8lxkKlyFWbeNlYnps9ioR+yl49n0hRCel
         84Bq9AMOajT2lQFsENwbDU6gS8Jx3imU0EdntNB8/dVX5Rn5OTZoeDU4R033V3VG2PU6
         N+yzkw2reK6bhJ2jzVbO8peoZLzSUpV/b5TCypqoCckEzeFmHXUPDmB9L7M19o4cJVfV
         qekAjOAzpb1t7bCt8oL6vXulB3UV+hs2pDzf3sWGxcTNDJKJM+a/Gnc6v0vRhui3diwA
         XvIg==
X-Forwarded-Encrypted: i=1; AFNElJ888P26r3svc07fqnnwceSXhioXze24r/KWor5Xs6OUMxFLFc/eng/pbIQC/PTEC8g1pfit6yiTBgExPk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gI4QKZWUScksS1XjuFESugW/c3egHFHMBwejornWSUWDBNVJ
	5+rPWnOb5Zn6x2BLyE21O+GzWnLTtU0a6zJ5Fv7YPRJfDAsR1uCZ8Lzm
X-Gm-Gg: AeBDietY98K+Nz3q7724QJ5gkq/TRJdtrxy/w6agAIXEIF1SjYuLKL68rsoFKkk24Hv
	woQQUHcQTRfxBxwA75em6w9zfIjO7tsp4pd//AqsoDwmA+amoIR0yDAJpxcMYchAaMBIm8aWyYh
	aRK6vqxs2hQ4LlsYfoUdjpaykbwXMLdKNNLyRp9tfXdea4ox4JNcyn0bzX8tv/byW7gAfA+HMEf
	klpbYzv0/ZKndysqTizdhIeWBk/GZB2cuDyTmnLLXsKygd61a5RQpOUPitNYiBAo0Q8OASdJrVT
	fyHb5GMZCnHMRCwIqiFVkVK+SZ5SVkKdTEzUS+J22TEV4P+qkzdpr2ofAmNDlIhOuK8fXm8Syh8
	+CdCjhl7jv7a5xWdfcaVzNQy0dcrRfiqGZHjvXJ1OktlpefP50O4yTqEneePWGPlao/48NPCM5G
	/uNppmGYidcv4gjOomhsTvPdxsM0EVgvg3n6t/rSECtTbIakB7oFX4D95+hSi6GQah+xQkHA==
X-Received: by 2002:a05:6000:18a3:b0:43d:7ba4:6b5a with SMTP id ffacd0b85a97d-43fe3df25a7mr19214923f8f.22.1776693871973;
        Mon, 20 Apr 2026 07:04:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm28377778f8f.31.2026.04.20.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:04:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/3] serial: rsci: Refactor baud rate clock selection
Date: Mon, 20 Apr 2026 15:04:23 +0100
Message-ID: <20260420140426.237865-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Since RSCI only uses a single clock source (SCI_FCK), the multi-clock
tracking variables (best_clk, min_err, brr1, srr1, cks1) are redundant
and removed. ccr0_val and ccr4_val are likewise dropped, replaced with
hardcoded 0 at their write sites, as they were never modified from their
initial zero values.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Dropped reported by tag as the goto statement in rsci_set_termios()
   removed in the previous patch.
 * baud check removed by previous patch.
 * Added missing macro CCR0_RE while dropping ccr0_val variable.
 * Updated commit description.
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
 drivers/tty/serial/rsci.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 40db9daa4272..444e89696310 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -217,16 +217,15 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
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
+	unsigned int srr;
+	int err;
 
 	if ((termios->c_cflag & CSIZE) == CS7) {
 		ccr3_val |= CCR3_CHR0;
@@ -267,25 +266,16 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
 
 	/* Divided Functional Clock using standard Bit Rate Register */
-	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
-	if (abs(err) < abs(min_err)) {
-		best_clk = SCI_FCK;
-		ccr0_val = 0;
-		min_err = err;
-		brr = brr1;
-		cks = cks1;
-	}
-
-	if (best_clk >= 0)
-		dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
-			s->clks[best_clk], baud, min_err);
+	err = sci_scbrr_calc(s, baud, &brr, &srr, &cks);
+	dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n", s->clks[SCI_FCK],
+		baud, err);
 
 	sci_port_enable(s);
 	uart_port_lock_irqsave(port, &flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	rsci_serial_out(port, CCR0, ccr0_val);
+	rsci_serial_out(port, CCR0, 0);
 
 	ccr3_val |= CCR3_FM;
 	rsci_serial_out(port, CCR3, ccr3_val);
@@ -294,7 +284,7 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	rsci_serial_out(port, CCR2, ccr2_val);
 
 	rsci_serial_out(port, CCR1, ccr1_val);
-	rsci_serial_out(port, CCR4, ccr4_val);
+	rsci_serial_out(port, CCR4, 0);
 
 	ctrl = rsci_serial_in(port, FCR);
 	ctrl |= (FCR_RFRST | FCR_TFRST);
@@ -315,8 +305,7 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	rsci_serial_out(port, CFCLR, CFCLR_CLRFLAG);
 	rsci_serial_out(port, FFCLR, FFCLR_DRC);
 
-	ccr0_val |= CCR0_RE;
-	rsci_serial_out(port, CCR0, ccr0_val);
+	rsci_serial_out(port, CCR0, CCR0_RE);
 
 	if ((termios->c_cflag & CREAD) != 0)
 		rsci_start_rx(port);
-- 
2.43.0

