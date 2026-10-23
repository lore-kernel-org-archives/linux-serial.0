Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795271;
	b=1yA2WVsQXMz/NgIz+vJtZYAmzigBCLcizgm/t4J26W0iele/5Gf9aNHGco7dWnk0m/K7
	 IBU8a+6romiLpq/zRLFH4/Brt2NN5gfFTJ1H/HJ79wXZCgNP3uYGJoKMALT88lPKygxjk
	 lWPTYcwwUolkGrYiTca4ydgASA0bgAVW14Lm5YAIGUcDuXfCO9wFD2thHrgDnTufDKfT5
	 w5VBG2FfRdJ3Zj8vU/jXBQzs5U9M1QLfmchXw/NVVmt8LqlRhDOt2ubvZqPNTVWl472/X
	 EVXgIxCRyxX4I3rQhfNjvIpVdd5G1+ZMcZIewBIWPLXUcm0bl0DHxZ3gxZCLy3UfKhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=dL42/PyafUKFVHXzhoVn7LVfob1WMmJrZRMrRHzsbRM=;
	b=to+MNoNOfAIIA0CgA1CFf3GwjacyzLaC/Bs7m+BO23ZpwrROyYEtzqcL+b0LEtShGUsC
	 bF21TsPXbCV/aYu+8eLY0wYKU95v7orDQcv2kOhwu/MUVkXpBYgPnx5tVC13OnDI9Qqi2
	 xcwfvCPL0bDGNH8G+w7qqf8Rv6C8DePexsupUWwdJ1Qnav22SknczDOuTUb80ErSmYE+m
	 bP+U6wsFxGG6z55LyPtoH/qLb8/9DpfLN3waXPv8zSgq2Pj3pWAlRY9SEQu9hkYy+JjRz
	 +shzWwEcW4JE0BwKx/1VUjSUPjq21Igxx11bCSurrb/ulSvZouBJskE2tGLmR8tTr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBoqK0wl;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF6606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDFF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBoqK0wl
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-53a448f86e0so781522b6e.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795270; x=1793400070; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dL42/PyafUKFVHXzhoVn7LVfob1WMmJrZRMrRHzsbRM=;
        b=aBoqK0wlppib0gvk8I26JbkZVf6ICzkjc5ENtP+tisn5IoAr1z7U0nRdJ7c31LcjO7
         v+et2LSmLqHMlP+H8pb2Dkk9TBeqvXrm7iSQIO8Edjb0DBcZkj/ZnKoYmAxlAW/NHA5h
         +YKDLuZtZwDkZKN3hZ+uZOckSGezyNND7rMaGOtnbH9+9+dH1U1yQ2jVd1X4bZPsLKBR
         baVyLmqs88pgvt6S1MCIkT9qMM6nqePFwG96sE5lONQZdXOURg+y6beYIZlm7f0zfq1l
         D6b6YJookpl96wcFP7ljTTo+3BOwn4Yq5EHcXxofmA8NG6hBlDgk9L69IQ+JrYkOhTsZ
         uHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795270; x=1793400070;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dL42/PyafUKFVHXzhoVn7LVfob1WMmJrZRMrRHzsbRM=;
        b=hOEhxxS/TO5fA5Xa3UG+2lorX+lRYbFy0FSKq+A7sOfQz0rciEs5al2ugc72227PXQ
         KTqFM4Qtv45RRrb644eRSgO5ok/KQgDEbrGhC+W6oaWPwqAN5wHCZMYL8FvORWfWFMIx
         V82jQxWHrR1kUOu2B7ZaxEdqGBm+3NLBkHhZdWtjPpSbO0bPNySMiMJ1Ej5UhrNytNPU
         O9E60iONzAOWHsKtgOOe8BgvKTmON8jBxeJfK5wt7csesupzTIlcDcvFDVntyUTStxJp
         lyzgH8tALh7O2Q1Y/p3gPKA+UlR27O8FxxlSskVntcqdpV5GzbidrgL5BE6cqFonD5Gl
         QaNA==
X-Forwarded-Encrypted: i=1; AKwUvByIPU2QhpQ/AN1uZuIpTs3fpWxrDfzo+ydXbByRG1SlDuumo+w0gu8lfanN2JRfocURNQijqbtkgNqg4qQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzkZZP6i60tLWKbLMJGdgzPJo/f0djpTi+lK8X3mBgDzxLxVff
	1X41p8BkUAs/4Kpz4gD5sV+uI/7cJWS1jvGyaRF2dHhBW7EPhSdRI+fk
X-Gm-Gg: AYBFou0cg7P4dR/4N3Ghu45l1BRpce5nBgGY+nfSCPvKezqkKE7g/iKaP55tlAwFL+C
	RS8F+LfqBZh1etWYv7MBjiKQEM+125BozYpYUNx7JupNYn/7odWsG7VL/nLHXilpUGFKekhXYdx
	ln4pNJoo98LRxB2RvHEqy8AZWTCFPfXKTYxDdVL+ytOAfrcHC96LSgwJC1vNdgZLMm0/WY9TkJT
	9OxbKZcO7aX+nqweOqOn/NSsvhET7dU3ixy/x9xELicc8dZyBwZhOOtAip8bZ6/A6/8phVWF2aZ
	KZW1Ipodnhot72MnyANTNuIskbscsry3Ep6WMXK+aV5lhTuKAfEGS8Y9UbICck9zdpAw07v1HYz
	l4pD6Ejn1wwuwJdu/9ddH50klKtSHkcdaXHjgGFlJshZ93KZ0O0ktogrxTxRgp1em7n3iSMalnl
	T3ChkWSz7BSeZZmuMcPBbbW4XUAebc4WTXSwP5UsrN3vRnE0tLx3xY0Cswfy0a2tFu6W1gtsGDN
	Fx7QLWVQQ1FTM16sfX02kw3ajnY3hGp51Fm+EnDM7acZITJexoSGs+XnMbPtTyw2LbdGkLWOKdw
	HIxlLrS5/ru/TOIOabbvYZXpYzf+dv2aeK29PxEMaVYWoUlsePUSu9hbjFR6oqYFlJri11FP5Ip
	CMMO6SdQG4ltCc+lEnIif4LAwER7DitSF+iq3aZ+Gu2ycCvs6ZsyyKo3BJMaULkD62jkrCbPiTo
	Wm7AA=
X-Received: by 2002:a05:6808:1804:b0:4d5:295c:a82f with SMTP id 5614622812f47-55c003baca7mr400009b6e.60.1792795269668;
        Fri, 23 Oct 2026 15:41:09 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8431c012esm226213fac.11.2026.10.23.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:41:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 0/4] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Fri, 23 Oct 2026 16:41:05 -0600
Message-Id: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Sy47bMAxFfyXwum5F6kVl1f8oZkFJ5MRFHq2dC
 aYY5N/LJF0kAxQI4A0N3nN5SX0Mi8yTLMN69THMcpqW6bC3InxZDW3D+1cZp271gA4TOIRxeau
 76TheZLwdCaMb+47Hxvsm2/EEY0VHSkGoNBgM82sWnd6vFj9ebrUxfko7XriXjsqLjHU2wubyy
 xpm+f3tfw74D2o9bzbu8Ua+QdphZ8OtVwAUlLJgLk6ItVTxAEmTo45CqYZcsOd+RfGxbSzleuW
 TC1WZPUNDCKXkLqBgQqwEHGIA1sj1UZVL76541eqjYAxint0qIspq/VBT0BLyo4ocR5egU2guR
 k6h5WQrJpUqHXJpiXItRT959VqDDckKSgkKYdPEoeYYuy9NpcVAiP5RFRyROQFjrpaNLQk6by5
 gKS2vIpScEw2X82ym5XiY/1wfxAmuq33+9va5UVRsX0XRO//9dcfT9qvd5Qq3490B8QkgGtDGF
 44gngp8Bvp7oH8C6A3YM2mR0ELxeA88n89/AcMsudoRAwAA
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
completion, without advancing the reset FIFO. Shutdown retains any TX
reservation until reopen or successful resume makes the port writable.

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
James Hilliard (4):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer

 drivers/tty/serial/8250/8250.h      |  59 +++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 283 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  34 +++--
 drivers/tty/serial/8250/8250_mid.c  |   6 +-
 drivers/tty/serial/8250/8250_omap.c |  38 +++--
 drivers/tty/serial/8250/8250_port.c |  31 ++--
 drivers/tty/serial/serial_core.c    |  61 +++++++-
 include/linux/serial_core.h         |  17 ++-
 9 files changed, 414 insertions(+), 117 deletions(-)
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

