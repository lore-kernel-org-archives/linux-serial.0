Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1432B122
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550412; cv=none; b=kzHwRceTirQIvmNdSkT+gncWouTwvHcQgWDDFQJ6T56oFjGEmQbyzOU3SXvO3QeQwhqQF6vXJWnovLmr9PbKs5S8XWqlOABarVX8glaG3sQ5K5T1otO3UA+T+U4Juv1B24NaHBJvx5wzAriAYuZ0x5NeAFnz0/ccajhCToRdmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550412; c=relaxed/simple;
	bh=91z+z59Pwcb/kiZKzSlCjY5dGY3dJ+BVbkEgnLDElro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ea+QS4rfZ8KVHkeBIa25U2ye7+fKSK5hAwAqufmucfzosvkrdx5HUCVE57kqlv9UWk57wwLzaVn3X9SM7ZwFxEhWTUnEVURKpRMYSNUCeOEmA1zvBoSHPqWp8HOXGPJeDtpnMe23kfTFX68TLQW6M4e4zkZhJDENCt8bI2gEtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkMtzD2S; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkMtzD2S"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f703a9d05so840817f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784550409; x=1785155209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8jc0IRFNjjSRdKsI6XkRn+ekjaqowPpNECwuezi5S0=;
        b=YkMtzD2SqvbWmZyObkz8MXZ2uBqC4zoEOni4nxQMO0NfKN63vEBd9Ys0B02ZjOtLSq
         UUuwsMgB6rnY1Ybbi8FDOi73fSkJPfwLnFwnI5gzSQZZbLSVY/eVDw4QPj2dZLg3AbxK
         YfpYXJ9n2tYmN9OcXYuAI7Of1sn3byugeI3xKAWn1MGMDIvSb2MoGSasVAciXUC/V+ZT
         jLDfBzzPV/yAIj6nD9Bck0a1X+S8ctKwfAJgxzbN4SnuEYVW/DDib802ErGim9I+2+4e
         d/3If3sFBdV/MNoJeE4SLIHf19kIKuHR9274+oGen7e62ygq+Xh9X0WutjRIpm0q610I
         NrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550409; x=1785155209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8jc0IRFNjjSRdKsI6XkRn+ekjaqowPpNECwuezi5S0=;
        b=re1GJSwxQVJxyA6MwL5Tfl4xzl9QOjr8eTW95Fd2Tzc2kjMk3AfRnWVfkliLVqVrYe
         JgXdkgKn3vNeUXXmh4ojnoXJysJaZEa6iY66u2EA5PmvA8QODGC/LwTMHLk404oVAcOL
         A88Ak8QjVpwY+f7Rqz5KGoglcql5zsBoznwHbRJ0MccSc5Emp0ofixSrla4+aiLs1h6p
         3+nU0bcHG3sB2qL67zKrxP86o5w13eSQF+AXPfcYBDRjyzyE8DKmqKpyx6p2+8aMQDPy
         l5qPuRM9hiYtS2pberDwXrYim3FJExj6HepTTqskQPgloaxy97y/aZyT4lIcrlR5Ci3T
         sZqg==
X-Forwarded-Encrypted: i=1; AHgh+RoQ6ndeswTyUl+XjGZtGXugR/FQV9sL8k9pJ40chaKvF9fhhdGNAdH9Nu0BblXAHOy8q2pZLpqMn2m9aCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGPLgAMge1ufCXSjOd8BOHLSAyGsYGCNTAoJo3Tnl7kCP7NSO
	Q0AczbnnRdfRAFFS8Lm3HHpcDyZumbZOk1oE4+/TRCFyT0R5dN03pcQ0
X-Gm-Gg: AR+sD11lfNShxNcf+6MngzcJusN7DJm5K1HCWUTTPtxSxXQvR7+O6D4AroL8mZXEtQP
	ILdh8T/4EILarN5OtS4tNpS0PBzGHoQtu21LovGdmGaiV0VkLtpqqT3KwV8i4cfD5CGkBt7Eq/q
	v+xyNlEArGOwsUl15f/MQQLF8mfCQuLaef2WbZ977a6p4PuuvfbbjJAGLg6XfsM89PG1JxQP0E7
	fc+0goed+YlbhWsh6j/eYIrUzImOd91OOstFiyxg163WbEeQK4YBxPgtOUZAZqW2qEGMZVOCvii
	N7zbABgh+JViKG3LA7l8CTN6Ve9EHLhHZzsVj6Al4ioQnALte77LeF704QO8Zz/JPL+vMd4vQjN
	i+EiG5F3Nq0KAr1j+r3dXlLEvgn6sDzBMe+h+juJi/CU1eibNxiAEhYH3YZY3OCCAh1YwXWf02z
	MJfANExQ==
X-Received: by 2002:a5d:5d0f:0:b0:47f:6ff9:1135 with SMTP id ffacd0b85a97d-47f6ff91564mr8421403f8f.40.1784550408657;
        Mon, 20 Jul 2026 05:26:48 -0700 (PDT)
Received: from NULL.Home ([2001:8a0:7280:4000:74ef:7b69:d912:ab76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm29648682f8f.28.2026.07.20.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:26:48 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: gregkh@linuxfoundation.org,
	linux@armlinux.org.uk
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [PATCH v4] serial: amba-pl011: don't wait for BUSY after every earlycon character
Date: Mon, 20 Jul 2026 12:26:46 +0000
Message-ID: <20260720122646.16994-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026071036-unworn-bunny-fec5@gregkh>
References: <2026071036-unworn-bunny-fec5@gregkh>
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
busy-waited for UART01x_FR_BUSY to clear before returning, i.e. it waited
for the character to be fully shifted out on the wire before the next
character in the string could even be considered.

Waiting for BUSY per character defeats the TX FIFO: instead of letting
the UART buffer several queued bytes and transmit them back to back,
every single character printed through earlycon was forced to wait for
that character's own complete transmission (a full UART bit-time at the
configured baud rate) before the driver would even look at writing the
next one. This is wasted time on real hardware, and it is much worse
under virtualization: each read of UARTFR and each write to UARTDR is
an MMIO access that traps to the hypervisor, so every extra poll is a
full VM-exit/entry round trip.

git blame on this function is unhelpful (this tree's history stops at a
shallow-clone boundary), but the equivalent history is available from
the upstream patch that added the QDF2400 erratum 44 workaround:

commit d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit"):

That patch added a *separate* qdf2400_e44_putc() for hardware where
BUSY can get stuck at 1, rather than touching pl011_putc() itself, and
it left pl011_putc()'s per-character BUSY wait in place. So there is
precedent for "waiting on BUSY is fragile on some hardware", but no
indication that pl011_putc()'s per-character wait was ever intentional
for standard hardware as opposed to simply mirroring the already-present
final-drain wait used elsewhere in this same file.

Both pl011_console_putchar() and pl011_put_poll_char() (the regular,
always-built console write path and the kgdb/kdb polling path) only
wait for TXFF before writing, never for BUSY. The regular console path
still gets a full-drain guarantee, but correctly obtains it only *once*,
after the whole buffer has been written: pl011_console_write_atomic()
and pl011_console_write_thread() each call uart_console_write() with
pl011_console_putchar (no per-character BUSY wait), then separately
wait for BUSY exactly once, after the loop, before restoring the CR
register.

pl011_early_write() had no equivalent single final wait, so simply
deleting the wait from pl011_putc() would drop the "the UART has
actually finished transmitting by the time this function returns"
guarantee that earlycon currently provides, e.g. right before a panic
message is followed immediately by a reboot/poweroff. Instead, move the
same "wait for BUSY" out of the per-character pl011_putc() and place it
once in pl011_early_write(), after uart_console_write() completes,
mirroring the pattern already used by pl011_console_write_atomic()/
_thread(). This keeps the flush guarantee while turning an O(n) wait
(once per character) into an O(1) wait (once per earlycon write call).

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
    after:  min 429.4ms  avg 435.3ms  max 449.0ms  (n=20)
    -> ~36ms / ~7.7% faster, non-overlapping distributions

  cmdline: <the VMM's actual default, quiet, earlycon=pl011,0x09000000>
    before: min  74.3ms  avg  76.5ms  max  82.2ms  (n=20)
    after:  min  53.8ms  avg  56.8ms  max  74.9ms  (n=20)
    -> ~20ms / ~25.8% faster

The second measurement uses the VMM's real default boot configuration
(not a synthetic debug cmdline), so this is representative of ordinary
boots, not just verbose-logging ones. Console content was diffed
(timestamps and per-initcall "returned 0 after N usecs" numbers
excluded) between before/after runs and is identical line-for-line:
this change does not drop, reorder, or corrupt any output.

An AI coding tool (OpenCode CLI, using Claude as the backing model) was
used in preparing this patch. It was given the observation that
earlycon output was slower than expected under virtualization and
asked to locate the cause and propose a fix; it identified the
per-character BUSY wait in pl011_putc() and, after being pointed at
pl011_console_write_atomic()/_thread() as the existing precedent for a
single final drain, produced the code that moves the wait into
pl011_early_write(). It also helped research the QDF2400 erratum 44
history cited above and draft this changelog. All of the above was
reviewed by hand against the driver's other console write paths to
confirm correctness. The boot-timing measurements and the line-for-line
console diff were run and captured by hand on the VMM described above;
they were not produced by the tool.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
v4: v3 mistakenly replaced this patch's actual fix (moving the BUSY
    wait to run once in pl011_early_write(), preserving the "fully
    drained on return" guarantee) with a plain deletion of the wait,
    which would have been a functional regression (e.g. for panic
    output immediately followed by reboot/poweroff). This reverts to
    the v2 fix, keeps the real, measured boot-timing numbers, and adds
    the explicit disclosure of AI-tool assistance that was missing from
    v2, per Documentation/process/generated-content.rst.
v3: (erroneous, superseded by the above; sent by mistake)
v2: Rather than simply deleting the wait, move it out of the
    per-character pl011_putc() and into pl011_early_write(), done once
    after the whole buffer is written (mirroring the existing pattern in
    pl011_console_write_atomic()/_thread()), so earlycon keeps its
    "fully transmitted by the time this call returns" guarantee. Also
    added the QDF2400 erratum 44 history as context for why the BUSY
    wait existed, and re-measured with the revised patch (numbers
    updated accordingly, same conclusion).

 drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22b..05a783dda4c4 100644
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
@@ -2750,6 +2748,20 @@ static void pl011_early_write(struct console *con, const char *s, unsigned int n
 	struct earlycon_device *dev = con->data;
 
 	uart_console_write(&dev->port, s, n, pl011_putc);
+
+	/*
+	 * Wait for the last character to be fully transmitted before
+	 * returning, same as pl011_console_write_atomic()/_thread() do for
+	 * the non-early console. There is no need to do this after every
+	 * character in pl011_putc(): checking TXFF there already prevents
+	 * overrunning the FIFO, and waiting for BUSY per character forces
+	 * the UART to be drained serially instead of letting it buffer
+	 * queued bytes, which is needlessly slow, especially so under
+	 * virtualization where each poll of UARTFR/UARTDR is a trapped MMIO
+	 * access.
+	 */
+	while (readl(dev->port.membase + UART01x_FR) & UART01x_FR_BUSY)
+		cpu_relax();
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-- 
2.54.0

