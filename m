Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086136CE0C
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846940; cv=none; b=OZoac6seImCEV83uAsfe79W/mJbcpHL2GhXUbIICtrwI477v3SHXL9CaGH/D3qPn3egasV7Gjml5daT/iTZSsj67MUTuePAwjmDmXHCsKEnDmYC4DeRjRin3mSAzz4Z7E04VnCYCLaI1rz/ppHiO5NvXEjYmY5bvPApVjDXmkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846940; c=relaxed/simple;
	bh=ZVr695PrkjlsTLaO5UZFDg6DGUr1VgaEBsWlk7XU+bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPtjgjwRcvigL6fpN5lUE3UB8bgnISKGSUnc2uRhj/qIcqlRjHWXB7Bi35YC8aq6lyy5dxsVi98/3XVno+jy9I6+fnFRJvNu7gOxjD7ZaunXfMipNdk/G6HCnizdCYnHG2c0MtDs55FH+fBKNCARpfPGGGmOZy+BopWnTn3pynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swqnbqey; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swqnbqey"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471191ac79dso15183825e9.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846934; x=1762451734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=Swqnbqey01kzoa1XCsgBJ96Ik0fRiuVDcnRfuMz8alz7WDm54NY3dzBwjkElt0srJI
         /HLCcmFPd3QN5j4M/BLm1ABFjPqtpAQcMW0LweGKjOTbsQXHgGbxEkcVmJIRN8CEp+LH
         QELc3ux58kIV0x//taAH9Ycmll+cuMKGkuFQXaIg+QLzIvaj8JRaWF/8yIl8Ez1GWEV3
         wO5i566uyZMpYYh4JcYUtxZ/CK8Z5G2tIyBbyaTcV/OV7JsrojxWrsFTngbgtjVspjWZ
         1ErfRY/pSOvrcVVPbKlLIhoKK12Apf4ENW9VhxguusPVyrZxfj3+3upqYVY2hxh4rHqM
         G4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846934; x=1762451734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=XiDblyX4sp3oY/WHcY8hZGnPg5Jb9S4Suse/K6GFLFdrfDvouEiHAoXJmUngWB9BiW
         m5MDsWpDKCotpyk60Id1YeFUE2dWXADliuQbOew1ceQu3q0t6h0WXRct76QcADXTsX08
         S4SSz6ni4aeQtwRDRr5ZQ+i0kfifoXnpKjOY3KdZEMkS87AM+8Xdf9ts7tXE3JUAgqWN
         oFj/atEP665TKC9yQjDD01kZiqYxVaRkyhXU1KR+MG9S/2RzsddUM1XUeT9s27baxq7u
         VMbzKk3g8y7Cgq66bZGmd9a1ni/Qjbwu8owJwHekMeddLoJz5knkei5oH5cJoOGK9ljn
         oQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWGd3dwF6f/BhbVoRODGX0kOYSr9lArLA6BOYTormDYUJPY4gqwHkXzzq2+P8LpouOKm4Rl9P5i0YioP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGA0x3bI2LRsv5dIAjnBUpaghwyGOVi/gigeHunV2D/2CdLlu
	ORUCBX+Pxofz1gsXztOPR6j/5bC0hYuY6A+J0Ipl0suAmMb9kpDCbGKx
X-Gm-Gg: ASbGncvNT/KFFjyM1N7x2kVd9NYsUVJl2yX+PrK8UCSa4zMNamtlz8PoN3Pqz+AfQAH
	Z1RckyV7UAV6YLrpBhQG9sx9/eTKQv15wUc0k1tdC/DqFmJTAbcibu/UCfYUlc2HfRDDOl2qrIV
	w+mPi6QC8f5Q7vPL8HoLA3CkZQaJcbE1T1kZGF3K9YN0QhYHcAmuYixfw3iPXzGHFiHjUifrLfx
	NjCkfd7TY2OcjQPKyylDG3EwyGedE0HDscXyFiVWOQEf1Qa6kdRnFyOsog/3JeZSB10UOwJQ98y
	NP7S1RtlREdRbAh6/0tvSnuSPa1XEsLCuntiGvDZ7SOWixgFlsCy6UOmBubWsmKZrQO88shk5bd
	DjT9xSKB+PEpCUWj8TnUaNp6cPmD0ZEsf+X4BkR0ilTKEknZkTTT/IKBeexZOG5jizOOpEorPJQ
	ZYa8gz35OnaSInmHj1LiefG1YSrCquAomgHgH3Twng4g3FQSs4UO7sX3LQkzdyxXj+wZe+Y1i2X
	uxavh84xw==
X-Google-Smtp-Source: AGHT+IE3z5lAmhGoh5d4Yy4K8o1VX+Hl6Sh/SAktovTtRK5y2To4h3DqtSkPbGR9LE39NISIviPJxA==
X-Received: by 2002:a05:6000:2207:b0:429:7693:884f with SMTP id ffacd0b85a97d-429bd6725bbmr488929f8f.5.1761846934316;
        Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 11/13] serial: sh-sci: Add finish_console_write() callback
Date: Thu, 30 Oct 2025 17:55:15 +0000
Message-ID: <20251030175526.607006-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add finish_console_write() callback as RZ/G3E RSCI IP needs special
handling compared to other SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index a3f4a76cdecb..2e97aad390d9 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -95,6 +95,7 @@ struct sci_port_ops {
 	void (*shutdown_complete)(struct uart_port *port);
 
 	void (*prepare_console_write)(struct uart_port *port, u32 ctrl);
+	void (*finish_console_write)(struct uart_port *port, u32 ctrl);
 	void (*console_save)(struct uart_port *port);
 	void (*console_restore)(struct uart_port *port);
 	size_t (*suspend_regs_size)(void);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ca4915c1e2e6..fac83dace27c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3259,7 +3259,10 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	sci_port->ops->write_reg(port, regs->control, ctrl);
+	if (sci_port->ops->finish_console_write)
+		sci_port->ops->finish_console_write(port, ctrl);
+	else
+		sci_port->ops->write_reg(port, regs->control, ctrl);
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);
-- 
2.43.0

