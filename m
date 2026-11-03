Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729157;
	b=ndmSHXgkrz15GO+T80I8wVS1wwkjR82ey39jujwusiaJWF/yqc2j8vncOMANSO/6oKZ5
	 SAOWOKXAxKGpgZacWfGXUKKMZf3jWGVSF2nxYcuwJYCj03RyWbwrscNPKvmmnoWX5wIVr
	 elSdrk6OZzpDRJz+N564BO+ZKHJD6omeeRvaIUnHN1q0HhzLb1VOPL2VcVW1JOscc74TL
	 eK3/yu7pVfmwX6Pe2+nQyxciWKe5WlMME6bnLgfjwg64LCg2lll0g3AN7j7FZtXvJ8ctG
	 r4MyYCzA2c3drkUXkGQPxCv2wCTtEt0mK1nMIOV+k77DhDI3+cmFZaKAfYDLxsT456w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
	b=zblI+4ddkSKgyY6ixcCX8C+LkY+uCNNOQj6YlAlHcG0Kv6REIL0ZxiRfWJb3/8nkxDsy
	 Ig0rZP63FqMr1/1KIRYGXfDJTReaP1ncovax53vFwwX2tlHavamG9G6yMtQ/ZgJ0vpqOB
	 S19cLQ6yL9d6KmREwx2YyKuTGbjczL5igeqAKz7Mn487LzRf+Dw+J4Us8eRGscP0Y/ZUZ
	 A5c5q3TqkIq6rJDyqdaNk2y1+gyxzZJO1KKPSI8xppcAwlwVQy5X9knnUOp8KBOQy6izL
	 U7WFG5aSs/mmlYQK7m8srZI4eEe6nN6UrCVI1GCeiZt+pXJuaQ8X/JVVgkbmUjhHqeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBXg5HLV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14C606A328
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 18:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE14C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBXg5HLV
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc81984fceso1424881137.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 10:05:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793729156; cv=none;
        d=google.com; s=arc-20260327;
        b=IW6WFtrgyGfn9o94SJq6sfFoApuVxR0asaK5v3Ryfj00h7A4VvKLLZP/4SO70bSLfr
         jRxXV1oGmt/4Ogf80OYNSZu33sGmZY5N6mqTBPOB/s1KVbiI5dhEfogF7ba/pE4+itW2
         Y9woPQIFRUwsfN16OrfP5r3w3AovTZoGo3ENu6J17wKaOILCzUzR3DthYlqa3rbzQN4B
         CVBNuUZBQidwXnvjxAnZl0IX9cpIiadSdNvtFDtll0ItaA6VkMJ6kWJb6UTtxDJ6HSgX
         p1x5IUz65+1bhoEmWkKJFFtr7zKRfgGI5tURXkfivnutBkcIoxqC3zpXGfCvS1bi+hUZ
         e9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
        fh=VaXw0HLyOBbtOm4AL5trE6BQ5IaEmglWGLoEuqdJdG4=;
        b=e09s+TasEEEvrOWVwzZz5pnWR8mjWZQ7Pa8ak/7bc1cNCo9v25NYQ2zzOgOAwdHFG3
         kONJqjW6zVJnCsDGod7JECwxAV/MbAV7OFPwiAOYh3m7zFBFpEpc5VHL5lHbYPfbjcxi
         wx10nrDHGGDY3KB47fiRLpG1lRGJOEQ2LN+bt2bGqBI5HRjM6h2OiTodQcy/cAj2lCtR
         7xwidDC0B9eNozFWxxbMLQiJKFDRSF98UtI64Sck8wSbMgFFI3ZKkSdv8+1R06ZTmx64
         CB407iG3EYv60obGxK07oXnUAa5Dq9DKq/9F2rQS3A8HELTvuhHZbzYn5Wx1yTct7RBZ
         IBsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729156; x=1794333956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
        b=eBXg5HLVs3+DnyK0HOE1HArp8LeVs07vZX8/90QXs4aNyYpremL/O+2hqZPtnY/Pxt
         afntlOfHYW5A3PQNeX1Nn0nICWejEG5J/bf59loCPDYM2t9QmhPpo9VG8TbqDjhQ9A/H
         GRmNSCNJ+hwceiMQg99yXPTWIjbZq5eUSafvD0KyaU+0YsXpil/GuuHhlZydBvt1ECH/
         VrPgrNzoAZ9iPS+z13CW2aJJs2oDtansUJq3cgqJbiI5m6dxM7QIzdbBCZN8NaZPNjR7
         5JSEawDva8Iyute9qb+55E8YDfEeKUMnmfcmiBCKrdpOjMv5Y76Zmprh3TZc9buitoW5
         brYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729156; x=1794333956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
        b=lbK62y3pf+Rpm5j25bTMb1RiTGS1iA0mRvt7vVicI7ADFmO9XWbG+y0yuUl8RHmc0n
         bb3ktsGnQi0dnn/lVMmEmSQFZXnjLgAAZfLGjDUmf60eopl/9yWBWacIL8l25T6G/eGI
         Sz5VBx//6qm93NMkPwIXM9aM93mTfUekdc4svWA7h71ZTPdKCgS0tt38IRV3jDJPdomq
         8790ZYRjQiHcet4uUGyFEHCAwYhQ3J0zq6+h6U2e9M4b7dxLztE4iJHXjSeko12bmDE6
         2+KvwpLDxvZYjO85j5/znrpu0F/8Ux3eYuqnyy8ovYuviTgap90UQZQxf2BZK0vYEWJI
         P3Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwaz4hI4EldVuaJeSat0755YWpm5g5qNPVTFbtbrxxn90es3R4++Lt5gMTHTRoGf5udq9HQ9825h/w5pfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XS/i3H7TdEmarKtVOcbAY3nHvkoRRVIy20wD3hE/DBP30m5Px
	kmq1wcvzkPG4EWUzhLoiXNAGC6l1ibLJliNL9+0WKZ7/grpQLsAz9699JJSVhee20/ZHOoM51MC
	Hxf0sZgHevSb//K7IJ1AwvTGfatgSt3c=
X-Gm-Gg: AYBFou37jpYBHkU549xg4Zp+OC2h31ddQsjkzmWz75aKhacplr0J3ZEKmQUbcJ+ar7V
	W6Y2WcA/dvXQczy6JRhq/9MVJR57EfggncI5C9dVeMVK8cCUTFD/hpI2gF+xAj/T3gzki8hq7E/
	PMZVphZhvArUH7c1HQQTiStorMrXQKq3byYtkQ5O24iotc9+Sk7uxeopo9O7W9CRfBHLpCzOcNQ
	05dngWo+CIx/a1wgSrPcLcZbLWtkL8yogsdj9Dr7c3pH/x3hnyn9SodRHiRXz/b94KgMVobEslO
	gX2nar09Z1Q3GGh3CI0NgoueW5UtzduokWWNrm3s3HEfWe7/v4K6eOzVrIgSKP36WyRAHTx2GKg
	cTjnXfdFhSWqMmnziP8jWPMB8qOuOxePiWE2F30Rnd9pfuA37UmNQQ4DWu5meoBQcLadGR3e6HK
	4LKzN4DtRgwostspH0hHmfP1MtPPM9NBsTx0wTNwlCn9ByBFUWvOgkTPQ0IaPKHIJC6gH2+JS8v
	HHxtiy11NaEz6QG0swtZuO0iuyDyw==
X-Received: by 2002:a05:6102:5121:b0:7cc:5c9d:7e07 with SMTP id
 ada2fe7eead31-7d072635de3mr4255291137.11.1793729155740; Tue, 03 Nov 2026
 10:05:55 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com> <20261103161104.2449407-7-rrangel@chromium.org>
In-Reply-To: <20261103161104.2449407-7-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 3 Nov 2026 11:05:42 -0700
X-Gm-Features: AclHuK8ExVfXbcYLwfHHnCvMLw6HMi1Pim5AHzKRXmfuq3AFPdi8A4knMcfIqjI
Message-ID: <CADvTj4qXcOqS-wDrrN-x3sXUQr5BtFBeGzz_wqpW8WJ1DMPg+g@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
To: Raul E Rangel <rrangel@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:11=E2=80=AFAM Raul E Rangel <rrangel@chromium.org>=
 wrote:
>
> Hi James,
>
> Thanks for v9 =E2=80=94 fixing asc_startup() locking in Patch 2/8, waking
> tty->write_wait for drain waiters in Patch 5/8, splitting OMAP RX locking
> and IRQ quiescing into Patches 3/8 and 4/8, and adding rx_pause_wait with
> immediate wakeups from dma_rx_complete() and serial8250_do_shutdown() all
> look good. Waking rx_pause_wait under port->lock cleanly avoids delaying
> normal completion or cancel_work_sync(&dma->rx_flush_work) during shutdow=
n.
>
> Two remaining comments on Patch 7/8:
>
> 1. Escalating to serial8250_rx_dma_recover() after a bounded pause-stall
>    window on partial RX transfers:
>
>    The commit message notes:
>    > A provider which never pauses or completes retains RX ownership unti=
l
>    > an error or shutdown; a timeout alone cannot establish that discardi=
ng
>    > the buffer is safe.
>
>    I completely agree that a timeout alone cannot establish that *reusing=
*
>    or *freeing* dma->rx_buf is safe while the channel is still running.
>    However, calling serial8250_rx_dma_recover(p) under p->port.lock once
>    the retry budget expires does *not* reuse or free dma->rx_buf without
>    stopping the channel:

Successful dmaengine_terminate_sync() establishes the required stop and
callback-draining guarantees. The concern is not that the buffer remains
unsafe after successful termination, but that this recovery path discards
the pending receive data and disables RX DMA until reopen.

A failed pause followed by an incomplete status can be temporary, including
when completion has not yet been published. Retrying preserves the chance
to deliver that transfer without switching to PIO. Memory safety after
termination and the decision to discard the transfer are separate issues.

>    - Calling serial8250_rx_dma_recover(p) under p->port.lock inside the
>      worker's retry block sets dma->rx_err =3D true and
>      dma->rx_terminating =3D true (and keeps RX masked in UART_IER), whic=
h
>      causes serial8250_rx_dma_flush_work() to exit the for (;;) loop
>      (retry =3D false, recover =3D true) and call
>      dmaengine_terminate_sync(dma->rxchan) outside p->port.lock in proces=
s
>      context (8250_dma.c:233-239).
>    - If dmaengine_terminate_sync(dma->rxchan) succeeds (ret =3D=3D 0), th=
e
>      channel is stopped and its callbacks are drained, so clearing
>      rx_pause_pending/rx_terminating and restoring p->ier safely falls ba=
ck
>      to PIO ("RX DMA failed, using PIO\n").
>    - If dmaengine_terminate_sync(dma->rxchan) also fails (ret !=3D 0),
>      lines 235-239 already retain dma->rx_buf and return early with RX
>      interrupts masked.
>
>    Why does this matter in practice?
>    Look at drivers/dma/tegra186-gpc-dma.c:
>    - Line 1521 unconditionally assigns .device_pause =3D tegra_dma_device=
_pause,
>      so dma_get_slave_caps() (drivers/dma/dmaengine.c:614) sets
>      caps.cmd_pause =3D true and serial8250_request_dma() enables RX DMA.
>    - On Tegra186, tegra186_dma_chip_data sets .hw_support_pause =3D false
>      (line 1351), so tegra_dma_device_pause() (lines 420-423) uncondition=
ally
>      returns -ENOSYS. (On Tegra194/234/264, tegra_dma_pause() at lines
>      389-414 polls TEGRA_GPCDMA_STATUS_BUSY after setting
>      TEGRA_GPCDMA_CHAN_CSRE_PAUSE for 20 us and returns -ETIMEDOUT if the
>      channel does not pause.)

The Tegra186 case is a permanent capability mismatch. dma_get_slave_caps()
derives cmd_pause from the presence of device_pause, but this provider
installs that callback even when hw_support_pause is false.

serial8250_request_dma() already rejects RX channels without cmd_pause.
Correcting the provider's capability reporting would prevent this
unsupported configuration from being enabled in the first place, rather
than discovering it after receiving data. That is different from a pause
timeout on hardware which supports the operation.

>    When an RX timeout interrupt (UART_IIR_RX_TIMEOUT) fires on a partial
>    transfer (e.g. a few bytes typed at an interactive console or a short
>    command waiting for a reply, count < 4096), hardware transfer completi=
on
>    will never occur while the remote peer is waiting for our response. Wi=
th
>    an unbounded for (;;) loop:
>    - Those partial bytes in dma->rx_buf are never delivered anyway (even =
if
>      we wait forever until the user closes the port, serial8250_release_d=
ma()
>      terminates the channel without copying dma->rx_buf).

For a provider which never pauses or completes, retries cannot restore
reception. A request/response peer can indeed leave the descriptor
incomplete indefinitely, and closing the port then loses those bytes.
Backoff and diagnostics limit the retry cost and expose the stall; they do
not solve that liveness problem.

For pause-capable hardware, a recovery timeout does not have to prove
that the failure is permanent. The concern is what happens after that
timeout: the current recovery path discards the pending transfer and
leaves RX on PIO until reopen.

Is there a recovery approach that avoids an indefinite RX stall without
turning a potentially temporary pause failure into loss of DMA for the
rest of the open session?

>    - UART RX remains permanently dead with RLSI/RDI masked and never fall=
s
>      back to PIO.
>    - serial8250_rx_dma_flush_work() holds a runtime PM reference
>      (guard(serial8250_rpm)(p)) for the lifetime of the open port.
>    - On 8250_dw, dw8250_idle_enter() (8250_dw.c:151) sees
>      serial8250_rx_dma_flush(up) =3D=3D -EAGAIN and silently aborts
>      dw8250_set_divisor() and dw8250_check_lcr(), breaking baud-rate and
>      LCR updates while rx_pause_pending is stuck.
>
>    If serial8250_rx_dma_flush_work() escalates to serial8250_rx_dma_recov=
er(p)
>    under p->port.lock once the stall threshold is reached (or immediately=
 when
>    dmaengine_pause() returns -ENOSYS / -EOPNOTSUPP), dmaengine_terminate_=
sync()
>    safely stops the channel before any buffer state is released and the U=
ART
>    recovers on PIO instead of wedging until close().
>
> 2. Minor nit in drivers/tty/serial/8250/8250_omap.c:783-784:
>    In omap_8250_shutdown():
>      WRITE_ONCE(up->dma->rx_pause_wakeup, true);
>      wake_up(&up->dma->rx_pause_wait);
>    8250_omap uses its own synchronous omap_8250_rx_dma_flush() and never
>    schedules rx_flush_work or sleeps on rx_pause_wait, so those two lines
>    in omap_8250_shutdown() can be dropped.
>
> Thanks,
> Raul
