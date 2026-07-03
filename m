Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B72857CC
	for <linux-serial@vger.kernel.org>; Fri,  3 Jul 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106230; cv=none; b=l5y97MzGG2cJTgWt/IfEOFGMysb9B+uCUeX98itFjOcrB6A+7hr+f8+IkRRLIeBoIIzdp+HINowDDVwa3vGpSQupFdb9UjFrwbqzcQojh2OLKT2sKeNQw21yTyF6+01DorpwP2vAACC2KikI28blG0p1CXAwyqGuCy1ZHE/Ft84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106230; c=relaxed/simple;
	bh=afcGtcbD7PyUaW+UT819p4KtVldnDVK4+9AMza4MjHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApvGC5fujml8cauhgrvhz2GHpP4PC8NMCNT5Jcc0Ki8GT4ibOZVTwsT8dL6PI/Hcic5c36tD1vT1kb6+F/TIq/sK+/PyCyx2BSBmSbepkoR3Bd31co/wftZy9qBXtGigHFnKn52EccfZVoTatwhLR3Wgr9IVbd5BgDwDmp13Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGgGhY+X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGgGhY+X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so9270865e9.0
        for <linux-serial@vger.kernel.org>; Fri, 03 Jul 2026 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783106226; x=1783711026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m3ClRH4jl2tb7BZ7KSJbaDqRdwPINA72LSU9ZECVwHk=;
        b=aGgGhY+XQd88wUJmqm0ooFnoiuH+1wzaQ9pF4nw3KeoOx1TENlmB8s+YfqvuSoOVVo
         fKaATl6iCobw2Dg1Bvsg10IL08yFQneW7BLbG8AzGI5mhNUEvO4FytIda1XujY0Jn1Me
         oS/MqNxzeiIistMl7h9Teus5OT9oD9Oj7aN1AcWNPl56e/B4RNnxZa3J8Vbl/OH06B5Z
         D2UHrZQoQANfgcY6E+p8J/TAPFs8zfg+DyqD2RnKJi0tKTvjwW/ITJDUzPI0h1tUPGay
         s6kmXoZKVnMzaPQUj0VuJ6TUpsWSnB/bAmG935w5X8vPgfLe1Mic1fsrzvhVoLhlX41I
         wXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783106226; x=1783711026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3ClRH4jl2tb7BZ7KSJbaDqRdwPINA72LSU9ZECVwHk=;
        b=IoIey+bUhQ/D6/XJ+M+H/9thYXTp2irXcYiPLQuFCFKHUm9M+cCSZBf04r3eFYyJKo
         YU/HrpchSZSGWHJnt5Y/sTn/UX8BmwkAUbmCi8LjEOpncK/HDmJCsGsxYojvSC8lhVxA
         c2AwIB5eTc2349Giptu7XQhbYY955gA3ME/Hflh52HnwQii8MXNhzAN2ZgHhvZlxXpb/
         ZdHOiZvPLZGSVDYCjtER4N2BajsPhgpNPrJ/ZkZA2ktMdBcFgFS7YsYiemMZgNGFJl/Z
         S9fALkFkwKFCLQJIrdHZ0CKyf9bn2FOzFFG1lR6UaRoT72shsIryXf83A3q5jR78BAys
         96rw==
X-Forwarded-Encrypted: i=1; AFNElJ+N3mtd56DrATmoSxx/WKEVORRNEf2msWCyMO/r1UtmIR8TwGLjHoyqVMYrqz+UYSQ5oFMLQN/XOzVaYCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRghAprnINcnPbsMSYTFstgK8eA7EQ+mWwARy+rq6ENh1NEtMR
	50EARNJ9heGgRifpC1fVSwI7Emzm8PeR6Wf5FcWVRF2+9MvLbf2VC9xX
X-Gm-Gg: AfdE7cluEOZDtS9It1e+38DlRJk+u1dULlRAn80ZUAibbsV4Yz7ZMP6dABbWauEhNbD
	rjHIbv/nHe4BuKoM7ePP8XuoAsGiqKneCq6yELiLARemlZAdpnI0OC50rfJHceqqpvbagp1uvnB
	AkahdZ3lBaLGU0n71ubeOX1KioLG2/HiiCwNfSVzVJQderHJW1Xds5NBu1t2QL6vpTiziLJhEDo
	gMv6ctkjiiOKJWlEEoKbzCUVnrRjSKpI7EtggtCrEZobkjoEU8OE+a51ejx0FHpNdSV0smhhTxb
	8pCD5lI/i2LGYo1XIeiJKvDQXGzVxhRZkIgqJtigsCO/AidlAyLb7YxQUAVsNc/shEMkQ9yHg0B
	RucuIJ6tyu0u0x3rmmPQGvifJaZDt8Bf22gchw1rjNnWVIHDgFkmhqVNCfdbAPSdcKJYwDutEgA
	huTDkyiXES98Bi
X-Received: by 2002:a05:600c:c1c8:10b0:492:1e36:1fe9 with SMTP id 5b1f17b1804b1-493d11fafa3mr4291585e9.37.1783106225693;
        Fri, 03 Jul 2026 12:17:05 -0700 (PDT)
Received: from fedora ([2001:8a0:7280:4000:74ef:7b69:d912:ab76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4a343csm180051065e9.0.2026.07.03.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:17:05 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Eric Curtin <ericcurtin17@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: drop redundant BUSY wait from earlycon pl011_putc()
Date: Fri,  3 Jul 2026 19:16:36 +0000
Message-ID: <20260703191638.131476-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_putc(), used exclusively by the pl011 earlycon (pl011_early_write()
-> uart_console_write()), waits for UART01x_FR_TXFF to clear before
writing a character (correct: don't overrun the TX FIFO) and then *also*
busy-waits for UART01x_FR_BUSY to clear before returning, i.e. it waits
for the character to be fully shifted out on the wire before the next
character in the string can even be considered.

This second wait is not required for correctness and is inconsistent
with the rest of this same driver: both pl011_console_putchar() (the
regular, always-built console write path used by every printk() once
the full driver is up) and pl011_put_poll_char() (kgdb/kdb polling I/O)
only wait for TXFF before writing and never wait for BUSY afterwards.
pl011_putc() is the only one of the three that serializes on BUSY, and
it is the one exercised the most heavily, since it backs earlycon and
therefore every line printed during early boot before the real console
takes over.

Waiting for BUSY defeats the TX FIFO: instead of letting the UART
buffer several queued bytes and transmit them back to back, every
single character printed through earlycon is forced to wait for that
character's own complete transmission (a full UART bit-time at the
configured baud rate) before the driver will even look at writing the
next one. This is wasted time on real hardware, and it is much worse
under virtualization: each read of UARTFR and each write to UARTDR is
an MMIO access that traps to the hypervisor, so removing the extra
poll removes one entire VM-exit/entry round trip per character printed
through earlycon.

This is easy to see, and to prove, in a fast-booting VMM. Using a small
KVM-based VMM that boots Linux guests directly on arm64 (no firmware),
booting an otherwise-identical 7.2.0-rc1 kernel (single vCPU, 512MB
guest, direct PL011 MMIO with no interrupt-driven UART - i.e. earlycon
is the only console active) up to the (expected, rootfs-less)
"Unable to mount root fs" panic, with 20 boot samples per kernel per
configuration:

  cmdline: console=ttyAMA0 earlycon=pl011,0x09000000 ignore_loglevel
           initcall_debug printk.time=1     (~99KB printed over earlycon)
    before: min 466.3ms  avg 471.4ms  max 480.3ms  (n=20)
    after:  min 429.5ms  avg 433.3ms  max 442.6ms  (n=19)
    -> ~38ms / ~8% faster, non-overlapping distributions

  cmdline: <the VMM's actual default, quiet, earlycon=pl011,0x09000000>
    before: min  74.3ms  avg  76.5ms  max  82.2ms  (n=20)
    after:  min  53.6ms  avg  55.4ms  max  60.7ms  (n=20)
    -> ~21ms / ~28% faster, non-overlapping distributions

The second measurement uses the VMM's real default boot configuration
(not a synthetic debug cmdline), so this is representative of ordinary
boots, not just verbose-logging ones. Console content was diffed
(timestamps and per-initcall "returned 0 after N usecs" numbers
excluded) between before/after runs and is byte-for-byte identical
line-for-line: this change is a pure removal of unnecessary polling,
with no functional or ordering change.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22be..2a25095e8d8c7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2741,8 +2741,6 @@ static void pl011_putc(struct uart_port *port, unsigned char c)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
-		cpu_relax();
 }
 
 static void pl011_early_write(struct console *con, const char *s, unsigned int n)
-- 
2.54.0

