Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90770355F22
	for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574736; cv=none; b=e68Tm5fvXQj2BRj6XEaHryDIvLGo71jRa//BHiuEyQKqWa0QsqXhdn6VLblBayeodNxgwQMO+ll+JJ7GiBD+z8UTAIK4Fw15ObqimWtonrldeH9Ny0DxrhsvBEAYDxFhffwCpAaBEfuT4aCAXTNWA+snZHaAvixFmABJ4jUTe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574736; c=relaxed/simple;
	bh=4dHH0h7811//j5T1In6lxiOLE27Lvcfag5EAV+NB048=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BX5qFJ1sl7D4ixvhW7s+IRSvlrSUsfR63SgTj7UvE7+5vvNkHlegkBodEtBq+xkBxrvsOHoqM/XYawPz9jqW5hrbO+OriIghJVY9BWRV1awwpwFGBfW4ozRBgU1cECEVF6+KGMx3LaylSrswCy8+EZAX7nkqlqnJ2/KL9IaEz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2eN9FZw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2eN9FZw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so2512989f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 07 Apr 2026 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775574733; x=1776179533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEGPU0Atu5gV0jwM3WLoUYvd7qnqbjH2TWBR26dz5rY=;
        b=n2eN9FZw+9HBqgmwhuzrWt0RBYUAROrUaEtQ1EZPgjHs/zvRuAAeXqJC1RpivAnggn
         89LZYYkXXx1p8WRMf2XrWdVCZQvrE5XJltAcu07Jpkwa7gQlSRE6a38RIK9le6ppzykM
         TeJkqdmFlIbmeQ0HsT0YpR7VXiGJ/iGciGF9kh+5nWlAoaoMnHX8DDPTf92cDiD9HsRD
         wmoRV38zteSFjEidYKEpPYnA0eAH0w3beZebZmiNZk92tF2pPD+VGQ1haDsLrExXEUrn
         mA5j4q3QxUPynmDXekjufJoqJRYW7IDHQ2DaYkqZnspAcbZzeqRsUTdgEgUL5vtN35qD
         CvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574733; x=1776179533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEGPU0Atu5gV0jwM3WLoUYvd7qnqbjH2TWBR26dz5rY=;
        b=lYjOT8OdUNte5eLV8nGz+mLXya4738kHtP3g1d74debAy7Fh78VqWQW7XkqQRnAEKt
         6RXrwKG5P9O1TrnX8yu7houASq0Kxcy23UdqFlNdjR9SYJNq8o8x6J0uZYYJhToZ/n7u
         K6LI/q8FvK/HQKXkuGAiInlp+5CG1Ek2kiMMazhJoHR7jMt9kRvgWA+O3tZtSbRBwyjs
         VvAJszgcvb9feG561E5RguPJrA1HBmevRBQK9IHquBeFsj5wPrxLPDsAxZ2mN7MRzNbV
         z4FUmtdW6d25Q4EbxQDAqvP6eLMwrDQBBZRCU7fPtiUZS2wrFv3R1v3heq+SnPwjXddM
         a0DA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZHrN+51R5PGE++j6UZg6hxEKRCoCTHCwbnRdn3J2tAt3XPIutu49nCvgnDPtGTvSpvza93HE1p4INeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEHI/Wd+506mWSjoshpg9wCEPDhF/6yM4hWCVPnhNubh75pYn
	4ayMf0DtqNFhuaGtdS0Sp2PJShGkXB3u7KeLk7F9NY2LedYp1KllgkE/
X-Gm-Gg: AeBDiesE1ieQSBBMzRroIQnJmHl7s5mMVyJlSka3AUBOQ7WuyeoPpZXm5aMd3jDPSWO
	VI+k7JIC7WCK4Fy87tkHeTA946Cmdl+6QxZU8DEE6Rw5Bv6fMe992+aoR3MGWaKGnY/qvZJm4DL
	lCgy59zJ/dYORSbuPE/oTOHoCxbz2wADyyVBwUeXU20veM7dNZwgN0AizqDIVlZvTQJEXshDGju
	fJX7+KtCJdbJKxcRItrAr0Hnmh+6NYv/7qyYmGD0Aw5FbIcIXVsbl1kfEr1zkeLBGcoJhkKZ8Nh
	TBTauhQ4U9dfY+DQEf3Lx+p0nD4kwd1Gfta0w0ARFAUj2UHHyZnCyGlOUTWhhYrLu0b5O/M2MoO
	ILdno7H3Cr7AEVwcjiICiKVvXx4APuFCL9bVV8dNFO16chqcc9zvShkkTEzdVdRSs10y/Jc6kpd
	2frhfRIzAZTC8ccqV3qJjGCkQKlBIiGNB9iF79LrYHwTXqLgpL
X-Received: by 2002:a05:6000:401e:b0:43c:cda2:4f2a with SMTP id ffacd0b85a97d-43d28f8df8dmr25550860f8f.4.1775574732772;
        Tue, 07 Apr 2026 08:12:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:3f9a:11a8:20c3:fe58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5016sm54488360f8f.33.2026.04.07.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:12:12 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH] serial: rsci: Remove goto and refactor baud rate clock selection
Date: Tue,  7 Apr 2026 16:12:05 +0100
Message-ID: <20260407151210.102693-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace the early-exit goto pattern in rsci_set_termios() with a
positive conditional block. When baud rate is zero, the clock
selection logic is now simply skipped rather than jumping to a
'done' label, eliminating the goto entirely.

No functional change intended.

Reported-by: Pavel Machek <pavel@nabladev.com>
Closes: https://lore.kernel.org/all/abPpZULsXhRmXTX9@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b00c9e385169..0b92173f8f45 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -265,20 +265,18 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
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
+	if (baud) {
+		/* Divided Functional Clock using standard Bit Rate Register */
+		err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
+		if (abs(err) < abs(min_err)) {
+			best_clk = SCI_FCK;
+			ccr0_val = 0;
+			min_err = err;
+			brr = brr1;
+			cks = cks1;
+		}
 	}
 
-done:
 	if (best_clk >= 0)
 		dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
 			s->clks[best_clk], baud, min_err);
-- 
2.43.0

