Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875153;
	b=UqdtvC5w5sbfCbF5cy0Jzcmxah5N4/7pm+To5UZGbyVKl5EHolqrdQ501CkpLQshOlo4
	 YNkzYTzXKUNh/GmG6/D1G3FgXpbNS2J6cLydaB87opR6u2BdBOA3fS94e1mnmPZI1f1S/
	 tuSKKDnCuG9f8cL3DVpRmNxjfixcfOscRq1GzEgI/D2DYaVi24FK9gKF1xLYVlGOuUiQ+
	 FPv0JxZolJWAu2HU+xpDF0Eop+VJxDx6BMJWTctjwiuQR8tA+NStZTvPvFlmhKe+WlcYA
	 UubY+W6vbN8F4PJSxxFpgK6Xd+4juKO9oQwzg5NJGe/xqnOnICedZVHkDoZD0PyBk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Q5g+37LHyIr/5ZHcnQ2k9bfTXYcAaVphq0sZK3Ck0qI=;
	b=q/VVHQzHwkhp+gwkZkOqyAN3su9a8Ultp33Xy+jBNegjtlLp/uAdmkDUh36/CJIzz0ns
	 sbXaQcUXr3mkGpIe3Gqy+xRk6epnIAde771tzbp+6/bNqLJy3B+egV4Zr+YJ9IMkPnow6
	 d75az3wXOs7A8hmEtSZR7H8GLJwPtNSUPltNnvT9rzeCwnhEHMIaOhdoQeUEvk/GJWTnX
	 eZ9jegGVXRcxoaCiMy242ftmaUGYwbPc9bCJxEoxbwavDXjCAb2zzkeKLA96qKz0VMdIm
	 z9u3dURf1uSJ65qRRgsmLuN4456wXRT9hOCUw92oeJ7NXTDkeqM4zsPUTrM+YtSGp4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7IamMvH;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D0606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A5D0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7IamMvH
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-82380b0f55dso811735a34.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875151; x=1793479951; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q5g+37LHyIr/5ZHcnQ2k9bfTXYcAaVphq0sZK3Ck0qI=;
        b=J7IamMvHxb5i94VBIAHaunj4MD4/tsc05yNU6XU0UUQPDpGH70tIsI183+koAo8/na
         lqD5G6wNwV7OWWp0modcdOWE9+XGkuoWGYZAZmniId8Gv9BweZ/U5zcBbJO9Oeu6OC6f
         T3QHJ6c4idiauM+4xY3NZglA5PxLoZCCQG+Lo61ISiaPGLG2gXLYjxoFyhW2pzcDdpAh
         lfR50TqR+CwO0ga/kiaLugFmH2uoOp8I7MfDM94UeDaBlnSPJJTC7tQjvwb0hgs/K7RV
         5+GQN8BXcoLu9ZlEdig/OLrvAYt5e0vdL9RSWAz7DQEv3G7bF7QQsoudUOJxI0ZOEFab
         CsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875151; x=1793479951;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q5g+37LHyIr/5ZHcnQ2k9bfTXYcAaVphq0sZK3Ck0qI=;
        b=QRL+2T0AABQbuhHGgwF4aT7TuyzdU4kzvX/uCKdovLpTuqoqxgNiNUzrhtvAWvAjqR
         WBpg4yjY436n3+KvvYkjvE5ooM7QrpRj3VgrrW3FNcH6BdO6ZJSA8xi+a/3glseLI+Gr
         8+nQxFssYKDGr5RVabfC2Fuv9fMsJaSUwGeJD0B7gqGeBKo8vKW5cfEtgIMi6C/ShHZt
         AzNDDOZ9itvW8USzdKPt9jneuDesiu5r9l5paVtMSVRHleedxzuujRghG4bd0P7sMs2N
         tEzPnccvsej5GzAGfb9irJ51GCuXlKcydrfo7upofWKafX1wLZtUFw//O7vPrM95kGD0
         qOwg==
X-Forwarded-Encrypted: i=1; AKwUvBxgobvokN4FBu9I1vYoDxukQHH67q9Xl5DY70dj11V+5BArIqb7smkH31JEl427oRZOY1bCtBh5VbVP1c8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ84Z1IvR+7zu2KGnZ4dKF6Uh6bAWDFxOiS6i4ja3l2lTicFU9h
	rptlL2cCdKEhAYremlIYytdHQW5t9dalCeI2rwCwOMqCRa6LazfRRMhE
X-Gm-Gg: AYBFou1BDbS7c3M6uhfUyXzs+dXZaTdtSKp0tWFKls/EbU6NiSIrgftoeV28oku/+99
	RLIXGROx6BTOVSaQwLx7NLZBxN59DOY5dLr5syz9g9etORWlGcCzwcc4+t4LR8iLcJb9gCHLurc
	jGW2DZD18GwSAfhZdS6cnXOF3+qyQ7ElPBHLMbCFkO2ktL9c2dEXo3/ArPYThwIkh1nIqoiUzK9
	l1FN9sI7czl2Qb5qRRdYBZfTmGcagwFbSbhm9MRZcfv2vfK+3DBfAcmPzOrFtWjxp/GsGQrHLu/
	6cyvouChZk7wky0WFo2mB4PESr9TGpdwyV/GjOaKAfphxpbrEQGlJjxVVjn0jqgqK14xRH+byaK
	jA5/M97Bx6MgHyJCDstP/STdqc7h12LG+BttjH3yI8RH95yKD2W9i0BQRJHMjb6sFKVCpclGWC9
	eQCVftvlOn6xVRs8sHeIuEklYstxvKh8BdcAyvyYMIjzysdREgxDNKwh2rdUQe//SOaHscLSjvP
	ySN85KV39IjBqxSWc9nveMRAvH4j3XbskFhwCHE/oAsPf5aRLFR/5QViyHOUfXkvsgDKwm+EZJ7
	pYnTUl1QXgkT7ap/NhYj+gcDySmpDTge9m9UUv5eSUYH8JvqTG4w799Qqdny+RgO5nsndKcMDsX
	Kv7K4NaC8eBv7rl4P6AKsPifgRwop3DRiwZoyDq/qP1LJK2fQ2fTkiA5lkO/N2+T1+9gyZBwRYS
	wAKQ==
X-Received: by 2002:a05:6808:1923:b0:4d6:90f3:74b2 with SMTP id 5614622812f47-55c003b61e2mr1752748b6e.50.1792875151379;
        Sat, 24 Oct 2026 13:52:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm1986785b6e.7.2026.10.24.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:52:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Sat, 24 Oct 2026 14:52:25 -0600
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WT3W7bMAyFXyXw9byJFCWRvdp7DLvQD7l4aNotS
 YMNRd99dLqLJMCADDAM0OD5jg5Fv04H3S96mB42r9NeT8theX7yIn/YTH1bn77pvAyvJwyYISD
 Mh5e2W47zKquPM2MK89jVudenro/zCeaGgY1JWTpMjvmxV1t+nS2+fH2vnfFd+3Hlrh2tHnRue
 yds10/esNefn/7lkP9CvefFj3t8J79D+vPOD/ewAWAyLopFgnI1aRoBsuXAA5VzoyI4yjij6rF
 vPeXDJuZAzWqNFToCiZShYOBCbAyVEkG1VNu1qsgYQaJZi0kxkbrn8IqZi3k/tEwmVK5VHGoKG
 QZTDynVTL1kHzGbNh1QpGcuTcRuvEZr5IesBsYZhLFbrtRKSiNKN+2JGDFeqygwuxNULM2zVU+
 CIboLeErPawhSSuYbFaWsrRiH0FsaKdQSOgtrHmkl1GKh9UrXqh4H1x5GogHNlGJORTxdgtKte
 krzmfoYb7w4J9GkFi35HEsZwTOBBY7BYUpZBDP2aV2g7XI4Pu9/n1f2BOfLv387/QmzmvqNimE
 M8fO3XV0eP/rmnOEnvATiHUB0oA9YawKNLHALjJfAeAcwOnAUNlHqJBFvgfS/QFojlyQ+eY7+v
 gWmSyDdAUwO9OtCySzof9Ql8O3t7Q/SXrY/VQQAAA==
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
[6] https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
 drivers/tty/serial/sb1250-duart.c   |  14 +-
 drivers/tty/serial/sccnxp.c         |  45 ++++--
 drivers/tty/serial/serial_core.c    | 100 +++++++++++--
 drivers/tty/serial/ucc_uart.c       |   6 +-
 include/linux/serial_core.h         |  18 ++-
 25 files changed, 551 insertions(+), 169 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
prerequisite-patch-id: c3d8ac0d54d1bfe43657964c517cfa4c7fde11af
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

