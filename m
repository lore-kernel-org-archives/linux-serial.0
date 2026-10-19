Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429306;
	b=UiCuRXt0AbfZnv+fnzEVacCJsAq+opo2DklcX+vwdCC97clg5WPkAdU167WAIA/FRQ8y
	 ADKqpaoYqu94n246xnQLiIXSTkQB+TmDOYRiDaVhUFwUfm1wCruSygecTnuLlT67reUBb
	 uartST4Mem2a2kLDnhVxF7oOHvcJ3EqlKlA9y8H8mYUzYeAbN9P1uXoLyCTBGN4FbNobU
	 D6VgXMocFY6UzFRHVaO75zUTTjHcSc/H9SlfxMQ4W8exw8lOonvhjMwY1Db+mk6B/lUXu
	 v5jCYogB+ObKnXAWXfmO/A4h0ST0XzjIjx11gfjuoEgb2s9iVHM0Cuu/uW5F9yZ5IUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TLZJ12VmKQ088zh6YEuB3BuBCiEf+3W1h7X9C6IEbck=;
	b=EHMvtRLZ0jdN8IJx/0jC/I7+XDu0sWJ67kFIuBGlobnoDU9udxGrCJb6w8NB0QB85sK3
	 nV76TswjGVBp0GzoOU64yHnPSmEPg+vAvkwrTa7BKRM2aywG/BeR8LspVZ9ZLVXY3l0Kz
	 kULwZwoFDd0QmwLIf5Jkd+xU5Ue3KYal64usq566MoSVz7VQj4Wp0VUjNuSN86LazX8A/
	 QQjO6mONl2wQLgQgi1JmtEIbsrN5QLv77qncJ9GnsQzcXTjZRTPn2/3FS6WNb9Khu9Xe0
	 r7l1ZhZu8Wpi+fKRtUAvgW+3l4WST4024LfSWF1hr8/mSnP1Wcl0aPtMbwMeg2GN41Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WfijDO5W;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F7606A31F
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505F7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WfijDO5W
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso11087015e9.1
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429305; x=1793034105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLZJ12VmKQ088zh6YEuB3BuBCiEf+3W1h7X9C6IEbck=;
        b=WfijDO5WDRjz8fW4mOT7Q6HqJMhB8mcZf/TCxmnXkNphcXc+74I8A5TUUUYkT3X24H
         8j2JeQv8+SkQG4RhGp/NUkTNBq9gM58rgJGEaqpA9Or2ezRzcLDgKctF+zmPXicF4kIQ
         nenLDRItutgqj16MY5OI5w2z9SrzQkk1zZdE3/KdZcZ1fUq6n9y1FQk0n+qeCFqOhAzQ
         3f0r7idK3GNGfpU2byZIneS+eL7V6P26yApOH3GprWTdu/7TsMI1QD7Tozfvoy4c91VO
         Idn1uqtzvq9AzhoRoTng/6yaJ7IpjEN5I8p6p/Qx+zkd4ezXTwn8dxqG8yzYUbZkuqCJ
         BsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429305; x=1793034105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLZJ12VmKQ088zh6YEuB3BuBCiEf+3W1h7X9C6IEbck=;
        b=pGqqM0+sWOiVLLjTPuMwgHJxeZHZ1Qu+9dzvcJKN48XOuX5A4ufWBcRrbhX0k6gSM2
         Yq5acGFj3S5sY07GBNYsAB53+XpJo1zqfoInJdtsH+wtC4vS4c79aTgIB6vhPRbHAQkD
         6mmi+HF3SwCPiS4inrg3JVmo9jnHkH29X/KcDeO0/5cNI+jeOtXJ61kdy56HuMoJJqpn
         SBURPk5lxT4Bkwesj7wJdCQBKTReR6eLlgkuMVo/OaTWxYQ/baImpaUXZE6lsQCEYfaR
         xyd+Bpj8kgUA38UZGEjBYS5bw+fMM4BNEqopZ3TK1jZhf4pIDK6QXOGotUJWWAWKZAMx
         jHvw==
X-Forwarded-Encrypted: i=1; AKwUvBw8AYY5q7ORjM3zKlG0nEP30vhJ03IkAOQoT84MPnQNdBYMVoUe9NPBAvW2d5DJ/l4yODKUngcrEGAOB2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJauanmWUoBQDoVk5VXm/kMULkzQ6gSi1qVn4QTs5RXp2Baq8xV
	cYvMa1oFX9WDe2c1GDYTuer2Jdf4bwkpe6u+hNB7ClCMG5j5Vi9kZPS+
X-Gm-Gg: AYBFou1a0ng+wgeUd/XJFV6GmoNiPC4eZcvUU4igTkdC9tMLBuUye4yFbMCLhxw2LU5
	+ZFi1hr05k0RzjhbAqF5UkJsrQHyccoKeD+dCTzWDsyJFZOzcmrhF5zz07AjdK07F4ymU23AfX+
	P7L6yjJpp+gVU/xJVWOZBafI1PU9+ZhPmgKIn7Y8YNBpxni1sxur90Up/M3h2A+23xi0BtWncjw
	aUkr8caxm5j7vmZ80tff0FE0Ty5bT0jPFg0K/h4GKlVV1NOofNw1DIyRX0bkIGF6yS9Df4VIUbG
	M0awpSAtTE/uIKbRXz8vriamya4N9wR+RKLH/GdObaobapXmtTsbvrliL1cjUu6sknlNsdSAB8K
	Fa+ZRE6cK8+WLySp2Sn9Lan3/r5StrW7WMe0r8VvxL6bp6qz80H8URuYneCrGO6q5fxakj2Kh6A
	OGYrvQ8vkJDzcadDm3HrFdAXi8F/2XyV/opF1aBa3jrCvwNSKr/fR0/3vZbxBgFjLRVsUmvtuxp
	3JGzTFZgdDg7qctr0dF7YxcQMBwS6bujjHpYmKM1+48dmCMrEhUSlzpegwrSnntses=
X-Received: by 2002:a05:600c:314f:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a1e6c5e47amr79415365e9.10.1792429304466;
        Mon, 19 Oct 2026 10:01:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823b7esm101784f8f.40.2026.10.19.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:01:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Au Dang <au.dang.jx@renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/4] serial: sh-sci: Drop TE disable at end of transmission on SCI
Date: Mon, 19 Oct 2026 18:01:09 +0100
Message-ID: <20261019170139.473808-2-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
PORT_SCI once the transmit FIFO is empty.

The hardware manual does not describe disabling the transmitter to end
a transmission, so this special case has no basis in the documented
programming sequence. Remove it and let SCI follow the same path as the
other port types. A plain revert no longer applies because the driver
now uses a kfifo, so the code is removed by hand.

Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa..9eb297dbc901 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1036,13 +1036,6 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = port->x_char;
 			port->x_char = 0;
 		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
-			if (s->type == PORT_SCI &&
-			    kfifo_is_empty(&tport->xmit_fifo)) {
-				ctrl = sci_serial_in(port, SCSCR);
-				ctrl &= ~SCSCR_TE;
-				sci_serial_out(port, SCSCR, ctrl);
-				return;
-			}
 			break;
 		}
 
-- 
2.43.0

