Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05328488F
	for <linux-serial@vger.kernel.org>; Fri,  3 Jul 2026 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107492; cv=none; b=LHE6Ek6DErEZlqI7zxnbzPxDuGt04jAFjJJDn8mtRPCoYzJ9fDf5jW+0MoXlpS0QZ7H89vH9tQ39f3C7iQu6oLBPSy2zhZI9fqd0r6wAhcY/uACiLKBdYgLexoz2Qm6z02TvpBiFOOmSkcXI4GHbfTsD8VNObXgNU4XMYOT/7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107492; c=relaxed/simple;
	bh=FeCOnklRerw7sXYwd6Nw/EMkh3G8k/wwxKyVHYd2LG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtcs4W74gB2/0qJ1xe1ZKshoxuGo6OD/86o21vzblOhG6WDh0FnzVZZQf+z4xH7AwzwE1osGziGtZ50lNzfE2SkNn+MwP7PKtlCvF4ps5d9xzxKchPKsi/I/3oSnlK/CUyMarrcSaIF+nE2ATpny7gAKOcQUv3sqf2mFgCsqNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/i7wPz3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/i7wPz3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-471eeac43bfso971300f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 03 Jul 2026 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783107489; x=1783712289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE9HGOf38ojrULtRh+7x9FTkImpcKADoGX4md0SiTHQ=;
        b=h/i7wPz3pgF9EERs2WK4054Y72OzZKvE74G1E5LQPZRjqF5plWQ7grzPpPTk1j8u+S
         cB/uRsZyxR20mPAl74mFzSZHkwKXRho3Mdu+otrExKPKkNw/pLbAk5Wpbq+7wKmFy/LE
         PruwRDA7tlmtox9KW8xUKW6FLORY1Myo39/QxeuzAXU+uJcmfimq2DeMYeRRuQxnQ9up
         xkmjig5jlPRPNkIqggRYBBm3YZ53lMdYaQUghtaraczXb/JHj9iK7017DwG0OYKHPBh3
         L0hM65Llrx4G9sGcayZUE5yKjdEIoxbKF8Uf5xhKmWhT0HRoyM4NS565V0I9aA8nGZoM
         oWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107489; x=1783712289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qE9HGOf38ojrULtRh+7x9FTkImpcKADoGX4md0SiTHQ=;
        b=poS3I+JQ2znL188RQ4B03uQ5QNC2DxzXobCuzgXbijMrEV54pKk4HqCn+4r0ierAM7
         Ngo0o0a2GxDEBFYVNc3I1oR93BjtBxeCq/Jx+eDUvb/lMfgK/DdxnayW/+lqxQErGTrT
         Z0Zpr1zXh9CKhLGeTvTIkyT5lAjOJCUrX7UOl9ifTaMh6P0JH8yIhYrKWjQie6nbAoaR
         sLUb47tKSqNVIb1LRzq82zxEgwcMAOMMYFwq/IKSJMAye+YiDLooG6mrvUbxwFHJLBTS
         fITsxz7ObpLsicUqoDxTSf+YPiq8g5zQRP3PNG4cy9+FqYsijRzttUHWDYPv/jXmtgLg
         5HpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4zVtRlT224mvBS4stT3h0876e0BN5HcLbjMmOT2DX34DysMfaNEsLX3ZxzSYPvCF3tt+QsujcGB2uD38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyi3IZZqmgMQJ9/Z1nQEaKUIffnfMuc19FcRq/TSpqqLgB6igX
	Hfengkt960OILFjU68mpJml8Zvchz0bej6X0RSCSYNI8hZ9lLx311m6I
X-Gm-Gg: AfdE7ckCHy6E0gIsWF40hM/1MBHJC3tiosuCObanqN+hpktG23Rt3RvF8daK296jqZJ
	/EZJyXzovqbdX8qVlnJFGGRrAvXmt80JOTI9aljqms8UOiYBKpq6quiCY4WAx5Pq87vtaiYEsea
	V+PeaRaSBP390pQv5TQ4qGHY1TpGR7VYqMGcOZybVhkY0muWwEtamxkb7pibsTAvfiAIOtK971y
	D9TX0RgMaq29nvrX/0Xin3X6euqZriXY4+NUuCpUy39Ius0FUnFv3oj7Q6jpdN9CPlBScoRoLiq
	2Nu/Dyt3MMD4+ZGBPGoh0qnNbECHSW4NVA3eG3vc5/sNEs2sO8Dt3GJNAEeBi0V/ovdUsSIQy3p
	FV+oMziF83Zm8XQ9+WtjnUlFeYqS3IBtttIU37iqWI63eKTd9ZiWFTQfr2SMVcD/RLJVzxIxI4P
	mwPPgiWlsEmx+f
X-Received: by 2002:a05:600c:8b28:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-493d11d274dmr5578535e9.7.1783107489385;
        Fri, 03 Jul 2026 12:38:09 -0700 (PDT)
Received: from fedora ([2001:8a0:7280:4000:74ef:7b69:d912:ab76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm147378175e9.6.2026.07.03.12.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:38:08 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Eric Curtin <ericcurtin17@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] serial: amba-pl011: don't wait for BUSY after every earlycon character
Date: Fri,  3 Jul 2026 19:38:04 +0000
Message-ID: <20260703193805.135511-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703191638.131476-1-ericcurtin17@gmail.com>
References: <20260703191638.131476-1-ericcurtin17@gmail.com>
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

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
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
index 8ed91e1da22be..05a783dda4c4a 100644
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

