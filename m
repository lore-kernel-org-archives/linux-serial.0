Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3725624
	for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579060; cv=none; b=jVVk5EBxBH3jvxoAznzWHSePoADDxldb3gMNdTHeB54K7EUJypr837mfQJKVe2xb3MuKP3xeSQSLtGWOnMPU2KqMi435C29ScMcFFwEEKvM02RY4cm5HCHv3EeTAKZXRI6yeXvcTwK3jjjrMJj/hh8qgK7fNq5ATvW+9Sj56eiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579060; c=relaxed/simple;
	bh=HY47OI6qgPGV0/QE09FI/k+0tj+UYHuJ+dL5B1JuDSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wpkz5V0xEPY2VMouo+FIyTUEq40ho1VJvlA7AhxUusOGnJRuWjNgWVLP2ZB+rwaG/tY3kBZbpS7r4IgoETtCFdaBq6taJfWiwCkagq//JfY4z0wWoicGfKvBgkz8hIEH+4Emuih261lwZ62XV3hp5h8kzxoOZxjZ9gXv2lC3hjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DEvn8vRB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEvn8vRB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aada2358fso35360266b.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723579055; x=1724183855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY47OI6qgPGV0/QE09FI/k+0tj+UYHuJ+dL5B1JuDSE=;
        b=DEvn8vRBq1+zgNVfiNgS5palLgjurmWj5RAC/VWvcA9J1+b0nqV7W4JuZzLoF/atUZ
         yqz+2BvCFTcwMCg4w4aSz1ySLVcEduL2rtaFbajAIJid42FTxRg9kKgXgWlia/YM7xNo
         67HUqYcNEDggvUSh9JBytkoMDMDNeP7Aclrg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579055; x=1724183855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY47OI6qgPGV0/QE09FI/k+0tj+UYHuJ+dL5B1JuDSE=;
        b=q+HN56krei/Aqb4G/B6AR2dK7dmFKgDt39NHwOrun3g1axur0acuj32cIDY7uyDsNa
         lRBsRAdInCREH+CNvkOi0E2RzLibQ+ZlAZdl0g6g7VHL1aYpsDZ1l659kH3Zc6Fytibo
         /rvZWNyCQ0Dw7ubNCJj0m69JH+JqQO0toLFU8W3HxFYA9Wq3LKVILgjCdKc/Dz1UC09B
         oLuft+rfNTTRmw70fOqDMbIq/C8aLfgFbUS6Zrf3OTmtaHgprJIPd+D4Nv8a21JF3gUn
         LMKTzRpSqgzrQ6spROH9G/u4aNrtod/LP8P0nTId3LTjgaBINfZMH79gdl9vQ0HWbVjs
         4vvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYH1RazcJpz4hNBYxWW3m+M5vLtuJmjBXmmQIMqcdBHrnz5Vcjx/o/maEh0j0WcXR16z34xD3//z61gltPw/JInyB0p8whbcV3y9SM
X-Gm-Message-State: AOJu0Yy0PMQDVvNOb5j9TY0Nqh0yyjBQbmrLiTZ8TivHKGgHVhguGIpD
	DV4ksxsw4X4KFk/mcbBkgwDz1AaLtyilbGIh6Tec3hl1GkFWPae8kepaCttyT7fHTcxajWcvBk6
	+Xw==
X-Google-Smtp-Source: AGHT+IGifJ/Ef5UMBLWfQ68WxQmODc8fK3cxAox8Dvkh8VyYWyXVQycFeMWG+3mTf6Bo0izpr4Ereg==
X-Received: by 2002:a17:906:d7da:b0:a6f:5609:954f with SMTP id a640c23a62f3a-a836274186emr73233166b.12.1723579054782;
        Tue, 13 Aug 2024 12:57:34 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7093sm95578866b.63.2024.08.13.12.57.33
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:57:33 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368440b073bso154179f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 12:57:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGJX+eDIGjO82k+D+sf3M6UJcP+4ApMKG9p/5ig4OdfdokAwmKh3xGOkJhBHSLxirbY93sabZliI/q9k9FaJF49cpckzgErfuz/da1
X-Received: by 2002:a05:6000:1e98:b0:367:8f89:f7c9 with SMTP id
 ffacd0b85a97d-371775d5820mr524329f8f.33.1723579053293; Tue, 13 Aug 2024
 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-6-wahrenst@gmx.net> <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
In-Reply-To: <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 12:57:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
Message-ID: <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
Subject: Re: [PATCH V2 14/16] WIP: usb: dwc2: Implement recovery after PM
 domain off
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 12, 2024 at 4:48=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi Doug,
>
> Am 28.07.24 um 15:00 schrieb Stefan Wahren:
> > DO NOT MERGE
> >
> > According to the dt-bindings there are some platforms, which have a
> > dedicated USB power domain for DWC2 IP core supply. If the power domain
> > is switched off during system suspend then all USB register will lose
> > their settings.
> >
> > So use the power on/off notifier in order to save & restore the USB
> > registers during system suspend.
> sorry for bothering you with this DWC2 stuff, but it would great if you
> can gave some feedback about this patch.

Boy, it's been _ages_ since I looked at anything to do with dwc2, but
I still have some fondness in my heart for the crufty old driver :-P I
know I was involved with some of the patches to get
wakeup-from-suspend working on dwc2 host controllers in the past but,
if I remember correctly, I mostly shepherded / fixed patches from
Rockchip. Not sure I can spend the days trawling through the driver
and testing things with printk that really answering properly would
need, but let's see...


> I was working a lot to get
> suspend to idle working on Raspberry Pi. And this patch is the most
> complex part of the series.
>
> Would you agree with this approach or did i miss something?
>
> The problem is that the power domain driver acts independent from dwc2,
> so we cannot prevent the USB domain power down except declaring a USB
> device as wakeup source. So i decided to use the notifier approach. This
> has been successful tested on some older Raspberry Pi boards.

My genpd knowledge is probably not as good as it should be. Don't tell
anyone (aside from all the people and lists CCed here). ;-)

...so I guess you're relying on the fact that
dev_pm_genpd_add_notifier() will return an error if a power-domain
wasn't specified for dwc2 in the device tree, then you ignore that
error and your callback will never happen. You assume that the power
domain isn't specified then the dwc2 registers will be saved?

I guess one thing is that I'd wonder if that's really reliable. Maybe
some dwc2 controllers lose their registers over system suspend but
_don't_ specify a power domain? Maybe the USB controller just gets its
power yanked as part of system suspend. Maybe that's why the functions
for saving / restoring registers are already there? It looks like
there are ways for various platforms to specify that registers are
lost in some cases...

...but I guess you can't use the existing ways to say that registers
are lost because you're trying to be dynamic. You're saying that your
registers get saved _unless_ the power domain gets turned off, right?
...and the device core keeps power domains on for suspended devices if
they are wakeup sources, which makes sense.

So with that, your patch sounds like a plausible way to do it. I guess
one other way to do it would be some sort of "canary" approach. You
could _always_ save registers and then, at resume time, you could
detect if some "canary" register had reset to its power-on default. If
you see this then you can assume power was lost and re-init all the
registers. This could be pretty much any register that you know won't
be its power on default. In some ways a "canary" approach is uglier
but it also might be more reliable across more configurations?

I guess those would be my main thoughts on the topic. Is that roughly
the feedback you were looking for?

-Doug
