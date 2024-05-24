Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93686644
	for <linux-serial@vger.kernel.org>; Fri, 24 May 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564073; cv=none; b=fl2KRA1nIHaxl2Cpg1UYYIj3Zwvm456EKKyPMNbR4qIaBRcgJO4BQh859h49cLtpb65CbHutoLqrAoXlp4kHv3k5DAj3Q0n4/wGYNA8vpES1XSE+QlgfwUrIGNwsLKcj/RFuR/BIFVNsGxCrAlObtka4MgkWlAdzM+eWWaIOJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564073; c=relaxed/simple;
	bh=yPgcE6iZuFN7YKISqfWrAmfdlGQWBE4xc36lHegonyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4kFqYBqE28ovNu/JyDL9k8/i+ZkARdMA9ZOdPctwJmn6D03oG/5OMD9aZonU6QYbHIjh8xX6Ii/gy+jGX9MhmXcW81hYyi1MpLTP+Dm5LnmSb2UOIOlNevCtB8UsEqyQcvLANlsJXdzIuYko4SGSYgBevaLSWZSCLhdUuDWHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m/Ib4EMf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/Ib4EMf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43fab2fa4ccso9625531cf.2
        for <linux-serial@vger.kernel.org>; Fri, 24 May 2024 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716564070; x=1717168870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpwx3Fn+gj42VdUyf2jwE8slBOE6zAH5ZapgIRoj3Dw=;
        b=m/Ib4EMfEQaFiGabRMgJmxYB7ukQZFMsJgTnQCpNz+OVbhGsHwqVRCjv4dIry4Ip60
         /hwEtzhPQipe/Qq5/Tr9Q4OuEMpNfqEgDkWY1ezs602lWrsFTEnMrSkIvJIU2PNceBT6
         /IIjcEcalOrBQY567lZxjMoAAgE6FP6y6Bu2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564070; x=1717168870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpwx3Fn+gj42VdUyf2jwE8slBOE6zAH5ZapgIRoj3Dw=;
        b=DsomEP1PoAbi9ejv39KrSTUVZ/ZlBeKbWSxm/QbK6F7DF8FYM/fUBcysPRNG1GI9IK
         HgRW0yLPTlrVrGlBPf7Hhwnvk6fkd4Fe104apwP6KKCD+56Phw3XShADguoKpF90ICrM
         V02BabyPaHQngw8ZdsKO8LfxhXZbwRYv8ZhkG4Ylgq1hAfqGqh3Kwi7cQC3aBcNPR6A4
         ys2aAEfx+dzGqVOAy0+Hk6A6ZDp/MyHeTpgLxHrJge//h8iNsEcqjpsXaY5RBM5Koi4f
         GRSimLwV2jGGqZWYzCg0A8IW6F6cdfQ4LuPHvqzsDUqKOl7EigROPHhPMVuYK3UzdWGT
         LFHw==
X-Forwarded-Encrypted: i=1; AJvYcCVt/UUDkpmJBkYx/u2WQ6LqurgFHEi1tDPNKY6oOvNLu7I8KVuxuXDU0G7K7GVCXuttLIIUhcJTcC5nTEIBMWotBiFhg3pxrK1NFZMB
X-Gm-Message-State: AOJu0YzGxICIipGmY9GxDOkZzGJkNpKgD2zAZFUtRf5ScoqolFYMToar
	cZHbsx+vSLN52ghwPthUJFrp/80hoQtGKXT5CwoxYaVuv7A/Q3HKSlbQe29bmJPWJmy88gGp2Pk
	=
X-Google-Smtp-Source: AGHT+IH+XOap3RadNebrJOsuCBZR4HjUFODTzysTnwBjHfYpK4vMnkUY/z3idczx7GC0FwJ+eyXRAQ==
X-Received: by 2002:a05:622a:3ce:b0:43e:26ab:4fbc with SMTP id d75a77b69052e-43fb0f09f36mr28384081cf.48.1716564069515;
        Fri, 24 May 2024 08:21:09 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb183507asm8795491cf.56.2024.05.24.08.21.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:21:08 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43f87dd6866so423791cf.0
        for <linux-serial@vger.kernel.org>; Fri, 24 May 2024 08:21:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlTataAuT3bLz22z8alutRuXSnbNhnVa9ayMiZ3ZLXWSBvIUMXLh8P8/axObA6GaN/6ASgP8qvUfcIgUFx0hskmTZCqta+bBn3m9FI
X-Received: by 2002:a05:622a:1b03:b0:43f:9eff:caf7 with SMTP id
 d75a77b69052e-43fb1642624mr2538041cf.3.1716564068055; Fri, 24 May 2024
 08:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523232216.3148367-1-dianders@chromium.org>
 <20240523162207.1.I2395e66cf70c6e67d774c56943825c289b9c13e4@changeid> <CAE-0n51nBXsaubmtbUxPBsNDiNuOVa1hB9O0bihm8fpEhEDjRg@mail.gmail.com>
In-Reply-To: <CAE-0n51nBXsaubmtbUxPBsNDiNuOVa1hB9O0bihm8fpEhEDjRg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 May 2024 08:20:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WsDYOJg3BHv1Lb-qSE6PDf1Ck4SoEkXf7mf0U2s8qFdw@mail.gmail.com>
Message-ID: <CAD=FV=WsDYOJg3BHv1Lb-qSE6PDf1Ck4SoEkXf7mf0U2s8qFdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: port: Don't block system suspend even if
 bytes are left to xmit
To: Stephen Boyd <swboyd@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Ogness <john.ogness@linutronix.de>, 
	Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, Guanbing Huang <albanhuang@tencent.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 23, 2024 at 5:25=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Douglas Anderson (2024-05-23 16:22:12)
> > Recently, suspend testing on sc7180-trogdor based devices has started
> > to sometimes fail with messages like this:
> >
> >   port a88000.serial:0.0: PM: calling pm_runtime_force_suspend+0x0/0xf8=
 @ 28934, parent: a88000.serial:0
> >   port a88000.serial:0.0: PM: dpm_run_callback(): pm_runtime_force_susp=
end+0x0/0xf8 returns -16
> >   port a88000.serial:0.0: PM: pm_runtime_force_suspend+0x0/0xf8 returne=
d -16 after 33 usecs
> >   port a88000.serial:0.0: PM: failed to suspend: error -16
> >
> > I could reproduce these problem by logging in via an agetty on the
> > debug serial port (which was _not_ used for kernel console) and
> > running:
> >   cat /var/log/messages
> > ...and then (via an SSH session) forcing a few suspend/resume cycles.
> >
> > Tracing through the code and doing some printf debugging shows that
> > the -16 (-EBUSY) comes from the recently added
> > serial_port_runtime_suspend().
> >
> > The idea of the serial_port_runtime_suspend() function is to prevent
> > the port from being _runtime_ suspended if it still has bytes left to
> > transmit. Having bytes left to transmit isn't a reason to block
> > _system_ suspend, though.
>
> Can you elaborate? I paused to think that maybe we would want to make
> sure that everything that was transmitted had been transmitted but that
> doesn't seem right because it's a problem for higher layers to solve,
> e.g. serdev would want to make sure some sleep command sent over the
> wire actually got sent.

I don't have a ton of intuition about how the new "serial_port" code
is designed to work. The patch that added it mentioned that it was
based on suggestions by a whole bunch of people but there were no
links to the previous discussions so it wasn't easy to get tons of
context. I would certainly love it if people who have been involved
could chime in and say whether my patch is correct. If anyone has any
suggestions for something better to say in the commit message I'm
happy to use different wording as well.

In any case, looking at it I guess a serdev device would use
serdev_device_wait_until_sent() to ensure its command was sent. That
eventually seems to trickle down to the UART function tx_empty(). If a
serdev device needs to block suspend while waiting then that would be
up to the serdev device. This could be implicit if the
serdev_device_wait_until_sent() was being called as part of the serdev
device's suspend() function or perhaps could be through some sort of
locking.

...so really I think the case we're running into is if userspace has a
whole bunch of bytes queued up to write out the UART. That shouldn't
block suspend. If userspace needs to block suspend they should use
another method.


> > The DEFINE_RUNTIME_DEV_PM_OPS() used by the
> > serial_port code means that the system suspend function will be
> > pm_runtime_force_suspend(). In pm_runtime_force_suspend() we can see
> > that before calling the runtime suspend function we'll call
> > pm_runtime_disable(). This should be a reliable way to detect that
> > we're called from system suspend and that we shouldn't look for
> > busyness.
> >
> > Fixes: 43066e32227e ("serial: port: Don't suspend if the port is still =
busy")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/tty/serial/serial_port.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/seri=
al_port.c
> > index 91a338d3cb34..b781227cc996 100644
> > --- a/drivers/tty/serial/serial_port.c
> > +++ b/drivers/tty/serial/serial_port.c
> > @@ -64,6 +64,16 @@ static int serial_port_runtime_suspend(struct device=
 *dev)
> >         if (port->flags & UPF_DEAD)
> >                 return 0;
> >
> > +       /*
> > +        * We only want to check the busyness of the port if PM Runtime=
 is
> > +        * enabled. Specifically PM Runtime will be disabled by
> > +        * pm_runtime_force_suspend() during system suspend and we don'=
t want
> > +        * to block system suspend even if there is data still left to
> > +        * transmit. We only want to block regulator PM Runtime transit=
ions.
>
> s/regulator/regular/
>
> Is this a typo?

Yeah, I'll fix that to "regular". I'll wait (probably till Tuesday)
before sending a v2.

> Also, why is "runtime" capitalized?

Somehow I thought it was supposed to be, but you're right that it
looks weird. I guess the docs call it "runtime PM" so I'll change all
instances to that in v2.

-Doug
