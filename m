Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425046C4D9;
	Mon,  5 Oct 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215467; cv=none; b=FK9O9lu7fg54toynKY94gYGnfkt8LcnwA11j+x34NIlyHHpYv2/Irh8PWTMUM9rTqOPlUbla9awErgNmiSHgXZHZ1dtosOlWv8Rb3Et4pdM2tnvzvWfn0Yf4TYe6MQXSRuFypgwF0VBCPLBilXj4aj5iU6s+P5sU8a/DKh5oNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215467; c=relaxed/simple;
	bh=Axy1v3/O+XHGochL1UAQ8OV1LoRotpMOTKI/tNqFgoc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MGGldAP1yCRCKj678nvNZTTMF+0cv+e5Wg8FQzxWf/UlExVNGQcztAWDVKHFrgyeFdBAHmfJnOt1FhLm/P/sJCawCVkejksvCUxzrVY9kRTjiUDNEWtS+7bfV4+jsAMcnmRXW2eNPE85xG0sGfYjs0V1ALAH1w0tS8rm4KFOjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=zdEpBDM5; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zdEpBDM5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=Z+MfAJeUKAYSkAAvJ+QnX+Fdkoqg0gkQGDWZV7UWNj8=; b=zdEpBDM5Z+iWt1lGFASP9KXE8S
	iVsOr+GD+pSHZhKwbUQ8/BQ3vzf8ltVupgOBXdx6OuScGRYmOZQGz74xyRjV0/8pQgXJMC4VYNRgB
	IcVHN8KVafCwTA9Wf6k85R7K2oyl/UTF6iTN6UBSVyYlB64YjAW2eWfsprE+z6ovoVKU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xDkxx-000000001qP-2Qfu;
	Mon, 05 Oct 2026 11:51:03 -0400
Date: Mon, 5 Oct 2026 11:51:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v7 0/9] (no cover subject)
Message-Id: <20261005115102.0b865d739b0c53a082ab2463@hugovil.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Mon, 05 Oct 2026 13:19:31 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> Changes in v7:
> - patch 5 reworked: instead of draining the FIFO at line rate - up to
>   fifosize+1 character times of uninterruptible sleep per close(),
>   pointed out by the v6 review bot, and unbounded with CTS flow
>   control holding the FIFO - shutdown() now stops the transmitter
>   (MODE1 TxDisabl): the character in flight completes, abandoned data
>   is discarded, and the auto-RTS release is given the configured hold
>   plus one bit time before power-off. close() is bounded by about one
>   character plus the hold, independent of queued data. This also
>   fixes a bug the drain still had: a truncating close() on the
>   auto-RTS path powered down mid-transmission and froze the
>   transceiver asserted on the bus until the next open (reproduced 9/9
>   on the wire: 0.6-2.4 s of stuck DE plus a corrupt character at
>   reopen), since the drain bound could expire with data left
> - patch 8: shutdown() gates first - teardown interlock and interrupt
>   mask before any wait - and the envelope wait honours only the
>   after-send hold plus two character times; the final RTS release
>   settle is tightened from one character to one bit time (the
>   measured pin propagation is one tick of the 16x oversampling clock)
> - patch 8: a write landing while the envelope is in its send phase no
>   longer rewinds it to the before-send phase, which inserted a
>   spurious setup delay mid-stream; the teardown interlock now also
>   fences the in-flight transfer adoption, so a reconfigure racing a
>   teardown cannot re-arm the cancelled delay timer; and an RS485
>   disable flushes a queued RTS worker that could re-assert the pin
>   after the settle (v6 review bot)
> - patch 9: the deferred-TX release in the rs485 worker takes the port
>   lock through uart_port_lock_irqsave() instead of a raw spinlock
>   guard, which start_tx()'s lock drop/retake would unbalance against
>   the nbcon console handling (v6 review bot)
> - patch 9: a write deferred by the reconfigure gate is restarted as
>   a fresh envelope: the reconfigure helper's transfer adoption
>   otherwise claims it and the restart pumps it in the send phase,
>   skipping the configured before-send delay (0.3 ms on the wire where
>   20 ms was configured; caught by the v7 regression run)
> - the shutdown rework was re-verified on the wire: the regression
>   matrix plus close/hangup/SIGKILL truncation scenarios on both RTS
>   paths and both polarities, at the baud extremes
> - Link to v6: https://lore.kernel.org/r/20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com
> 
> serial: max310x: RS485 delay and RTS fixes, software-timed delays
> 
> The MAX310X hardware can express at most 15 bit-times of RS485 RTS
> setup/hold delay, while struct serial_rs485 expresses the delays in
> milliseconds. The driver rejected anything above 0x0f with -ERANGE,
> upon which uart_rs485_config() wipes port->rs485 and silently disables
> RS485 - a device tree asking for a 20 ms setup delay boots with RS485
> off and an unusable bus. The values that were accepted got written
> into HDPIXDELAY unconverted, milliseconds as bit-times.
> 
> Patches 1-5 fix pre-existing bugs found on the way: a termios write
> clobbering an active break; breaks never reaching the wire on RS485
> ports because auto-RTS only drives the transceiver for FIFO data; the
> milliseconds-as-bit-times unit bug (patch 3 first centralizes the
> transceiver register programming with no functional change, patch 4
> then converts the units); and close() powering the port down
> mid-transmission, truncating the final character and, on the auto-RTS
> path, leaving the transceiver asserted on the bus until the next
> open. Patch 6
> adds active-low RTS on the hardware path via IRDA.RTSINVERT. Patch 7
> is preparation, and patch 8 adds the software-timed RTS path that
> takes over whenever the hardware cannot represent the requested
> timing, clamping the delays to the UART core's maximum instead of
> rejecting them. Patch 9 fixes a reconfigure-versus-write race the
> asynchronous rs485 config application has had since 2016, which the
> software path would have made worse.
> 
> v4 was all of this in a single patch; Greg asked for it to be broken
> up into one change at a time [1]. Splitting it meant re-verifying each
> patch in isolation on hardware, and that re-verification found two
> bugs v4 contained: a set_termios() or TIOCSRS485 during an active
> break released the transceiver mid-break while the break bookkeeping
> still looked correct (prevented by the tx_break ownership guard in
> patches 2 and 3), and the patch-9 race, where a TIOCSRS485 followed
> immediately by a write could put an entire transfer on the wire with
> the transceiver released.
> 
> Tested on a MAX14830 (SPI, i.MX6SX) driving RS485 transceivers: for
> each patch the bug it fixes was first reproduced on the wire with a
> logic analyzer against the kernel one patch earlier, then shown fixed.
> The complete series additionally passed an automated regression
> matrix, grown during the v5/v6 review rounds to more than 40
> scenarios: both RTS paths, both polarities, RS485/RS232 mode
> round-trips, close/hangup/SIGKILL landing in every envelope phase,
> output stop and flush mid-burst, mid-transfer path switches in both
> directions, XON/XOFF injection at idle and mid-burst, and termios/
> TIOCSRS485 disturbances landing in every envelope phase (setup, data,
> hold, break) - each scenario checked both on the wire and against the
> driver's reported state.

Hi Tapio,
Did you forgot the changes for V7?


> 
> Changes in v6:
> - every patch now carries the Assisted-by tag, which v5 omitted [2]
> - patch 1: the LCR clobber is now described as "overwrites the whole
>   LCR register" in the message and as a whole-register write in the
>   comments (Hugo)
> - the character-time caching and the shutdown drain-wait comments now
>   state their reasons in place: both values must be current before
>   the RS485 helper runs, and the tty layer's wait-until-sent is
>   bounded by closing_wait and absent on hangup (Hugo)
> - the old patch 3 is split in two: patch 3 only introduces
>   max310x_set_rts_ctl_params() and folds the three copies of the
>   HDPIXDELAY/MODE1 programming into it, patch 4 then only adds the
>   millisecond-to-bit-time conversion (Hugo); break_ctl() keeps a
>   single max310x_rts_ctl() call at the end instead of duplicating it
>   in both branches (Hugo)
> - one_char_duration_us is renamed to char_time_us and the shutdown
>   drain bounds to tries (Hugo)
> - fix: disabling RS485 during an active break left the transceiver
>   driving the bus indefinitely - break-off only ran its restore while
>   RS485 was still enabled. Only the break assertion is now gated on
>   RS485 being enabled; the break-off restore always runs and derives
>   the register state from the current configuration (patch 2)
> - fix: a reconfigure that moves the port off the hardware RTS path
>   while a transmission is still in flight - a termios change or
>   TIOCSRS485 pushing a delay above what the hardware can time at the
>   new rate - released the transceiver mid-transfer, and the rest of
>   the data was shifted out with the bus undriven, with no error
>   reported. The helper now takes such a transfer over: it enters the
>   software envelope and keeps RTS driven across the handover, and the
>   normal drain path arms the after-send hold (patch 8)
> - fix: a break that begins while the previous envelope's after-send
>   hold is still armed - TIOCSBRK waits for the output to drain, which
>   lands it exactly there - was cut short when the hold expired and
>   released the transceiver mid-break. The RTS worker now derives the
>   line state from break ownership as well, so the expiry re-asserts
>   instead of releasing (patch 8)
> - fix: an XON/XOFF character deferred by the reconfigure-pending gate
>   was never transmitted when nothing else was queued, and the re-check
>   after start_tx()'s dropped lock did not cover a freshly posted
>   reconfigure (patch 9)
> - fix: a delay of exactly 15 bit-times - the largest the chip can
>   time - was routed to the software path, because the hardware
>   ceiling was computed in nanoseconds from the truncated per-bit
>   time (49999995 ns where 50 ms at 300 baud needs 50000000). The
>   selection now converts to bit-times first and compares against the
>   field maximum, which is exact at every baud rate (patch 8)
> - fix: a close() racing the after-send hold expiry could leave the
>   transceiver driving the bus: shutdown's manual RTS release reaches
>   the register, but the RTS output stage is clocked by the UART
>   channel clock that the power-off stops - stopped too soon, the pin
>   stays asserted until the next open (register confirmed released,
>   pin confirmed high, in every observed case). shutdown() now gives
>   the release one character time, at least 100 us, before powering
>   down; measured propagation is below 50 us at 1200 baud, and the
>   delay-free alternative (handing the pin to the auto-RTS engine) was
>   tried and rejected on the wire - for an active-low RTS every
>   register ordering of that handover drives the pin to the asserted
>   level mid-sequence (patch 8)
> - fix: a reconfigure moving the port onto the hardware path
>   mid-envelope stranded the software envelope state: nothing reset it
>   in that direction, and the TX-empty hold arming ran only on the
>   software path. A later reconfigure off the hardware path trusted
>   the stale state, skipped the in-flight-transfer adoption, and
>   released the transceiver under the running transfer. The TX-empty
>   unwind now runs on both paths, the reconfigure asserts RTS for any
>   transfer it believes exists before auto-RTS is disabled, and the
>   hold arms only once no transmittable data remains (patch 8)
> - the seven fixes above came out of further review and hardware
>   testing of v5: each was first demonstrated on the wire, then shown
>   fixed, and the full regression matrix was re-run on the result
> - Link to v5: https://lore.kernel.org/r/20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com
> 
> Changes in v5, beyond the split:
> - teardown interlock (tx_teardown): shutdown() and the rs485-disable
>   path set it under port->lock, and start_tx() checks it on entry and
>   again after retaking the dropped lock, so a racing write can no
>   longer re-arm the delay timer or queue RTS work against a port being
>   torn down (addresses the remaining review-bot findings on v4)
> - shutdown() also cancels tx_work, previously only cancelled in
>   remove()
> - the per-character duration is stored as unsigned int microseconds
>   instead of ktime_t: single-copy atomic on 32-bit, so a torn read of
>   the 64-bit value is gone by construction
> - the TXEMPTY handling documents that the interrupt latches on the
>   FIFO becoming empty, so a stale interrupt cannot pump data during an
>   RTS setup delay
> - new in v5: the tx_break ownership guard (patches 2/3) and the
>   reconfigure-pending gate (patch 9), both found during the per-patch
>   hardware re-testing described above
> - also new in v5, from a review pass over the split series: startup()
>   clears a latched break (nothing clears TXBREAK when a port is closed
>   with a break still asserted - 8250 does the same); a reconfigure
>   arriving during a break is now deferred and applied at break-end
>   instead of partially dropped; the rs485-config worker runs under
>   port->mutex so its break-guarded register writes cannot straddle a
>   break edge; the termios-path idle settle re-checks tx_state after
>   writing and requeues rts_work if an envelope started meanwhile; and
>   the hardware-delay ceiling is computed in u64
> 
> [1] https://lore.kernel.org/all/2026092326-truth-unweave-c773@gregkh/
> [2] https://lore.kernel.org/all/2026100116-saint-idealize-32cf@gregkh/
> 
> ---
> Tapio Reijonen (9):
>       serial: max310x: don't clobber the TX break bit in set_termios
>       serial: max310x: assert the transceiver during a break
>       serial: max310x: centralize the RS485 transceiver programming
>       serial: max310x: convert RS485 delays from milliseconds to bit-times
>       serial: max310x: stop the transmitter before powering down in shutdown
>       serial: max310x: support active-low RTS on the hardware path
>       serial: max310x: schedule tx_work directly from the IRQ handler
>       serial: max310x: drive RTS in software when hardware delays are too short
>       serial: max310x: don't transmit while an RS485 reconfigure is pending
> 
>  drivers/tty/serial/max310x.c | 632 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 595 insertions(+), 37 deletions(-)
> ---
> base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
> change-id: 20260513-max310x-rs485-sw-delay-a306d783d529
> 
> Best regards,
> -- 
> Tapio Reijonen <tapio.reijonen@vaisala.com>
> 
> 
> 


-- 
Hugo Villeneuve
