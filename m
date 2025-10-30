Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91D37DBD9
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847104; cv=none; b=PaWkISJzIdPMPiWG72IKFodgI8i34/4oK97bXMfgHH7Gn8Vkj043j2HES5HMb8s2kps97O8riEGY2wfKYCUWUNIeWZvFBhJ/h5Dcjq9BcdD6QPUpusnEllL1dmgRvbpq5var6Zsm4/J1dY3LSmOOOTwwa0lCJDPTcmhItpgYgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847104; c=relaxed/simple;
	bh=ZVr695PrkjlsTLaO5UZFDg6DGUr1VgaEBsWlk7XU+bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYWXfYwVM5pYfc0ONXc+m8dFEg7V1Ug154OW2wD9pPiWZpn619dT0X8kDBBq8qA8S6Nk+sEYYJ2dDxehofkKKYeAiWM6uOpvzAafl/GEFFl51sm+/y3orh+eAsK6Uj1TGHyjRkI60M8dnaOOyf5rS8fDIl58Swn4mpsGaRMjbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azfsx1pU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azfsx1pU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1123143f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847100; x=1762451900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=azfsx1pUgFkTpN+3DH7falTpbwTn0N/KvJ6g8CC7E/3doS+qKR7yNqPpyogWr1QVE2
         iMsNPVBxARX1g3x63S0iX1GS2pusGQtkWWAQhcvjjkWjXM2i77OBe0wQqz9yHUYhzNkd
         Tc94/bq4+WT//uyIb1+tRf/r70lSOPWYnnmEJb1VSZA4DTbsdZBckHYAUTeeBpx5bV9U
         Y/7moIRtxksVby79yTngd8EHSQrMfGGBxVEwQoC3QveM4wpeP53UvEbQ+uKC4R0POPxj
         T7h3mF4LGFfH8Y4YduINwE4kDIuAC0bdqoCxSzDal+02OW0sE7OG+yMNZwEdFfXzu+8h
         VePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847100; x=1762451900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=GhLsymXVnO5jrw6yE1qJ9k2M7+0+nFofW0pR11uNtudar7iGD3EGxwWVolDwmQ3N+3
         rfL8qre81QrgREbauc2LfX2hCSWkZPcW8DCC8QYxWdrn0h7rBm+EXc48yFhb4mLkYThr
         fIV6M9kbQkaYUJyOWhGImO1Lt3974+JDMEx/Eo7ZJ+4wW18iAD/ZvH7RE2+a4ITPz1m1
         Os8a26uwnczXQmuxxkougdZ59m8mnbfJAX6S7M+tVkaY3jcis02srbfTBswA11Wx+2Le
         KNFtJCqzQMK6OPaJNGV1yHRvbqk+gze/77OpRTw34liJcwaTTst5vD1N/Oy6oWhzjhzE
         C2ew==
X-Forwarded-Encrypted: i=1; AJvYcCXuY8iandsRiXlCs1K40JVyh0lJ9MY2k+H9UegTqFh5v1GM2hyWZ/fYkcJRK8gig61nYsg4mqRtNSgUKjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1LKxKG02glW0HfjXYZOBDVVdOVzFOJNMrWysUWUyPVu4g3zd
	sy0IySLXcd5cYk9VFKzTJ3KF9Jhy4m7cY+8OL8Fy0cYU5eUA47h9O8TR
X-Gm-Gg: ASbGnctygJX5et6Y44L+WYXWeJshBiEpiUOuLKh9DoLPlkTe41+6pg9jPu5IS788l76
	Wva0mP/6EKnH+j+RBzOkKI1Sqnue0lmJpAU/oAFdaWUoIaWQXDfg/BzCIwaXE79I5eUgSMVjztm
	4xamb7mr37pgZH5vyhIKDDJ6htgGzjIQEUo7njjOs1tbi03ECGsVNv7sISCoBNoBJ0d1ufEQFiL
	MVTPjPdPfrsqckFo+VzlhKQXaBL5WM5i0xPSOgahZ8R2Vt3Uvt2oI0FH/gY1P7xS77LGASgJ41Z
	dVj6ygcskMURSDZEbPlJ6Jndo1JJl0LPZBhraIvgiLCyNlfGWv/TBZYmFjjHDoeI3YgLvLJ5z8C
	8vPzw+6dlx7nSJqDQWqXz2WiRa3yb9F9q00ZRi6cf3Fgp5w+gSSt8C+LgcD9YJFOfDM3SMiZkpG
	HF266lWC2tZtp6TmdyuK59EREYRl8PQbH2OBOsB2dfzmfsCpcUHougFR/IeMbbkdGlZX4FkNs=
X-Google-Smtp-Source: AGHT+IHuRhTGUiR2NIlai1bZW5SqOJBWIIwWKnWsf40J77cS2AzqDsRE/KFfqvOf5LEZ0cNzAruVbA==
X-Received: by 2002:a05:6000:1ac8:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-429bd6726a2mr523089f8f.11.1761847099845;
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:59 +0000
Message-ID: <20251030175811.607137-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
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

