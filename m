Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DD39BFE1
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195589; cv=none; b=cR6KLUCz7geBSQYxWkKd02rHOGF9cqKxs+gBnl2hkG2olufywu9yRPaTsD44aY+VaVCKHi/Mw/PVoFGWghzEUkS8fvqmGdhTOCwEVeNhqmvkTn/0KKk08xl818k4UK8iQOGGQHqvLWwEPnJIqfkjzrPCLbZDOM49NV02S3Z8e04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195589; c=relaxed/simple;
	bh=Zbvy1O++/pnSoStSV+8mco8OqlJIVst8FKQqHOa93UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=eHUkY0HhXHHZdAI6pYD3+LgLpRYIzL6DCapguZzL834hUzVPAafhUaQu+GCtXKCfQwVxRyxKNKuNCYZgr8Kq6vJQDvtdZtcy3Ua7wh2TTGK2Og/04iHURs6fivINx74pkmv1y3nWZnPjU4fcoCq7JfQSJqda+3n1JYzqUMwjrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=nPhs2M/b; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nPhs2M/b"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-78677e30980so983501137.1
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 09:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195587; x=1788800387;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yz+SlEJxTrhVGNjozUlkHKCqwLCZLIFaEBLA1h4I/Gk=;
        b=sTBLA6X8PkOgHqZt1ScHecvlAt/yKL/Riez4t9NzZdnsooMK7YkQFinJksF5b7INMu
         efgDI0kTCfPCjhLlgcoY5zCq0fqpKDuVkpsfQqIFm2uchnyH8GJTuGSjRxB66zpvnWhY
         ZP1lrdmyY72WItmCQCo0Bzh/jKTWEWEBrqHbweZdDVo73+dYnegvJ2ymtbP4zONW7qXV
         CfSqiBPE7FmN8qKKbprMswkkIfr5CXnr1rDAwx6bg75KvTTMgIISOJSs/m8BHGtZtcco
         5yxXz0XGxiaD3dWD1Db8AT7X0ucIb5mP3qEtR40nKMVC6CwdVEdcqohZOKcMRaHHMT+7
         Z5mw==
X-Forwarded-Encrypted: i=1; AHgh+RruKRnqAk9TyF1WtpfdjYF7yFzoPJop+wvkBJLrGg0jqM2zGpSqFCUsweHwVYZQYmrZ7M3Dfeh325r63N0=@vger.kernel.org
X-Gm-Message-State: AFuF++mwpQEMzKojTkjT/yYsHepUrqGfyXpuvXCGAft+wdwtpjf164J2
	0jCXCbtlKHqdwDox9y0a94SeuVeb8XJhFA1By6FpMLMdywKIjFtCzkDRMjU1eMksOxxWAfmW83F
	+RUDHV5tgkYwbgsRjqPI3zGit17S+ZmLtOA==
X-Gm-Gg: AR+sD13Ad7Svw07IXdXBqAR4glaftv9MdOsFTFucnfjdyKQfIFV4o5dtAQDLrAaOMb6
	eoFOebklz88DhZSo1rOVtlhtQo6bge8RAOQ/SjtozJ0t1mELNsPkbAXoxSFU93/ml29qBoSQsA1
	qO5PGiDmK+gKLo2Mqin3nF0S+axzDQjB+fqVIemPID/9H0QPSkpAgeqU/hxsJTERvksTHdahL1Q
	0xVTVrJce79iRCHUN3kFSnd1N4h36lQGgv8KvOczD0BFyQopTs2azB137A/YMgCxOd+8M3KF+V5
	ZHS509ecsc3OVMVdjbXxX0k0cNX7n+e/YSeBDeY1LQ/cOPDZlECUEqlmVoZombHbjSHselOc+iG
	0OfOenFj4a3LHx6CkORHl1Qu2WrzTpej3IhUD4IXJwjDYtNxNlW9fAis6mTPZ+FcGnBNc
X-Received: by 2002:a05:6102:578b:b0:786:7a59:a313 with SMTP id ada2fe7eead31-789fc3e189fmr802913137.13.1788195586757;
        Mon, 31 Aug 2026 09:59:46 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-52-52-135-65.us-west-1.compute.amazonaws.com. [52.52.135.65])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-785f842fd8bsm120358137.20.2026.08.31.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:59:46 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1788195585;
	bh=Yz+SlEJxTrhVGNjozUlkHKCqwLCZLIFaEBLA1h4I/Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPhs2M/bzemz0ItWvdh/FZjFAeg/p+GeT6gfMTYhmDscg2KkWW+2S+fH552NT9Ixp
	 WetIbfv0UcJWqrOWfo+jZ2h4I7h+LjTrpnprd2HVm7Kd28KG061OaS8g5P89J5GrSw
	 /HXojO7zgfso5D6RU/Ig85w1uakjy0JXwxNVxVuP6/EtfL5x9A11p2PVTswbFYOPDg
	 vPQoBXb35vTIpk7CVnf1dCV4Atvxv3qvSv1Qh+5EwdSudZmZZXpGuj+YCOiEZmLN/8
	 IuZs9+I4AXSaxUuZbK9MjCvJyQSY7E82BEzUKMMWdKqG1j4+S3NkHjO5gDkhxTYC3y
	 fqKQrYUAppfqQ==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 6E2C0C2E81;
	Mon, 31 Aug 2026 16:59:45 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 2/2] serial: 8250_mid: wait for LSR tx empty before setting termios
Date: Mon, 31 Aug 2026 16:59:08 +0000
Message-ID: <20260831165911.2029839-3-whiteberg@arista.com>
In-Reply-To: <20260831165911.2029839-1-whiteberg@arista.com>
References: <20260831165911.2029839-1-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

If mid8250_set_termios is called while data is still in transmission,
the corresponding register updates will corrupt the transmission.

Fix this by locking the port and and waiting for the transmitter to
empty before performing updates. It is necessary to wait for both
UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

Fixes: f549e94effa1 ("serial: 8250_pci: add Intel Penwell ports")
Signed-off-by: Tate Whiteberg <whiteberg@arista.com>
---

Changes in v3:
  - Update Fixes tag
  - Apply formatting change from andriy.shevchenko@intel.com
  - Use scoped_guard() as suggested by jirislaby@kernel.org

Changes in v2:
  - Separate changes to 8250.h and 8250_port.c into prerequisite patch,
    as recommended by andriy.shevchenko@intel.com
  - Apply feedback from andriy.shevchenko@intel.com to 8250_mid.c

 drivers/tty/serial/8250/8250_mid.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 82656645b8a6..9c5ef207bf8a 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
@@ -209,6 +210,7 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 				const struct ktermios *old)
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
+	struct uart_8250_port *up = up_to_u8250p(p);
 	struct mid8250 *mid = p->private_data;
 	unsigned short ps = 16;
 	unsigned long fuart = baud * ps;
@@ -231,11 +233,16 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	}
 
 	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
-	p->uartclk = fuart * 16 / ps;		/* core uses ps = 16 always */
 
-	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
-	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
-	writel(div, p->membase + INTEL_MID_UART_DIV);
+	scoped_guard(spinlock_irq, &p->lock) {
+		p->uartclk = fuart * 16 / ps;	/* core uses ps = 16 always */
+
+		serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+
+		writel(ps, p->membase + INTEL_MID_UART_PS);	/* set PS */
+		writel(mul, p->membase + INTEL_MID_UART_MUL);	/* set MUL */
+		writel(div, p->membase + INTEL_MID_UART_DIV);
+	}
 
 	serial8250_do_set_termios(p, termios, old);
 }
-- 
2.43.0

