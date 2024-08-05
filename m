Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CD4CDE0
	for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872781; cv=none; b=bYI+sQpy06dhiS/P/xmTZIvBZ91fX0GHqh2zscAxpUYWqysUqZc+EX4oE8MohflxZsSQs57uVe1nyPmUgnrMaBwT4CbarNC/ZKVKciDpZaUCJKfeRe0G1bpon6BC6wvHBA8zANddR/taioriDkwSoYSSBKguJ/TRSqa0yVuk6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872781; c=relaxed/simple;
	bh=5wjHU1wKHRRchFX2cqWEk5v6q0TdpGyDqI3gFeTqBiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkBs0N56iCptQ4IxOOc3GMq2bucB7XOTqeG8B32fAMeyNQz6eFVOvMUxxn66vrQjb+lOPKTPLpfPFbo7ySgMvg+hEatuuJAuJh4vTJrVMwqO8uPDCvNQSAv3N0tucwXcYAd06rpznZZEeqsc8sypA2+9AgRSUBZmRifV2qjJmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UOxsqe3c; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOxsqe3c"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db23a60850so5925044b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722872779; x=1723477579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqOaptwxc12t3A/k1QIs7JMco9pX/hGJo5YaprxUknE=;
        b=UOxsqe3cbqludNtOBbYkk/wjzak5Sst16gQvEGUWEK3sclUoWL+DeodBNdSEBlouZK
         J1uEhdL01XbyWqbCSsZkMy850FTnvcS1oTC7rSFOML/hdXmFl2kkDxgZ1tZFaCMmWe7D
         RATHh4qapcb4ZPs9bJD9ZKCNAj0a7vS8oHCWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872779; x=1723477579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqOaptwxc12t3A/k1QIs7JMco9pX/hGJo5YaprxUknE=;
        b=UJ2Sfo2FMeouN+rbuAjddB1jVtZyJTYTvYmnMETMyC+c04QlqIvByxkISQTLmq/wZD
         4q/AIRnGsNA7hrPdb72vUl8II4iAz4fYldUXu+QsqoirtRWR2uZnvywGqrVsFjWRG2rl
         cQacfvWDrnlZYYtBQ818TOLA2X1FwjHiZh1EbedWhBU3jB8dW/zN/i3Bbm5s0SsetShZ
         G8wQXfMGeJ4D9aR3/7GpGmT1OFIlgyvfVwm+xsTiyrUNAG852S5P382+jAsiKpD/SNsp
         pZaHmwuYtFajzlvaoQdoJwMO79ZAl7qzGdROerKOANlH4p2MKnhfr9B7EVr6O6ESrdyg
         AEaw==
X-Forwarded-Encrypted: i=1; AJvYcCWGNbStwkz11TlT/GOvwkraQN6Rh1vZFnSjE12cB3raPxGs+bL4VVZBlpt97QNBeWhIPBw5h3Af/5N+Ci4HITEbH1f3Jw4+tTorCLjT
X-Gm-Message-State: AOJu0YyEI8fDVLSF0rKYznQHj/fN7cZa7BNgYyTG2Ormk+DlK6kPaqnG
	yeD+AMjng+ov04DIj7vTkWdZBZUqX+OOGnNQo5UTJ5MkNXmG587NDKSyJGsCvbi/dTfjSWZpV8A
	=
X-Google-Smtp-Source: AGHT+IGaIPqVTpcOKOdiA4ORMOtQM3zdea67qjp11+XWWqwiLTqGlNGWzp+iylQCP/gZA/O6pCK11A==
X-Received: by 2002:a05:6808:3094:b0:3d9:360a:3a08 with SMTP id 5614622812f47-3db55835400mr17464088b6e.34.1722872778777;
        Mon, 05 Aug 2024 08:46:18 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6e98f5sm30519161cf.49.2024.08.05.08.46.17
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:46:18 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4518d9fa2f4so849161cf.0
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 08:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHsYFjUoAnaKU2wXrJn0ZLqtJlRndSGe4CbG3ryO0u8pdItwm6sjV+v0VXn/2NDjF1xp13iY65Rop7ITx+RH7NDXQa2Y1Opgxhm/y1
X-Received: by 2002:a05:622a:282:b0:447:e542:93a7 with SMTP id
 d75a77b69052e-4519ad00ecbmr5909431cf.12.1722872777503; Mon, 05 Aug 2024
 08:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
 <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
In-Reply-To: <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:46:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Message-ID: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 7:28=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 5 Aug 2024, Jiri Slaby (SUSE) wrote:
>
> > Coverity reports (as CID 1536978) that uart_poll_init() passes
> > uninitialized pm_state to uart_change_pm(). It is in case the first 'if=
'
> > takes the true branch (does "goto out;").
> >
> > Fix this and simplify the function by simple guard(mutex). The code
> > needs no labels after this at all. And it is pretty clear that the code
> > has not fiddled with pm_state at that point.
> >
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> > Cc: stable@vger.kernel.org
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/serial_core.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 3afe77f05abf..d63e9b636e02 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2690,14 +2690,13 @@ static int uart_poll_init(struct tty_driver *dr=
iver, int line, char *options)
> >       int ret =3D 0;
> >
> >       tport =3D &state->port;
> > -     mutex_lock(&tport->mutex);
> > +
> > +     guard(mutex)(&tport->mutex);
> >
> >       port =3D uart_port_check(state);
> >       if (!port || port->type =3D=3D PORT_UNKNOWN ||
> > -         !(port->ops->poll_get_char && port->ops->poll_put_char)) {
> > -             ret =3D -1;
> > -             goto out;
> > -     }
> > +         !(port->ops->poll_get_char && port->ops->poll_put_char))
> > +             return -1;
> >
> >       pm_state =3D state->pm_state;
> >       uart_change_pm(state, UART_PM_STATE_ON);
> > @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *dr=
iver, int line, char *options)
> >               ret =3D uart_set_options(port, NULL, baud, parity, bits, =
flow);
> >               console_list_unlock();
> >       }
> > -out:
> > +
> >       if (ret)
> >               uart_change_pm(state, pm_state);
> > -     mutex_unlock(&tport->mutex);
> > +
> >       return ret;
> >  }
>
> This too needs #include.

Why? I see in "mutex.h" (which is already included by serial_core.c):

DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))

...so we're using the mutex guard and including the header file that
defines the mutex guard. Seems like it's all legit to me.
