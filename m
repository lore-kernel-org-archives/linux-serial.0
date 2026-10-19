Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429309;
	b=AZ+DDLNve8/Bb/+36dbdi7wzpILybLoRjzPuY6oWKZw/FcOPuQJ/pSYvHs0xw+azbR8P
	 82DkyW2HJLg5xrmAg7X3U/I/UI0spJ3qPsQ2MPks2ZUNRB5lEHWr98sadlrNyvz+WhDxL
	 ir3bKk8Cx+zKz0aD9afQNb0vc0IqWmAUW57bnnyt9JMapRKq5JHKbuHZeEoMtzO5Kehpw
	 IKp7KCiiNL430Q4qOO9LChOAoU7dxB+vVJxt7xe5OGvcnTpXtHlQaCiYsIRmPG88n2Z2W
	 qHyoLh26tciA4qh77NFtOZ9umEnk4FjY0lcCHpvoDTGM9fvlUU2mscX1KDLBBLT1tfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X2JdP9uBFx29VsMFSt4MqnFpZC02U9gkSb2YVKNtlIY=;
	b=sjA4AoR9YybvQ1f1jPZfGqcBmZnHcJ2xbwkoNSjEvlDzijgzonAK9mX/YqDf0cbMAVqh
	 CanosfdLlbPwMH/s9/E7OYQc1cIlp7V7Yn6Zl26ZJx9Dy+PqAhfP+/tMRwVDgLG8C9XZZ
	 5bHJlzx6/W4dk4weQIhUNSTxFc9aBEfZTWdXVkKKUma+d8SmkizQNmNv7eG2rxFOkEAZP
	 ptMghjPPeVV2PyR8rfYDefPkgYu60L26RDciQlJGdLqlL6UaUxa62kCZYc6RqWX9BykMN
	 MIG9G8zmGhqVqqpz7cifq6H1+F0d7maKWYzsYwsspGCj3WE1aux8dZv6D7jrvr4/MEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R7MpN+SO;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE9606A33A
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDE9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R7MpN+SO
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e0d885929so1730639f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429307; x=1793034107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2JdP9uBFx29VsMFSt4MqnFpZC02U9gkSb2YVKNtlIY=;
        b=R7MpN+SOvxv5O57TUMwFOBF8ZHJg0a6mzHs0MBsBUbSULF+iGZOtcbk+j/eXs6zsuv
         hAR6+OGJmLnHKp6FMvn2AHiBP8MtNleMcaU1E5sPdR8ah6xb+azuVQRBY73gyJ4oRLY7
         FzoR3WQpH2DQKmurzzQhDG02AZCtIKY3mFsOYZW5c6HuBbJqbqBwCbKYxnd4ETXIZvco
         1t/YRaNDGw81TWg0q6XxcDdXbZgqgNq1gC/Gp7M74OObKUJJrkzCRP6cwewziqH0FQcE
         yLqaUI7fZFopdsx5AdX9DrKrhxec1Y9qKkYKvz6V4bsWG1G8NCOBo7g4rs4W81Jsr5fY
         aJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429307; x=1793034107;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2JdP9uBFx29VsMFSt4MqnFpZC02U9gkSb2YVKNtlIY=;
        b=lSA15BLK0pgosOmspsZANuAs46pSZ/CFpiel4503ACuaOzYUeFh9soaQ3k+zA7JL6U
         sonc9QfQEIPerMlZAxXzYgB9zxpj4zmJ1t3vYoeMK7Rm+FLZSAfWqlPvMhkV5hCL/J/U
         MyQqVi5n/dzdsQbX9HBdLc7pPaWpZ2yaXsSRwR/BWHDh0ZtyrkgLk6T4TK9Bzj3HSGW9
         gFU8SH58M3eboy3yrQbTcN4tNLkIaYnVMHJir/LwAOqUMv2ADMk/u9FfXGDKcXz4VMfT
         XBjYT0O4ZRZAy5yIVJEDthSVKsTWSh1UsY7WhksK/dK/dDG7hDI5KYQYuqiDu8QV/HDy
         of/A==
X-Forwarded-Encrypted: i=1; AKwUvBwCpOM09J1sqjzQBZa2l74+eQJr5I/X7csB/k4SCJSU0BB/j9joIrcoFRtAd2HQmx2Qagj/RsWIsQF4xsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcocVqlLjBVtiUwCgp0TOGyvWUX1qyS5iJDGY5er8Cxi4wBg3q
	uYDFWSRc+8EU1tKwZ1BqGemvAYHwDVI1IMbMeKZGTR1R6Q2CRu7DOVvwJh2HIw==
X-Gm-Gg: AYBFou1UJgKWxD8VhvXKbJS/Z+Bj2Sx7r2VBj2N8hik4IzeyYbFB5cYFrZ6MiJOvPIO
	fvrXhhvFtUooBFPpfx6jXAF9aJoY7MYx5zh4nMzOJPcikX166jphi3NgEwoupQ73tB5HQ73WOXC
	hryn4wJjBH4M8QLxa9slv/kur14haNs/ew/6wa9aCntswizDYljs+5HJqDXhrOHq3ZkA1hHegH7
	0h1QyMgVN6jsboTlMZvlIWD2XIoswp0SQcZakW4yqyOeK1EnIMrv9GPIYpnEKuYXLh6cEbYygql
	acGoXnTmg9/w1xu0RYLDUQp/fRG9hcuq7LO0uzXUi9W21/2v18bf+/8IrRFEQPnbPH+eeQ75xVt
	Jb0dikygj4KNeATiGjBPY3ZsvgOWSXEWFgfLZ3kyd6EnzOEM7dHyYCK6GfM1nQq3qcuVRtnNOWl
	/z0ZM5OIhD2hDulXZaTrI/n/ujxo4RpWicwZani38TtR9feGVDzgtmWTVnWL2RX3ZRb8ipFvsn6
	Z2hwJzxZeFzcLzlkLhUX1iwVGht0e1UOKdGT1cRphgcXQSdafIXPEZ8
X-Received: by 2002:a05:6000:4a1e:b0:487:88b:4681 with SMTP id ffacd0b85a97d-48e07bbc7b4mr18155599f8f.10.1792429306635;
        Mon, 19 Oct 2026 10:01:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823b7esm101784f8f.40.2026.10.19.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:01:45 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Au Dang <au.dang.jx@renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=202/4=5D=20serial=3A=20sh-sci=3A=20Don=E2=80=99t=20disable=20TX=20on=20TEI=20while=20the=20xmit=20kfifo=20still=20holds=20data?=
Date: Mon, 19 Oct 2026 18:01:10 +0100
Message-ID: <20261019170139.473808-3-biju.das.jz@bp.renesas.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

sci_tx_end_interrupt() handles the transmit-end interrupt (TEI) on
SCI and RSCI ports by clearing TE and TEIE, which turns the
transmitter off. It does this unconditionally, even if the xmit kfifo
was refilled after the last byte was written to the data register and
before TEI fired. The queued data is then not sent until the
transmitter is re-enabled, so output stalls or is lost.

Check whether the xmit kfifo is empty before shutting the transmitter
down. If data is still queued, clear TEIE, set TIE and hand over to
sci_tx_interrupt() so transmission continues normally. The existing
TE/TEIE teardown path only runs once the kfifo is drained.

To keep the handler independent of the register layout, add tie and
teie masks to struct sci_port_params_bits and populate them for the
SCI, SCIF and RSCI variants.

Fixes: d61ae331d6f3 ("tty: serial: sh-sci: Add support for tx end interrupt handling")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c          |  2 ++
 drivers/tty/serial/sh-sci-common.h |  2 ++
 drivers/tty/serial/sh-sci.c        | 22 ++++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 40db9daa4272..52638db7bbeb 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -627,6 +627,8 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
 	.rxtx_enable = CCR0_RE | CCR0_TE,
 	.te_clear = CCR0_TE | CCR0_TEIE,
 	.poll_sent_bits = CSR_TDRE | CSR_TEND,
+	.tie = CCR0_TIE,
+	.teie = CCR0_TEIE,
 };
 
 static const struct sci_port_params rsci_rzg3e_port_params = {
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 01ff9fced803..273856fbc20b 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -56,6 +56,8 @@ struct sci_port_params_bits {
 	unsigned int rxtx_enable;
 	unsigned int te_clear;
 	unsigned int poll_sent_bits;
+	unsigned int tie;
+	unsigned int teie;
 };
 
 struct sci_common_regs {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9eb297dbc901..d577f9de6259 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -261,13 +261,17 @@ static bool sci_uart_earlycon_dev_probing;
 static const struct sci_port_params_bits sci_sci_port_params_bits = {
 	.rxtx_enable = SCSCR_RE | SCSCR_TE,
 	.te_clear = SCSCR_TE | SCSCR_TEIE,
-	.poll_sent_bits = SCI_TDRE | SCI_TEND
+	.poll_sent_bits = SCI_TDRE | SCI_TEND,
+	.tie = SCSCR_TIE,
+	.teie = SCSCR_TEIE
 };
 
 static const struct sci_port_params_bits sci_scif_port_params_bits = {
 	.rxtx_enable = SCSCR_RE | SCSCR_TE,
 	.te_clear = SCSCR_TE | SCSCR_TEIE,
-	.poll_sent_bits = SCIF_TDFE | SCIF_TEND
+	.poll_sent_bits = SCIF_TDFE | SCIF_TEND,
+	.tie = SCSCR_TIE,
+	.teie = SCSCR_TEIE
 };
 
 static const struct sci_common_regs sci_common_regs = {
@@ -2012,6 +2016,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
+	struct tty_port *tport = &port->state->port;
 	const struct sci_common_regs *regs = s->params->common_regs;
 	unsigned long flags;
 	u32 ctrl;
@@ -2019,9 +2024,18 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
+	ctrl = s->ops->read_reg(port, regs->control);
+	if (!kfifo_is_empty(&tport->xmit_fifo)) {
+		uart_port_lock_irqsave(port, &flags);
+		ctrl &= ~(s->params->param_bits->teie);
+		ctrl |= s->params->param_bits->tie;
+		s->ops->write_reg(port, regs->control, ctrl);
+		uart_port_unlock_irqrestore(port, flags);
+		return sci_tx_interrupt(irq, ptr);
+	}
+
 	uart_port_lock_irqsave(port, &flags);
-	ctrl = s->ops->read_reg(port, regs->control) &
-		~(s->params->param_bits->te_clear);
+	ctrl &= ~(s->params->param_bits->te_clear);
 	s->ops->write_reg(port, regs->control, ctrl);
 	uart_port_unlock_irqrestore(port, flags);
 
-- 
2.43.0

