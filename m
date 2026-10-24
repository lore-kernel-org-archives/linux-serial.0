Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824051;
	b=vqTojHdO0UQGqECwJxmTQK7lwpdg9x/6c/Pb9VpfdQ7MTJOlv+BMqHEuF7k5lr0Tu7Os
	 H4/nu66mIrrrFzNA3jYFeX5ghlHCK82qNZ/TeVe0uITbOpSyvqDIOtKIlYfLtj5LH5JI+
	 Ur1O/e1wSDNBgrW026XFj1pg37ImHwotpn0rFcN831/1+uYBl3Tj+D/7gM3o9MSaFs5eG
	 pYItP50JnktOMp9DsDaNM/A8kgJYm+PXSnfet22pVfn29AlCFJpU+D6WumxMhALAlE0z9
	 8m89gVK8dzOFN5q/7uYYZjEgy4D9Rx71Ei/KL6daHD+T3vx4XSFY3iFJuZqg8+d9lsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=edz22Fq6n7hqO7w64D56fVejxYtfF3v+LcW93z688tQ=;
	b=LG7s1lT45jK/YgOh5xH6JuAAXqlwtyy7rbUXUOw9yRxCA/Jw8srldBAg4hLH4WHFQ+YJ
	 +oymsMZuJAM2UO3O8JIqbl2zzLskapekP7/NjpHY/Ged4J/YX1p9x39XxSxd3RHoo0AQf
	 HUtY+YtCJ+p67b8EC2hn4qRXiuUSZJMeci1W3f/ppiZhKHVRtobglhYOTSaj7Fy43909w
	 xwuG8APxg7vD7D72Uh9u3WOcU7yv7WbO6FhoObrmWyaYxpQAclMSEeXm5rgeg2nAmGHte
	 yV3GClmZwLwGnurNhc4quMvVkfeQVZqRtRziakqU9rQfJIUNUNIXTgOscCIsy6/95ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MU03/R/X";
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5E606A31D
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA5E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MU03/R/X
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-504ae5941faso852794b6e.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792824049; x=1793428849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=edz22Fq6n7hqO7w64D56fVejxYtfF3v+LcW93z688tQ=;
        b=MU03/R/XVM79NAv2uJNXqapzmAr0ozfPFm6JKYva2MFIbe3L0ttoeUO7RXi3R5/IzR
         FeREYYMS/drEl4gfzpPzEeUHimbRQTgxWlCMkg8UgFdLo8HXwZ0iGus3jdBlWkWjTuSL
         lhgvzv1sG/G6a0CwWQJYlGnpGWCdcUO69bd1mykNINYqT3Qfoe61CmyNbEDvT2Vq1PRz
         lY+Fdt7iBwP82G21j0CI08zvC0OYSNUGuGeOl4OuQzsbIpyo6oR1I7iKEOAo7IcEYAZ6
         KUfeHOzZTUbvFYfUkWby5ZFi6S/sTXVMVdezfbh5hGndv20WAGjpMqzG9TIyFxbo4rqe
         KjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824049; x=1793428849;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=edz22Fq6n7hqO7w64D56fVejxYtfF3v+LcW93z688tQ=;
        b=z5DPmCL3oDJx+pOhKh6pmNxxfqomaYJkNC82B/ZFEK+D/SCmLe3IWC/FsRUhmzmECI
         Bas292KsHpNYQmGyUpf9MM38V632ZE4keaSYfNT35abcpxT/4gYtXQfDDQqEgMj4B8px
         jbg8DKd6AZ81xQOg6ASl2xZeYsPhWOi2pReCFdSE/afPhwkzNQ2mfqu4fNek+QT9d4HA
         JhH5OPoAW5iUCDhBuloWH39bmIBAuMHVgBLaWrTWUrIZW+ERrNqJGdXxtBqM8yOnYHNz
         wrsXanskXrYo8MfG+1OPUO9ajELRXwbEGTbLKBbzTITPcB7LC8YpqB7Z3x/YF4wGTdV9
         Zzgw==
X-Forwarded-Encrypted: i=1; AKwUvByTYavpqc8VHEuhU8dzzZ2L/xu2z6tJOlwNfbojnXp8s7w3lTqyoBOD0i17+UkeyYI/vU7qNeyC/K675Xg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5gVOenuWB4cc0YV5scT3yKEN0e0iq2ci6fPjyaP2GT9Fn6dQ7
	IUrRk7DnhgwIwLv1Jgp9EkJ3VAuJulZtlg7yBBTetG+gFO+Bvu6Wj8w/
X-Gm-Gg: AYBFou2ZbwmPLo/MweNlA2Tb0TFmXUSelnTMNG+MfnIyZLZ2rKDIF0D7vHIjH9RVdeg
	FfMPglWBES+PUeXreKJrgHwtSys281C06ifiGBnMXwcHOV0XOF/sT0zDVyMKKcd2xYr/1HQLOjM
	4OsvMeCTNXFant3wXF/DnExd5rrgEWU2RksEYNx3/ztSqRqdTR0MAB1fz/hBzP5EX5TwwvV41ey
	0gMW4BW4FLJl+j2thkFvidP39or1ZDxwBh3tW9BH9oLWtdl+KGHjmJ1ysqzdnjTpGKoTP6PHyXp
	LllwarQeBZLa0pfY3Q2/H4+GyeGMS4nA7ilw4fm3CHlsxi0PVP48aN4hwwkc0m9djUpWqTUD/zJ
	gAIPAIamKFWDnOFc3PrbtxblA2gSMNXLTsVJleN5JHPX2AvzdXf9ue9MiLPwl6JlVDL3iDkA06Z
	MqV5R2Bm6oANKBS2pV6PZbgeghwEd/AEiMQpfnpRBAQzEMT158o1FH1rXYiCxEwD3mwvAPtkV6h
	iCogyVaLi6vEgCEGxwwM83PYlL6zOPvYrjz56UNVgsLP1cxrFzeJDaOm6LqcTm9ZzwYS9IfIXef
	FyLwicJoQebWHOnc/B+DQVuLu/Vqi0ADhkcLChaHaKKRRghxt6sPyjeUay4++7XpbwNnHTzhw4e
	cl15WvNBGoGWLzmTui37x1cN1KmlaUIs4Ra2CNfrB1zw/vfZwIP4YxNGIKuihe3lyslNI/0lDxg
	DYTg==
X-Received: by 2002:a05:6808:1798:b0:525:184c:7952 with SMTP id 5614622812f47-55c0026231bmr837705b6e.16.1792824048956;
        Fri, 23 Oct 2026 23:40:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm864633b6e.9.2026.10.23.23.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:40:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v5 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Sat, 24 Oct 2026 00:40:39 -0600
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WS3WobQQyFX8Xsdbcdaf6kXPU9Si80M1K8JXZS2
 zEtIe9erdOL2FBIYVnQovMdHa1epqMeFj1Od5uX6aDn5bg87r3InzZT38r+XudleD1hwAIBYT4
 +t91ymleZPMyEOcxjJ3OXfdeH+Qxzw0BGSYk7TI55Oqgtvy4W376/1c74of20cteOJked28EJ2
 /WTNxz055d/OeS/UO959nFPb+Q3SH/c+XB3GwBKRlWxclAS46YRoFgJNFCptFQZRx0XlJz61lP
 ebWIJqZlIFOgIibkOBQMXYiOQlBOIZWnXqspjBI5mLWbFnNQ9h1dEVM37oZVknOq1ioLkUGBQ6
 iFnKanX4ism06YDKvdCtTHbjddoLfmQYmBUgAm7FUmt5jwid9OeEyHGa1UKRO4EgrV5NvEkGKK
 7gKf0vIbAtRa6UaVctFWjEHrLIwepoROTlpFXglQLrUu6ViHVIkCBNZsi+xYws2uj/4oiaj4H5
 ZBvVIlKdoVatOx7rHUEzwQWKIYehqbCjAX7tB7QdjmeHg+/Lyd7hsvP//h1+hNm9dEasWEM8ev
 9TpaHz345F/gZ3wPxA0B0oC9YJYNGYrgFxvfA+AFgdOCoZKypJ454C0z/C0xr5JrZr5miv98DX
 19f/wCQKuFMBAQAAA==
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

Based on tty-next with the posted shutdown guard [0], channel
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
[6] https://lore.kernel.org/r/20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
 drivers/tty/serial/8250/8250_dma.c  | 284 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  27 +++-
 drivers/tty/serial/8250/8250_omap.c |  38 +++--
 drivers/tty/serial/8250/8250_port.c |  31 ++--
 drivers/tty/serial/atmel_serial.c   |   2 +
 drivers/tty/serial/clps711x.c       |   6 +-
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
 drivers/tty/serial/sb1250-duart.c   |  10 +-
 drivers/tty/serial/sccnxp.c         |  45 ++++--
 drivers/tty/serial/serial_core.c    | 100 +++++++++++--
 drivers/tty/serial/ucc_uart.c       |   6 +-
 include/linux/serial_core.h         |  18 ++-
 25 files changed, 532 insertions(+), 155 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
prerequisite-patch-id: 2876a1809e5fe29b8825950a32796aef1d885054
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

