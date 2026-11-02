Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646118;
	b=D68mDgO4on4+cyCgJyAvm2ny8heSl15pa/bUZbcWJUQPWFHKWmI1YN+188KMWrB7FEfk
	 DzuZlCSiIt1rLJ5Mn6SI3URykxArQmutUJDLADh/7hcJFJUU30UedFjOTR038vTbbLKm+
	 aSgmhS1m3lrMwbtZ3VbSb5kpPEMS5F5qqNAdrXUYK+hKtcImRm2+26OTfNZri1fZR2Pt5
	 HrwWRWCvkq+0Pl8YQuIBOg7uzoQLMWFEK2upJDlGUEUe1OPL+jfISCbySuK0tEI2pnKFS
	 vH8rB9iQCCIzZqdh65+qv8+F0tzYjeVO6GMAHu1mRXBbONIVJenhJKFB6V8xK2OthAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
	b=E27wRfmM3GcVrb7xBPxD2KxRrj0PaLTZbiYadfkd9PHEzmxPU8ADJb/t2KgJdRjdhGwZ
	 cekLH1gdLw18Mr/l75z8nXgAA7aAOuR0D2g55VIn1ZEGvJhnidMKze/GOzWqq3sJ39zpL
	 7aPWbgaOPuE4Qfuhl3EPkR3BcxF3SJloZSNQSgzO7GJxdDTdO9CIGRY/sOUPNpergzYdX
	 FeSNOwCmalzWsO/jdz54geIEAtOaOzEpDl9TWu9ueFAgn2JMJvdlpGKrSJOexH97xW4Oq
	 I6Kk8wAfz1Gudz2gdJEc4lzgsRCy1iYV9+hkPe0jhVSRFlbswNOgwu9y57iFLsJwGOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OoS/CdOz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C616606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C616606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OoS/CdOz
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9905e692905so272286241.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:01:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646116; cv=none;
        d=google.com; s=arc-20260327;
        b=oZakA4KMpI7igQMVgdlL7r17qIOWTr/wdvOOt8j0jH6UYBZiZzZv1kArcIQr5DI8Zs
         g73+K2dnNADQLgx3pTtVtTaH2f2ZzWLgEfr6oTw7WUNBWsy8Vne9N1PdSFSui9uKWCwh
         Fg6drt9fd9bZXfflt9G0cC33/qptIc74EoYJmbW5AZ+3vfTyBFr8rSvX/G++EESfcqZO
         bA0EVxf3HrZdTAtC9kbixs05G19RDTlKJTge15AKlTS8ujBUuxpJ2UJzVuK93tB4e8vO
         tXAHhnPTYFT7pANAPVN1x5/eL8IOpQ5DVarqccD0hBsoWSQgzt76GoeIXkm3H3qxpaJd
         qeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
        fh=wnLIJ/S+IBjyq6Q9dm0S2NGZX5Fl7SrmyrudT94rydo=;
        b=h9G29s0opnf5O7FalKbLEVHlu/gJbLrBQyboj/7U5/nQUlwXiQpDOepiCqdUQv9fzN
         Cl1HkKAvVLfbxM30MCjVc1UKhdIe/K8ZSBD+41/ZZty+NYmyCDRUTTW/yAAsBdi0QDhv
         87Gv7rsJdS9a3F0SmNiicVCiSe6rG0CBHTvRqilf+1iD7Hg5Jx7XvEj2mSMBUDjMPbv+
         hkufZnNliZ0n4SwX759aVWd11XdoNLvFPFuzrByPUtLYc+jwMaR/J+mIuP5lmAVuTsPV
         Guy5tc2Gr8J4iYYlGbg5PhGzoRr5yx5B+kixd9WRQpfVgW3to1Ij9SpW+j/0AY+BCVzx
         fvmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646116; x=1794250916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
        b=OoS/CdOz8tQYiW8NJVemZhVqI7PjK7UstpTdQY4Dz6TKPNul6fYv3wiPUjHSpHVR0X
         +8G7/pSZXoj3VBm+C4dJMmCiEGzZcMUzCW1H0qMMp5RGkNaw0R0+tKREaicYCfwqsmYz
         x0fp8lsiDbrcssAnqhY01lprh/ni95JhhwkCvg0WgLlUZxrTK5tv0rc0TrAuYXIstkSo
         Z7sVetFi8O2ocPpB8QLXZsWIrhtRAtoNu4pSQbLFTYp+EaaoXTq22kx0Z0H90Hd8g9/F
         AO92ly93r0kXkZZNFZ8sWIB44GZ15Otq9O7z/AsCuDASrqdxQhUeAFX6Yu43plwg1N4S
         aJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646116; x=1794250916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
        b=M6jnQVYt9uQYAgJKotd78qHtsvIcuGcyq27qCngtM0RO1p2EDFaECXs1PRNf/Q2yp/
         QuPhHpx8MIi0GMeh51BjHOXtN3ABNnVOO51P+OoxRuH0BP/am8RAPq4VyfpPtjlNNEKE
         VMT0xCDbFuncvUZQdcgMF+lvYu8zzHhZBPvNTwCqXFydviHaqEW9xr7h3S19B0oIsEBC
         R/Cjq6w9X+7tZabi0xugFzlnZbDf3HoO7jHlU0OduCPhZ/PL5hytugNO+vvPHrcr5nNL
         ZuDB50U6l/Evq/B94ByI/zHxyDdCHS3KgFnrpl0p7AUtxVBaZilk3oIVmbwP1cuiOo8L
         BXZw==
X-Forwarded-Encrypted: i=1; AKwUvBwT2MNsz9ZP13pmsN7Wrj4n+LLOxGANTnZHsxMoCRSBl4elQ8mt1A7KC/2XXvNzkT52JUDtGcoh55deyfo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1UXGFZDhCWsAHanTkURQp2Vm2LeuWHaPSLKhLRlwtfda06gZD
	IdTUgQz7DzlhH6pMXkRnsDLqElkS2Dzlqi4WjK+vL9vSPFJJPTWIfKjN4gwyYjsv94ZObZGJJgI
	pdoHVrOjRJX8jYC0qJIapRsr0uYynWeA=
X-Gm-Gg: AYBFou27fLfHsUcVJnv9X6aZXZuGzIZKDLQInSIuaqc/taLM8JlL7IsggaP0A30HzcQ
	Frwb8txwMkq9Onb0HtAPsJFHEpEyoPcNTyo4ZPau7hIWwLNya32sv6LD0syYVddIs61Z0/TVHsY
	AOh23O8jUdO5m49ZN1atv9PngXPlV9pXUFjtG6pVqiCTzTrFvfFCaP0vSnO4Yrdg5ycLlwKt8Gw
	Eid5lkJLANIh8Hhn+gsAVSxIYnRggmdALh+f5mWnTxh088XEAVWUcLjGr8iPIbGolRbbXzSCmP2
	FL+uTA6LmP+lc/R60FR9MiWerxgoIHinZvH+dJoyLtLPSdUkkv7WvWBmaj2aA5qQTxjKhnqeVrE
	QwIjetjuVMpawINtdjMBKMGedPsO+S1s2buTTFgpEdzXCqF33OtINDf1yIzhLQfMHWjSBMOM4BO
	yAclY2OOkyW3pPdfKE7OWokHDKOb4T+AH3uBbGUlNw5C9YQZndjc+3EMFKp6eJzoV/xKnY8OCmc
	g+2BHilULPWuJMV7wEdGO1mbtAM2w==
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr4192494137.13.1793646113500; Mon, 02 Nov 2026
 11:01:53 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <20261029222734.3086943-2-rrangel@chromium.org> <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
 <20261030173635.2186490-2-rrangel@chromium.org>
In-Reply-To: <20261030173635.2186490-2-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 2 Nov 2026 12:01:42 -0700
X-Gm-Features: AclHuK8hePvnISH49dlVrc4mCThAhAMYZDLctOcSiiJ-Xdrwl739zXGlDWt75pI
Message-ID: <CADvTj4op-tFqWmtzOQnt=q9aZttaWngYXLjfXEkdqcLirTMoXA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
To: Raul E Rangel <rrangel@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 11:36=E2=80=AFAM Raul E Rangel <rrangel@chromium.or=
g> wrote:
>
> On Thu, Oct 29, 2026 at 6:35 PM James Hilliard <james.hilliard1@gmail.com=
> wrote:
> > That is the current behavior. Returning from shutdown allows serial
> > core to free the TX buffer and removal to release the callback
> > context. The retry loop prevents those releases, but a permanent
> > termination failure blocks teardown indefinitely
> ...
> > Retaining the buffers and channels does not preserve the complete
> > callback context.
> >
> > The callbacks carry a uart_8250_port pointer. For DW, the DMA state is
> > embedded in devm-managed private data, which can be freed after
> > unbind. The registered 8250 port slot can also be reused. Retaining
> > the DMA channel does not prevent either operation.
> ...
> > Clearing up->dma does not stop hardware accesses. After unsuccessful
> > termination, the channel may still access the UART FIFO, so reopening
> > with PIO can introduce concurrent FIFO access.
> >
> > A hardware-specific stop/reset sequence could establish quiescence,
> > but its implementation and effects on other channels depend on the
> > controller. If the channel cannot be stopped, quarantine also needs
> > to preserve callback-context lifetimes and prevent unsafe port reuse.
> ...
> > The current callbacks fetch p->dma before acquiring the port lock.
> > A callback can therefore retain the old non-NULL pointer across the
> > assignment of NULL. Checking that cached pointer does not protect
> > its backing allocation from being freed.
> >
> > When termination returns an error, dmaengine_terminate_sync() also
> > returns without calling dmaengine_synchronize(), so callback draining
> > has not been established.
>
> Those are all good points. We added port reopen and a `NoConcurrentFifoAc=
cess`
> invariant to `Serial8250TxDmaV8.tla`
> (`Serial8250TxDmaV8_QuarantinePioReopenHazard.cfg`), and TLC immediately
> confirmed your point on FIFO contention: clearing `up->dma =3D NULL` and
> falling back to PIO when reopening after a failed `dmaengine_terminate_sy=
nc()`
> violates `NoConcurrentFifoAccess` in 7 states because the un-terminated D=
MA
> descriptor can still access the hardware UART FIFO concurrently with PIO.
>
> We can satisfy all three constraints while still preventing normal `close=
()`,
> `hangup()`, and system `suspend()` from hanging forever in
> `TASK_UNINTERRUPTIBLE` under `port->mutex` across the three lifecycle edg=
es:

Keeping the DMA state intact and refusing PIO reuse addresses the earlier
reopen hazard. However, implementing quarantine safely requires changes
beyond retaining the buffers and rejecting startup.

For example, serial8250_do_shutdown() clears the FIFOs and reads UART_RX
after serial8250_release_dma() returns. Those operations also need to be
excluded while the retained channel may still access the UART. Close and
suspend subsequently enter power-down paths, so retaining the allocations
alone does not establish that either transition is safe.

There is also a serial-core exception to the proposed reopen contract:
startup errors permit an administrative open for CAP_SYS_ADMIN. That
allows reconfiguration paths which can release port resources. Returning
-EIO from the driver startup callback therefore does not by itself
enforce quarantine.

>
> 1. **On `close()` / `hangup()` / `uart_suspend_port()` (`serial8250_relea=
se_dma()` & `uart_free_xmit_buf()`)**:
>    - Bound the retry loop in `serial8250_terminate_dma()` (with a short
>      backoff rather than an unbounded `msleep(100)`, guarding
>      `if (dma->rxchan)` / `if (dma->txchan)`) and release whichever
>      channel(s) terminated cleanly (`rx_ret =3D=3D 0` or `tx_ret =3D=3D 0=
`).
>    - If `rx_ret !=3D 0` or `tx_ret !=3D 0`, **keep `up->dma` intact** (do=
 not set
>      `up->dma =3D NULL`, including in `8250_omap.c:omap_8250_shutdown()`)=
, keep
>      `dma->shutting_down =3D true`, and retain the failed channel and its
>      buffer (`dma->rxchan` / `dma->rx_buf` when `rx_ret !=3D 0`; `dma->tx=
chan`
>      and mapped `dma->tx_addr` when `tx_ret !=3D 0`).
>    - When `tx_ret !=3D 0`, explicitly call `uart_xmit_block(&p->port)` un=
der
>      `p->port.lock` (`state->xmit_blocked =3D true`, since `xmit_blocked`=
 is
>      otherwise only set when `uart_flush_buffer()` ran prior to `close()`=
),
>      and in `serial_core.c:uart_free_xmit_buf()`, return early under
>      `uport->lock` if `state->xmit_blocked` is set (without clearing
>      `port->xmit_buf =3D NULL`, resetting `port->xmit_fifo`, or calling
>      `kfree(xmit_buf)`).
>    - Because `up->dma` is not cleared and `struct uart_8250_dma` /
>      `struct uart_8250_port` remain allocated on the bound device during
>      `close()`, `hangup()`, and `suspend()`, any callback that was not
>      drained by `dmaengine_terminate_sync()` safely loads a valid `p->dma=
`,
>      observes `dma->shutting_down =3D=3D true` under `port->lock`, and re=
turns
>      without UAF=E2=80=94while `close()`, `hangup()`, and system `suspend=
()` return
>      cleanly without hanging in `D` state or triggering `hung_task_panic`=
.
>
> 2. **On subsequent `open()` (`serial8250_do_startup()` & `omap_8250_start=
up()`)**:
>    - At the very start of `serial8250_do_startup()` (`8250_port.c:2356`) =
and
>      `omap_8250_startup()` (`8250_omap.c:724`)=E2=80=94after acquiring ru=
ntime PM,
>      and **before** clearing `up->dma->shutting_down =3D false`, touching
>      `UART_FCR` / `UART_RX` / `UART_TX`, or setting up IRQs/timers=E2=80=
=94if
>      `up->dma && (up->dma->rxchan || up->dma->txchan)` is still non-NULL =
from
>      a prior failed termination, retry `serial8250_release_dma(up)` first=
:
>      - If `up->dma->rxchan || up->dma->txchan` is **still** non-NULL
>        (termination still failed), immediately return `-EIO` and **fail
>        `startup()`** (do *not* clear `up->dma =3D NULL` and do *not* fall=
 back
>        to PIO while the wedged DMA channel may still touch the UART FIFO)=
.
>      - If termination succeeded on retry (`rxchan =3D=3D NULL && txchan =
=3D=3D NULL`,
>        which also unblocked `state->xmit_blocked`), reset `xmit_fifo` and
>        proceed with normal startup and `serial8250_request_dma(up)`.
>
> 3. **On driver unbind (`serial8250_unregister_port()` / `serial_core_remo=
ve_one_port()`)**:
>    - Driver removal is the *only* point where `devm`-allocated
>      `struct uart_8250_dma` and the `serial8250_ports[]` slot are about t=
o be
>      freed/reused (note also that `serial_core_remove_one_port()` at
>      `serial_core.c:3336` only calls `uart_shutdown()` when
>      `tty_port_initialized(port)` is true, so if the port was already clo=
sed
>      with a quarantined channel, unbind must still drain/release it).
>    - Restricting blocking termination wait to driver unbind (when a chann=
el is
>      still active/quarantined) prevents `close()`, `hangup()`, and system
>      `suspend()` from ever hanging the kernel in `msleep(100)`.

This looks like a useful direction, but it introduces a broader lifecycle
contract across serial core, the individual drivers and power management.
In particular, suspend may need to fail until the hardware is quiescent,
rather than succeed with a quarantined channel.

The current retry loop still allows permanent termination failure to
block teardown; changing the backoff does not resolve that limitation.

Would it make sense to address quarantine separately, with that
limitation documented explicitly here? I would prefer not to fold this
larger redesign into the cancellation series before those paths have
been worked through.

>
> We verified this quarantine + `-EIO` reopen contract in
> `Serial8250TxDmaV8_TerminateRetryHang_Fixed.cfg` (`AllowReopen =3D TRUE`,
> `ReopenFallbackToPio =3D FALSE`), which passes all safety and liveness
> properties (`NoUsersAtFree`, `BoundedTerminateRetries`,
> `NoConcurrentFifoAccess`, `QuarantineImpliesXmitBlocked`, `ShutdownProgre=
ss`)
> with 0 errors:
> https://github.com/ismell/linux-8250-dma-tla
>
> Thanks,
> Raul
