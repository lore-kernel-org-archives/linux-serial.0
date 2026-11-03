Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793669023;
	b=090Dz8lHCo0mfJW7Re6lSuvd9p5tqCshGEAXUwJaLatgX4IFgOiP3W2FM+sAzSp6ghEr
	 ugf7UczuDmjXuYp2An9ALUwhNsuvWDrAtgjRumb1vS88AkTjpAm3gmUXXDmQIypERU737
	 tfLq4KjmUQnWwZaBGmXZaaKeZAqErphSXpflcn1W7qtG7YYJVyShorroJH+eehrPJuv4+
	 hdpS3TVaDaTG8mq9bdh7tFW+hQa8Qjy9eV934ZwV8mbuays8qP8FhqYt8mpxzI448ZWwk
	 awA0CUXNc/w0/FBRQaMfJSVwM1CcMJkwsx4Rqb5jwVtwh8Emm6fo48IgKaOgWyq1eWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=j6X54P/n20M1/zDVnxESincFUnXpjUB5mtxgldEc2PE=;
	b=NQYhN1j+llo/9J7vGrDQrzGIE6mgGjreVGFkmbRO3u5ZgiPmFS7Q3eEg0kf/1e7c9BYK
	 Om2KAt8fQCv0VxQodxNxMm5SpSa5hrbzD6ePMri4XMelDXryA1z24Q969jxjfK+savN0s
	 E9n2hO5yRCoQiNYQwI8yNnA00heHFjcdWvJfbnE9gaWv0lNQ3EkAOSirXToAhAabzixTS
	 76LuDZsfgDWKFr3FfQVUmy+uJDq7KUAEgJpoazvhQQlviLf5us8JfLyglm9qlJ7P94KB0
	 APuZsqjw/oGxT0oUGMI4ub04Uu+oMYJZGHX6GXw1HjmuFFTk78JjveyQ0T7XhPcZ/Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjowP4Ix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3A606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 01:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F3A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjowP4Ix
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9909e82513fso153374241.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 17:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793669022; cv=none;
        d=google.com; s=arc-20260327;
        b=KR7Ds7JqoXdjgaM/I0/s3ZSc+kyTULR5zcIOhPcpzUOLs3XCHLM00Li1yp9jfUc310
         MMPZtqQPqUs1vyygUP18wDWnr3NXYGGBoff33wVrNrsvhChkY+tySQM0uAMZCRsmllA5
         QAZ/Uh0LpPAfGy+0ZRMVNCvTIr+AXIu61ic/PMA0DBmlett4vlOoJch+QtpgFqGreLHX
         8z0CNcpLD2mRxjbOUozjAIIeZSxrlmjTwjo1I49/dyNeDXaLKXzWFvtlsSYtSkTpy+Pd
         aoF8HKIhAFu606btyI5IULn87jeO94vuYDq3KDrNtHGdXrHUxq88Z4jNUR6+LQRIpVuX
         V+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j6X54P/n20M1/zDVnxESincFUnXpjUB5mtxgldEc2PE=;
        fh=W8JJw+p7qCtTXxeq73mloOeppwwTRHzId7aPWe02dqk=;
        b=J/3/Fzj/1wL1YfKlIsT0hNU3stm5/EnbJjMgUNaU3PDLjeKXrfrNaRGN0otsxxbTCd
         kvpBm4sFh1KZFt+Z7lAadvCr/bfiDIIvfcW8mKx6bial4M2DaN/jqf0cx30zG6dDUzNb
         uYayTVO1LjcCF35qCvw+6ue8bZdGK9m3De6wj3Bl+/QZyx9vGWfoSakSb1GYhvL2LsCa
         +vJ5ZjfKOadO3waeIsJgS+rK+GpIpbR5IdgfpJe/dbEB27voMP4+Sv8In9bpKf3jcVPM
         ovMicHP5V4uDAXKJH1Rcb8wiZFwllJW/CSZw5Tv1EwFMqGBLPx6HJxir9Yc3njfbIVJF
         NjmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793669022; x=1794273822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j6X54P/n20M1/zDVnxESincFUnXpjUB5mtxgldEc2PE=;
        b=YjowP4IxZgonhpxh8Bjrgo5AEoyOS2ERjZd6rEqwL4lcR7Vvc088gMMflpFweTFZjD
         Qitfqz/KqarPinFD/cnLiB1a3iFIdaGgGRsR/aQh7m1UiyTqzWlCKdykRhWfDmRMxaEj
         rc0GijFn/b0Il2HMrqReP/S6kGOeX8Vev/qajwPhrFtID9mcMrPpP4cieHPiYdaNMZC7
         7otFmdX1BBP6ub0UCKgtMR/vwDyG4IRhlZu94tCz9FPAuFJUDEywjX0/NE1GljOOWecl
         /mGe1mIy/xqUN3bWziOgNaZEY1gVZGktwM+pqtzP8zzfUdV8bdBbC6tq1GzgcreUP5iE
         Lyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793669022; x=1794273822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6X54P/n20M1/zDVnxESincFUnXpjUB5mtxgldEc2PE=;
        b=xg+fri946DBmVvTg/bNUFjKj+xIy/VV94RPsYmsx1xIQHhl7WRH76O5K9cYEjV4le3
         Vj34iZUIrvU3wKgR07YBGOoaflnCdMV86B94zE/fXucGwkZSioBBjVv/7Fl9iRxk1Y0j
         VsoywWTsVLY8iOirA++u5RkVbmY8rzCP+05s4wHTZV6Zb3fr1osfHS6YqJBvGXzvyILZ
         Pd1gP8qnTdye4YK4muOsH3zfseCB+tAfDmA5pErihX83mz7L/32+kXkT8ZMssFfihVfE
         jNJysOLq4KcFsIHgEeXRD+U+zJ51XK6QYk842Vh2piKHdEQzEZTTkVk2oBgf4ZYmTx6X
         h3MA==
X-Gm-Message-State: APuU4Z/eHhmJA9zC4io5BRQh5NgPmYvftbFc4tzrG61/Rbsgny5YqURI
	9uNOxu7czZnBkVXodBGzjSXVAEfW36hGUrn+dDD1pE17DkX/4WZr+DVOYQ9oNvg1oYFub0kuvNr
	U1eGRyr9bkn/g1v9XrMZSEoCQTNI5mb6PwEd9ZlI=
X-Gm-Gg: AYBFou0+hDtZGwAYUI/GJZ6hi6J8Qi4k2HdSKIGeZFnXX/nEK1WPhb31u8mLbLeH9eL
	PbNICwk6Z2oXtdumZ9DBEaa84UuQOh/kRZ3q1seBpqkMDbCLGuoPh5IqUP76sVer1FvdagAmN7k
	NpN1DoEfIcR/uoPrvjqa96P+UcJypJfZYzFZjnH4H7HMiNPr1XOf95jzC0F5CcBJ4iJ9b3FoiMk
	7YXX8/O6hpFHb4NqBjJJ9qaMBotmSfHq6m8LfIBRkybp4BR4OcB1jerJz/ZvjKZnrsJkX7X5ofm
	eIUGMX1YPTYDbIKWWIkhWh+vOTdrKJwqXapn3Ojk+cgoum/OMfETZkMsCnzh0CdON59WlNyq02y
	sZ47z2mNpVaG9MMSVamZcnncvMrCxNHzPzde6i5fkvjm7HrSblXHvzfiM4ubcVBvc4JwRnDE+FE
	tFwyTz+y+EckvLSXzE4G3coP1ScZVggmMSo6qwI5Jh/frKjuY6K+RgCxppWnPQAa5KmX5LolyO5
	Gs+f9nJt6AP02Ikke3Q2R7aPJOmX3RfKeXYnsTKL6XcgRLONUA=
X-Received: by 2002:a05:6102:5cc8:b0:7c3:874d:60bb with SMTP id
 ada2fe7eead31-7d072bc027emr3228553137.5.1793669022111; Mon, 02 Nov 2026
 17:23:42 -0800 (PST)
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
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com> <sashiko-outbox-194343@kernel.org>
In-Reply-To: <sashiko-outbox-194343@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 2 Nov 2026 18:23:30 -0700
X-Gm-Features: AclHuK_gt5lz7AswOV3gb8RGMWLh9TAATw8FhlHVD0RjFRvXQGOlI9L1gN2tR9Y
Message-ID: <CADvTj4rYqTXsZcSPfe7o1i_-nB1z1ZBkeySKua+f5CWR=7BzwA@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] serial: 8250: unbounded pause retry loop in serial8250_rx_dma_fl=
ush_work()
> --
>
> commit 7216db0ad0fa3a64d9a52f2eff54fb53c9c43c75
> Author: James Hilliard <james.hilliard1@gmail.com>
>
> serial: 8250: retire canceled RX DMA before reusing the receive buffer
>
> This commit reserves the RX DMA receive buffer until a worker has drained
> canceled callbacks and adds retry and recovery logic for RX DMA pause and
> termination failures.
>
> > diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/82=
50/8250_dma.c
> > index 344f0dd24b416..fd2a0ed211657 100644
> > --- a/drivers/tty/serial/8250/8250_dma.c
> > +++ b/drivers/tty/serial/8250/8250_dma.c
> [ ... ]
> > +/* Try to obtain a stable residue before retiring the current descript=
or. */
> > +static int serial8250_rx_dma_try_flush(struct uart_8250_port *p)
> > +{
> > +     struct uart_8250_dma *dma =3D p->dma;
> > +     struct dma_tx_state state;
> > +     enum dma_status status;
> > +     int ret;
> > +
> > +     lockdep_assert_held_once(&p->port.lock);
> > +
> > +     ret =3D dmaengine_pause(dma->rxchan);
> > +     status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &stat=
e);
> > +     if (status =3D=3D DMA_ERROR) {
> > +             ret =3D -EIO;
> > +             goto recover;
> > +     }
> > +     if (ret && status !=3D DMA_COMPLETE) {
> > +             /*
> > +              * Hardware may be idle before the provider publishes com=
pletion.
> > +              * Leave the descriptor alive and retry outside interrupt=
 context;
> > +              * neither copying its buffer nor canceling it is safe ye=
t.
> > +              */
> > +             dma->rx_pause_pending =3D true;
> > +             serial8250_out_IER(p, p->ier);
> > +             return ret;
> > +     }
> [ ... ]
> > +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> > +{
> > +     struct uart_8250_dma *dma =3D container_of(work, struct uart_8250=
_dma, rx_flush_work);
> > +     struct uart_8250_port *p =3D dma->port;
> > +     unsigned int delay_us =3D USEC_PER_MSEC;
> > +     ktime_t start =3D ktime_get();
> > +     bool recover, retry, restore_rx;
> > +     bool warned =3D false;
> > +     int ret;
> > +
> > +     guard(serial8250_rpm)(p);
> > +
> > +     for (;;) {
> > +             scoped_guard(uart_port_lock_irqsave, &p->port) {
> > +                     /* Shutdown cancels this work and drains both DMA=
 channels. */
> > +                     if (dma->shutting_down)
> > +                             return;
> > +                     /* Serialize reset with completion and shutdown n=
otifications. */
> > +                     WRITE_ONCE(dma->rx_pause_wakeup, false);
> > +                     retry =3D dma->rx_pause_pending && !dma->rx_termi=
nating;
> > +                     if (retry) {
> > +                             ret =3D serial8250_rx_dma_try_flush(p);
> > +                             retry =3D dma->rx_pause_pending && !dma->=
rx_terminating;
> > +                     }
> > +                     recover =3D dma->rx_err;
> > +             }
> > +             if (!retry)
> > +                     break;
> > +             if (!warned && ktime_ms_delta(ktime_get(), start) >=3D MS=
EC_PER_SEC) {
> > +                     dev_warn_ratelimited(p->port.dev,
> > +                                          "RX DMA pause stalled: %d; r=
etaining transfer and retrying\n",
> > +                                          ret);
> > +                     warned =3D true;
> > +             }
> > +             /* Notifications also cover completion or shutdown before=
 sleeping. */
> > +             wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->r=
x_pause_wakeup),
> > +                                  ns_to_ktime(delay_us * NSEC_PER_USEC=
));
> > +             delay_us =3D min(delay_us * 2, USEC_PER_SEC);
> > +     }
>
> [Severity: High]
> As reported by Raul E Rangel on v8 [1], when dmaengine_pause(dma->rxchan)
> persistently returns an error during a partial RX DMA transfer (where few=
er
> than dma->rx_size bytes have arrived and dmaengine_tx_status() remains
> DMA_IN_PROGRESS), serial8250_rx_dma_try_flush() sets dma->rx_pause_pendin=
g =3D
> true and masks RX interrupts via serial8250_out_IER().
>
> In serial8250_rx_dma_flush_work(), this causes the for (;;) loop to retry
> serial8250_rx_dma_try_flush() indefinitely until port shutdown instead of
> escalating to serial8250_rx_dma_recover() after a bounded retry budget.

The reason for retaining the descriptor is that a failed pause is not
necessarily a failed transfer. Hardware can finish receiving before the
provider publishes DMA_COMPLETE. At that point pause may fail because
there is no active transfer left to pause, while the cookie still
appears incomplete.

Treating that combination as fatal can discard an otherwise valid
receive buffer and disable RX DMA until reopen. The current approach
tries to preserve both the received data and the ability to continue
using DMA when the failure is transient.

Without a successful pause or reported completion, the consumer does
not yet have the stable receive snapshot needed for the normal flush.
The worker therefore retains ownership and retries after releasing
the port lock and enabling local interrupts, allowing the provider to
publish completion. Once pause succeeds or completion is reported, it
delivers the data and drains the old callbacks before buffer reuse.

The backoff limits repeated failed calls, while completion and shutdown
wake the worker without waiting for the next retry timeout. It does not
solve persistent pause failure: if the peer is idle and the provider
never pauses or completes, reception remains stalled. Retaining the
buffer is an ownership-safety measure, not a recovery guarantee.

> While a brief retry outside p->port.lock allows an already-completed tran=
sfer
> whose DMA interrupt was masked by p->port.lock to publish DMA_COMPLETE, o=
nce
> p->port.lock and local IRQs have been released across a few sleeps, any
> pending completion interrupt has already run. If dmaengine_pause() contin=
ues
> to fail while the remote peer is idle (for example, if dw-axi-dmac times =
out
> waiting for DWAXIDMAC_IRQ_SUSPENDED and leaves the channel hardware-suspe=
nded
> while returning -EAGAIN, or if tegra186-gpc-dma returns -ENOSYS when
> !hw_support_pause), dmaengine_tx_status() will never reach DMA_COMPLETE.
>
> While dma->rx_pause_pending remains stuck:
> - UART reception is permanently wedged until the port is closed because R=
X
>   interrupts stay masked in UART_IER and serial8250_rx_dma_recovering()
>   forces skip_rx =3D true in serial8250_handle_irq_locked(), preventing P=
IO
>   fallback.
> - serial8250_rx_dma_flush_work() holds a runtime PM reference via
>   guard(serial8250_rpm)(p) for the lifetime of the open port.
> - serial8250_rx_dma_flush() returns -EAGAIN, which causes dw8250_idle_ent=
er()
>   in drivers/tty/serial/8250/8250_dw.c to abort divisor and LCR updates:
>
> drivers/tty/serial/8250/8250_dw.c:dw8250_idle_enter() {
>         ...
>         if (up->dma) {
>                 ret =3D serial8250_rx_dma_flush(up);
>                 if (ret) {
>                         serial8250_out_IER(up, up->ier);
>                         d->in_idle =3D 0;
>                         return ret;
>                 }
>         ...
> }
>
> Since the recover path right after the loop in serial8250_rx_dma_flush_wo=
rk()
> already calls dmaengine_terminate_sync(dma->rxchan) and retains the buffe=
r
> with RX masked if synchronous termination fails, can this loop bound the
> number of pause retries and escalate to serial8250_rx_dma_recover(p) so t=
he
> port can terminate the transfer and fall back to PIO?

Successful synchronous termination would make subsequent buffer reuse
and PIO access safe under the DMAengine contract. The concern is not
that termination cannot establish safety, but that this recovery path
discards the pending data and sets rx_err until reopen.

A retry budget would make that an explicit, potentially lossy recovery
policy. It would not distinguish a permanent failure from a transient
one. However, continuing to retain ownership indefinitely also fails
to provide useful reception when the provider cannot recover.

The Tegra186 case should also be distinguished from a transient timeout:
advertising cmd_pause when the hardware cannot implement it allows
generic 8250 to select a DMA configuration whose requirements are not
met.

>
> [1] https://lore.kernel.org/r/20261029222734.3086943-1-rrangel@chromium.o=
rg
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-s=
erial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D7
