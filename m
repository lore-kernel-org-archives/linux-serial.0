Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65362364E9E
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474069; cv=none; b=fBs0gzh8eP6VM6O310XazuXw06QFPEMFXPLYOHiJ1igltL9vbqdSWbWvHXWV4AQ8LqgLN/mj2JMvWGHyMMK3wXJX6RMMJPoSTrAQTq5t7bybZleMq6zOV/PhJseWw3++xoidiT/i9eLY2RVJUtMh70nMb2jPc4pfOUjVEbC99kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474069; c=relaxed/simple;
	bh=fs+kQ5gxaKxL2LPaK51ZnnoduqjedXId2Yucc+4hYfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzi4wEwIppbbpc0/Dnge18fQMZiubBiBTVQhXQY2n+IGxIpuJSVqHUs1QbLyC13i2FKbgHvOEpvhDjcSynfo+fmBAcTFGO+8btrUX6btgwNrFYAvYcqvgY3I3di7FzDuyaAnFU+ggQ1jZaU6WRJu1/WtvKMwhT3gDhwX5ZWY0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM3cVhGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM3cVhGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DDE1F000E9
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474068;
	bh=l1T985IKnkb+rag4Ev46oD5FTC5IUTvKk8EBZgfZUds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mM3cVhGOB9MBWTXSI3e+CKwunk2SIAzrC1HjVpjthdKnjNi7GT8daKjOeZPsbAYUr
	 frbpI+bbAJdumt88x9D5YRuwQctYFJCpdLmZlV9YBAwpFqTdi+AWXjZ2yuekm24Qwm
	 wFRt86Wx7fl/bUwf1zM7HgU/fK8ZnwlrjMxyMIz/iac3s41Om6VX/A9dgKOZHdEGkZ
	 HaZbZsr40mJajaVEpshkUdPmSliQcEciPfvRIxy73czuBqdx3/oF7YxUD9/IKWvMvG
	 EZ1eApGRQhuCS+H2SYY5tgHqgTK8vmfuDomN8SfgIYXLVIboVgaUDVH0S2QlCdSs5I
	 TD7hTNj6heW3A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b00d083818so1283170e87.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 11:47:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqV/KzE3t+YVmyNQjrkQbcRkxjUZeo3Ynav1zEvo4o52EL/JRi3eQiVzZ7EAuqwayZx+DdqHpqDQqBZPhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+kP/dI6fBomI/2Xg+GhaXK3pJCRIooUjSPIljkUF7SbWf/lA
	tpOX2sXWuyJ1DkRPXLgRmmaGaOSZoyh6C1yH6j8K+woxyEZZs49kN0+DQa9PMHSsZbIAK9ixvk7
	F1amASer7q5UTbX1D+SeDTfgXSezkbKE=
X-Received: by 2002:a05:6512:3137:b0:5b1:5f8f:bc2d with SMTP id
 2adb3069b0e04-5b44bee9ca1mr273730e87.9.1786474066843; Tue, 11 Aug 2026
 11:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com> <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
 <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
In-Reply-To: <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 11 Aug 2026 20:47:34 +0200
X-Gmail-Original-Message-ID: <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
X-Gm-Features: AUfX_myohMKgRx6sJJWRdyudRMqrqoDrihh3TYNeodoTfS6C3zCDC4T-Mw3R3dw
Message-ID: <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init
 pinctrl state until first open
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vic Huang <vich@google.com>, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Tue, Aug 11, 2026 at 7:00=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:

> I don't _think_ that's what his patches are doing, though? It's only
> changing the transition for drivers that actually call
> pinctrl_keep_init_state(). For any drivers that don't call
> pinctrl_keep_init_state() then the behavior is unchanged.

Aha OK I get it. You're right, the behaviour change will only
affect this one device.

> Furthermore, this would only affect hardware that specifically has an
> "init" state defined.
>
> When brainstorming this with Micha=C5=82, my thought was that for a certa=
in
> class of drivers we could unconditionally declare: if an "init" state
> is defined for the hardware, the correct time to transition away from
> the "init" state is upon the first device open, not upon completion of
> probe. Specifically, I was thinking that for "bus" drivers (UART, SPI,
> I2C) that the end of probe doesn't really mean that everything is set
> up and pins can be configured normally. It's only after the actual
> endpoint driver (the one using the bus) probes that you can really
> transition off the "init" state.

But why is it such a good idea to alter the core semantics of
"init" and "default" for certain devices instead of just coming up
with some custom state?

git grep pinctrl_lookup_state gives a lot of cases of custom
states, it's a normal thing to do. Maybe not common but whenever
you want something not the usual semantics, use a custom
state.

> > What if this is not good for all devices?
>
> At the moment, I couldn't find any device that the above rules would
> break. Certainly I could have missed something.

No you're right, nothing breaks other than the that for one
instance of a driver the default/init semantics change.
Which isn't elegant IMO, but it works.

> Definitely the things Micha=C5=82 wants to achieve can be done without
> changing the pinctrl core by using named pinctrl states and
> transitioning at the right times.

I think we need to do that. This approach is a hack, it will be
hard for others to understand and lead to a lot of questions
about why this is done and so on. Better use a custom state.

> One of the solutions we looked at
> together was functionally equivalent to what he proposed here: he
> defined a state "unopened" that was a complete copy of "init". At the
> end of probe he transitioned to "unopened" and then later transitioned
> to "default" upon the first open, never to use "unopened" again.

I think you should step back and thing about what state names
are the most relevant for a UART.

Why would you want "unopened"? Just use "default".
The states are just state transitions such as any finite
state machine.

These are perfectly fine semantics:

          open()         close()            open()
"default" ------> "open" -------> "default" ------> "open"

The device core doesn't touch the states after probe()
so the "default" state can be reused without any problems.
No need to have any "unopened" state.

Yours,
Linus Walleij
