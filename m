Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164F3DDDC0
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881100; cv=pass; b=N/32QGToMRPU88ZezL20T0sbjZLuJ30xCaAt3xz1lpgADkjn0FTLyrI76k+T2e2aWYxREj09Si9P824+BbtDnaXetrYf/VtzKUFmks2nuEYA3a/KgSzcFjp2KDMOtvFcwlk+qL40n3AeNl0CIFyYiWzdlzram5/ll3TbIWci5lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881100; c=relaxed/simple;
	bh=ZBhMOmtdPtm2ewznb0I6h4e/lc4ZNSuv3xrzaOINis4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnAQgAHu+VPqlZ6v74nyQ0kvcjXU0iIIY9Rr6HLvSCKF1TqgVTD52dDGG6d1EhDuxPVgLPFVyEgr7bovf+EPZD9fcQy8uRzDP+1Pgi1lQUCD7I31KwBS4Gvd62+i+hlSqlEqzMNd/wjy5UPIYSE5M5czgf6grMDBAwBG4MhGUFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XehcVlCD; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XehcVlCD"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so4733630a12.0
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 11:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790881097; cv=none;
        d=google.com; s=arc-20260327;
        b=KWvWmzo4Vfqa0UarCkO0pzPSFqGM3uLTf/T0PlyCsOcx7tr0ipsI6eGaPWzxMvp9C5
         jLXpGryITqkbEKzGV1/nz0kPNQ4C+SdJKC3LJrJkkWrDQnzQoTbbXjj3Fb7ttISUpVYN
         ZkBIm0AbpojmacMYdESs+ol5nAKSWEx0OzAfWGJqIh9sD1qxh8YHM8ioP3GpYvFdTh1o
         Vg1KqmKctPcIpU36TbalCYh9rkibQ3DXyqmGYT7qDRK2cjIuzVVmz5GXCLOLRDORzchF
         4qfrCYd5A30qk52FBcjdNSfqyMUK9TAl0v1+wTNgKoPkxniS4CiqrDHG7B4ZKhok8WGI
         cZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gdBCcya7Jd9eS7uFOMyWkhA5NDxvi9ClIG0tBCXyRE=;
        fh=yBXTMFpvpq/6iufX8D9yKl+GmlU/n1SsxkVONCqx1ds=;
        b=nqKZJGYU59SFMsE2LPYpyA+cY1zyHLHUL8l9QbzjkIWQbYGLuKt18Ng5mZb+RqZ4qw
         En0aQcgf1W7hpeQ9iLvPB8ljUXeeNgRp/iUOQ61b9xxrpYqxB205ybtiKAN0jVjnvVUg
         OYGbaESTsvUzxbdaYBEGrWZVxziJRVoJ1BjrcIvI5+cvfAktaUE44txpS3OErhlmBYUp
         hQdggqV2XwbXOkx2wFn/b/U6tFb8iqcCKXAGDemYpkzcmVzUw1gEFn7MiEyVNsYPzzSO
         MLUzUh3Oqf73OyWLKhDzMxD5mmii3DOx+0vguKVPFISRQaUdJ2hfGQTp8o0Yem0UHmME
         Ehsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790881097; x=1791485897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gdBCcya7Jd9eS7uFOMyWkhA5NDxvi9ClIG0tBCXyRE=;
        b=XehcVlCDrWzmlinD4tVaUcORuE1PKauvKECaWQ1Xtr2Fo/3ypZ/ajABHfjEmKrndhO
         1JpWtIscNLvjAeASkCgzUQIjpnrS0IJw8YOZHn55qXxae3qI1MQQCJ6Pg4yQKDJl88+i
         m5PRW2L7Cfef3z3QWSqqL9xDFZLCKcyoZs+ZvQWAaROSNgT7j+CFthyMttlT0pYdlmVU
         ApUQaX2gJwoCsC1iqf5rCAUJ7A0V3ysbc79HqdEe0oStr08zWcbTxmLAoTajnRvbdx+U
         hNhrkGZ25XPs5cdTxRmW2RQ1H8cBbjsgpSmzxTc8qZGmJrrb0Rzx43O0EajuBYlvam8b
         MwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790881097; x=1791485897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gdBCcya7Jd9eS7uFOMyWkhA5NDxvi9ClIG0tBCXyRE=;
        b=QSDEiyABQC3P9AtvrsnBIaauvf3vb8lroJfALuY4yg8h3nULap6UEI9mAo2AY+Fe64
         1HHldiudoFX8bedkN0ApTYbP9/JIKR/yRr5iKVKLyzWYWFw2DzHCE776BGoBVKdJdBjR
         5uyE6cqDekZxOn6PuDCyfDPE+Ue/vy/dr5lTyS0WTAYvEIXVxP5gum2PLl8qWxOUoV2F
         Jw2G9FGIXBQdDsFdwM3xftzEAUE9B8j0h+rRN11nDHShrP6aM4+h7pnFA5R0Tlu4kIHv
         +/nh78W8/rVzEmnYc0i0JqpqjqYVBe7QZfOMCvMvn12sJLpz/79hwOn3p+N13QQt16Ju
         +dZA==
X-Gm-Message-State: AFq9FYLN4jl86GXy/I5HzK1vV7ZBcoZZCtBodz0VJodo11jH2pzaXAYs
	EPrsmTvahimSdcYv0CQhLV+/Lr6p2ImQw0zv1+p3SVmJ4GGgMKFkIVHcsVj/DBhpEs2tOwJ5b6d
	rtsR9cscQOyL++GuJHSZsRrIFGBacY+U=
X-Gm-Gg: AYBFou10uvFs7I7fVcDYoZe8tsHEUwHER012QM1ZorqYO5GJMQOeDcrvQLkDCsok5sx
	utJMWpkMOlI1d1Sr0jAKIqhIaXKmAwCrVN4yolh3U8LB+6vieA1a3LiH+t+jNmuGy7bZtRSKCsY
	lhOxsBXVN/lUjRY//ELUWtsk81C6SPj9jrZg+P5giMFiGADcgH7HKjTsjoSXjmaNbkU0OLCcfDB
	kgqxmrcTkBzjdUV4n84YBgOmAVKtJwEpknggunFsZnbKChwEsF6vJzzX1EjoWxWl1geYy8/cxy3
	S9Zsgy2i96LLXP3kx8xsZc3NSCswGjNAajMDxsjV+8ldQaJTu1MNsCO+/LIFdQtwG/YOag7Zaut
	RfAZWJAX2BS2H64wrV7S/rmM8yZofHj1bujXcNNFjgxxvuUIe2m9nQhHvJdvUpPhxjWCinM8L+k
	FkcyKpDAXLL6aYUKNfMjnc+pYbz8Gd2+vyM6xzzl1r7rpdJV4A9iYEDlrJUjLRmrkZTw==
X-Received: by 2002:a05:6402:320a:b0:6a9:ae86:bb1b with SMTP id
 4fb4d7f45d1cf-6af9e03ded3mr104018a12.5.1790881097207; Thu, 01 Oct 2026
 11:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925183050.56839-1-rosenp@gmail.com> <2026100129-unrest-cleaver-6528@gregkh>
In-Reply-To: <2026100129-unrest-cleaver-6528@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 1 Oct 2026 11:58:05 -0700
X-Gm-Features: AclHuK96Et8-MkZL9LMhD_ijnC8Z5TWGJ6g5yJxUOPLdgKxS1Jb9-JO48yVLGLI
Message-ID: <CAKxU2N8Z-CSxki5mWQvJCEiQDmy00WLJqPEMgujOA0LQzbHHjw@mail.gmail.com>
Subject: Re: [PATCH] serial: arc_uart: Use platform IRQ helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:42=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 25, 2026 at 11:30:50AM -0700, Rosen Penev wrote:
> > Avoid calling irq_dispose_mapping() by letting the platform_device
> > machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> > and other errors. Handle as early as possible to avoid doing unnecessar=
y
> > work.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/tty/serial/arc_uart.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uar=
t.c
> > index 3988e5958896..b46b057a181b 100644
> > --- a/drivers/tty/serial/arc_uart.c
> > +++ b/drivers/tty/serial/arc_uart.c
> > @@ -30,7 +30,6 @@
> >  #include <linux/tty_flip.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/io.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/of_address.h>
> >
> >  /*************************************
> > @@ -571,12 +570,17 @@ static int arc_serial_probe(struct platform_devic=
e *pdev)
> >       struct arc_uart_port *uart;
> >       struct uart_port *port;
> >       int dev_id;
> > +     int irq;
> >       u32 val;
> >
> >       /* no device tree device */
> >       if (!np)
> >               return -ENODEV;
> >
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> >       dev_id =3D of_alias_get_id(np, "serial");
> >       if (dev_id < 0)
> >               dev_id =3D 0;
> > @@ -607,7 +611,7 @@ static int arc_serial_probe(struct platform_device =
*pdev)
> >               return PTR_ERR(port->membase);
> >       }
> >
> > -     port->irq =3D irq_of_parse_and_map(np, 0);
> > +     port->irq =3D irq;
> >
> >       port->dev =3D &pdev->dev;
> >       port->iotype =3D UPIO_MEM;
> > --
> > 2.55.0
> >
> >
>
> You forgot an Assisted-by: tag here :(
No LLM used here.
