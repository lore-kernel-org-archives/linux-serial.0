Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13D351C0D
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036119; cv=pass; b=PIW5MOflmdtM4sGr1mWtKyG6SFJT6sDBGm6TVivLpQxzJHkiXdzPdNtCmYhW/QNJYMn4H75sJYBx1gqb0K15znH76Xhh+jQqGX3GekOFxXy/B62b4/DjUdXp5geaAB3qFUEalYHX0fUnt5eRbNLx7Ech1FiKZ4IkqTRwk7Ku6rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036119; c=relaxed/simple;
	bh=drnC01+K3Ukc+ClakwIfh8RLiDXnAWEMEKnSPoPVMwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoNwG4EgxIHj7k+35P187FWwk8lFvFIBJ4GTH5tyDkXu1tGr4uqmWUu5YrQhiCtPvXNsBtEk95Fglj0ny8SffJLhW1lzq0jI7ekaMVZqvl1hbp1aFEMLuz82bD/vM3dl4mi11THhoYUzvqa0svxKQCTjsy/ThZNF7jKeCG6sM7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6JLd1jQ; arc=pass smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6JLd1jQ"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so152728a12.3
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 23:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036116; cv=none;
        d=google.com; s=arc-20240605;
        b=IUK88Nir/KjLabuMvT4N+N4B4t6oP1nNlU0x/fIXliKAdv/muzg1tgsj8Ez1sqvgm5
         2JLxRd8pAXgXrM0MknWTvLJyKJXTEH1XBd3pFgFUJa7c/3XPZT74cAeXiOnG7RMFQs9g
         NVKUtcC0RxyEh3BLdxXxBHsRqdDqrPvSuZWwL88COYoOAkPJfKhp3/cGKuMpq05oWUYz
         7/qfnQusbamXEPo3knJCrqBppUYWCw+l5n+sWMpzB2zNAVd/1DvvqOK3vcA0QtuTwzQW
         RaZcn3nvBuD4p7uiPKAuLS4EhQziqL597Cf+riqF2usWwL4bFtQMQfwX9lFiQGL2llU7
         TLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KT60xnzbFq0pmsxCe1gkiPRL3QyJUpe0N3MIfnJxoDs=;
        fh=Pc5HvyGvS0TEXymy+LQ9of6iXl8nukvt/W1NI/D/7rw=;
        b=Q5s0Sn9uksrpkQDfC5iEV/CqPI4AWe9Nz5RwSUV9rgpR1xsPlpMY0Kqn76mAvqa3pH
         mHgH2CLsGgAeFLrnjX9bRLFKle/WJfB1sTqwVQXC1Ma+amO9htLMXB+nmeM1DVwKSObv
         nUoyl/xGkn2j6q2lt/LddyEpWf7zpMg35+0qKms77RpwRdEcT/fAY+8W5IaJPj5kGoER
         q8vZbDlQbdPBZKGD/3h0Lw4WjDbXueN50eNr9w+G/iOAoDZeKR2Za7Hh/qbNX0UuGfsf
         2j5FznU6AnLXKxCsSM0/Oqb818C6qQPkqcpbmyP+Jjy+8whPmzF4rT969lrqheu2C7uK
         yNeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780036116; x=1780640916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT60xnzbFq0pmsxCe1gkiPRL3QyJUpe0N3MIfnJxoDs=;
        b=b6JLd1jQyk95gd+ps4d2IBE3ja1o+dwePSYWYQzbTW9x6tUZpByuJHrY8N/7Vl1EzS
         bvVU0EzvVAZX1udbKL6GAXgRTIzOA1FPxBZq3wC3sDnbPC69VE3uhLWPayV6lI+O5gpU
         zNkdl8iyKNh3a5g80cR2/xfnn3oFCGSlzONklGoB4WJIEaCft9Vbm0YUvFd3oAQKWwTe
         OMG3B0cShJ6TD6QSFssh3SlRRmGz2Hb9IDJyE20Gf2BFqvjH/HZ/GZr18bnXblfqC2ct
         vX5y4YHq1wf/jyhpS0x0Twp6LKXAHyK2vdVJFoiBqCr/rNKaiSNodfxcJFGlbsHnEU5M
         eQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036116; x=1780640916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KT60xnzbFq0pmsxCe1gkiPRL3QyJUpe0N3MIfnJxoDs=;
        b=K0qbIMxyLIMN4Gqg2lQ8ikqAy0k+QRr49V7A9nUHpWy0O5TgPtKtRcIxvtUmUyYCm0
         KH/uSpny3XOxs2Kh2V8n5GLoS1UM7pKXSb3dKGNaahsiBIW/drKATS0ynOhH33M8fX3D
         dsqQiIQ5OZmsCoekRSVPkCql351RcvXqRGOqPjPpTWBjfGoWBT+bAjqzq7Zq1IPagXIl
         z+dITHe7Wh6v6y6Uiy6j9O4Tc2htudQv+eKt5gkkSFEHAVS/YnK/hXNwSXrabfU7pdTR
         p6OKNSa1nLs8rpRE1ysUmfOiIGvYNCmXuNsYjcNGCWqeY0ZtXZtmYzYK/v5Fn8H8sIN1
         BRlw==
X-Forwarded-Encrypted: i=1; AFNElJ//GDoozDwMsEWe59UrGTMRIA8AgjXOO8qTuLE9l23elsvscIYbDT8mVvIgOJlBEiQroFMb/rpsxebybqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFj/l0UWIGGIS/SLIfvONUU/2H1CcPh60k/LbeJNZUSPNdHVgY
	7gV6gCmad+H0tw3znY/vGodqSvxUCb9M4/Y0h7iNvLxGUCl30O96P9cbAj1SKbTyulWC0D+b61g
	EHuamy2bIbxSMhki9ylJFhGfUZK+mPxsoVFSZAUWjB3O8jAc=
X-Gm-Gg: Acq92OH9ataF5CmqToUSxSVZqPcoSjFkIZdorDZPic40Cr37jzfE14a8htgyxdO5ufX
	TnTD/AI1GRWL9QT4YDPP+3++T3LRwHduGNKVDs8LTlQCmCAd5lRRlJn/BVKgntSnY1JnS7Vzn+C
	3o6mDcnD1QuU3iyp7pvfvE9WOc1VLS72SkDQaY/RYuslCbmJnKwuk4YhxTGxv6go0tSl9ExFvJ/
	rsWN9lA5zrG+yuSTBqenT12rdW6/tupoI0AEHdw+CevEc0dFBTglR2n0aqSdTOKAt2/6mKKnjkt
	5we8CsZa++ovrRxM
X-Received: by 2002:a05:6402:3204:b0:687:f05d:7cb6 with SMTP id
 4fb4d7f45d1cf-68c0f88abc0mr716538a12.5.1780036115702; Thu, 28 May 2026
 23:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526102924.3174-1-kipreyyy@gmail.com> <2026052743-probation-anything-aa72@gregkh>
In-Reply-To: <2026052743-probation-anything-aa72@gregkh>
From: Zhenghang Xiao <kipreyyy@gmail.com>
Date: Fri, 29 May 2026 14:28:22 +0800
X-Gm-Features: AVHnY4IxXFv4MMPlpbP2djFqD200bcL26MNTXFPXLEd2NRkGN4E0zZF9UOYMQ_E
Message-ID: <CACQTXGDb0vHRxjYTJo8r9Sq_ozu8Z=Y7GR4+F-2HGKGsA17kcw@mail.gmail.com>
Subject: Re: [PATCH tty] tty: n_gsm: fix use-after-free in gsm_queue vs
 gsm_cleanup_mux race
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending this email as plain text, since the previous reply was
rejected by the mailing list for containing an HTML part.
-------------------
Thanks for your reply!

> How to test
I built two identical arm64 kernels (v7.1.0-rc4), differing only by
this patch. Both kernel carry a msleep(20) instrumentation in
gsm_queue() to widen the race window. Then run PoC and the patched
kernel do not report kASAN again.

> What prevents dead from changing
Nothing prevents it and it doesn't need to. tty_ldisc_flush() is the
sync mechanism not dead check.
If gsmld_receive_buf() is already past the check, it's running under
buf->lock. The patch moves tty_ldisc_flush() before DLCI release. And
tty_buffer_flush() acquires the same buf->lock, so it blocks until the
in-flight receive completes. DLCIs are freed only after that.

The dead check handles the other direction, any receive that starts
after the flush sees dead =3D=3D true and returns early. But I'm not sure
if silent drop here is fine or not.

Thanks!
Zhenghang


Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B45=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=89 16:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 26, 2026 at 06:29:24PM +0800, Zhenghang Xiao wrote:
> > gsm_queue() reads gsm->dlci[address] into a local pointer in the
> > flush_to_ldisc workqueue without any lock. Concurrently,
> > gsm_cleanup_mux() (triggered by GSMIOC_SETCONF ioctl) frees DLCIs under
> > gsm->mutex =E2=80=94 which the receive path never holds. The cached poi=
nter in
> > gsm_queue() becomes dangling, and the subsequent dlci->data() call
> > dereferences freed memory.
> >
> > Fix this by:
> > 1. Checking gsm->dead at the start of gsmld_receive_buf() to reject
> >    frame processing after cleanup has begun.
> > 2. Moving tty_ldisc_flush() before the DLCI release loop in
> >    gsm_cleanup_mux(). tty_ldisc_flush() acquires the tty buffer lock
> >    (buf->lock), which serializes against any in-flight flush_to_ldisc
> >    work. After it returns, in-flight receive processing has completed,
> >    and subsequent calls see gsm->dead and return early.
> >
> > Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> > Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> > ---
> >  drivers/tty/n_gsm.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
>
> Cool, how did you test this?
>
>
> >
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index c13e050de83b..8322fffbaeba 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -3156,12 +3156,18 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm=
, bool disc)
> >               gsm_unregister_devices(gsm_tty_driver, gsm->num);
> >               gsm->has_devices =3D false;
> >       }
> > +     /*
> > +      * Flush the ldisc before releasing DLCIs. tty_ldisc_flush() wait=
s
> > +      * for any in-flight flush_to_ldisc work to complete via buf->loc=
k,
> > +      * and the gsm->dead check added to gsmld_receive_buf() rejects a=
ny
> > +      * future receive processing. This ensures gsm_queue() cannot acc=
ess
> > +      * a DLCI being freed.
> > +      */
> > +     tty_ldisc_flush(gsm->tty);
> >       for (i =3D NUM_DLCI - 1; i >=3D 0; i--)
> >               if (gsm->dlci[i])
> >                       gsm_dlci_release(gsm->dlci[i]);
> >       mutex_unlock(&gsm->mutex);
> > -     /* Now wipe the queues */
> > -     tty_ldisc_flush(gsm->tty);
> >
> >       guard(spinlock_irqsave)(&gsm->tx_lock);
> >       list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
> > @@ -3604,6 +3610,9 @@ static void gsmld_receive_buf(struct tty_struct *=
tty, const u8 *cp,
> >       struct gsm_mux *gsm =3D tty->disc_data;
> >       u8 flags =3D TTY_NORMAL;
> >
> > +     if (gsm->dead)
> > +             return;
> > +
>
> What prevents dead from changing right after you test this?
>
> thanks,
>
> greg k-h
