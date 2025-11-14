Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093D30DEDD
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115238; cv=none; b=aHGv7NsW2q1b6mLAcC5YkoE7++7/BJy88ItMzX7k0KceKc/PnPJy8tUGKbkJDTxQV/LneKPa7ldYwPK4IDKr7UzyAnlbr1HiPVqVt7DFsHdOw3Cs2L4NKIyGlMWiVDyp9uYOXr8TctzNISJuLkDijc1F6NJjDKf7GBDLLdnDYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115238; c=relaxed/simple;
	bh=d0pkjgunEzx13WUIALT9aumD+by6YT5fFu2YZ0/tu7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSQLuv2P7+hok/TrIhB83u5aGa6oWQgZSmp7dcrPXg3wygxczW+xv6Yl3S13GLDy62fh1ZgLt+E8cTAIiWjVybihA6Fr8tam0IF2J41nKNhS/96ud0Po4McsNrwhwjvFtp2qUXcbtJ4U3TidQMG6chqB3hwOBVESK5N9C6nreo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKgS9BjP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKgS9BjP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47721743fd0so10464815e9.2
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763115235; x=1763720035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGBAsgxn8goZuL00+tYzFnNl6N+Ofr6aIgLUsJCCODo=;
        b=eKgS9BjPpm2z3k3gnFJt7ts4KPpmKGhGd6+wdFPH/lq3myCgcc9XARFPEhOw1qoRJB
         nMQ9HnWDNe9S6VdHip36WmlHwhcaz81P8q8rK2mzDoFjaNyt3c0VabR1HioHwK2nq9K2
         51RgWKUsmgvsoOd6DR7QSFXO56gNtHb9v5587lkBD9fIhIsxztboYuIRuziLx3C9fkFl
         rddflFfCrMFS5HmJZMLClXZeF8CwpQ7EzRGC0ivkkXIzVMPXnyUrn1I2tSC4XR62XcP0
         7nAzKt4mxwwWV7dadmOyO+jsp2mBNHke8iJufmZY0R0E0vM0r56SpJNqwu3TDo3lNtz6
         AzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763115235; x=1763720035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGBAsgxn8goZuL00+tYzFnNl6N+Ofr6aIgLUsJCCODo=;
        b=RE+nmi2yfKDv3PF131MocHGxGSk79fr7VKB907DO0/okdmcyjZM6JEoQtplBGTu15r
         dyswcwo0QwDI4D6Rk9Vs6M+hKITPMGuc+8nINR2ld0l/HFBSZOydzR7zt0DIn8YpPIUl
         FUQlp3b174c3KgPMdUCDFoXy/2eyP1fjBRX5dsHLhGJJODzWZBQjwzVwEAKQt2BsY9gK
         BuglLAyJSO6EmKXXiorCKpKya2sQgad2qPtLyHAYbfJsNPqWKTXZPc8RXLibDsiCS4AO
         4monGFvD4hM+MfrwT/0878IgdbieF2auCXNaBcoNO0GNWRZgUw4i2gu7Zz3NdHbQ5oFh
         Z3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUoNJIudg51z9OtlEO8FEj9wwa5QLWNkA3i6rjxZIEtuJuylQ9l+QKTu/dHJ3vsHQ/VpDQIubzKKRafgO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLLunC/4lbZkAGMfkh+e1POUFp6Vck6+y1W033akcCwY3/STT
	glG8hgHjyet6sfocogaJzI+ELihR/vAPHSNR2Ci3gpGLdI7uxRJvX87l
X-Gm-Gg: ASbGncvuE3B65bKRzv60JI8vk+p+n5hAAIvJN8vGc3uIz8VmseBDZOlSWs9f2Edouqd
	w875KnYdJYIrLDGzW9CNgtKJJcagk3YzESt5X1OtbRpAvMSW1F/q0AlBiANKiwD8bSJCZ2ejPjd
	JcXS0RsdkGTJa8LKNMIK6FbKZwvIzXlw+0qFtchiPdCrp9iOE3k2khmDHowzKqKDVrswxAZ+IZ5
	ZgZKy8ThN+U14yYabQICXBuxW8ZT6PV7lCkzTHxjUSLxsFLNDaKofxjmgmJuHNzySzPI9TvLY15
	aUx+ZPd+TUjH6M7CDUIKlDzCgYmq33KuoOMUGGNJpjesNAt6M3RLTr0EhQGf27x9cMcgosvLBPT
	sxSuWEELCtDhQ0GyP0W3DLJPpAEpjhXzDgH/FNUU/purFRAjvuqYyhnULijT0CPmqYP9JqCdx3I
	XNDQlQYCsqP1R3EPejQGV3RyQC13Qo25thn4AwzVNGsSncDVgL+IzA0Qznl4GOJbj2VgwaIi/Ej
	yxbOcIP4poQa8/SAdkh7ugjWRs=
X-Google-Smtp-Source: AGHT+IF3Hp2zi9egWQjUTP0dosC8tsLQkIB4YmHISF5XV4biOcIYmIf94xkl72U/X37QWsHQMM31TQ==
X-Received: by 2002:a05:600c:a06:b0:477:8ba7:fe17 with SMTP id 5b1f17b1804b1-4778fe5ef11mr24976475e9.7.1763115234842;
        Fri, 14 Nov 2025 02:13:54 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bae816bsm40685815e9.0.2025.11.14.02.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:13:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v3 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
Date: Fri, 14 Nov 2025 10:13:47 +0000
Message-ID: <20251114101350.106699-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114101350.106699-1-biju.das.jz@bp.renesas.com>
References: <20251114101350.106699-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
different register to clear the FIFO overrun error status.

Cc: stable@kernel.org
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Dropped overrun_clr from struct sci_port_params_bits
 * All of the CFCLR_*C clearing bits match the corresponding
   CSR_*status bits. So, reused the overrun mask for irq clearing.
v1->v2:
 * Split the fixes patches from original series.
---
 drivers/tty/serial/sh-sci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b28711eeab71..53edbf1d8963 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1198,8 +1198,16 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		status &= ~s->params->overrun_mask;
-		s->ops->write_reg(port, s->params->overrun_reg, status);
+		if (s->type == SCI_PORT_RSCI) {
+			/*
+			 * All of the CFCLR_*C clearing bits match the corresponding
+			 * CSR_*status bits. So, reuse the overrun mask for clearing.
+			 */
+			s->ops->clear_SCxSR(port, s->params->overrun_mask);
+		} else {
+			status &= ~s->params->overrun_mask;
+			s->ops->write_reg(port, s->params->overrun_reg, status);
+		}
 
 		port->icount.overrun++;
 
-- 
2.43.0

