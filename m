Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793034625;
	b=xqjbU02a5/Og0QhST8uygyyzHzRG+OVKD9ySPigehgFExcnUyyJIGFP4/zd2/8+aSCAK
	 SxvB+mAwiD/qJi5N22lIrbLWBm7qu6QO5+ZsYC1eI6LL+bkCvnxjSZfenbUsA8DACiAwx
	 giTJXbxs3ypD6gcrB9RYPy4WVl1mnDmDpnLfa5vAR28w33UDhem+sbbpSBNysn1ZxAoZn
	 M3ZDBPIA2c0cWrmuygrW0UmRorHI/Y0waWSztGws+RR/50IzSY2aAPE2Pdicn+4MiOEOa
	 8EYzWE8DzctKfQUQM7ABzfZDoXNFbPAqMFPoDWmgQrFhW1UVKkWnvk6nlR33MC96eQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lAwtPwvP/GgJfxjpJQkSRJHv6LmBYN/Q1Oti0MV20cE=;
	b=fR/fdpN2f1Y/+TMPmep52JUdxBIlV+hBR+c/bw7QRoe/6hsTwW0KzdAQucJMP+mp/J99
	 dgCZjN/Mi6+HUg6PmmHfxTpiZ1H1x2z313g+ZuX1CgbXxgnMxVdShJKc0hmUMQD0bPXyC
	 GMjsQAj3GeR2O/y8k/cGE240mG8lnMIiZIU8rE2PODYA4/DTwZMrDPCN9oy9HCXazHcZu
	 d9F3SW2gdkI3FGVjJQkbKsgMEMlx1syLdqJbDcGbvpDdPO96pQzmOUP4rfJwITYM3XJsz
	 Mp8U1VGGtbKK5G1zVklv1QVxVgFS++uPTZSIIkbHwaFtkpCp1aQND5LKHFfF6CxbfXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kxHixAFu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC7606A31E
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 17:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DC7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kxHixAFu
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so99239e0c.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 10:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793034624; cv=none;
        d=google.com; s=arc-20260327;
        b=WBC9sHJFEO8qxD2b9aSeC0q2JgUB6oH/k1jmXboCbFCbKtht3bhzUJxCZsKzGWrlZD
         ZAHaMepq+UyBVVLmmZInmIoeWV/ItBSno3t+vy0MTdavxfVKm1wZpON7xja2WbsiUUS4
         d17rsOw2MuvH9P4nHHZHQ0PGO/uk7iUXzfPIec1+eWdUE+5YHIsmC4mYWKcw9NxHF7on
         wvE1kTz5Ar3KvXpToT+ajRV2sAaFJFu+eGmmIpV2Si2RdR2iO2mANMAAZLcVbWEtVfJy
         vAlontGzJTetB6PGnmMfAfaL15CUBVgUgmd/HShQwOGzcf9TSqjtsuK1k076NhiaAALb
         BaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAwtPwvP/GgJfxjpJQkSRJHv6LmBYN/Q1Oti0MV20cE=;
        fh=hAqAQI8WvrxUqEvgIjX4Hp+6iwklgCFmCzYtZO+irSI=;
        b=F31rIngsRvx+YGvVrG4DxVsfsEM+5PnPklc/dPUpi6xKM9mD0Wz7C3l85iXpHDgdyr
         iC8j8FnPqRa7QBCvnMMI8XSVPNEMFVJxP4N0jcSJcemNCyA7EERSYLVFpO5pvWz+5pb+
         njXtyDdXWe3B9V4I4zFwO6+lfxmv+vZVHkb4vm2IsuklIhlKZliXr7HeUHbNGi41Tvz9
         gp7dmKjszrTdWSUHOA3FotHMCSTn/vIzrkHirw3Xx75y6/ELw/3IOH+VVIK8gK3OAu3/
         WdOvvZ6zRIV1Km/uTr0O41s6e3jNqqpOWdAVql9Sm8eVoIJy0CRApHWV49Ke/qTHeev5
         7yiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793034624; x=1793639424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lAwtPwvP/GgJfxjpJQkSRJHv6LmBYN/Q1Oti0MV20cE=;
        b=kxHixAFu73g2TOlVARwCUzLo5nwLBmfBq9JmGjWlvcpi2eq3CIFN1IEtURdAO9xY8v
         egYXKEuJ8AcYEIn+G/r2mULntXT/s1zATfbQed604vrC1PYnsoQOjuZpZdxFdjhk5H/Y
         MlmqS9PTcvrCp8CD9qdV6s8JNDR9uGW5SIAlL9uYWJLuwn8hg58Uml6erBEo9lR+Nj+R
         cPdPIJZ94e9BUGbc4XJSXrRo0pXKxcbUbYR4o4JgsMeiKNGQbzMx6a/QyM7snFCwN1E2
         LVbD+trZRzW+gkVXllpROMxmY0FOsmdEhaoKQyBjJ35MzaI4x9awGX6xEv86k9sv9AwY
         1oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793034624; x=1793639424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAwtPwvP/GgJfxjpJQkSRJHv6LmBYN/Q1Oti0MV20cE=;
        b=2aZjIXQwsmGNj1htox9oQ23Z5gxwRL4d2Cs+QpcbJAPZfArcaPDl3t6LRpt6LfD4cw
         cdCPyLGgHUxXvMDvdaxWY86AkNbp4eK9JEqnMGykt06J7hW7yePWE/3jCUG5DWZK1HPh
         YWtt/iwj4CGYz3MhG5cxFzHKlGsMHGniLI7gNHRWH8X2+fHxd7gnmSv1BPrYFmes11l2
         7eOh8F+ErGTKIGF2jfDLHK9h1YInyAExrV0RMRZqhw88vVJQ6hM0hqDrMhfPsP8m/AQ/
         M96LaXWFFppeupIcOkpP5b1TjyzGivu+5vE1hHLwg/JRNJ8OMqYRMpVMRsyKzbFaAzjS
         Oxxw==
X-Forwarded-Encrypted: i=1; AKwUvBxYNwtWuQUsfHjaSXFROc6drilxD+G6b5P8u89HSGioi3WBRXyxG1j7NfQkZ6Dmcx7gSVq251zxtDOA3mM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtVPX2o3Hkt4jZQ3Nn+g1KaOusXXpCpUiN8RPdwN6SrVAZ7yl8
	HTF5n0Ri13e2e7azpgBzLtvxZmKMlXWpczrwMaMopSOWNYVPYeqQSrLpPels8DWY9nAsfXmoKg1
	8zluu4CfzKGhLBKk3wR+DfPERbRuqJ8k=
X-Gm-Gg: AYBFou2D6EyjD5EMUuFw4WwPZzmblGHd+9YmQeLeEw6ldUKjdW2O7V08hd1AuzeFiap
	zk6cFGS1oods0GHByjrgKgjL5hwvxva7Tt44l9kTyGibVowXBeYQAflAGfNgcrX17hRqB93PGYo
	25MNwh4TIRsYy+gep9u4JT34S7We0lQHAliNefw64E0WGAsFnWy1athby2BRVRJx1gV0i9hM2k8
	5XfxULWBIJJnESRygXywahGag/uwZNQuCaw2uCTmmeNnlXijp6RljnBo7I8x0pqNjGv/1np8ntN
	4fNPkaEGqoZQBvb/dkeWuSq0hCmSKxZa5AA+kl9dpzs2NcfmRR8t+cTLne6ipqdehb0sa3y+jqn
	RSU6qoFnYYh3FDPvRam0gX29EwZFUtCBksjeZHuiBsGeAgpCKOi9wpslRJkwg+TJFY2ozqwvm/d
	eFW16ozrQlffg2piimJOolVC3Q8PaOTcyn9l64ywmDON3y/4BFBxbKkXVqEOxMBU4DJZxGLJm8f
	tQYfD5qIFkP1gaxvELzqrhfvx6yUQY=
X-Received: by 2002:a05:6122:50e:b0:5e9:441a:d5f8 with SMTP id
 71dfb90a1353d-5ec3e8e04admr159689e0c.1.1793034623801; Mon, 26 Oct 2026
 10:10:23 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <a011174b-d64c-305b-7dab-62017fc885fa@linux.intel.com> <CAHQZ30AfcwMTXPpCgiWkhz1OFoxHJOqcVmur8Buz72M45Acuag@mail.gmail.com>
In-Reply-To: <CAHQZ30AfcwMTXPpCgiWkhz1OFoxHJOqcVmur8Buz72M45Acuag@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 11:10:12 -0600
X-Gm-Features: AclHuK8g6EMHpoadOv3TJAD667Nte-zf1vnBPpYx8rpkF-Kg_pkoFpFDJdWRf6E
Message-ID: <CADvTj4okFSpw7Wo0e3DR4r4-1TDvOY1esoUDWftY27B7XwWAHA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
To: Raul Rangel <rrangel@chromium.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:24=E2=80=AFAM Raul Rangel <rrangel@chromium.org>=
 wrote:
>
> On Mon, Oct 26, 2026 at 5:16=E2=80=AFAM Ilpo J=C3=A4rvinen <ilpo.jarvinen=
@linux.intel.com> wrote:
>>
>> On Sat, 24 Oct 2026, James Hilliard wrote:
>>
>> > Reserve canceled transmit and receive storage until DMA and its comple=
tion
>> > callbacks have retired. Serial-core write backpressure protects a flus=
hed
>> > TX FIFO while normal transfers continue to DMA directly from that FIFO=
.
>> >
>> > The series separates OMAP's locked completion processing and serialize=
s
>> > asynchronous write wakeups with the port lock before adding the serial=
-core
>> > reservation helpers and applying them to 8250 TX. Flushing
>> > empties the logical queue immediately. While the old transfer owns its
>> > storage, write_room() reports zero and write-ready notifications wait =
for
>> > retirement. Failed termination retains the reservation until normal
>> > completion, without advancing the reset FIFO. DMA retirement releases =
the
>> > reservation independently of port readiness. Serial core keeps writes =
and
>> > wakeups gated during shutdown until successful startup or resume.
>> >
>> > RX delivers paused data before the PIO fallback and retires callbacks =
in
>> > process context. Track FIFO access separately from buffer retirement s=
o
>> > PIO and the DesignWare empty-FIFO timeout handling can run once DMA ha=
s
>> > released the FIFO. On failure, retain the requested interrupt enables =
in
>> > the existing IER shadow and mask receive interrupts in hardware until =
DMA
>> > has stopped. Recovery then leaves RX on PIO until reopen. Shutdown exc=
ludes
>> > new retirement work before releasing the channels.
>> >
>> > Based on tty-next with the posted shutdown guard [0], channel
>> > configuration error handling [1], RX TTY accounting fix [2], RZ/N1
>> > transfer-length fix [3], transmit-PM shutdown fix [4], serport
>> > write-wakeup deferral [5], DesignWare BUSY-safe fractional-divisor
>> > programming [6], and Intel MID RX DMA timeout locking [7]. The serport=
 fix
>> > is needed before serializing the remaining write-wakeup callers with t=
he
>> > port lock.
>> >
>> > [0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown=
-v1-v1-1-3d3ce383c614@gmail.com
>> > [1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-e=
rrors-v1-v1-1-c067587d1ef2@gmail.com
>> > [2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accou=
nting-v1-v1-1-c11795914ab4@gmail.com
>> > [3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-lengt=
h-v1-v2-1-c3106ef4d2df@gmail.com
>> > [4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdo=
wn-v1-v1-1-0e894afa3bb8@gmail.com
>> > [5] https://lore.kernel.org/r/20261023-submit-serport-write-wakeup-v1-=
v1-1-74e7311638a2@gmail.com
>> > [6] https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor-v=
1-v2-1-032ca5338359@gmail.com
>> > [7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-=
v1-v1-1-2b9afdf869d7@gmail.com
>> >
>> > Assisted-by: Codex:gpt-6-astra
>> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> > ---
>> > Changes in v6:
>>
>> Hi,
>
>
>>
>>
>>
>> This series is moving way too fast with new versions. Please slow down.
>
>
> +1. I think you should have spent more time refining your patch set befor=
e submission, or sending individual patches that weren't interelated.

I was doing as much validation as I could locally already but often I
was missing
issues the Sashiko review bot was flagging. Since the Sashkio reviews appea=
red
to be release issues I was doing respins to try and fix all those issues.

Apparently not everyone is seeing those reviews posted despite them showing
up fine in lore for me.[0]

Is everyone here seeing those reviews or are they not showing up?

[0] https://lore.kernel.org/all/CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCH=
NPo3pS6w@mail.gmail.com/

>
>>
>>
>> We're not aiming to who manages to produce highest version counter for a
>> series. ;-)
>>
>> You're making non-trivial changes so please do expect human review to
>> take time. Cranking new versions almost back to back (or even every othe=
r
>> day) will just fill up inboxes.
>>
>> --
>>  i.
>>
>>
>> > - Use v2 of the DesignWare BUSY-safe fractional-divisor prerequisite.
>> > - Serialize CLPS711x TX servicing and interrupt-enable state with the
>> >   port lock. Use non-waiting IRQ disable in stop_tx(), skip queued TX
>> >   interrupts after stopping, and drain the handler outside the lock
>> >   during shutdown.
>> > - Make the Atmel RX/TX tasklets and SB1250 termios locking IRQ-safe
>> >   alongside their interrupt-handler locking, preserving the caller's
>> >   interrupt state when releasing the port lock.
>> > - Report RX DMA recovery after releasing the port lock, keeping the
>> >   state changes and interrupt-enable restoration serialized.
>> > - Link to v5: https://patch.msgid.link/20261024-submit-serial-8250-dma=
-cancel-v1-v5-0-9e52968928d2@gmail.com
>> >
>> > Changes in v5:
>> > - Add the posted serport write-wakeup deferral as a prerequisite for t=
he
>> >   caller-locking preparation.
>> > - Add a preparatory patch serializing asynchronous write-wakeup caller=
s
>> >   with the port lock, including indirect CTS and transmit-helper calls=
.
>> >   Keep sleeping register accesses outside the lock and defer SCCNXP
>> >   notifications until its controller lock is released.
>> > - Use the separately posted DesignWare BUSY-safe fractional-divisor fi=
x
>> >   and Intel MID RX DMA timeout locking fix as prerequisites, leaving f=
ive
>> >   patches in this series.
>> > - Separate serial-core write readiness from DMA storage reservations. =
Record
>> >   retirement during startup and shutdown while keeping writes and wake=
ups
>> >   gated until the port is ready.
>> > - Wake deferred writers after successful startup or resume, including =
when
>> >   reopening with a retained FIFO, and restart any retained queued outp=
ut.
>> > - Keep the write-ready notification pending while retained output is a=
t or
>> >   above the normal wakeup threshold, until TX completion drains it.
>> > - Publish resume readiness under the TX restart lock without releasing=
 a
>> >   reservation that may belong to a newly flushed transfer.
>> > - Release 8250's TX reservation after shutdown has stopped DMA and unm=
apped
>> >   the source; serial core retains control of write readiness.
>> > - Link to v4: https://patch.msgid.link/20261023-submit-serial-8250-dma=
-cancel-v1-v4-0-e759de1839de@gmail.com
>> >
>> > Changes in v4:
>> > - Retain flushed TX reservations through shutdown and failed resume. R=
elease
>> >   them after successful resume, or when allocating a new FIFO on reope=
n,
>> >   so retirement cannot wake writers into a closing port.
>> > - Treat RX flush as complete once the channel is inactive, and clear t=
he
>> >   shutdown guard before startup configures the UART and tests interrup=
ts.
>> > - Check completion after a failed pause so a transfer that finished be=
fore
>> >   its callback acquired the port lock is delivered and retired normall=
y.
>> > - Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
>> >   discovery, writing DLF and DLL/DLH only after confirming DLAB.
>> > - Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma=
-cancel-v1-v3-0-d78f9e4c4932@gmail.com
>> >
>> > Changes in v3:
>> > - Defer write-ready wakeups while flushed TX storage is reserved, and
>> >   serialize the flush wakeup with the reservation under the port lock.
>> > - Suppress ordinary TX starts during the reservation while preserving
>> >   high-priority flow-control characters, which use separate storage.
>> > - Separate RX FIFO access from callback retirement, allowing PIO and t=
he
>> >   DesignWare empty-FIFO timeout workaround after a successful pause an=
d
>> >   termination while keeping the receive buffer reserved.
>> > - Use the existing IER shadow for requested enables and a shared regis=
ter
>> >   writer to keep receive interrupts masked throughout DMA error recove=
ry,
>> >   including termios, RS485, modem-status and overrun-backoff updates.
>> > - Preserve the timeout-enable bit across stop_rx(), exclude late shutd=
own
>> >   interrupts from PIO, and avoid FIFO resets during RX DMA recovery.
>> > - Preserve the completion-path LSR read after stop_rx(), while gating =
DMA
>> >   resubmission on the receive interrupt enable.
>> > - Pack the cancellation flags after moving all their accesses under th=
e
>> >   port lock, including the recovery worker's snapshot and initializati=
on.
>> > - Apply the early-return, shared-helper and line-wrapping cleanups.
>> > - Link to v2: https://patch.msgid.link/20261022-submit-serial-8250-dma=
-cancel-v1-v2-0-088ea51e3891@gmail.com
>> >
>> > Changes in v2:
>> > - Add serial-core helpers to reserve flushed transmit storage until DM=
A
>> >   retirement. Apply write backpressure during that interval and keep n=
ormal
>> >   TX using the FIFO directly, replacing the private transmit buffer in=
 v1.
>> > - Document the flush callback's reservation, writer backpressure and
>> >   retirement requirements, including release before shutdown returns.
>> > - Split the OMAP completion refactor into a preparatory patch and move
>> >   the RZ/N1 preparation-order and shutdown PM fixes to independent
>> >   submissions, keeping four patches in this series.
>> > - Take runtime PM references around worker UART accesses, and leave no=
rmal
>> >   RX retirement to release ownership without reading LSR or restarting=
 DMA.
>> > - Synchronize the queued TX ranges before preparing the descriptor and
>> >   return the mapping to CPU ownership before releasing the reservation=
.
>> > - Keep the TX transfer length separate from FIFO cancellation, so a fa=
iled
>> >   termination can account completion without advancing the reset FIFO.
>> > - Exclude late RX flush work during shutdown, including Intel MID DMA
>> >   timeout interrupts which are independent of UART_IER.
>> > - Accept DMA_IN_PROGRESS after successful pause, and recover from fail=
ed
>> >   pause, termination or DMA_ERROR before handing the receiver to PIO.
>> > - Preserve stop_rx() and shutdown across recovery, and retain the
>> >   DesignWare empty-FIFO timeout workaround when receiving through PIO.
>> > - Apply the requested guard spacing and container_of() formatting.
>> > - Link to v1: https://patch.msgid.link/20261021-submit-serial-8250-dma=
-cancel-v1-v1-0-efe2b89f2303@gmail.com
>> >
>> > ---
>> > James Hilliard (5):
>> >       serial: 8250_omap: separate locked TX DMA completion processing
>> >       serial: serialize asynchronous write wakeups with the port lock
>> >       serial: core: allow drivers to reserve flushed transmit storage
>> >       serial: 8250: drain canceled TX DMA before reusing its buffer
>> >       serial: 8250: retire canceled RX DMA before reusing the receive =
buffer
>> >
>> >  drivers/tty/serial/21285.c          |   2 +
>> >  drivers/tty/serial/8250/8250.h      |  59 +++++++-
>> >  drivers/tty/serial/8250/8250_core.c |   2 +-
>> >  drivers/tty/serial/8250/8250_dma.c  | 286 +++++++++++++++++++++++++++=
---------
>> >  drivers/tty/serial/8250/8250_dw.c   |  27 +++-
>> >  drivers/tty/serial/8250/8250_omap.c |  38 +++--
>> >  drivers/tty/serial/8250/8250_port.c |  31 ++--
>> >  drivers/tty/serial/atmel_serial.c   |  12 +-
>> >  drivers/tty/serial/clps711x.c       |  23 ++-
>> >  drivers/tty/serial/cpm_uart.c       |   2 +
>> >  drivers/tty/serial/fsl_lpuart.c     |   2 +-
>> >  drivers/tty/serial/jsm/jsm_cls.c    |   3 +-
>> >  drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
>> >  drivers/tty/serial/lantiq.c         |   3 +-
>> >  drivers/tty/serial/ma35d1_serial.c  |   6 +-
>> >  drivers/tty/serial/max3100.c        |   6 +-
>> >  drivers/tty/serial/max310x.c        |   9 +-
>> >  drivers/tty/serial/mux.c            |  13 +-
>> >  drivers/tty/serial/mvebu-uart.c     |   2 +
>> >  drivers/tty/serial/mxs-auart.c      |   2 +
>> >  drivers/tty/serial/sb1250-duart.c   |  14 +-
>> >  drivers/tty/serial/sccnxp.c         |  45 ++++--
>> >  drivers/tty/serial/serial_core.c    | 100 +++++++++++--
>> >  drivers/tty/serial/ucc_uart.c       |   6 +-
>> >  include/linux/serial_core.h         |  18 ++-
>> >  25 files changed, 551 insertions(+), 169 deletions(-)
>> > ---
>> > base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
>> > change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
>> > prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
>> > prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
>> > prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
>> > prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
>> > prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
>> > prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
>> > prerequisite-patch-id: c3d8ac0d54d1bfe43657964c517cfa4c7fde11af
>> > prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c
>> >
>> > Best regards,
>> > --
>> > James Hilliard <james.hilliard1@gmail.com>
>> >
>>
>> --
>>  i.
>>
