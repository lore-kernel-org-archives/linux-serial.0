Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8A1DDF5
	for <linux-serial@vger.kernel.org>; Thu, 15 Aug 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750668; cv=none; b=XZcdxq7PFQvK5F7wUEcqgGbwUrRgtnxLRquYft95XPv7zTMKZ70YZ9NMFiwkUY19FpDuHGpEeCTzHDiaLGX8uViPHoeZR/Fr90Q3KpFqrTY18U1LznBZZOT+PIsgfj8Ntf7lmQWioEf5TY0xAnNVBipRUUVZoVCxM8VpHxI2giY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750668; c=relaxed/simple;
	bh=WgHv8qIghW/XGbfA3/inME7zpGlhOrWspJ9Qn/7HUik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfpbsFYOicqMvNRs5D7yokutFSEGx5zVq2gYFmaLn9VvWorW6vnz1zna4Q7AlTNYcHYkDzrxGGJjxMGflHT4tU6nPpxp27rxL9HRconYkbH4s4YhP1ca1jiu9AkrhK6Eaj04bAw3jwY2RBpHu18Vms8xdFc+rbby+nKsRezV4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fib1ygNd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fib1ygNd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fffca4fb7so6019161cf.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Aug 2024 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723750665; x=1724355465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgHv8qIghW/XGbfA3/inME7zpGlhOrWspJ9Qn/7HUik=;
        b=fib1ygNdcNlcqyE5/pxU4VIXOa73igsPtMb3IIToqzOOP8JnStjihDo4emoI6MsQCl
         e0AKJx8j02nSf9rniJyLcCLy2WEr+FMu57hCwTbRcB0nojxEbIl5VL4F4AfSh10tuTUK
         qdYx2yc24dEa1jFRfhUCNsqdu12cXtfqmINow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750665; x=1724355465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgHv8qIghW/XGbfA3/inME7zpGlhOrWspJ9Qn/7HUik=;
        b=JRcRTUu19abksjpcx0NJH7gsmeKLi99kv+djuyQIDG28aZVTaI/hhyXhBWC3IffAzN
         BSvF2Of4xOxz9iEitLJGeHPEY7rhxswbYJQYlK89t30JwXn0BmreOKuNILZSMtQRr2hv
         ogyI52/PCeTCdBWdGF6Nk9Yp7bR6XNujeUjfTXljod3zrm0dgYiezzsZZg+Sn1z+gifj
         qZmQmIHfSuddbLxUvLvgs9weM/JcK2GcqOhmkRMNCsQSLnTWaQ+EizMwaP3LX7av40/T
         NarFmj3knrQIqa72VyUDnBbfMZjmpIlCLZz0g6DUqyAvbCcccfcHlPQTjyS6fjBBfPGE
         7BSA==
X-Forwarded-Encrypted: i=1; AJvYcCV4/M74tWIkvkw3+a7AF+66XfXZF8WhMkvIglQqkLrOG5qz/JlF4BFQVnXlFMDPENJnLK+epuzlFWpvrAq0Dr209OgI2lh8Gc9KyamK
X-Gm-Message-State: AOJu0Yz3Vynm57TayNn/A9FQUoCf9VykUQMvv78eoqiaIiNVlnjiX2Vh
	bEIi385Df7c9MEMuFj7B5jxY7AGS4B9BOgUHiKLDykvTYVfzcmNq0ITQZQ2HM92Fr/3IYQ8LoI0
	=
X-Google-Smtp-Source: AGHT+IFS+tveD8XYw83VPq38hkfJePqkS6TFrE+c6uNvH34B1jncs4vHWutjWS55Hoen7hIMpGVsuA==
X-Received: by 2002:a05:622a:997:b0:44f:f14c:6a63 with SMTP id d75a77b69052e-453741b5e79mr6556761cf.11.1723750665083;
        Thu, 15 Aug 2024 12:37:45 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e676sm8683911cf.67.2024.08.15.12.37.43
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 12:37:43 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf6dedbfe1so7060236d6.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Aug 2024 12:37:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaZ1spggaMMKL5XLyC8fwoRIKGJnWUnx7GeecAogibhmD5l68ytpZ6B3mwvDuEWSHWyYHKOf0ouR//FfAd2i1grSHR0RPhS/fBBlpb
X-Received: by 2002:a05:6214:3186:b0:6bf:66e6:4754 with SMTP id
 6a1803df08f44-6bf7ce7c3efmr5290586d6.48.1723750663162; Thu, 15 Aug 2024
 12:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-6-wahrenst@gmx.net> <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
 <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
 <CAPDyKFpj0C1Bifmx=4zH3r8YooOrNfn_iDB+1sfRb0gTaKnT2Q@mail.gmail.com> <51b63ea5-808e-41e4-92a9-50e20afd155b@gmx.net>
In-Reply-To: <51b63ea5-808e-41e4-92a9-50e20afd155b@gmx.net>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 15 Aug 2024 12:37:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHnKJT4ubmV8EPRYi-qPFH21tNFzWEWMezY2PGEFEKrw@mail.gmail.com>
Message-ID: <CAD=FV=XHnKJT4ubmV8EPRYi-qPFH21tNFzWEWMezY2PGEFEKrw@mail.gmail.com>
Subject: Re: [PATCH V2 14/16] WIP: usb: dwc2: Implement recovery after PM
 domain off
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
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

On Wed, Aug 14, 2024 at 2:48=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> >> You're saying that your
> >> registers get saved _unless_ the power domain gets turned off, right?
> On BCM2835 there is no need to store the registers because there is no
> power management supported by USB core except of the power domain. So
> DWC2 don't expect a register loss.
> >> ...and the device core keeps power domains on for suspended devices if
> >> they are wakeup sources, which makes sense.
> >>
> >> So with that, your patch sounds like a plausible way to do it. I guess
> >> one other way to do it would be some sort of "canary" approach. You
> >> could _always_ save registers and then, at resume time, you could
> >> detect if some "canary" register had reset to its power-on default. If
> >> you see this then you can assume power was lost and re-init all the
> >> registers. This could be pretty much any register that you know won't
> >> be its power on default. In some ways a "canary" approach is uglier
> >> but it also might be more reliable across more configurations?
> I don't have enough knowledge about DWC2 and i also don't have the
> databook to figure out if there is a magic register which could be used
> for the canary approach. But all these different platforms, host vs
> gadget role, different low modes let me think the resulting solution
> would be also fragile and ugly.

I won't admit to having a DWC2 databook. ;-)

...but don't think it's too hard to find a good canary. What about
"GAHBCFG_GLBL_INTR_EN" ? From a quick glance it looks like the driver
seems to set that bit during driver startup and then it stays on until
driver shutdown. The databook that I definitely won't admit to having
almost certainly says that this register resets to 0 on all hardware
and it's applicable to both host and device. I think you could say
that if the register is 0 at resume time that registers must have been
lost and you can restore them.

I guess if that doesn't work then "GUSBCFG_TOUTCAL" could be used (I
think that resets to 0 but must be initted to non-0 by the driver).

Yet another register that could probably work as a canary would be
"GINTMSK". I believe that inits to all 0 (everything is masked) and
obviously to use the device we've got to unmask _some_ interrupts.

I can look for more, if need be.

-Doug
