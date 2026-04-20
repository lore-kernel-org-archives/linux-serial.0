Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB41363092
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693874; cv=none; b=g3yQ8GbfWjPIOGQVehqzG59bWJDKpbtGe+99tSvGGsU7RpVBYxVSwCyIKxcHSNF23HGHyZ6SjaNh5TW63LoZbl4ujsL0ddVkhSJCM+2GfzRn0pscbaPE/Ay47LmdNVxa3+ngkRHGLyvaHXMsU2vxXwVGE3fvk/HBvIcaTiP/jBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693874; c=relaxed/simple;
	bh=yDUaC1/iNFVY6fhdVZI8/bN0lGWyeP+qc3u5oWUJa8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLrgs2ik4N2McegnnrNtV39SeFFWrV20SO7nAE19NRzmb6/yRilmNEUq3bW6C0LZrqGTi6/+SgnEdrjO7f82sgSmLWZhflE0UeTeg/MHt1ALmG4k9ImxSkZiyKEvEt7UKXyvrsKanQHdNHhm8jofLSe+uRawudctvAnvYBw1aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAzlAvWW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAzlAvWW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so22036815e9.2
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693871; x=1777298671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UMhxU2rlH/zA2V/NdLqMV3kwXNHA2/stIZVA8XUKtU=;
        b=QAzlAvWWJxxZA2Mawq6YF9LMqIwES/EIGDAIQT6TLGuTGyu+lzny+d0qWnX/fNP7wv
         FEpopZ2uxcetgoL6JDn1/tAEKgIt/4KUZD84+S2a702QT5PJ1Y+Ieveh7OAHiIQcmzV+
         4yt1EIu3IF9CXl/h8lR4fcij3MPY77dEAYUogvJOwaU0b2YF7UglePcpqnj3IJsS2ISz
         tdGuFFaBmtR0/h7JLYZ7Pe03bX36wwX3iq58FaBI/GJ0hkslNLFNkJjEyPcSTfzjc+3Q
         kEFTX1ubFFb0n0BWuSAMZE+i5btudHXVxBdIRMqxf3u7ltqmN3DDzcYKaj5sBTrFRQLi
         UgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693871; x=1777298671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UMhxU2rlH/zA2V/NdLqMV3kwXNHA2/stIZVA8XUKtU=;
        b=N78IhZX8Tx5RvYfHX82xQysywoPyQ6K5FOhRvygqsE9cvXdqyuZsauNwRPnvydDKmE
         b8mnEUjXGEZVtcMT7JXMIPiE4MnYIzkjdvl4kyhYghlIEvwse7rnOC+lXDCXoP/FdUwP
         Zdzdyf6+VAdOjMCm8Gb7HzxP1fzcy7WslrPnXF8+cv1L43lZUS5ExvSijGpP4yyoWn3V
         kGOTyeO3ShPVXfOAo0X5OrFUsSyZZzRLi/UIsY/4L1EdkpeNaydBXkSuH4YWnFuvZHLP
         l9NlH6wYbWU2Kc9r8URD7j2B+yQAoczz/A/Twax2mryauzcjsk5vnwQfywtnBCEakv6f
         1a/A==
X-Forwarded-Encrypted: i=1; AFNElJ+FELqAQx488XCVeY9+7Q36QUlW+sraUOZ0si9pa+3jr2K7Od2qcLIjC2ZvuOYGcm+VZ7QCJcPtCAKG+2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzA4UygNITW6tDH5bVp4qPoVLQtCKI8Vli2/KkYqyRICMe62/C
	S0q4SjD+GIq9c5vgo0V4sTPNU6SfnqFFVVQxREvWP+NW0ifMHulPQupF
X-Gm-Gg: AeBDiet2Z3bLcKy55Y2meSpovnQlIfdGcc+Km4e48i0hELI/Rc+9CF/+Ql/jx/rDrHx
	0ATd7Gb9150o/GSTZimUCynW4S3Qx5df/Y0VUw4BQWF+OXBQ5jURAIJs1i0yc7jJdkD6eoCfwNR
	FFrcFm9Z6zAKWgjO9Ri7gHtOYF82TJUO5dwIlajb4u7i+yzHIAPFJEhBhXnOLP3pCiQrUP3dnie
	B80qAss1ZhBathQGjUP3vC96g4pXS4Tu+X/8yv5dFiXm+owpS8N4cq+XrNNhZxbMbj69+DvD7gK
	oL7tJgc2BZrOMDV7DxkFVpJHmDtEAXkSXYd+53tWj13UBvma1lECJKbat6B2dtKyO4PB6zorfh+
	XBqehEox+tEVaswvOo2rhrFf9jSWpxx+ylgKgu2P6v/3ZeEyJ8n5P65SI+R1hSrJp3zXK2FcJJ0
	EI5U3xm7WQo4790Q3yRd26L99hst93P4tsbW1bfHEvFDXO5A0nv+O8D1BwH74=
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-488fb793c6bmr201341385e9.28.1776693871037;
        Mon, 20 Apr 2026 07:04:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm28377778f8f.31.2026.04.20.07.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:04:30 -0700 (PDT)
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
Subject: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate from uart_get_baud_rate()
Date: Mon, 20 Apr 2026 15:04:22 +0100
Message-ID: <20260420140426.237865-3-biju.das.jz@bp.renesas.com>
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

On DT systems, a zero baud rate from uart_get_baud_rate() is not possible
even earlycon derives its bit rate from chosen/stdout-path. The zero baud
guard and its associated done label are therefore dead code. So remove it.

Also drop the unused done label from rsci_set_termios().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch
---
 drivers/tty/serial/rsci.c   | 3 ---
 drivers/tty/serial/sh-sci.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b00c9e385169..40db9daa4272 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -265,8 +265,6 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
-	if (!baud)
-		goto done;
 
 	/* Divided Functional Clock using standard Bit Rate Register */
 	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
@@ -278,7 +276,6 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 		cks = cks1;
 	}
 
-done:
 	if (best_clk >= 0)
 		dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
 			s->clks[best_clk], baud, min_err);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7473b26ce9cf..9be359e04995 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		max_freq = max(max_freq, s->clk_rates[i]);
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
-	if (!baud)
-		goto done;
 
 	/*
 	 * There can be multiple sources for the sampling clock.  Find the one
-- 
2.43.0

