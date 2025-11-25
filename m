Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F6329C50
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083210; cv=none; b=A2LbUr6OoVooKvJxO8RrAfAm98VeR4x56ePN+/bq/y3/fvRR07oT3TeS7GMDHykn9Mm4+i8q/ZW23lwFPtOO3rUiPvY2bK6rl/FLIvUO5VLcaXNJs484JMUTOcHs8LCMZjO56OQYlTQvSrz8GVTP2qt/gEv67OlMy3TRApgKTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083210; c=relaxed/simple;
	bh=xIPuy2AVoMcOuThGQUd2vsGav+08nP3KI7MIQ3gZGTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1RmFI+fStZOKE8C58EXUXlSidBQvCSs6mJ4tZzwsVBnokq4nCL9epMY/O+/BKYX4xwFF44lt6jlZ+mK/1JqrvT5UbVBt7vdeWVgzdfkwrZH/m5trffVZkXfdGISq9l99Vy1bC2KKFwplb7f3jKY6W3HRhDzK9YUc7cvS4c98fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKSc0f55; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKSc0f55"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so40267065e9.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083205; x=1764688005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoUcpPy/VhJlkw0mixzg7KI55t0x2bZGdTWh+eiAOlg=;
        b=HKSc0f55trZDx8pjRUSNalOe5SWBnTNzpxgZ8JA5lzZNRm9uiqk8/3y/HUr5WLXwoD
         IVgBwxB7w9qLF+Ccd+OSD3Vy0UGF2IrHoJGf+sRZcOtdq2dm/e5A42aaihOwvnvL4gBq
         tRloEs72ULcDzje5nTsF/E9flpZ9o3OZr+AQbaCbKSXOQXRAPoiPn1oEnP9wlOf1jq3K
         zumkN8BxsUUeiuj1Sw2Pm1oHqmMH1icIyoOe1q2dP1BSPeNSRnMSouS7L+5x9Ix5xUh1
         kqDS351wmHxV9fHjOcLAj81oEETCEpE0zdz5yp5owZitK0j0Oew+NqdP1ndGIHD/db5j
         d+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083205; x=1764688005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoUcpPy/VhJlkw0mixzg7KI55t0x2bZGdTWh+eiAOlg=;
        b=SCMdrBYg/bqkKQrUuK4A9Xoa3RtBogN262fzKt6LKE+ePj3y66UZBBxCGiboBXs/3w
         0FbJiXKQWgjwgs/2gKX6zn7uCyZmRnLa8S8BhR2tmdqrxxpR+8nrfZYB0YVvpAvYbvlS
         /Ej+Eednli2+tWmkFVh9k8S6+6Op8kcQhucaKy2DBQxwZyxz/BNP5U4mdscu7XMHwd/O
         6zucgMHTqSQL/uqSrKnYiHjYJlix8Id6mzfyRxxe4fsQivEatldXRAwq4HfGetaC2ZOj
         jmFiV7ZtbnjbmuDKlxvtdbuIWiq+QOovhQswsMLDf5k5JDDohjhOBCtY8fBAiLhn7cEd
         Qr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkfiu01WY5US3RfJWdS4Wc/JbZQZsG7avQR5VElwynrbycELnBF08w2ncWSMA1VjwhaBSv2s3tYP947mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UYMJlat1qNya0vYLngZX/jfzV0rHu33i65OxgTtgUGvnocxY
	tz054fCELqxGMGrLy1ViZnfaj0DquSyDAFnP+D6Lxywf8FRADLfVsssai7TKHA==
X-Gm-Gg: ASbGncsUMi7NScpcqBXEP+7N5pLozUZEJ0oBFeVXVY40pNDWvKv4MUHo4bPCorUioGn
	aotPM39rwt5OElPrOFZrLRlL1+8I9J6ExmwyS8X2lz7xtle6yaHkHh0Cg1iOD4sR1v86/tVxrOO
	zw0xe98lSnJSuvEArqgGSrmLvX27GgTPmBqaTwhvoJ6GNAcEi4BjXnDVD8wq2BwrKU2cUWvO95g
	y9jV9mprxJbzvEGS5RmaGSz0mgWLiYlVddXvQtAH+2mb03yHeEB224sZeWkapdfb+thgV9Ra5XX
	iPIbdpRpE5zHro61H6c+ptBHWeUzhaTFLkgRtNynns97mYTkTrKwmBmEiH4UcSmi6mSUfsD7HzD
	vgucNXBSMCjUeSPhYllTMFr3+yBZtSj+Y/6hVNzj3luCEXMSM8Ao76H7uGZai5W0dmXP7xo2npP
	6eBRsxnDE28GfN9B4JcY8jb63+7sx7FRiL2shtMRXklIW0FYswVtn+bhQ1q3PbGTyVOxkLvZXJ6
	REkJmQ6LYGk
X-Google-Smtp-Source: AGHT+IFpusnzk4BRnri2FE8OMEBlx88fWJcmGapVeYq2gIFQvpFMinK+o5GyvlxplqNXxaWlj/0VUg==
X-Received: by 2002:a05:600c:1c0d:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-47904a6867fmr39604245e9.0.1764083204866;
        Tue, 25 Nov 2025 07:06:44 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:44 -0800 (PST)
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
Subject: [PATCH v4 13/16] serial: sh-sci: Make sci_scbrr_calc() public
Date: Tue, 25 Nov 2025 15:06:15 +0000
Message-ID: <20251125150632.299890-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tag.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 5d30771278b4..976e394ab968 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -169,6 +169,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d7c25635bb2a..0cdaed2e1b90 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2573,9 +2573,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select */
-static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-		   unsigned int *brr, unsigned int *srr,
-		   unsigned int *cks)
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2639,6 +2638,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, "SH_SCI");
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0

