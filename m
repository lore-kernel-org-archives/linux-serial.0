Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45611313291
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117535; cv=none; b=ZvHNWQVQF5DqTbsBx86FIVrqOpX0dtrTmQBzn6Mf31WfiWY/k7lkd8N+ElPinHVy/fPmo2jkHLmYhpf9hO6boN1Or3F2XiWvzaekvhyJS6JdbUjMajqXJ08SGV7HP5Kx5wxG+/Y6Usu1vTYbM75PxqA0rYj+3QEqTXvIroYIx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117535; c=relaxed/simple;
	bh=mv2mYdOg7LrC0MfHxAiJ/nb0yhCqexkBIc6K7/VaeZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kloBVlKOut3pz825PratuJFDkO7r32bQNULyQVcM06x83K+Q1mqvtBxiB0jA7zsac/bwzJzbOb+ff8FK6hpY9YzYl6xDDvjVSEuaA3e4GUEoAwLo5IIq9ktDC6vMCLI3OyLQ3DsDjQ8Ht3m7jfW7WzLd+yobX7Ri2CS1L2i/oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLNQASvS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLNQASvS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47755a7652eso13046165e9.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117531; x=1763722331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oure4CGk54ZT9fjfLN97GsFO/opoaJIaOfBNUUyjY9o=;
        b=SLNQASvSnDd2uDeeYA+Ny+FWmQVj5sAbRjHv/P+oLVz2KDlCHwFHQmYWTmcHHffTVz
         8O3ssz45zIVLPZavfwFaetJUmYe4mX/V1wTTy/4I9Qx6RC+P0xil2neJ0j+1ciVsMebE
         2edYkzDkqRb/FY7yG5F1A/9nfFi2gleYUhObqncGxpcWdzp9DfscVxWeXcIaj+mUq0J+
         FINJGIkoMS9aIUj1OurPQYHmjN2HO0EAVZ5/ffMRjP0XqfhetFCKdI+DA2c0XuZzB77S
         xJu2AtKCLn/vHS1GpE0uBueGOPzNpybT5gjcuguieEai2UmzpmlOl2A5wALT1DvWDUIB
         TzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117531; x=1763722331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oure4CGk54ZT9fjfLN97GsFO/opoaJIaOfBNUUyjY9o=;
        b=SsWZXh8L1N7RQu4c0vKDtOQ6gawcOwKhGW20zM5ILOLM1cY+oQ5dMOZxxXfR8TPaed
         BP9jP2eRWm2XrkkcVEN8UjQXkShCOy3mrkVt9WcQeDEcEbAHq0LwvDNO8uPPAwpwIVgd
         CkuOSV0vLsKbBH8IEfjjiTIk3ah3IbvpCihnfaE65EikPaaGRzzene3ZuEx6OObaAqQA
         aTYpTHuc2I4BgHUm5knsp8pYeVJGsBBQkb9BXtslT1GeSgEBV/DaaY6GVmi+OwEIvb/a
         HF+f+Pfe4vAXlq2mEdWPdaTkzOWS0jXuSib3os/VqiOPUeyq7yU66GUDeMu7fL9QWdDs
         Ulsw==
X-Forwarded-Encrypted: i=1; AJvYcCWKT3SgwsmvUdrAuuonfN8S4MZgifRD58xVyE0I7pZZ4ZV4t8Yg52rHhscDzcxujg81xD5VVcgl06gQzh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRokLfoQ2hKzKW7AlOc2xeD83ev9Gz94khlNcyaM3/dDDQ1yw
	fob09o/Bobv2ZimBcChQyl+dGC3ySM4RDjPtiutBLxRqiGg9QPfaRygH
X-Gm-Gg: ASbGncuG1R3knVfLjb8oUzTkQaaxo+99dm4eNkBtIhAVj9qDOvzHWhhfroJY1usvzvo
	J6F3zaDe8RhoPAA4mrRLhYGLITF0p+gPGzvkQEQ67POSAc92wLjwaMV/JOYJZADftvJFWWEApoG
	l3aBhLAZ3epHjnI/GYxRoo5F9FaOBt+I2BBE18DYh4aVrF0J86GlQAjm7TN7LKCmakJeDOE/Kx5
	2bOvOd3mSeGG9BXpAJOEh5zi4Q5i34lSZv4vhqyfu7Qph/3t3zEFVL5yv0+a1JLRzmbq2XJ2WZz
	9u3IG6nmMQBZ6VdgJRQc3NRJ8ss10h3yiVmoCzenbPC4CRFXDKPtcu75VwIGX5duEKPpsfPUU7T
	0GlvKSjHzM1KyUmVH4xkLw0tZFJE6Ih2X56N+sks00axUlyDpHIMuJcxfOks2bEJ9HH89JDTuEs
	OZWHm8IKnNb6yMpuYL89dnjxztf7tmjOaMmy5P+hDnSbCwm85aH71Z0tQzcAyctxi7iv/M2wStj
	jwXFDxZ8f2htcY6
X-Google-Smtp-Source: AGHT+IHyh9+bCTJgLOvK9EK/d8+FstS+PNLykYKfr5zqimCLJC1FA+ELYVlW0o49D5QHxK8wWp+yvA==
X-Received: by 2002:a05:600c:1f86:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-4778fea17bemr28907635e9.32.1763117530874;
        Fri, 14 Nov 2025 02:52:10 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:10 -0800 (PST)
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
Subject: [PATCH v3 10/13] serial: sh-sci: Make sci_scbrr_calc() public
Date: Fri, 14 Nov 2025 10:51:19 +0000
Message-ID: <20251114105201.107406-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
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

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 6c849757119b..41a437440dfa 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -170,6 +170,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3b03d3d3f2c7..c7f8a9b470fe 100644
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

