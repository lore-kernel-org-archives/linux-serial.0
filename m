Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144393;
	b=G9mEwwDLG2aoqGWBmjdvHxl3ZMAvH/8ScEy6rsaY77u7u71nlIt5xoSwnuOyJJkR6OdH
	 GTrSo7jZIXMY+yxJv7HdK4Cy5wThakpkUvBfQrysUyTytgGZhzoDIPgeGVebYJ+DDf0NS
	 w4M4WJdY5AunNc7luw0/FzqlF9/2bM05E6+a4Mu7RN8gasVgfLZ7KfvcqPU5mM1bM0ig7
	 3Hzdju5OL2FJWFixMU2pTeo+n48vDpqwzfeoxAV0tCF5o800BvYbtzvB+XNVL/qbbYvb9
	 UAnQRlTwIN3Vz2bqdA9+d7sDTlX1WrBZMklTIBhCX/o6sgnf9IXQdwDknORsJFGNN1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yIVO+weDm1+tGevJZRy06b8T6JtTvA4KsUNwW98N0DY=;
	b=l1wa7YrhjWS2AsLozva+v+CUK77y0tzBnA896rYHL2DwayAHFhTRe7ctYgc0VDbXJOC8
	 d+EA8zFUy3w4AB5m8TiG0uEGte/GheFvSb6CPHnFwORJCFOmnVbGhzN/uUpPWCl6lm/9/
	 Ao0yFGYXWauhiSMlI0Z1R6tVoYdL83mzXHd49b8VfRSF02bByPhoSgy5tWFRZF2fZWDVX
	 oscZ3jv8EaCOJpdgxTH2Na/+r7YAbx/m9P2GYPTiq3ucyVTcLV+qB9QxuHlmk62c6wl4T
	 9fRK3EUeOBsiRTtJga9M+nzh8AVf9R2iZVu8tFFq6WUUDR7uAlchDUTxdwVyVpnRm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xWyl4BZ5;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E69606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E69606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xWyl4BZ5
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-82380b0f55dso216764a34.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144392; x=1793749192; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yIVO+weDm1+tGevJZRy06b8T6JtTvA4KsUNwW98N0DY=;
        b=xWyl4BZ5XesZXU960PNPj+KlzqXuI/64CYgP7egbEgkcAkJJZSldsZo/yP0lumtv+u
         Qhz/hkpQ1HzxSxzCFkB7A29oAsvHR6AfHjcTgyMQst1kLT8FBm3tN4mDL/8+g2OCGgxa
         MPjjHgvBky5g/lYDtadXqum8mieTCynvevxxPMZN581vJYkT5v3b9UlwIVBToVR224Rn
         RkVGpZaPDeI53T/+0pT+Ts0QOsLgzOk39ZrG5u4ZxWXgqMcoY3FpxuGNfYOsQELXCXJL
         kwewLAIhGdw/mNUg6z6NTgSv/VdG1absNubJ5WFEngDQVC8d99/4hg6xz0/zK8WAI8UW
         7F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144392; x=1793749192;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yIVO+weDm1+tGevJZRy06b8T6JtTvA4KsUNwW98N0DY=;
        b=KlsyGtWDSq1odF/2A5VvlLEQ8bm4poHxpygouhZ6K6RNMt2yrBBlG7Vddb5quQ8v6h
         g4q+auzxkHmXld5XBpyHQlI2mim5xibEBgI7gMirFqu5w8xsyCt/zbFJWPndrVH4DSZK
         Ys5oxgsubTp03o8THCW7tyOBIYVBdnQ7mMpiITZtRsqKS4KgofE/1U7yMk2TKak0dkpV
         kIpxex3iBycH/XyhTw5zVO7jgKAKfJdBB9DW1KuRrPwZfs2SS4cbRKG0NaQZvggmAz2d
         kq5cFLOMSKdW9nOhinQOo7Evteqku9WC4otx4Xakg0JzAaR8Ux546CyjnWMLJHx1I0Uv
         62Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwrPx5AMZyiNKL5//v8e3T1krT2NyDD5Yj9J2dBBtguH+3DCL/dCtx2bSC7e8cmONPAXd7/XOWiiQed6d4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeC/PdX+aMpzskdDfdTpbpF7pF4gxpxvfbJiLFVVxIzXGdVYFz
	lyIQDzVFj9vFvAiIE36IhikGFJvv9UxaHppxP1OUEy98JXgcxacbnnRJ
X-Gm-Gg: AYBFou0MEZZfOHp/l83mZmahFoWLrQ+JFwZyofUHsrO8jWRimt3OTkMOyKwdKevZzqk
	qvmF7+tFDarV7U8cWAfO9hSJ5txPsEIVU477cdyFA26UXobTwThZvWmjEx8HuCpRoXzWJNhNr/1
	BD2ObUW9r4VcpjxqJN4eR5Oe06RklJcrU+6QMuwyHZ+0xfSymyE5HmW11TWaqTTfVBG2dhE7vrl
	DZu2crpAYp2234B5i2lkRc6NCAmiYv5xn13Ju+414pNU9x1dvDmPYAxzkT+BOV9vo4boiar4vB5
	Z/dSrmab2d67fjjgMdFGRMKFivvoGHYGjv8UVHq9jjTbgHO6/NO3PafipCeF2um087WxkFFA5Ox
	pSGMrp6P5r7gk+hjrmRAXZzg8JegHT+45U1n4a2HOGwrZnDIm8vOP2fO3e80JFZifm3D2Gv8QgL
	H+AjRI8RKd0veiRd01jFhLAi1mHeva9xYhAktHpsHmm2myTbzm1AMG/nqNDPmIFBm6/Jx0f/Fw0
	Dn1yqkpVuGCbxbJaAKpcS22n6kPzir+HcBagevTQIkKdRxh68hCRiwNqnltlRoxo4BKGz52x0qk
	efJQ3RbtfAS9WP3z62jH8WKa3wZRpL6qqZQa35E4/5TDcCNrlX8Zl/Qz3oT5LGjnM1BYpzBFCfz
	BsaGAy80NQm6ZkmlYBaS77I5lHeUspC1/JELDtlLuB1E5gzf3V3B/uucnqvuAxBqSrVpHwmGeUc
	xL4PI=
X-Received: by 2002:a05:6830:2317:b0:829:8a9b:de79 with SMTP id 46e09a7af769-85ab6f46263mr973241a34.4.1793144391882;
        Tue, 27 Oct 2026 16:39:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd31a6fsm62836a34.18.2026.10.27.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:39:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v7 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Tue, 27 Oct 2026 17:39:45 -0600
Message-Id: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WSzW5aQQyFXwWx7m3HM+OfyarvUXXh+XG4VUhSI
 KhVlHevL+kCqCoRCSH5yuc7Ph6/rvdjN4/9+m71ut6N47yfnx694E+rddvo4/2Y5u71OoZIECJ
 M+5e6nQ/TItOHSSKGqW91avrYxsN0hKnGICZ5SGmwdszzbtj862Tx7ft77Ywfox0W7tJRdT+mu
 nPCZvnkDbvx88v/HPgv1HtefNzDO/kd0p62PtzdimqumJMpCCPHwtoYSckGDcqGgSpLznpC6aF
 tPOXdKlHI1VSTQouQS+E+wACAYhXQjBnUUOulikvvoSSzmnBEzINL6F6JCJv3Q3XHkvlSJUF9C
 uiSW0BUyo3JVyw26ujApZFwLcWuvHqt2YdUAxOCIrEZaa6M2FNpNhpmiTFdqnIQcSfQyNWzqSe
 JIbkLeErPaxEKM8mVKiONyiYhtIodg3JoUmRQx4WgbKE2zZeqLg4jThFC1yaxJ+1aMyCLWTQmQ
 6HYypWXEJaBw5Kh75G5B88EFiSFFvrIVEp02Xo5oM28Pzztfp9O9ginx7/9Ov0XpmHDX7RYTCF
 9vd/q/PDZL+cEP8ZzYLwBGB3oCx6KMJIUuAamc2C6AZgc2H1dZeSWS4rXwPxRYF4iMxa/Zkn+f
 w3Ec2C+AYgO9OeKhaRE6f9MSB8FkgPJEvkVgCHROfDt7e0PLj0+OqYEAAA=
X-Change-ID: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Reserve canceled transmit and receive storage until DMA and its completion
callbacks have retired. Serial-core write backpressure protects a flushed
TX FIFO while normal transfers continue to DMA directly from that FIFO.

The series separates OMAP's locked completion processing and serializes
asynchronous write wakeups with the port lock before adding the serial-core
reservation helpers and applying them to 8250 TX. Flushing
empties the logical queue immediately. While the old transfer owns its
storage, write_room() reports zero and write-ready notifications wait for
retirement. Failed termination retains the reservation until normal
completion, without advancing the reset FIFO. DMA retirement releases the
reservation independently of port readiness. Serial core keeps writes and
wakeups gated during shutdown until successful startup or resume.

RX delivers paused data before the PIO fallback and retires callbacks in
process context. Track FIFO access separately from buffer retirement so
PIO and the DesignWare empty-FIFO timeout handling can run once DMA has
released the FIFO. On failure, retain the requested interrupt enables in
the existing IER shadow and mask receive interrupts in hardware until DMA
has stopped. Recovery then leaves RX on PIO until reopen. Shutdown excludes
new retirement work before releasing the channels.

Based on tty-next at 6b4b543fa187 with the posted shutdown guard [0], channel
configuration error handling [1], RX TTY accounting fix [2], RZ/N1
transfer-length fix [3], transmit-PM shutdown fix [4], serport
write-wakeup deferral [5], DesignWare BUSY-safe fractional-divisor
programming [6], and Intel MID RX DMA timeout locking [7]. The serport fix
is needed before serializing the remaining write-wakeup callers with the
port lock.

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com
[4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com
[5] https://lore.kernel.org/r/20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com
[6] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v7:
- Rebase onto tty-next at 6b4b543fa187.
- Use v4 of the DesignWare BUSY-safe fractional-divisor prerequisite.
- Use an unsigned long bitmap and for_each_set_bit() for SCCNXP
  deferred write wakeups, with unsigned port indices.
- Narrow SB1250 modem-status locking to shared-state updates and
  avoid taking the port lock for RX-only interrupts. Keep TX FIFO
  consumption and interrupt masking serialized with writers.
- Link to v6: https://lore.kernel.org/r/20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com

Changes in v6:
- Use v2 of the DesignWare BUSY-safe fractional-divisor prerequisite.
- Serialize CLPS711x TX servicing and interrupt-enable state with the
  port lock. Use non-waiting IRQ disable in stop_tx(), skip queued TX
  interrupts after stopping, and drain the handler outside the lock
  during shutdown.
- Make the Atmel RX/TX tasklets and SB1250 termios locking IRQ-safe
  alongside their interrupt-handler locking, preserving the caller's
  interrupt state when releasing the port lock.
- Report RX DMA recovery after releasing the port lock, keeping the
  state changes and interrupt-enable restoration serialized.
- Link to v5: https://patch.msgid.link/20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com

Changes in v5:
- Add the posted serport write-wakeup deferral as a prerequisite for the
  caller-locking preparation.
- Add a preparatory patch serializing asynchronous write-wakeup callers
  with the port lock, including indirect CTS and transmit-helper calls.
  Keep sleeping register accesses outside the lock and defer SCCNXP
  notifications until its controller lock is released.
- Use the separately posted DesignWare BUSY-safe fractional-divisor fix
  and Intel MID RX DMA timeout locking fix as prerequisites, leaving five
  patches in this series.
- Separate serial-core write readiness from DMA storage reservations. Record
  retirement during startup and shutdown while keeping writes and wakeups
  gated until the port is ready.
- Wake deferred writers after successful startup or resume, including when
  reopening with a retained FIFO, and restart any retained queued output.
- Keep the write-ready notification pending while retained output is at or
  above the normal wakeup threshold, until TX completion drains it.
- Publish resume readiness under the TX restart lock without releasing a
  reservation that may belong to a newly flushed transfer.
- Release 8250's TX reservation after shutdown has stopped DMA and unmapped
  the source; serial core retains control of write readiness.
- Link to v4: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com

Changes in v4:
- Retain flushed TX reservations through shutdown and failed resume. Release
  them after successful resume, or when allocating a new FIFO on reopen,
  so retirement cannot wake writers into a closing port.
- Treat RX flush as complete once the channel is inactive, and clear the
  shutdown guard before startup configures the UART and tests interrupts.
- Check completion after a failed pause so a transfer that finished before
  its callback acquired the port lock is delivered and retired normally.
- Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
  discovery, writing DLF and DLL/DLH only after confirming DLAB.
- Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com

Changes in v3:
- Defer write-ready wakeups while flushed TX storage is reserved, and
  serialize the flush wakeup with the reservation under the port lock.
- Suppress ordinary TX starts during the reservation while preserving
  high-priority flow-control characters, which use separate storage.
- Separate RX FIFO access from callback retirement, allowing PIO and the
  DesignWare empty-FIFO timeout workaround after a successful pause and
  termination while keeping the receive buffer reserved.
- Use the existing IER shadow for requested enables and a shared register
  writer to keep receive interrupts masked throughout DMA error recovery,
  including termios, RS485, modem-status and overrun-backoff updates.
- Preserve the timeout-enable bit across stop_rx(), exclude late shutdown
  interrupts from PIO, and avoid FIFO resets during RX DMA recovery.
- Preserve the completion-path LSR read after stop_rx(), while gating DMA
  resubmission on the receive interrupt enable.
- Pack the cancellation flags after moving all their accesses under the
  port lock, including the recovery worker's snapshot and initialization.
- Apply the early-return, shared-helper and line-wrapping cleanups.
- Link to v2: https://patch.msgid.link/20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com

Changes in v2:
- Add serial-core helpers to reserve flushed transmit storage until DMA
  retirement. Apply write backpressure during that interval and keep normal
  TX using the FIFO directly, replacing the private transmit buffer in v1.
- Document the flush callback's reservation, writer backpressure and
  retirement requirements, including release before shutdown returns.
- Split the OMAP completion refactor into a preparatory patch and move
  the RZ/N1 preparation-order and shutdown PM fixes to independent
  submissions, keeping four patches in this series.
- Take runtime PM references around worker UART accesses, and leave normal
  RX retirement to release ownership without reading LSR or restarting DMA.
- Synchronize the queued TX ranges before preparing the descriptor and
  return the mapping to CPU ownership before releasing the reservation.
- Keep the TX transfer length separate from FIFO cancellation, so a failed
  termination can account completion without advancing the reset FIFO.
- Exclude late RX flush work during shutdown, including Intel MID DMA
  timeout interrupts which are independent of UART_IER.
- Accept DMA_IN_PROGRESS after successful pause, and recover from failed
  pause, termination or DMA_ERROR before handing the receiver to PIO.
- Preserve stop_rx() and shutdown across recovery, and retain the
  DesignWare empty-FIFO timeout workaround when receiving through PIO.
- Apply the requested guard spacing and container_of() formatting.
- Link to v1: https://patch.msgid.link/20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com

---
James Hilliard (5):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: serialize asynchronous write wakeups with the port lock
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer

 drivers/tty/serial/21285.c          |   2 +
 drivers/tty/serial/8250/8250.h      |  59 +++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 286 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  27 +++-
 drivers/tty/serial/8250/8250_omap.c |  38 +++--
 drivers/tty/serial/8250/8250_port.c |  31 ++--
 drivers/tty/serial/atmel_serial.c   |  12 +-
 drivers/tty/serial/clps711x.c       |  23 ++-
 drivers/tty/serial/cpm_uart.c       |   2 +
 drivers/tty/serial/fsl_lpuart.c     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c    |   3 +-
 drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
 drivers/tty/serial/lantiq.c         |   3 +-
 drivers/tty/serial/ma35d1_serial.c  |   6 +-
 drivers/tty/serial/max3100.c        |   6 +-
 drivers/tty/serial/max310x.c        |   9 +-
 drivers/tty/serial/mux.c            |  13 +-
 drivers/tty/serial/mvebu-uart.c     |   2 +
 drivers/tty/serial/mxs-auart.c      |   2 +
 drivers/tty/serial/sb1250-duart.c   |  25 ++--
 drivers/tty/serial/sccnxp.c         |  45 ++++--
 drivers/tty/serial/serial_core.c    | 100 +++++++++++--
 drivers/tty/serial/ucc_uart.c       |   6 +-
 include/linux/serial_core.h         |  18 ++-
 25 files changed, 558 insertions(+), 173 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
prerequisite-patch-id: d8219673210dac82d3adab41578ff2f76f5862c9
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

