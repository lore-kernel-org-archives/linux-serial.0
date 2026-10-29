Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261666;
	b=y7Zp4GwY60YBx1Uexr5BPzowWCdMC7XjpzOMnmjNxOJxS3S63qthJf0P+aL4GTyXMOKc
	 uW516ImmwLWulNidOrb5lMqD6lEfm21KX2AlAhTpHjhmQ/hR6D+rr1/ALlpBMc1vyAhna
	 e3DIDhqSFxfQIkO6uOsU0XyvCh0itmOH7bkzSESuJm4tHFanIhHkXA8PLDeyeaPjYvviQ
	 Wf2OcY545qrXXHXYDVNVvEVfahHcF+4KMvIXbxTqn/wQWgsiYwUO93l6kD2yIkxqPzhWT
	 WppK53g9u0bI+wls8ssEtlA6+JCcRRN/qtIOH5lLwN1rlBSOL6YmWdAKqonzi4x7iuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
	b=AY4yeu8Cju1ZdOWTxCNXNjkZhkmwCqLGJfLlXlMSqG8eRlHU7zvlGb7E+Z9gqOi4Y4o4
	 i2j1qiS3CgKANqJKKMnOC5p4G1vd3HJoLk0HwgxdPMaQyGKAKfC4a//Kpu2qPFUkl9rmx
	 6i0KqBWf0Wu24iJUdNlb884iOkj4hF0jlaQ7sLEj+XhSYuYyFoOFw5wRUs5HM0h5OOKEQ
	 riXqIezNFGzOtKiDmiC4sKlIDvC0lIg0CF3cvc/fmOr1lU5nRLoq4atUXiuGuxTD5pMwA
	 erK3TE5vYrvt65p1pl26Wv1NTXH6pKwjN9Hg67t9bJhpyP7dWutuF0qyBjH9+TEmUCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ND8m6DLV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B8606A322
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 08:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3B8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ND8m6DLV
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso543281241.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 01:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793261663; cv=none;
        d=google.com; s=arc-20260327;
        b=rsI2oQMdas4xunuQOX64O+Emba39JEzRako2lDlr9XH2ax7hK/MWfEkwiEGOkCyQp4
         m3aMKWyJn4EAL0pnKwnjofSBd2jNiYprsqXIUgQeyQ0T0uSDK/S6P/kPt7thxHOz7nne
         Ibh3bCR/STOUUuvLbH5XLisC49wKqc6qkaNYGvI1e/OgHbeox+pYl6jGkUamTGGI2R27
         sbzqW053b4MMwpEO57UqcQQFk6spkbLURBuf4uJAg2U2fHX1ODnku0VsaPc5EnS/meTJ
         MPE6T5tVYJckT+j3WNFetdjZrQN5DA52n+605GyJ9RjteLhEiOCjBCblgah+aSmluL6A
         CyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
        fh=J9l7pOSkjaCMgQf5DIT6OOxl17V2W2c8ecfRPMS/jzA=;
        b=lUQuXL+RcN0UWiOisz4cYTQKtx0/+wQhbYVUsfQQRp9yLFM4R+rMn4SpuxEWQtoIum
         KZ0HvFBi9+Q13iVJIHfgwLfzKWvNYCT4CWthsy4QDZPC7hrCwYZZpbyP9f4ZO2AlkEu7
         iJ97ESosxivGfhkkvMxtGiRJseCh70fC8KXo1rW0/qHGFZg3kc3udzaVDsZeGzwOKPSg
         b+Dwme20MnjCciLB2EG0cRkrz7dnCpX5nfbN2IhYZd6bo/mX2jznabeT+oWAl96ajgN/
         6DwQ9EQrxeqXgmbKkdIR1rLFkSW14y+X9NWAt320wZe0IBqET2qVfaAgQCRiASyNgeQQ
         9FOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793261663; x=1793866463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
        b=ND8m6DLV16WWuekpMoLR812L+eu31U1myLQ6nrOupj4bwLsMer37A88fkbPpuJivo2
         buLxk6PuSeWeI1XYI1H7eSTkuK//cqvN0F6ZkxSI2dnCWqoppwqAirEGfsIGKKNViLo+
         uyNcWafSBTD5b14OUsWIYt5XgxXgsq93hP0y0YierUXE9TJffVG5/4LGs1o2fhfMMXVA
         Qp6kNiuis0kMZgX7AcDTRYwshNn52APSHWdgdBVKTksd+BgpJma+BhttiIVLmku2txIe
         r2rxdUITukKnUY4NiNQS9IBIea0nsfUEB2hYwoJWN+DMXCEP56QQkfb3zB8u5jM6qJ8/
         zA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261663; x=1793866463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
        b=iRT8LoVO58hOREg2SNOIEE4WoqardDgTf01Dno2q+wl5nBzY0YxY7262mTyoPW5bde
         7SvQitl6Yddiiw0bstCn6qGFe9+2o3AZwLQQziqALsW6t30Ge8hM/zssRSF624KFqsRY
         9QX7EvcckCCSN19ZB0RGS8ZFeascbzmTHpjfWGQomXGJMn62BhT7hLGnYAnGd0F+ozct
         dWaJeh3iUTXiyvBeNdaVShBYBTvAom4n+cgxzaaNt8ef2vlFaeMUVJl2crfxDJZg/E6E
         mPP75Yz7RqcXsmYGPniwDfpKp473AH2l67yDW93rJUk4yJo2k6bUEcIRWAcU7DbZqo6e
         psTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZvjBafgAna1dvJI82AdoJgEWuTFzLBhgA5Jne5G21EB11WgZ07qCOetC5h0G/VBNjG6Zu3Ynfqjs5JVg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1omQNzV6yyk/DWFIeEvo3dji5bx3/IOOzjvk2V6Co42tSRjeU
	7mPvF7RTIiCAMthWPsba9AnAtWBGS3CFrjywbbww8e3k+/kCmUx/bFRmCuWIvvNbDTqpcz/+VFu
	as1zKb31QBgGGp5f1ZWRilVXjUETWzaU=
X-Gm-Gg: AYBFou0+37ctfZWFa+ypXdB+41WwJCpSXaJgc5RNxcEAqnhXvYBsENVhOdd2E5nbrBY
	WxMaRY5iBocySv10D27kbXKlCCWzG3WL/upL8feD9LYDCmZ+nM91R2o05vT8G2orBmAvBz8V7Sx
	SIYXkULTH4XkBqWscPOPevPSXtUbPtYsKtkatJi41FWAiP2X1T8LvF+ukMrIqHOclND4kTq9MPU
	XtDaPR+E5RDVilQdnw3zyGr+6YqplDRscoUVTvLAb24jF4AZXoilbyajGWNK3IDAy8DnXbYHNIL
	4d0DWM1Y6PDYveOTTc7gED8MXeZKg6fgk+tpv/73TnKTEe9eHfGRNkLi/v7nwWQvv47YJP8YtbP
	/jBLPkPsWDoeGs7UhyFe1VCRDXSEPbq/cs8OKwsncQv3pnxf1lFYpEvOHY75dFfAiavj5oxUtsp
	yttcad2RTD1+R8x8Hb9HFQq4uaAQrgBRPUYAa8pZVSnyWYZ1/VQ/CjeR+150WhFcDK8ACgb+hVs
	I8PPzHzcSjYcL0LWAlKmzPt8ekqTg==
X-Received: by 2002:a05:6102:424c:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7d03a5708f1mr2019992137.15.1793261663187; Thu, 29 Oct 2026
 01:14:23 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com> <20261028204847.3471382-2-rrangel@chromium.org>
In-Reply-To: <20261028204847.3471382-2-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 02:14:10 -0600
X-Gm-Features: AclHuK92fmKJThZ29uPEx3r2hwaWsXISrLYNiraGYBJq2R2TpOOpVIz5KsrBhR8
Message-ID: <CADvTj4pEo3uj2bLbP6RwD=P+hW2omQ9x_sn_ag_FHzxUknX-nQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] serial: 8250: drain canceled TX DMA before reusing
 its buffer
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
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:48=E2=80=AFPM Raul E Rangel <rrangel@chromium.org=
> wrote:
>
> Hi James,
>
> > @@ -37,26 +40,35 @@ static void __dma_tx_complete(void *param)
> >       struct uart_8250_port *p =3D param;
> >       struct uart_8250_dma *dma =3D p->dma;
> >
> >       guard(uart_port_lock_irqsave)(&p->port);
> >
> > -     if (dma->shutting_down)
> > +     if (serial8250_tx_dma_blocked(dma))
> >               return;
> > -
> > -     if (!dma->tx_running)
> > -             return;
> > -
> >       serial8250_tx_dma_complete(p);
> >  }
>
> Removing `if (!dma->tx_running) return;` and relying solely on
> dmaengine_synchronize(dma->txchan) to drain completion callbacks breaks o=
n
> DMAengine drivers used with 8250 UARTs that do not implement
> .device_synchronize (where dmaengine_synchronize() is a no-op), including=
:
> - drivers/dma/sun6i-dma.c (Allwinner H616, cited in the commit message)
> - drivers/dma/dw/core.c (dw_dmac)
> - drivers/dma/pl330.c
> - drivers/dma/mediatek/mtk-uart-apdma.c

The provider-side fixes are posted separately for DesignWare [0],
sun6i [1] and MediaTek [2]. The v8 consumer changes require those
callback-drain guarantees on the affected controllers; they cannot
compensate for a missing provider synchronization implementation.

>
> On those controllers, if Transfer #1's completion tasklet (vchan_complete=
,
> dw_dma_tasklet, or pl330_tasklet) has already dequeued the completed desc=
riptor
> on another CPU, dropped the channel lock, and is waiting on port->lock at=
 the
> start of __dma_tx_complete() when uart_flush_buffer() ->
> serial8250_tx_dma_flush() runs:
> 1. serial8250_tx_dma_flush_work() calls dmaengine_synchronize() (which re=
turns
>    immediately because .device_synchronize is NULL), acquires port->lock,
>    clears dma->tx_terminating =3D false, and calls serial8250_tx_dma_comp=
lete(p)
>    -> uart_xmit_unblock(&p->port).
> 2. If no new transfer has started yet (dma->tx_running =3D=3D 0), Transfe=
r #1's
>    in-flight callback acquires port->lock, sees !serial8250_tx_dma_blocke=
d(dma),
>    and runs serial8250_tx_dma_complete(p) a second time even though
>    dma->tx_running is 0.
> 3. If a writer has already started Transfer #2 (dma->tx_running =3D=3D 1,
>    dma->tx_flushed =3D=3D false), Transfer #1's stale callback runs
>    serial8250_tx_dma_complete(p) while Transfer #2 is still active in har=
dware,
>    syncing tx_addr for CPU, advancing xmit_fifo by Transfer #2's tx_size,=
 and
>    submitting Transfer #3 concurrently with Transfer #2.
>
> In addition to implementing .device_synchronize in the affected DMAengine
> drivers, __dma_tx_complete() (and omap_8250_dma_tx_complete() for symmetr=
y)
> should keep `if (!dma->tx_running) return;` and check
> `dmaengine_tx_status(dma->txchan, dma->tx_cookie, NULL) =3D=3D DMA_COMPLE=
TE`
> (matching dma_rx_complete()).

I have not added this check. It could reject some stale callbacks, but
dma->tx_cookie may already identify a replacement transfer, rather
than the transfer whose callback is executing. It therefore cannot
replace draining old callbacks before releasing or reusing storage.

There is also a complication with the existing classic DW provider:
its status path can scan descriptors and invoke completion callbacks.
Calling it from the callback with the UART port lock held therefore
risks re-entry. The DW series [0] removes that behavior, but callback
draining is still required independently of a status check.

The intended guarantee is that termination and callback draining
finish before a replacement transfer can reuse the canceled
transfer's storage.

[0] https://lore.kernel.org/r/20261023-submit-dw-dma-synchronize-v1-v3-0-c6=
2bf048f5ce@gmail.com/
[1] https://lore.kernel.org/r/20261023-submit-sun6i-dma-lifetime-next-v1-v3=
-8-ef1acb0be768@gmail.com/
[2] https://lore.kernel.org/r/20261027-submit-mtk-uart-dma-synchronize-v1-v=
3-0-aad7a6b3c62e@gmail.com/

> We modeled the v7 TX and RX DMA cancellation state machines in TLA+ to ve=
rify
> both the counterexample traces above and the fix:
> https://github.com/ismell/linux-8250-dma-tla

I extended this a bit as well:
https://github.com/ismell/linux-8250-dma-tla/pull/1

One issue in general I'm frequently running into is that there's such a
large amount of correctness issues with this driver that it's tricky to fin=
d
good boundaries to split fixes up into.

>
> Thanks,
> Raul
