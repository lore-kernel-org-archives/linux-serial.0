Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259467;
	b=pmARCbSiol/vtd4q65qFqP4zBQWLHPvby/U5kn+Vr/Wuaq/oitjgQD64ZRIzhwhA/4OI
	 ImWHuHMmQJb8F+CEatRRBTpz6qj5CKkQbi7CLtnRH/Q/h2bjGt1YrYi+GbUbzBXl5NxKP
	 5xhwUn7rER5LiPO22HWslcERDp2QSflEJfmWoO57YMKjO6z3v9ivxA5//okAtR/Cl4U+0
	 UA+k3ziHFF0u2n21AwS8xoINqrlvXgdvODNSLBg8zd9BI0H7dBGTswlY6U3Fdzz7vAM3/
	 Bfe8wBvB12X6m0Z0GFCxRBaRPW0oGkr4BkOMj/XZrit1khVf26run6t8fSbtnBJro2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=h/Dloe74u1A6+wvw1reLkIMXgsC13a5txQ9r+u600PE=;
	b=A2YJQJJ41/U8IOetpbUbMqPMHvnRCcZvCBA0MnQktzHAN1GB6jlUuY62UCk2M2o8pRUo
	 ksfQXoxUaZ9NwUCJ3i3FjBFmqSyfxVE9yXogh5Kc65v2xPNTt6PRV9/0drX6KjnFP3vck
	 u6SouDFjqw9+S1z5ZYfWtUMVL33olMQKD8RRQ5M5IoHRD21wE3/GHwA6R4O6gdVYaOyKa
	 MAws0QH0ODEoisRarAiJatBt1rg148+YQVLcgM1K/dcy23r8VwOszSXHQ7GEuxELNemBP
	 oDnTVTWjVfSmGbmk0a13e/Zg+REfH2YPIjwI73M2ZFXv1R2ZmDei7+2QIXSSeo32MNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mb1xsj9J;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7D606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F7D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mb1xsj9J
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-843b6f8e2c7so2155976a34.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 00:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259465; x=1793864265; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h/Dloe74u1A6+wvw1reLkIMXgsC13a5txQ9r+u600PE=;
        b=mb1xsj9JsW0qHXBs6J9VW+/aKVeix7sN9eRatnJ2IFXYyIGiHavGcDqT5JnSaygWH4
         Bi2mpBX7qbmRzCE18kbYH/ZxWpxCAy6wVEqoGjXA9/G7xZ3M5PUQWYtQ6YPECka9+gig
         6V6AglMfLSbBvxYYS++F/QvzmQ0D+0N8ObaKDGKfgr+FUqyu5696T8xJ24iZhVZFSM8+
         BYy1KyAL9FjDEtr+H6ctXdIooa+zHD364cR1zgh7iU+t5PVXwTpU9RvnHjHbE8cCQWGR
         26eSTFZ96/4EMP2PESuANgLhvWJ42XekNRXjuYavD/kWEpicxK7cXv0dUquCTVO/8eMP
         da5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259465; x=1793864265;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/Dloe74u1A6+wvw1reLkIMXgsC13a5txQ9r+u600PE=;
        b=PntcBCJGYszjMh5exuerh2C8v+O9anVj+n433fzKwQ49XL1Wh8X5J0Y9aemXLQpJkO
         iUDyMNOxaC+h1TW2p75qNS/aI60NugSEk+oWRNcV1927Ea/SG9BoMyN23YvnTx7cVFrR
         JCPboULVHQlx8GKMojRaXi0squut5ISFQl7HntU1XDPVo0HrW3LXJmlujaLcoDEB8CA6
         YAjxT0SLRh2ehNFxfVIix2irPKj6mb2tn2J3Z6w40AgepjeHC2jNZbqiG9+YQoXu4yTP
         oA3+KnJ0OAAI49ZXgZPLPVq1pCvXwwOOkQtBCH3FZitJmcYjVTlLJC9Ul5EHwOPo+SPZ
         Xx6Q==
X-Forwarded-Encrypted: i=1; AKwUvByprScf8Hm+1/zxAnGobN0GvQr9TVBzJOBqi6lDUgtVm9JI1PbssN7hUYMugjRXek9X6UF8dauw+d/zyxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI12Ce26UejNj36r5+9mPLvxY/hpl3iTtE++41mAisf9sLQPDSX
	kJwaBxvAZZE0BgVW4HvJWI+45bZe/xZoHetGYc28fxOJjAX5VpNXL2DR
X-Gm-Gg: AYBFou2p04hy5VSk92xdB0KRgsHjeNKfxnjnmK+XvjxE9kvfIEDqR7FWqtBXd+R1k46
	p+y1HL8Git80K6vmV9YM7qFmgrDxlXReBot9NXHPhD/mQB9rjYThU2cTk0191Ajw3+/EDMAfmcO
	N4llrRu25nJYyRreKpkvozQE7BwDQfuOLhJLbmoZnLYpvPIPORDSglEC19L9ylqyzklU4mFBmRF
	7xo8mTW9CL1wWXksq1HTgy7Y2awXhXgF7hDNhp6Ji71KhkWH2vAIj8wwjtrRvXKULcz6oz2nO2A
	tqUqsx1lolrdWZO4iEc84/2BDyvzpha4a2141ysNPF5ByPJV5d1vpJgOZIQWXGDn5af9beA8Nz4
	XmphvRO/Ri4KYe0OxBOLVAeRk0bf91o3PHBkzCiz/+C3CLTmQkEuAPRPzrqxnZnmV+ws2llZSUq
	ylMVQ+bJm5sUCwtCpdpn1pMAIgVlOxoF3LExFK6sk5IKACZZy3r9hxDT4Vbd/c21pKwFyiUi23K
	QEUS82vAoXRQJ3occXUl/W19CHMzyh4Mf9Loi6Dv9zs0VuSwksvogSRfUQwSFB6wxtYAqfrrzPc
	sjT6SJL7l8fx6XIqxZlC4lNtdDzjsj/iiD6G0KN6cG+qtIgjJevn/kXhQhrr8MwpfALDKQTATd0
	K6OLRsAl2DfhUhsonql59d5JZn22WW3UCFdKgjEhTCV4I6tJ08Rzk94l2djZvn8MWYGtOe6RziO
	Kx43NqGkxdiNDMJYU6Xu4hSbVxx+cvCNf86dAnBkwN6KQ1kk2x2r1X
X-Received: by 2002:a05:6808:120c:b0:556:82f5:5aaf with SMTP id 5614622812f47-56383d8ed87mr3220318b6e.49.1793259465274;
        Thu, 29 Oct 2026 00:37:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c3638604sm3321976b6e.1.2026.10.29.00.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:37:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v8 0/6] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Thu, 29 Oct 2026 01:36:56 -0600
Message-Id: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WT0W7bMAxFfyXI87yJFCVRfdp/DHugJLLx0LRbk
 gYbiv776HQPqYcBGWAYkEGeey9Fv2yPepj1uL3bvGwPep6P89OjH/jDZtt38niv0zz8vMWAGQL
 CdHxu+/k0LW3yMDGmMI29TF0euz5MZ5gaBjYm5dph65jvB7X550Xiy9e3szO+aT8t3KWiyVGnd
 nDCbvnkBQf98elfCvwH6jXPbvf0Rn6D9Ke9m7vb5EYtUTQBLqlgLdJLypJNs2ayFHIrTCQXlJz
 6zlPebWIO1EwkCnQEqrUMBQOAjI1BKBGIJWnvu0odI9Ro1mJSTKSlhuEnZi7m9dBcsVJ538VB3
 AUMph5Skky9ZB8xmzYdUGrPXFqtttIarZGbFAPjDJWxWxZqJaURazftiRgxvu+iwOxKIFiaZxN
 PgiG6CnhKz2sItZTMK63sBm3UhtHNuTXEYkag5HG5KqOjKK60Bjssl4gQhnTGEWVII0iFzdBKt
 sQZe1055JyqJrVoyedYygieCSxwDD0MpVwrett2WaDdfDw9HX5dVvYMl8u/fTv9CZOa+o1Wwxj
 i5/u9zA8ffXMu8DNeA/EGIDrQB6ySQCNXWAPjNTDeAIwOHD6uqtSpRlwD6X+BtEQuqfo2c/T3G
 piugXQDMDnQrwtr5oo8/nKY/xeYHZgtZt8CsJTzGliugeUGYFkcchIfUPP/g66Br6+vvwFEx1x
 89wQAAA==
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
released the FIFO. Retry ambiguous pause failures until a successful pause
or reported completion makes the buffer stable. Keep receive interrupts
masked meanwhile, preserving the requested enables in the IER shadow.
Confirmed DMA errors use synchronous recovery and leave RX on PIO until
reopen. Shutdown excludes new retirement work before releasing the channels.

Final shutdown retains both channels and their storage until synchronous
termination succeeds. Failed channels are retried outside the port lock;
a permanently failed DMA engine blocks teardown rather than releasing
storage or callback state that may still be in use.

DMA providers must supply the callback-drain guarantee of
dmaengine_synchronize() before retirement releases storage. The related
provider synchronization fixes are tracked separately and must precede
these consumer changes on affected controllers. PL330 provider-side fixes
are deferred; its callback-drain requirement remains unresolved.

Based on tty-next at 6b4b543fa187 with the posted shutdown guard [0], channel
configuration error handling [1], RX TTY accounting fix [2], RZ/N1
transfer-length fix [3], transmit-PM shutdown fix [4], serport
write-wakeup deferral v2 [5], DesignWare BUSY-safe fractional-divisor
programming [6], and Intel MID RX DMA timeout locking [7]. The serport fix
is needed before serializing the remaining write-wakeup callers with the
port lock.

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com
[4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com
[5] https://lore.kernel.org/r/20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com
[6] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v8:
- Retain RX transfers after ambiguous pause failures and retry in the worker
  until pause succeeds or completion is reported, preserving delayed data
  while masking RX interrupts and allowing shutdown to take over.
- Retain both DMA channels and their storage during final shutdown until
  synchronous termination succeeds, retrying failures outside the port lock.
- Update the serport write-wakeup prerequisite to the posted v2.
- Cover DZ transmit servicing, DECstation ZS TX/modem handling and
  JSM Classic modem notifications with the port lock.
- Defer ZS console-triggered TX restart to a worker, preserving the
  port-before-SCC lock order and draining work during teardown.
- Release Lantiq's private hardware lock before write-wakeup callbacks.
- Assert the port-lock contract in uart_write_wakeup().
- Retain the tx_running guard in generic and OMAP TX callbacks.
- Publish OMAP's shutdown gate before the final RX flush, serialize
  RX completion and runtime-suspend flushes with port and RX DMA locks,
  and drain its UART interrupt before releasing DMA state.
- Link to v7: https://patch.msgid.link/20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com

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
James Hilliard (6):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: serialize asynchronous write wakeups with the port lock
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer
      serial: 8250: retain DMA resources when termination fails

 drivers/tty/serial/21285.c          |   2 +
 drivers/tty/serial/8250/8250.h      |  62 ++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 356 ++++++++++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_dw.c   |  28 ++-
 drivers/tty/serial/8250/8250_omap.c |  66 +++++--
 drivers/tty/serial/8250/8250_port.c |  31 +++-
 drivers/tty/serial/atmel_serial.c   |  12 +-
 drivers/tty/serial/clps711x.c       |  23 ++-
 drivers/tty/serial/cpm_uart.c       |   2 +
 drivers/tty/serial/dz.c             |   9 +-
 drivers/tty/serial/fsl_lpuart.c     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c    |   6 +-
 drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
 drivers/tty/serial/lantiq.c         |  12 +-
 drivers/tty/serial/ma35d1_serial.c  |   6 +-
 drivers/tty/serial/max3100.c        |   6 +-
 drivers/tty/serial/max310x.c        |   9 +-
 drivers/tty/serial/mux.c            |  13 +-
 drivers/tty/serial/mvebu-uart.c     |   2 +
 drivers/tty/serial/mxs-auart.c      |   2 +
 drivers/tty/serial/sb1250-duart.c   |  25 ++-
 drivers/tty/serial/sccnxp.c         |  45 +++--
 drivers/tty/serial/serial_core.c    | 103 ++++++++++-
 drivers/tty/serial/ucc_uart.c       |   6 +-
 drivers/tty/serial/zs.c             |  94 +++++++---
 drivers/tty/serial/zs.h             |   3 +
 include/linux/serial_core.h         |  18 +-
 28 files changed, 736 insertions(+), 218 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 76506fd9b234c7268227ff41e4d0989e82a1a433
prerequisite-patch-id: d8219673210dac82d3adab41578ff2f76f5862c9
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

