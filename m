Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCE3B71CF;
	Thu,  1 Oct 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843753; cv=none; b=IqmuVM9kBmXRWuFxunoyxO02SVHD/n5oMS9XlLD5F6Mo1L882iLIi6DpeN2I2RUdkAUgDREXLRZRMFG8zecrBk/MiflPFB4yxuwSOHk9g7nFHmzh/ScYbkzXTI5xl/z5dAwfuCG+8T4razfcBqHOJPWprXZ3Se+9tQZmyKYk6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843753; c=relaxed/simple;
	bh=8ACtc2pB+mUmbIDPgo3RIw4BTckUvRlW8MvnUxLIGvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxHamELFDyfeLIS8wBHIy2UbuRkf/9ASSGwjCsdllcEfPvhrmnk6tGtXxiU/1xhFRb9kOZ1CJjVnI9J9BbKv5vi5/Icsy/KG5rAuX1HbxZtw+kRgoPnI8PtGVoyta/X7bypjiKP5ED1v7/tJ6Yc/1sXAKD3X+x1rnpRQishLypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GXxOdGbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GXxOdGbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB56B1F000FF;
	Thu,  1 Oct 2026 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790843751;
	bh=CFeio76G9Ht0Aq+YXGrXeREzMT2PmC8TvIRnVyPMF+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXxOdGbcd4gxaSV7gn8z+tIP7PKhz88xzArKYPAADo2T4d0jlROTNSWvdHI4b33hs
	 O26Fr6k2jM/Q07qh7PZeb4yba4/yFQ4DxJwPPGscvaO/iDTOcYmgx9UfZE8Md/9cr/
	 f43QU4eI0c7qj3Wo9Xe9/2LM1CkOqHMEaPIs8WcI=
Date: Thu, 1 Oct 2026 10:35:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v5 0/8] serial: max310x: RS485 delay and RTS fixes,
 software-timed delays
Message-ID: <2026100116-saint-idealize-32cf@gregkh>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>

On Tue, Sep 29, 2026 at 09:37:54AM +0000, Tapio Reijonen wrote:
> The MAX310X hardware can express at most 15 bit-times of RS485 RTS
> setup/hold delay, while struct serial_rs485 expresses the delays in
> milliseconds. The driver rejected anything above 0x0f with -ERANGE,
> upon which uart_rs485_config() wipes port->rs485 and silently disables
> RS485 - a device tree asking for a 20 ms setup delay boots with RS485
> off and an unusable bus. The values that were accepted got written
> into HDPIXDELAY unconverted, milliseconds as bit-times.
> 
> Patches 1-4 fix pre-existing bugs found on the way: a termios write
> clobbering an active break; breaks never reaching the wire on RS485
> ports because auto-RTS only drives the transceiver for FIFO data; the
> milliseconds-as-bit-times unit bug; and close() truncating the final
> character because tx_empty() does not cover the transmit shift
> register. Patch 5 adds active-low RTS on the hardware path via
> IRDA.RTSINVERT. Patch 6 is preparation, and patch 7 adds the
> software-timed RTS path that takes over whenever the hardware cannot
> represent the requested timing, clamping the delays to the UART core's
> maximum instead of rejecting them. Patch 8 fixes a reconfigure-versus-
> write race the asynchronous rs485 config application has had since
> 2016, which the software path would have made worse.
> 
> v4 was all of this in a single patch; Greg asked for it to be broken
> up into one change at a time [1]. Splitting it meant re-verifying each
> patch in isolation on hardware, and that re-verification found two
> bugs v4 contained: a set_termios() or TIOCSRS485 during an active
> break released the transceiver mid-break while the break bookkeeping
> still looked correct (prevented by the tx_break ownership guard in
> patches 2 and 3), and the patch-8 race, where a TIOCSRS485 followed
> immediately by a write could put an entire transfer on the wire with
> the transceiver released.
> 
> Tested on a MAX14830 (SPI, i.MX6SX) driving RS485 transceivers: for
> each patch the bug it fixes was first reproduced on the wire with a
> logic analyzer against the kernel one patch earlier, then shown fixed.
> The complete series additionally passed an automated 25-scenario
> regression matrix covering both RTS paths, both polarities,
> RS485/RS232 mode round-trips, close-during-transmission, and termios/
> TIOCSRS485 disturbances landing in every envelope phase (setup, data,
> hold, break), each scenario checked both on the wire and against the
> driver's reported state.
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
>   reconfigure-pending gate (patch 8), both found during the per-patch
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
> 
> ---
> Tapio Reijonen (8):
>       serial: max310x: don't clobber the TX break bit in set_termios
>       serial: max310x: assert the transceiver during a break
>       serial: max310x: convert RS485 delays from milliseconds to bit-times
>       serial: max310x: wait for TX to drain before powering down in shutdown
>       serial: max310x: support active-low RTS on the hardware path
>       serial: max310x: schedule tx_work directly from the IRQ handler
>       serial: max310x: drive RTS in software when hardware delays are too short
>       serial: max310x: don't transmit while an RS485 reconfigure is pending
> 
>  drivers/tty/serial/max310x.c | 511 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 477 insertions(+), 34 deletions(-)
> ---
> base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
> change-id: 20260513-max310x-rs485-sw-delay-a306d783d529
> 
> Best regards,
> -- 
> Tapio Reijonen <tapio.reijonen@vaisala.com>
> 

Did you forget the Assisted-by: tag for this series?

thanks,

greg k-h
