Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB2453A54
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467648; cv=none; b=j1lQjlfN/6PHHhHU52m2gfWcfQFodyr8vN+pY8s9bl4HgksEaBwxkaJ6/BxCRhkBsguc48MdhEP6wZ7T2NAdW9TpY8wMYw+buosiOBJT2avvKehrkm/Agw+JREakxZy4HhRFclqke4y9kJGUtNM1XHCKmBPeFyQroi9M6Q5bMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467648; c=relaxed/simple;
	bh=MvVE5fCo/uk43S2LvkXxwzgaOyJn4uz4kLvIJ8hxgg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6/7ULPIl5gLepA5uMwPVNmhz6awOQPFfup6tpMkX0obUr/wMUzq9DzNsCLNJZy4q9fTw+dEdvi0TS7tdndy0Ai1nTlca4MIRHn9e2sbgG+rkymirMumpx6eBiYckOMOXI4QPijsfrbTJ/a4GdM6TIz7c/PUDrA4RAxyXQtqV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EOTH76H+; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EOTH76H+"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-74ad03fa605so11414137.0
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786467642; x=1787072442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elhOyLUazvaE0ZO/jAPeYhdWBT1Grfwgiid1+rrKxgI=;
        b=EOTH76H+6akO3o8l0t1MZy99dPvps1f6LFuc6fQclZopWsH+ATMISC0rjNnwMwVnl2
         MIOXUsRgCnQ3WV4EKqnWchEdSLUKVnzzrjMdQdwKGhkkRCkBOI0SscmEVV6lv8OhEIVp
         dBP/4IsgiDIceT8UGsltG0wyc7kgDQJ6IUbq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467642; x=1787072442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elhOyLUazvaE0ZO/jAPeYhdWBT1Grfwgiid1+rrKxgI=;
        b=PZ1liI3fD5kUJrIXlNwdwcF5sjvgLQ7PN6Fb1Mjbx4918D3c5OGKb1sQOL213BuRyp
         00RmT/xz5vakGV75byJXgCw8TcT45eObFJpawF7tjIEfpIcnhn0qX2tL1R3npx/+kHSN
         UN1EaS9c9uw0w9KQ/R7pYcBXKqASRLZdVFbB5NUGs2mcjwih287KKOR9Zdg25YJXnEtB
         TprkoMp5PaFUpOEOzh5PgxUD0XUf9jC3nE5kZyB6GOCAZyYUY/mDJJ4gt+mNch7bxRUV
         ITE2/iqsd2j9JneQdRBkZmiqKE7aujbf8a4yImaGAvNyyVoG4ZE2m9JRtEVakoYihrZD
         dUkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri8z6WPwqifxMHTn/p9tpZzaVTC2F6iBfRv9+jNAmsEdLEDAu8VAaCuFHpVDY66VIFP+bfBp0y94wK33Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp43MpiXag+PemVuo0fUQIRCvD2gCLRuqkGxW8kYPspbGDNOjD
	1ZWFIAFMlH91rp6CxPF8Dh0yayAW3GbikQcY8AY92XCpaRpl/7IpBhxCzvy1+5Vwt8yYR5PBJsi
	llBM=
X-Gm-Gg: AR+sD11TGjY9XznjFNXrsxIbDcuVYqro9yE3g/ROUnyaoN7zHjJmRvfK4OPsOlU/guD
	ldZDP5ngkfuCTZQlURlUlDjYyJj9O+i+3YMIRn0VCHdkgon4iVd2Sme/md7inz3tMOuHIAmAvi8
	bOntDwlSDHiRl0IhvCvmXI4o+hhq3tG+pIhxCRYbJXla1u9khVlpabHy/616brLW1tbqoc3eCeC
	96YHksnhibluP5muoGWs0ouTwEIBBIyk/GNiEgMHvrgiK7TKzJK9srAZvl6vJFgUM9gUBnjxVOW
	lxeTIkJh0VotOzM98VL2hSPdvhBGYCaRtv85b7DrQl2iBun1kHjhh5kgR7N2pYNqQkqJU3xzpT3
	oxbRzmywOAl7yk7c7XrPxlk351ryyVidh7BObai6A3GZBdi5fQdSSK0bQyDXVoAEXwCeXr3E08G
	28mj5r0gWhkgVhUvR187vhAWdLbIn2s65RTm5TCax4R13nv6IgxXD9Y0e8Zmwtoi6ZqAgUvkbwQ
	+1JkAOLsvoZDfsrPurPDE+FJv8=
X-Received: by 2002:a05:6102:5107:b0:643:80f1:350a with SMTP id ada2fe7eead31-76b54d851f1mr1349975137.2.1786467642304;
        Tue, 11 Aug 2026 10:00:42 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a3c2d259csm327584241.13.2026.08.11.10.00.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 10:00:40 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-76b3036d2d4so418095137.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 10:00:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoCjM3P/gj3+I7HDwArvx9yRiD7Uiwtmh0dW/mo6YfS+jzJa8sib5dh8O5LmsLAdWUOANJM2mX8VBBtXYU=@vger.kernel.org
X-Received: by 2002:a05:6102:548c:b0:737:2ce5:7b2d with SMTP id
 ada2fe7eead31-76b56fb7605mr1468915137.9.1786467638692; Tue, 11 Aug 2026
 10:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com> <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
In-Reply-To: <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Aug 2026 10:00:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
X-Gm-Features: AUfX_mzzbBUmJa6CY-JNqz5oF7CakiwtOphskrUjp2MQpW4UkyJMPgOxTxyCIBo
Message-ID: <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init
 pinctrl state until first open
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vic Huang <vich@google.com>, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 10, 2026 at 11:34=E2=80=AFPM Linus Walleij <linusw@kernel.org> =
wrote:
>
> Hi Michal,
>
> thanks for your patches!
>
> On Mon, Aug 10, 2026 at 3:06=E2=80=AFPM Micha=C5=82 Karda=C5=9B <mkmkl@go=
ogle.com> wrote:
>
> > During device probe, pinctrl_bind_pins() binds pins to their "init" sta=
te
> > if specified in Device Tree. When probe finishes, pinctrl_init_done()
> > automatically transitions the pins from "init" to "default" state.
> (...)
> > 1. Patch 1 (pinctrl core):
> >    Adds pinctrl_keep_init_state(dev). When called during probe,
> >    pinctrl_init_done() opts out of the automatic "init" -> "default"
> >    transition, allowing the driver to keep pins in the safe "init" stat=
e
> >    upon probe completion. Updates Documentation/driver-api/pin-control.=
rst.
> >    Board configurations that do not define an "init" state are complete=
ly
> >    unaffected.
>
> I think this is the wrong approach to this problem.
>
> You are changing the transition from "init" to "default" for all devices
> on the entire system.

I don't _think_ that's what his patches are doing, though? It's only
changing the transition for drivers that actually call
pinctrl_keep_init_state(). For any drivers that don't call
pinctrl_keep_init_state() then the behavior is unchanged.

Furthermore, this would only affect hardware that specifically has an
"init" state defined.

When brainstorming this with Micha=C5=82, my thought was that for a certain
class of drivers we could unconditionally declare: if an "init" state
is defined for the hardware, the correct time to transition away from
the "init" state is upon the first device open, not upon completion of
probe. Specifically, I was thinking that for "bus" drivers (UART, SPI,
I2C) that the end of probe doesn't really mean that everything is set
up and pins can be configured normally. It's only after the actual
endpoint driver (the one using the bus) probes that you can really
transition off the "init" state.


> What if this is not good for all devices?

At the moment, I couldn't find any device that the above rules would
break. Certainly I could have missed something.


> I think the right approach is to create a new custom pin control
> state for 8250dw, something like "active" or "online", and then
> actively retrieve this state when the device goes online.
> The "init" state can just be the exact same as "default",
> or you can just define "default" to be what "init" is and skip
> "init" altogether.
>
> Pin control supports any kind of arbitrarily named custom
> states.
>
> In wherever the UART is actually opened:
>
> #include <linux/pinctrl/consumer.h>
>
> probe():
> mydev->p =3D devm_pinctrl_get(dev);
> mydev->pins_online_state =3D =3D pinctrl_lookup_state(dev->pins->p, "onli=
ne");
>
> open():
> ret =3D pinctrl_select_state(dev->pins->p, mydev->pins_online_state);
>
> close():
> ret =3D pinctrl_pm_select_default_state(dev);
>
> + all error handling and stuff, see e.g. drivers/base/pinctrl.c for
> good coding practice.

Definitely the things Micha=C5=82 wants to achieve can be done without
changing the pinctrl core by using named pinctrl states and
transitioning at the right times. One of the solutions we looked at
together was functionally equivalent to what he proposed here: he
defined a state "unopened" that was a complete copy of "init". At the
end of probe he transitioned to "unopened" and then later transitioned
to "default" upon the first open, never to use "unopened" again.
Personally I didn't love this because it required duplicating the
"unopened" and "init" states when really we just wanted to keep the
"init" state longer. ...and I couldn't think of any time when a UART
driver would have an "init" state when it _shouldn't_ persist until
the first open. :-P That being said, it worked and wasn't too ugly or
anything.

FWIW, that is a _slightly_ different solution to what you've proposed.
In normal pinctrl usage the "init" state is a temporary state used
just at system startup time before all the pieces are together. In the
solution above "unopened" had this same property as being just a
temporary state during init time.  As I understand, the idea is that
the "init" state isn't necessarily the same as the "closed" or "sleep"
state but can also be a "safe" state to make sure lines don't glitch
until we're certain everything has been initialized properly. In your
proposal, the initial state needs to be equivalent to the "closed"
state, right? That may be fine for some cases, but maybe not
everything?


-Doug
