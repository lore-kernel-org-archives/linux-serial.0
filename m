Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792722025;
	b=j2YSDGBcwny5BP6VAOt8gAk8mDG1oeWpGV9z5KyeMRZay/ytM49nh/sLxibh33kN+uet
	 wnjs21hMWWgjm7puEW+xUi5bQt3Tjhni3VkYNw5385x2kl48JBrJhEB50sQdzyq0W3Op/
	 Dw64y3MRw1KDKlt+NYgNgzk2jFG9PTB/lpgmm4Jpvh2EfklA67zhJ5TQCvbpmxxFL28gj
	 WfzGQtzMym53gdfSEkoKSg28IxV8yFvYa6SMZteXdm13qrPLxtAmbLVbG34vCwo9V5zHp
	 kmVf38JEcqyInkkjsq+8rWNRrcdAFCY8kyRTlITeXZqTtrSN7ISTlTahcJoafrGUbpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m31+kFGOIU13FQ2niFCIhiyf7qxQvPAkGY0Wzy9JHCU=;
	b=wOcWzPo3Moy29U+UgKZjn66thK83Xpjjm+9t8xpoHAjpozA3lx/H0UFEMm8w+NG7ekEE
	 4AKD7+RFmnhFf03+X2n/6ri2jgwZSZ1yFr68654b1FSosIg8fcsDjug8VJ/XXOu0VVpFy
	 YpCFWEbEmG0+NnJzwV7LzVwCRGS31Bx45Ir1WmdPvZ4tvG4fLxBkGuI8SjUXbBztvmi7m
	 /cUcOBdGDPlarFi58ARfFDQObb+u/boiFM3fyWuJxgcZ6QyoAzdqvLGxszc2emgzHicUi
	 L6by8Gj2xpUB33aT140gXfmkNxPLd0vB80cJIfotOeWgqWMpbltHR4WKo0Hef3RKveQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=As7nSnfk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A4606A319
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 02:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4A4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=As7nSnfk
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso135531137.3
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 19:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792722024; cv=none;
        d=google.com; s=arc-20260327;
        b=TF8LU5Qx88hvSKDumf95s1qjkLC3OhT2KN/wtcV4Gat9dUh18yAzIIuR0/MZmM8HWQ
         HSutbhQrb/0Bc/cjQs4krHv7HIFs4sCO41vJUNvhx45/2dAGfRK0NwydQO0uM/gyAXmC
         9f4eKsoDWJ7yUyXS100Baj2HHlpx2gxxtr1jwieQHgQjNAH5io8wSxsCCVVWPf/mntJr
         G164HBdnxWfoV8om5ZvOemzuNl3OLOOYMvZga00kz68mH7AdkSPdbNWXcOuu83APi8gI
         L+FBTFar5J6vqWo9z94/kfrKevw1POXlOijpyKMH55d7QPT8kcKNileBcUeAwRXBULoH
         ADUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m31+kFGOIU13FQ2niFCIhiyf7qxQvPAkGY0Wzy9JHCU=;
        fh=ket6W+o/VI8NSuI1/naRZnA4/MhcJz1ItYC+3DJ5AAw=;
        b=etYMIB6xZt1wMxrl2WkSt3EcgFOT7vj2u6QWx1YhBef5YOteWq1DoqFyhjj/vnADD/
         7VH0h2U61gYJoOZyL+eF83UGzEt7VYLDsleFL81v+l17a7RoomMvpL4CgOnmk5K2Zd46
         Ze4i602YPT9pKFBUNB6KatVYwGFXpvHIhtGEJ5qSXNOsPaX2N6CB7ExOLVmWqfApZ4Pf
         nRk6wZSTPm2veHTeg5ZxS3I+4NEuJUr+TOXTjS8bsTi2rLmVAboBgp2iJrIbdq2iUCY9
         VO2F2XGyMtgajs/caNroQSbIK6JnksuGIOE2E9S+WHK4rqcVGbShs9+Ks4t0x0mns6Jn
         LpNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792722024; x=1793326824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m31+kFGOIU13FQ2niFCIhiyf7qxQvPAkGY0Wzy9JHCU=;
        b=As7nSnfkSHggMfctBcifriijdDMf3/xQzJSHc+yzOO1ArUwgMvaAt3eysez4OywqPe
         HHwJ8/wTfajUPSOuuPGVOjNIWlkJu8E3d3L71UOeRCa52KbSVoN6G1iJHxLmReisLbHH
         6e1EibhUL4ksaSEU3lBli08gVK7P4cvn+aT4T1kcXhQWIXc5KbxvD7eGUWIUCrnFUhGs
         SY04Z6Pn2IEhrFslsg6efCDxXuISZDzQ6uB/q7RcguttWSp0uSRIyfeBYyjeJoVhoyRx
         0W0+4ovki8fS2bBVulgIu96yOI1yLYXSO15sgP9JUtHwKfbrGxha9dlbmxaEkW891S+F
         xG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792722024; x=1793326824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m31+kFGOIU13FQ2niFCIhiyf7qxQvPAkGY0Wzy9JHCU=;
        b=Mr0kaQ39tYZHWDpY8Pi/5rV8/EVZnH5VLO87WNm8QqgF7sJk3lCQ+RECiYTo9sC5KE
         reaHZZ7bK/koQ5oSbdwOiKN+/InjSzBcVc5GzRg1efKcicWH2QlUTIwiVAAzMHcLsyEJ
         7IRbbeQrBnoOcXxapN6vMV+eBCDvFeFkfCFk4cbdwqRO909NVCpVCEz8Gs1Dqy4UfEov
         agRvpKakJvkfdbDzmqE2wNZ+OQWCJSihM5zOfRmd1fOkVlY7FUppSJkeSqyGYfSJZ8pt
         2+70HxLPXxdmBHSak9mBm7LXJFA9K/yePFwHGJBtbsRwcpK76Tuxse4s3HmJClUb5Jxj
         LQOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/+pdPP1fLrg/68SG1fuRBz0AalaWf1nvr5ZY+j/UDRx8GWLYhOgdCVyuvklIMPs5g/G8It0W48AQUnV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJDAleL78xVsXHc4u9DqaVK3Lsg1Oj3PRb4fRi+NdzyUMfKqm+
	omeUXgLSVB87HH18Red46UmCJ6w3koR/9nBJKuHOZ7gdg+CeorsGnbapWk+iAwOtc12c+L94djm
	zpq3pFpG1WrRnYpV7SUQ5t9fS0oLm2z0=
X-Gm-Gg: AYBFou1QbDgCfuUJ/ylUf/sTYvROvk6J/WHzAzq27/PAemC9jxhHrkhEnw8mW7FBsbC
	JLgN4P5R217c0avwLxbVN1OkLs2bU3hD3X+FYFvhgXSxJ7BWVW//63dSKNs5d99d02fBIEvjx0K
	YFpVamWu4gZn/zLd/VawUW2TB1DKP5xBy2zvTRvxZ6h1SW1tQ6iD4NZQ8eDqMM6iOXSxeAgsNbZ
	zH0ObBgy9OHwcsWJvLqc7tEuyUBe4k0A4wSXDLpyCsb7Kcu5vS9y3Ywm2wMNcIMATm0gPiauO50
	MmMH/qib0lmMYGhbaymsPdDEl9ivIBgVNLgNZx0X8uzj8uR/0B8u+/7ooN4hn+By+aQMk4QK4n+
	lF535ehgOUoySJ4WbcrSnyjzCFp9hVpTtSUoGbEBeIIgH7TUK/HD9nGr1odARZ977GUibqX/dE0
	8NbBo4ila04xfCsqXW/LH4vtfY1OYjdgT64/wQPLoXXuJ714NysPgpe84vKYDV+ey+MaWJlOM5m
	UOEnDkUTvP7X5FeykwXdJQFpIpnTA==
X-Received: by 2002:a67:e704:0:b0:7b1:6028:5475 with SMTP id
 ada2fe7eead31-7ccc325fc45mr450317137.12.1792722024045; Thu, 22 Oct 2026
 19:20:24 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
 <20261021-submit-serial-8250-dma-cancel-v1-v1-1-efe2b89f2303@gmail.com> <atoW90cG8hz-h9tc@ashevche-desk.local>
In-Reply-To: <atoW90cG8hz-h9tc@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 20:20:13 -0600
X-Gm-Features: AclHuK89aWM8taPGRZeoSyiqd2k01IuhObkpr-YSGe7k_7rKgUFx5DXk8auc5y4
Message-ID: <CADvTj4py34R+Ohin7XOh3a1az9_8SbZoZLryeMK7iUCXNumJxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: 8250: drain canceled TX DMA before reusing
 its buffer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:00=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 21, 2026 at 04:37:43PM -0600, James Hilliard wrote:
> > uart_flush_buffer() resets the transmit kfifo before calling the driver=
's
> > flush callback. serial8250_tx_dma_flush() terminates DMA asynchronously=
 and
> > clears tx_running, allowing a new write to replace tx_size before the o=
ld
> > completion callback has finished. That callback can then consume bytes
> > from the new transmission. The serial core can also overwrite the old
> > DMA source as soon as it reuses the reset kfifo.
> >
> > Give DMA a private transmit buffer, keeping the kfifo offsets used by
> > FIFO-window providers. Copy only the queued ranges before handing the
> > buffer to the device. Flushing the kfifo can then no longer change an
> > in-flight transfer's source.
> >
> > Keep tx_running set while a worker synchronizes a successfully terminat=
ed
> > channel. Suppress callbacks and new submissions during that interval.
> > The DesignWare idle helpers must not pause or resume a retiring channel=
.
> > Once synchronization finishes, process the zero-length completion under
> > the port lock and start any data queued after the flush. Reuse the norm=
al
> > completion processing for OMAP too, including its delayed register
> > restore and runtime-PM handling. Drain the worker before releasing DMA
> > resources on shutdown.
> >
> > Calculate the queued length before calling the platform preparation hoo=
k,
> > so it sees the length of the transfer being prepared rather than the
> > previous transfer's length.
> >
> > If termination fails, leave the buffer owned by the transfer and let it=
s
> > normal completion release it. Do not submit another transfer before tha=
t
> > completion. A DMA completion still does not mean that the UART transmit=
ter
> > is empty; the existing line-status checks remain in place.
> >
> > The race was found by inspecting cancellation and restart while prepari=
ng
> > H616 UART DMA support.
>
> ...
>
> > +static void __dma_tx_complete(void *param)
> > +{
> > +     struct uart_8250_port *p =3D param;
> > +     struct uart_8250_dma *dma =3D p->dma;
> > +
> > +     guard(uart_port_lock_irqsave)(&p->port);
>
> Add a blank line after guard()() everywhere, otherwise it's harder to see=
 it
> in the code.
>
> > +     if (!dma->shutting_down && !dma->tx_terminating)
> > +             serial8250_tx_dma_complete(p);
> >  }
>
> ...
>
> > +static void serial8250_tx_dma_flush_work(struct work_struct *work)
> > +{
> > +     struct uart_8250_dma *dma =3D container_of(work, struct uart_8250=
_dma,
> > +                                            tx_flush_work);
>
> Make it a single line.
>
> > +     struct uart_8250_port *p =3D dma->port;
> > +
> > +     /* Neither the channel nor its buffer may be reused before this r=
eturns. */
> > +     dmaengine_synchronize(dma->txchan);
> > +
> > +     guard(uart_port_lock_irqsave)(&p->port);
> > +     dma->tx_terminating =3D false;
> > +     if (!dma->shutting_down)
> > +             dma->tx_complete(p);
> > +}
> > +
> > +void serial8250_tx_dma_prepare_buffer(struct uart_8250_port *p,
> > +                                 struct scatterlist *sgl, unsigned int=
 nents)
> > +{
> > +     struct uart_8250_dma *dma =3D p->dma;
> > +     struct scatterlist *sg;
> > +     unsigned int i;
> > +
> > +     /* Preserve ring offsets for DMA engines which implement a FIFO w=
indow. */
> > +     for_each_sg(sgl, sg, nents, i) {
> > +             size_t offset =3D sg_dma_address(sg) - dma->tx_addr;
> > +
> > +             memcpy(dma->tx_buf + offset,
> > +                    p->port.state->port.xmit_buf + offset, sg_dma_len(=
sg));
> > +     }
> > +     dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan),=
 dma->tx_addr,
> > +                                UART_XMIT_SIZE, DMA_TO_DEVICE);
> > +}
>
> This is a bounce buffer, why do we need it? Shouldn't this be rather the
> respective DMAengine issue on how to treat the pieces?

The problem is ownership of the serial core's transmit storage across
flush. uart_flush_buffer() resets the FIFO before calling the driver,
and writers can reuse that storage after the callback returns.

dmaengine_terminate_async() does not guarantee that the transfer or its
completion callback has finished when it returns. The driver's flush
callback holds the port spinlock, so it cannot wait there using
dmaengine_synchronize(). This lifetime gap therefore exists even with
a provider implementing the DMAengine contract correctly.

The bounce buffer in v1 protected the transfer's source from those new
writes, but it added an allocation and copying to normal transmission.

> ...
>
> Overall I have a feeling that we turned somewhere in a wrong direction.
> This all activity on 8250 DMA support looks like over engineered approach=
.
>
> Perhaps we need to reconsider the whole picture?

I've reworked TX in v2[0] around a serial-core storage reservation instead.
The logical FIFO is still flushed immediately, but the driver can reserve
its storage until DMA and the old callbacks have retired. During that
interval write_room() reports zero, and write()/put_char() accept no data.

Normal transmission continues to DMA directly from the FIFO. A worker
performs synchronization outside the port lock, returns the mapping to
CPU ownership and releases the reservation. This removes the private TX
buffer and copying while retaining the required lifetime protection.

[0] https://lore.kernel.org/r/20261022-submit-serial-8250-dma-cancel-v1-v2-=
0-088ea51e3891@gmail.com/

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
