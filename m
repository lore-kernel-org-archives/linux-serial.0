Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429311;
	b=Tq+uxZ4t2nhCxaWrnZP4kTEiEJdWijrC2sAtSsFPqPWJIN+dvGYHBdIC6bsSsiAebWnp
	 EBtB4CpmZl/8snpPQi9Ih/QyXHQWoFfXBpBywtBbs/XuTJSZVkI+7omJy/GB+K3PPuGsz
	 XlKZghSi2mMVtFfUSpK8207MuVq41cmCgAK6bPC4zSx/HjbblYEGbW6tYoYgtJQQSOivA
	 h4aA+iEQnWO1N/1ss6j3p3S3Q6B9c2eP70KwZnIwzXPVkkSWyU/kw2DwTcYcFX85O9HZ0
	 hmGRF/NGexI2GQrC8n8XDDY50XF8vn6r7wABD7ToZcYoaHFtehB8dx0DjvOnMnYw1lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r5VXnrteDtiwyhCjk9bhH4hMMO3JPBb3BFlXcONxZ0s=;
	b=P6wBIVW/LHak2dDmv30593kmpKJt9J2qxQQsn/770xXw8xgkCaugahMiHpnevffjNxNd
	 jFplYc5iatM6rVOHSyZ/gTc9soMZjERhBj1UErkpJlr+d+Tn7kVSJFLVR3Yu2L0Bozuv4
	 KjVnYSlKvwbzfgDIgKFa98k8Jjh5Aah+P+eF4DWuzxMzoGKqVYU4MoNqvjc7BV2wyYPne
	 y4wE0q0/37VvZpiwiADoFh081zA8xRszNXBzR4BIAsDCifCE0EswPVemqV4YYZP4WUzJG
	 XvnA1brvzKJR9K/b5situv7QztOJITe5MyzxHXvnzNCS8l/m2bX53A04NSCd8Nxkc6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k5Z0Uetx;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFC60A262A
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01AFC60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k5Z0Uetx
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so18017085e9.0
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429309; x=1793034109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5VXnrteDtiwyhCjk9bhH4hMMO3JPBb3BFlXcONxZ0s=;
        b=k5Z0UetxOSMvmrz0ml/rNZCpNQov0H41drmFbH8PiVo4AiF3pNApCTHIgs1K2rw7/i
         cFUgJUd5f/37Izl0lsRHI4a7lSyK/aw9Bm7o/zqp1wsjCnFy4GEhRCvgUjjQexHoHpSM
         1a0wv11cqK770dSRClE9PyuD0BoQ9wPyApGcvJriUOqqVH3FT9Wd51RXn3Zqvd2BG935
         1E20nTAT36wvaCsgSfL/Phsgz9dgXaDIjxaCXKC4OMHVcofRNSfQsAyChZIolcA80eYX
         ALi8Qv9PmC6fetmBiq+eIGxovyLGtzcSrWWTurQoEe1b+4bqUn+IzTtvBP5lZrAtwR4A
         allg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429309; x=1793034109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5VXnrteDtiwyhCjk9bhH4hMMO3JPBb3BFlXcONxZ0s=;
        b=uQfYCAiHNk/SnigtZIxxm8VrY6QzCJgkMu1wSDRUULWiuXkgBYTWkHg6QBzAOsoAKp
         qEhUNrqeBo3GtUurOEKstbw398CXTC6eQf3PBYgYtJ8fCpfPS3Vh7FcHURrpxVbHTimX
         MJ7pw2+TpU+eNPtNdn/EP8Y3ZR671uc/gQI57IiYLKz0Lc6BZY3hPfRuIWGkbylLP8QO
         Onw4l5JObjxaJISfftInyzFMSkmrm9BBDe5BgSn2JEkvwUZaA9Vg/zRMUMX1aCx1Iz0X
         ltLgw8MROe9LlKXQNhhir5EfGS5e/MEVD7OUdivEuZBKKuFCHFTu7TVjO5XPKHDCZRNK
         K23Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+GIbUYoC5Ttocd9dRy662QBxcTfnnRBWyAg8pMMC7sgeYZCRS6/8m++efS7y1dYLKs0CgkXzAfv/A2yA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIggsxJpyAsBT8xGkAI6FU07Fpp8WxLEk0D7OHXiUNDy2/Zal9l
	oqM6Cqr/T6qIXkV2HbaoTh+UbcbP9TONIkmSnmjv03oSxEFUPnSCXvqh
X-Gm-Gg: AYBFou3jGsQqA1TR4Azi1fyVz0DW7RSIfkdZOCv93JeD9AkN0Hphg2cXrtRsEevohBJ
	mgMGie4t32EQWyYn0NIVFtuX7CighSnEEjySPDpYYVKs4DiliajR7JqybhoKE9p47MggsrIC41P
	WjY3e5ldjNNekkn74AT8b7dgkLUosZsmkG0J/0rtRTtosbR6VNm3HP8rYwMxliyZsXmO4UbLHg5
	LXfE149IMcYVtO0dT02lrkH20aI2Z6Zp74el/W8dJOwZAq/xFGDqzkS8uEwFndE+XDV3BeEflTU
	pGMJymb+VkpSDHULGo7VtnFHTMglHNya4L3qlANzUyV/4M2qUN1l3oNNxO/cklSBEUvGw4irdHB
	DCch7HS21FdkNtZr4nYOAgvFQ1L36NeimbYV10Toj1VNlp83yIWk4fTEo6qZQ2eyVyzx4b2j9Gl
	aZTSZen9llLpOOeKhdnf5Yc/bfE1AmtmBaMJiXom1G5T9myh2/i+7y7NcwiKmaUxiCy7t0QyuCm
	tLa9t5UzsY/Czi5gUAWnBAT0OYZncKa7xmedJuHXkFR7mE+9jOHSD5s
X-Received: by 2002:a05:600c:1395:b0:4a1:c6fe:5c0e with SMTP id 5b1f17b1804b1-4a1d76148e6mr175520865e9.33.1792429309188;
        Mon, 19 Oct 2026 10:01:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823b7esm101784f8f.40.2026.10.19.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:01:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Au Dang <au.dang.jx@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] serial: sh-sci: Skip TDxE status clear for PORT_SCI
Date: Mon, 19 Oct 2026 18:01:11 +0100
Message-ID: <20261019170139.473808-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Au Dang <au.dang.jx@renesas.com>

On PORT_SCI, the TDxE (Transmit Data Empty) flag in SCxSR is cleared
automatically by hardware when data is written to TDR. Clearing it
again from software via clear_SCxSR() generates a spurious TXI
interrupt, which causes the last character to be transmitted twice.

Skip the clear_SCxSR() call for PORT_SCI in sci_transmit_chars() and
sci_poll_put_char(), as the hardware already handles it after each TDR
write.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d577f9de6259..e4c7a3e14688 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 	} while (!(status & SCxSR_TDxE(port)));
 
 	sci_serial_out(port, SCxTDR, c);
-	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
+	if (s->type != PORT_SCI)
+		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
 	  CONFIG_SERIAL_SH_SCI_EARLYCON */
@@ -1049,7 +1050,8 @@ static void sci_transmit_chars(struct uart_port *port)
 		port->icount.tx++;
 	} while (--count > 0);
 
-	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
+	if (s->type != PORT_SCI)
+		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-- 
2.43.0

