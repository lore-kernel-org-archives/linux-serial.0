Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793320533;
	b=MgFmbh7KBWiKX9MIGdHa9hUHSutv3YxFyo/mDTB6PDeMetzrq3/iSjJ3+l/axYKXtOmp
	 a+928lwHFKnhtZcQLe7gX9jqwjthJeZ58/3SSjRp1Voc4QiT6+2WBRjvh0gxbvv6+eFSr
	 3n+8KhGu4MKh9zhb2mYbSL7ZoJQnEEnO++lHQsKlUo13pO0KuP4nMzHrPHcAHNVz18Jf7
	 C/rng3cvx1z9J/P9m75xSNV8DDriFbXoKu7gDt8fLjhVxlnlDASSgh62ra2+IvUcj0g3x
	 oeREll2U9lOP/DdYgSKYpR4AYJlH1y9+mUng+mPEQ8VNTnXP7JupHNA+bVLoB094tIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
	b=uPVSgxOgcV/DWTdjaEElWba3lIMF6FsZGVlQsE7KWONjKm83y4uj2+2CPjqPTezVlBYa
	 qbHa5cnpR86RMc4y78IAekA8pqJrHm0FDBpASTqGrOPo8Bl2vdPUAK2WpeMVS+w0Zh7+o
	 4vfIzCO3jNhu8QexFbvHpg4cUWskA5qM6xlFsXnBDmXACiCWf0Wmt4HHH84l18fHQ73eZ
	 9JtRV2CfKsc6tQC2FeqDyEDW5DlrTrK0+jreqZ/E1dFh5bdK6fNE0Rl9XROR7braaO0/W
	 QhA42uvsVzIx7cQ/tdV1t2JLpDsEB5XTUndXJEVqpSqDQJaW7QL5AuUrbeS96VPpbHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NveNZKyY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98606606A31F
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 00:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98606606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NveNZKyY
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9912c47367cso166929241.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 17:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793320531; cv=none;
        d=google.com; s=arc-20260327;
        b=fEmEnBxI59DBNH8jQV/I2fMyMk1pZEdxuM3/QlRgyezmF3TwJXEMsyU1fYQs7XqUMw
         W7sHjp7HHsihlLN/HsDrg93mZKGJu1l4ZNZhdtD4+29x9buxEUQcx+DS0MOzUMO2v4y4
         j57h8O9whpr2F5tLZhqtd0YaIHyXj6fx+Vsr6iEOp1cE5OhanwkO+dmXxgXbXc+63G2i
         TRRKm8CkcKZUjfMHeJVRoLhvi6EEunFvrw5a521vzwXP1bsbOHZbxBEb2i59ATY8Jstx
         4TV6ABOhVBVoavlZd/n4flnAXYN56NJO5rf0lTFqLE8nXwljN7MjpNxKPFoGMwcY0gXU
         mh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
        fh=/BRJxWTq2gtcDBjmoLPQvdQYzQfryBzdAXEcwDJ1CFc=;
        b=p7TsISNj+9k99fPGt7c3g0jOR0idRCroURqfY2lbp2tOyeUtafdmkBcJFDsj9kpu/1
         axp0bbgKfrKGMSb8czk/VYMKQvzbOhMX9zJRRNsnE4Hm6WsOGVgFp3gZ0+uigRKa+Cv+
         gYWLHxeMTMXXVXIMj3HPh8QS/tdTCOSE9hvSWmPpN09Pt1LXMVAgbjrRvXLAoQ+dgheL
         8+0PiEmHcoNojTXLUmryD+Rkanc/XIpE7G0NbRXrQFe4BOEHebstmxwYvI0zQFPtOuCS
         4Hi1EXy9zSzzeSXvigEjQpGHnftFme0+pqShgzz2Iq5h0l4MS4HZBaPjB8tcoejeY+jM
         PXpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320531; x=1793925331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
        b=NveNZKyY/FOrtHSAw1/cT7/BtKuFAKKDeJwA5bNqmY71BgoSFthc2SE+Wxp6Cw2wm1
         2xhicHAT3TVspQqbqhk5eb4bmSYh54Yq8qBukYr7vCtOk0fZ1OeL+p7CLkVWrrptlPuy
         rYMdVYrgKAVwbeK0bd0Qmvqi80/NyXv/BnzUCRLSILgqQrpsXqkVQAHvFj1XKl2NC6kh
         QKHMGWRd3IpmwmebOVoEH25nog3pIvF/gMkxkTbo2wMi8b0G7ivW3O00k0ajpNS2Tt6x
         9w5YBLwj/vh8AnUlzWuVP5ff/fLXqZzbX44qvzR4SMA93BwX17mHdV2Y3Yb2SH801flH
         8UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320531; x=1793925331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
        b=BoxZFLBe1Bvw5QjneEyoNKoMYuFIPYrN/Cz8/7CY3eQwKblJOe17/iXrdftHRbs5UX
         Rz1fjzzlWB+XrNwII08RhtnGqquXb1MKKNRb8AjSFc9EJfkgUtm670s+9E/Nvc4cj+5D
         bWRfmDerhtQURxTNSSBe7LgkKg7NpGBFc+pAIRPPT3fDyCDH+G5JvHC4lqKkFaUwZbuv
         f5BB/IvISTcIYt9xp7/8WLCUcYuHAL7S/usEr/RGKCjBQU3NkMNUdRQUg3AjntRJ6ZXZ
         N613loWEuBQhDAxJraDOqjFoTuOfMQzhty3HoLoPPYAp3GXXcy6oeEKegMTUPSub1AZD
         lnOg==
X-Forwarded-Encrypted: i=1; AKwUvBx5fwtEvNICE32xcI9+BDl1UaZKvXYZB2XWTdFat/46/XMqun/6Gnw/7MlpxpHpyv8v6ZclSEE2qAa89nM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLh2O5cH+hcZUgRse7ab9jP0Zf6YymnCpwouCNGAgJy1rDs4U0y
	o/uVXfvJQ4YFx3hBDxsu7OCJwiPA/PyVodS4XfZ9/5+DB5DBKm3ewBRiuXF+/o4o/QEICMi8u3X
	kdXpFsbVC3L5tZHusWFe6m15grEuYBqE=
X-Gm-Gg: AYBFou3GlCyTq9HgdWWjbDuXMYh566z0Ny2xGNz+OdPmUiATqOuj/gaTSOlzr6T8MoQ
	zYQKyhgBbtEPN6K6d8n1Cc2pIdlx8RwOxltknPUrBHYSmbpKtf1BS2d0hsj8M5Qi8bU/T8h02SO
	+DgeAab5Lau69B8Z6ELNhVsU/qJcQK/DhNJVxwC0Huno3RwqqMxzy1ghagQUtHiTAfHpk0Yjj8p
	mxOQrn1hPWxgfELFlk0Wi1O6EpQUv6RHxjB2fgYEmahjcTmhyvj0jzbKQ1nu6v8pXUjaW5bm0i0
	lKEVxQYv7S2W6FFBlnkZBnvbXb4cfVc4ZEjC5at4ufWmyLJXtdjFyoioUTwiQo5/HMN2irmJsb4
	9Tfnc8t33+rCYTNDgS3lXyjtNjvW481DIuVSZsyf9eCgiKyZAho/WJrycR6OY0mYflsCQL2EtIz
	2/VOCPVv0D7cuaTYaadb7qDtg712H/6veJAv/i2R5QaqOJo6DcjIl4Q+LCGOCn9cmyNgw6IMBDZ
	JjvPU5Jl5wI8bvtsnFn+7+8xAGU3A==
X-Received: by 2002:a05:6102:50a5:b0:7bb:64cc:1362 with SMTP id
 ada2fe7eead31-7d072c2b96amr253188137.6.1793320531134; Thu, 29 Oct 2026
 17:35:31 -0700 (PDT)
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
 <20261029222734.3086943-2-rrangel@chromium.org>
In-Reply-To: <20261029222734.3086943-2-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 18:35:19 -0600
X-Gm-Features: AclHuK9fwQEf1FE2SE005DWVvtH9Aa6gi9TWL3-I0d1O0Zk2jQvC0qB4u35B3dg
Message-ID: <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
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

On Thu, Oct 29, 2026 at 4:27=E2=80=AFPM Raul E Rangel <rrangel@chromium.org=
> wrote:
>
> On Thu, Oct 29, 2026 at 11:19 AM James Hilliard <james.hilliard1@gmail.co=
m> wrote:
> > On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > > + while (rx_ret || tx_ret) {
> > > > +         dev_err_ratelimited(p->port.dev,
> > > > > +                                   "DMA termination failed: RX %=
d, TX %d; retrying\n",
> > > > > +                                   rx_ret, tx_ret);
> > > > > +               msleep(100);
> > > > > +               if (rx_ret)
> > > > > +                       rx_ret =3D dmaengine_terminate_sync(dma->=
rxchan);
> > > > > +               if (tx_ret)
> > > > > +                       tx_ret =3D dmaengine_terminate_sync(dma->=
txchan);
> > > > > +       }
> > > >
> > > > Huh?!
> > > >
> > > > This is unacceptable. Sleeping is okay, but value should really mat=
ch the
> > > > baudspeed and other parameters of the transfer.
> > ...
> > Regardless of the retry interval, shutdown cannot release the buffers
> > until the provider establishes that DMA and its callbacks have stopped.
>
> Agreed that if dmaengine_terminate_sync() fails, shutdown must not free
> dma->rx_buf, unmap dma->tx_addr, or kfree(port->xmit_buf) while hardware
> or a detached callback may still touch them.
>
> However, because serial8250_release_dma() runs under port->mutex in
> uart_shutdown(), uart_tty_port_shutdown(), and uart_suspend_port(), an
> unbounded `while (rx_ret || tx_ret) { msleep(100); ... }` loop means that
> if a DMA provider returns a persistent error from dmaengine_terminate_syn=
c()
> (-ENOSYS, -EINVAL, -ENODEV, -ENXIO, -ETIMEDOUT, or a wedged controller),
> close(), hangup(), and system suspend will hang forever in
> TASK_UNINTERRUPTIBLE while holding port->mutex (triggering hung_task_pani=
c
> after 120 seconds).

That is the current behavior. Returning from shutdown allows serial
core to free the TX buffer and removal to release the callback
context. The retry loop prevents those releases, but a permanent
termination failure blocks teardown indefinitely

>
> Would it make sense to satisfy both constraints (no UAF on buffers/callba=
cks,
> and no infinite sleep in close()/suspend()) by quarantining/leaking only =
the
> failed channel's resources instead of looping forever?

Retaining the buffers and channels does not preserve the complete
callback context.

The callbacks carry a uart_8250_port pointer. For DW, the DMA state is
embedded in devm-managed private data, which can be freed after
unbind. The registered 8250 port slot can also be reused. Retaining
the DMA channel does not prevent either operation.

> Specifically:
> 1. Bound the retry loop in serial8250_terminate_dma() (or do not loop on
>    non-transient errors, checking `if (dma->rxchan)` / `if (dma->txchan)`=
).
> 2. If rx_ret or tx_ret is still non-zero, warn once (`dev_err` / `WARN_ON=
_ONCE`)
>    and intentionally quarantine/leak only the failed channel's resources:
>    - If rx_ret !=3D 0, leave dma->rxchan non-NULL, keep dma->shutting_dow=
n =3D true,
>      and skip dma_free_coherent() / dma_release_channel(dma->rxchan).
>    - If tx_ret !=3D 0, leave dma->txchan non-NULL, keep dma->shutting_dow=
n =3D true
>      and state->xmit_blocked =3D true, skip dma_unmap_single() /
>      uart_xmit_unblock() / dma_release_channel(dma->txchan), and in
>      serial_core.c:uart_free_xmit_buf(), skip `kfree(xmit_buf)` if
>      `state->xmit_blocked` is still set.
> 3. For a subsequent port reopen after a quarantined failure:
>    - Remove the redundant `up->dma->shutting_down =3D false;` in
>      serial8250_do_startup() before serial8250_request_dma(up) (which alr=
eady
>      clears shutting_down under port->lock), and have serial8250_request_=
dma()
>      return -EBUSY if `dma->rxchan || dma->txchan` is still non-NULL so
>      reopen falls back cleanly to PIO (`up->dma =3D NULL`).

Clearing up->dma does not stop hardware accesses. After unsuccessful
termination, the channel may still access the UART FIFO, so reopening
with PIO can introduce concurrent FIFO access.

A hardware-specific stop/reset sequence could establish quiescence,
but its implementation and effects on other channels depend on the
controller. If the channel cannot be stopped, quarantine also needs
to preserve callback-context lifetimes and prevent unsafe port reuse.

>    - Guard the DMA completion callbacks (`__dma_tx_complete`, `dma_rx_com=
plete`,
>      `omap_8250_dma_tx_complete`, `__dma_rx_complete`) with `if (!dma || =
...)`
>      so a late callback after `up->dma =3D NULL` is ignored safely.

The current callbacks fetch p->dma before acquiring the port lock.
A callback can therefore retain the old non-NULL pointer across the
assignment of NULL. Checking that cached pointer does not protect
its backing allocation from being freed.

When termination returns an error, dmaengine_terminate_sync() also
returns without calling dmaengine_synchronize(), so callback draining
has not been established.

>
> That way, neither hardware nor a detached callback can ever UAF rx_buf or
> xmit_buf, while close(), system suspend, and subsequent PIO reopen all
> complete cleanly without an unbounded msleep() loop.
>
> Thanks,
> Raul
