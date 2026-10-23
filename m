Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778693;
	b=ImK8Dc8LJ6dg0onSHrItiHUm7iYEwLJP2x+YJ2i3IkSB46QWhA0syXiqwVXWbD/b8gZw
	 1AXKRWXvDHGDVJ78zta+pmb/OtXZ8zDiS50xqwNfs9QnjHkRKe/6lZ6ffgRlH57X2YuOS
	 r8CB47uB4oDyQJwytzMFLIj0Ht2U9HwAdbiw9MT+tfpsEikkWhIaoS0M25fe3K0ny/fvM
	 K+SqsuDFFghKgEyRWkgdIfwfCbY+G3i8/r40mkYgH2OQff8xUdZgkeH70p/EPHFzMggsH
	 WUmyQVRY3USS+cpZRFpqTdEBpbOjC6Mz6VwXPQgpwSmgvXul9HtC6JPedO+9GoKuq1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=mBexMLJiPFmtPzDT8JWrWHKmJ4NS6CY9MOqWPB2Dln0=;
	b=BIBUhvH9ymeJHTp4CwuR9ceQoJlM4z9TlE7OFyKYztQ7vwBuZTxhoszBWEdLHWr1b9RU
	 MMYvz/crsGHqI+iL+g77YPSRuhYNqSW3ehNCLCFAF6Pz88p5INoI0sFcXKK8kmvNZgZ/H
	 r/w5ofYbtsONxq+1vPYcF9fY/f33pVAkdxkRSHohRCu2pdBadKXIk2GbHuULVY7Dc5MKB
	 NcY2wBd+tzZGMnaXAdp17ety0vAsu3zu6F4UZaQfAvHokk2w2ZMLuWtZdW+4zBNXtMttc
	 EMQJYZoPBEH9m90fLCdFg4km5J6y1lrKY22XqaUGHBaVO7/EY2RQr2Ozk8d70Eox24A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bPUVTJAu;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E7606A327
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 423E7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bPUVTJAu
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6f74f6b46abso573738eaf.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778692; x=1793383492; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mBexMLJiPFmtPzDT8JWrWHKmJ4NS6CY9MOqWPB2Dln0=;
        b=bPUVTJAujIQkkIApzRqiVOHngUL0el7GGPKnzHYGZ7lUvMCQ4D8mi4avV+Z8iXoRPx
         Vn3bVNZ4EbjS+G5x2LR4feWOpsxhZf7+lm66BSAQi8jfUPj9MWl/StOO227DRtsc2Lzq
         xSAKLfxqegDbZ0DwAReKalJBAifWtoMdWiUTyVvYB3UM5qjBa4tre/jD6SBsf/gNbk93
         PPXUQCr+VUnPXgkduqdVg8NLmpz/SzdCKPDLsIKKgcpIJpeuiM7LP/dwUXFlxff7aKm2
         9evHM2YvyB+I5AApdYFqbei9BEV7VJTCpklBR4fRBD0ZZcifL19RjsmyM9+ZXCW8qcOz
         j7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778692; x=1793383492;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mBexMLJiPFmtPzDT8JWrWHKmJ4NS6CY9MOqWPB2Dln0=;
        b=Nn6PlYlRAzd7PfaJmKamlTzd2Tou02EY4v4zvBtyaVY4nfYJY/k8JE03KFov8hcaiG
         9OjmgwZHqMsj/AaJr+gSNJO3Oh2TS8qYqEQHdQ3Y4LmrXg7asfRkaSt5UFaFmfZRUwMk
         DbHiK5liRdzhDFt1pOmRMu8LtwdIUaeK+++Jxiz8klMjaQqMSr1Lz1z7cj3Xl94tc9WI
         j/Ib6IMvRmfQxGbqaWS5rNH13KLEe1wfRtZGIZfa2FQIzdgytcqXKlx+MeWP/XRP+zGJ
         +xMorlEVgkYLU1LOSnjcw4bnv81q+Z6gn8OmuAGkPP5RPUtl8C9+6DliGGlpoyEdwPB0
         L/zw==
X-Forwarded-Encrypted: i=1; AKwUvBzHjTUwkCibojcj2Xavt9f/xmVeRz+bO6J4i0aJTv4Kg8Ou8pwR+aSyGQG9SQvON+RDo1rjAMVdaqQkbn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLM5cKf/26dDrIgVMIGabWXovD8W2z9P5GXAkvMeNARm5N6Er7S
	vCKzKYaqszFgVnqnXNGKkSv49AnKI/W/wpT2uxgn3XP7lNCyWNh2LR93
X-Gm-Gg: AYBFou0Hm6lHjHJfiza3GGrFm+gx8+YGYY2EIUeibQ88JRYc/dx3KZ+hWrpNp33eipE
	wUTmJh5xVj0nkzwGik2kafRUO2JqO1/HZYBcPy6pF9dlqFXL4d1Ue+9kLsiKbT0ZFZlUT3GUA67
	UKsTb6t2OEbGTn3y9QkzmYpGfSjtpDfe7FbJyFGRJqgxQxxiF7BXH98j9MTS89k6k+VVOl0THZa
	e56h8yy3VjHUHNY1UPKJVY+6Vb0dgrvYbGjYqEEZh7SNklxbL4AZslc36MIiJR79+rAK4ojA8ap
	f9wDZTUUl8RzIC1eNtjPCA3xa/Glr0bj7zuAL0Hgs4YwCT0tROt0Iao476KLX3avEfdb1AgpChg
	x2p+crCM+xBft/FI6hs6Z2XYPctUWbhHw9KIPRZ3B7FnJcQOQFi7zdRZqwggjkrfLzqpwG97bn+
	kO2CqikvTNloSBN/HunKDUioVLcn3Bfe/RkLIEC0dezvXdwnEAwlhNG92fYmJ97wt2R0j5eZFiD
	gVD62fvyvpRiH6H5lNCAH/TBp/dAEtnzuQT4qhZOECnxQ+ccL96ci76eFGjKIAme2Qp9bqivncS
	pitb8wHKpykjgB3X+z8kQ9U7/r/mcuxppdxJelq18BmpmiMF4hkVSCtUTLQiejHUNLnLATYbICp
	x5ftAue7c56hTupEffd9RzcoqlwiTNYGU4zP9DEcoVraSE9k9GjZiWtA+FNEFool8Jq53Xi3C/D
	/8jg==
X-Received: by 2002:a05:6820:f012:b0:6d8:6049:124f with SMTP id 006d021491bc7-70b889a0ae7mr1969012eaf.17.1792778692051;
        Fri, 23 Oct 2026 11:04:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a838207cb9sm544329fac.5.2026.10.23.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:04:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 0/4] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Fri, 23 Oct 2026 12:04:28 -0600
Message-Id: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Sy27bQAxFf8XQumqHnBcnq/5H0QVnhoxV+JFKi
 tEi8L+XlruICxQIoA0F3nN5yXkbFpknWYan3dswy2VapvPJCv9pN7Q9n55lnLrVAzpM4BDG5bU
 ep3W8yfgwEkY39iOPjU9NDuMFxoqOlIJQaTAY5mUWnX5tFt++32tj/JC23ri3jsqLjHU2wv72y
 xpm+fnlfw74F2o9rzbueiffIe18tOGedgAUlLJgLk6ItVTxAEmTo45CqYZcsOe+oXhte0tpoZM
 LVZk9Q0MIpeQuoGBCrAQcYgDWyPVRlUvvrnjV6qNgDGKe3Soiymr9UFPQEvKjihxHl6BTaC5GT
 qHlZCsmlSodcmmJci1F//HqtQYbkhWUEhTCpolDzTF2X5pKi4EQ/aMqOCJzAsZcLRtbEnTeXMB
 SWl5FKDknGm7n2U/Lep5/bw/iAttqP357+9woKravouid//p85Onw2e6ywe1474D4ASAa0MYXj
 iCeCrwHXq/XP/8xlu7AAgAA
X-Change-ID: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Reserve canceled transmit and receive storage until DMA and its completion
callbacks have retired. Serial-core write backpressure protects a flushed
TX FIFO while normal transfers continue to DMA directly from that FIFO.

The series first separates OMAP's locked completion processing, then adds
the serial-core reservation helpers and applies them to 8250 TX. Flushing
empties the logical queue immediately. While the old transfer owns its
storage, write_room() reports zero and write-ready notifications wait for
retirement. Failed termination retains the reservation until normal
completion, without advancing the reset FIFO.

RX delivers paused data before the PIO fallback and retires callbacks in
process context. Track FIFO access separately from buffer retirement so
PIO and the DesignWare empty-FIFO timeout handling can run once DMA has
released the FIFO. On failure, retain the requested interrupt enables in
the existing IER shadow and mask receive interrupts in hardware until DMA
has stopped. Recovery then leaves RX on PIO until reopen. Shutdown excludes
new retirement work before releasing the channels.

Based on tty-next with the posted shutdown guard [0], channel
configuration error handling [1], RX TTY accounting fix [2], RZ/N1
transfer-length fix [3], and transmit-PM shutdown fix [4].

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com
[4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
James Hilliard (4):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer

 drivers/tty/serial/8250/8250.h      |  59 +++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 277 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  27 ++--
 drivers/tty/serial/8250/8250_mid.c  |   6 +-
 drivers/tty/serial/8250/8250_omap.c |  38 +++--
 drivers/tty/serial/8250/8250_port.c |  25 ++--
 drivers/tty/serial/serial_core.c    |  56 +++++++-
 include/linux/serial_core.h         |  16 ++-
 9 files changed, 392 insertions(+), 114 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

