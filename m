Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474365;
	b=EvpJrVae0wv4V7Ef5jVGOz2bsFok5rjUeXw4pCEFEX8hj1KKO5c+GXQHr1Xi/v+3fqnE
	 OFF2Ry3lpDqsy48MwWSOOu8HBMlEW648uO/1Ic+qpAPaniiVR6oWuNtrMkbRW+9MuBRrD
	 UQIDmQH1ZHmBi7mYhRiQRsQhSXC7hFoFxm3Stb+WIF9otA/n4WtORvioNvDp8hKGnZAEX
	 NMrBv6dHj/RplHnINg98h6CjgpBqDjY5gHp3Qe0oM0wv7ccJZ6ABHK2HHjlC8yquiWP38
	 EQLZQZ3MHufhJRnc1icHOzpGPSGQ45maNoK5rIIqA9zhuQHtxS0uhHedv1TmPeevtBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=MfUIqTpsmGf12d0YxNZ6y6o/elGBodL/n6v9C4By9jw=;
	b=dXxfl9mtCQhrtpHmTD9eJSROtqYtK8PgEul5ttNo3aU3TYnYWlqIqR3I5JoxffCCxvbL
	 FvoAWvWhh3GZT0B1ZjS/WgqMdCjcAwslRZtsipxqGAJ4w26UFdJHpBWLpfA/DJ19viBLU
	 pOOseE+tUC+2NnSWkfQ5smBRRyBX52qPFdSiK6/mGOomdW5QP4a07mYshGsn2rbUzIHqv
	 isPGHxPDLjNhD39scYiw86mtYBLUVZ0GyVsN+BqWjVRHQHfxXDCh7aGWZxnVdi9kcBk7D
	 FKzabv2M8NzeVZTcIb+xlFzgzMXVfXzVx2Klfg5lQerowgxuBddrPTvu2pfnmnZDVcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OzrKdyX5;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA8606A326
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 22:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OzrKdyX5
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-851f720d7afso2331388a34.3
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795474363; x=1796079163; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MfUIqTpsmGf12d0YxNZ6y6o/elGBodL/n6v9C4By9jw=;
        b=OzrKdyX5jLGj3cEMTXqrdE0BJDXL6zVUPT1Ik0t45Ymd5NefkuI+tdkKI93fHBgBDM
         Y/CAHV5zQLJSK8gRGaNqztW9lYNilDfAHiDjMjMm8AFCM75uZOExhgnJQuqiVNYftCI/
         q6sm/3KIXnCkl/0bS7Gu20Domv5F24S05dBtKJuCgrp/g0YCEmJ5+9BP44GRNMubHrt3
         7S5eJ5OCcZb+a820Ncs/22icAeiZhllfpoKZQZZNsq2nTePeWKHM9gpBgYPkIr2AMyRm
         7vZXsDVHY9mJUwneDFrKqlcbW0zQ1IX7KHyKInSV1mpDExrJn2Qqe1opCfdSnt3nYZbo
         ZBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474363; x=1796079163;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfUIqTpsmGf12d0YxNZ6y6o/elGBodL/n6v9C4By9jw=;
        b=CQffLAswZTOoNKSL3stRSPoyOjYL/y5YV0B7LVWq4rpqS+umN5ZNU80H9UlR+DbOMQ
         mUy+8o2Mm269bUcM2dqGrfHnFnQZst53nM56M8oZ597eNrmDkijExxiFcsT+2tSnGx6Q
         Dlkvr/69mgAyYdAfgY4QRKCt0TOEt4P0Y5I9vLTEC72Ks41pGPPmE+fOCSSe3AsO/88c
         h8jRdRY+QFF+4aeyxTu0t8gStQ9Mt149h1oZXfogm0DW6KCuRNdbldg7qPgcOSn7Fp/q
         omgh0NLzzWoe47VfL2TsE3jescjWhs+EtPPqf0cGuuObPAEPxpVuh+lT3+GPDMOEs9Ne
         tgIg==
X-Gm-Message-State: APuU4Z9i0D4mz+AqtOFqSvjo4mZG4gvc18lrHcOdnJeMkmvUPnBRBerx
	TqrwXZ5698FlGQ9agzi3IV2ztKB+W+swp8HdkQDd2sISh+qECoBpw3UlpniPTjDxHTges+Yzh2e
	yMSAuNB/L04r5pTMOAp2rEUejpW8qQw==
X-Received: from ilef5-n2.prod.google.com ([2002:a05:6e02:6185:20b0:524:d8ac:6887])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6809:22d8:10b0:57b:473d:7d60 with SMTP id 5614622812f47-57b473d7dcdmr7263663b6e.40.1795474363280;
 Mon, 23 Nov 2026 14:52:43 -0800 (PST)
Date: Mon, 23 Nov 2026 22:52:38 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123225239.1653134-1-zhenwenliang@google.com>
Subject: [PATCH] serial: core: take the port lock when setting DTR in uart_set_options()
From: Zhenwen Liang <zhenwenliang@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

uart_set_options() sets DTR with a plain read-modify-write of
port->mctrl:

	port->mctrl |= TIOCM_DTR;

uart_update_mctrl(), which uart_throttle() and the other modem control
updates on an open port use, holds the port lock. kgdboc calls
uart_set_options() through uart_poll_init() for a port that can be open
and in use as a tty, so this update can race with them. If
uart_throttle() clears RTS between the load and the store, the store
puts the old RTS bit back, and the following set_termios() call writes
it to the hardware (8250 does so in serial8250_do_set_termios()). RTS
then stays asserted while the tty is throttled, and hardware flow
control no longer stops the other side.

Do the update under the port lock, as uart_update_mctrl() does. The
same function already takes the port lock a few lines further down to
set UPSTAT_CTS_ENABLE.

This does not cover one more problem in the same function: at its top,
uart_set_options() re-initialises port->lock for ports that are not a
registered console, which includes the kgdboc case above. A lock holder
on another CPU at that moment is not excluded. That is a separate
issue and is not changed here.

Reproduced on v7.4-rc4 in QEMU with two 8250 ports connected to each
other and a debug-only patch, not part of this change, that delays
between the load and the store. ttyS1 was opened with CRTSCTS and not
read; kgdboc was configured on ttyS1 while data was written from the
other port. After the tty was throttled, RTS was still set in the MCR
register in 5 of 5 runs. With this patch RTS was clear in
5 of 5 runs. Without the delay (one control run) we did not see
the failure.
Configuring kgdboc needs root.

The problem was found with a Lean-based formal model of the code and
AI-assisted analysis. The patch and this description were written with
AI assistance; a human checked them against the source.

Fixes: f2d937f3bf00 ("consoles: polling support, kgdboc")
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
uart_set_options() sets DTR with an unlocked "port->mctrl |= TIOCM_DTR"
(drivers/tty/serial/serial_core.c:2294 in v7.4-rc4). kgdboc reaches it
through uart_poll_init() (2696) on a port that may be open as a tty.
If uart_throttle() clears RTS under the port lock between the load and
the store, the old RTS bit is written back and set_termios() programs
it into the hardware: RTS stays asserted while the tty is throttled.
Also in next-20261123 and all seven stable branches checked (5.10.y
to 7.3.y).

Needs root (kgdboc configuration) and a port open with CRTSCTS;
functional bug, not a security issue.

Reproduced on v7.4-rc4 in QEMU (x86_64 TCG, 4 vCPUs, two linked 8250
ports) with a debug-only mdelay() between the load and the store.
kgdboc is configured on ttyS1 (CRTSCTS, unread) while ttyS2 floods it;
then MCR is read:

  v7.4-rc4 + delay:           RTS set while throttled in 5 of 5 runs
  + this patch:               RTS clear in 5 of 5 runs
  no delay (1 control run):   RTS clear

In the fixed runs the throttle came after the locked update: they show
no stale write-back, not behaviour under contention. Without the delay
we did not see it; only 8250 was tested; we did not measure data loss.

Limit, also in the changelog: uart_set_options() re-initialises
port->lock (2265-2266) for ports that are not a registered console,
including this case; not addressed here, your view is welcome.

Backport: 6.12.y and older lack the guard form; they all (5.10.y to
6.12.y) have uart_port_lock_irqsave()/uart_port_unlock_irqrestore().

Found by a formal code verification tool under development (Lean-based),
with AI-assisted analysis; verified by the reproduction above and human
review. The patch and this text were written with AI assistance and
reviewed by a human. Point of contact: Zhenwen Liang
<zhenwenliang@google.com>.

A search of public list archives, git history and syzbot found no
earlier report.

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b06d2649be34..836ffa8cb845 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2291,7 +2291,8 @@ uart_set_options(struct uart_port *port, struct console *co,
 	 * some uarts on other side don't support no flow control.
 	 * So we set * DTR in host uart to make them happy
 	 */
-	port->mctrl |= TIOCM_DTR;
+	scoped_guard(uart_port_lock_irqsave, port)
+		port->mctrl |= TIOCM_DTR;
 
 	port->ops->set_termios(port, &termios, &dummy);
 
-- 
2.56.1.809.ga0b61035b5-goog

