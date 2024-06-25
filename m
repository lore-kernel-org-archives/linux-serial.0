Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D116FF5F
	for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325798; cv=none; b=CltgSxq9yX9kV9JgG6vx8W63LM4UAwX3Fp5zal9kyjp0qusIn5VUpGHBH0sNujb3OldpAnIyuFUpFloT92Rx7L9QBUkRPstHbNFilwuBWjn8axM63tjfJFtF2BBv8Zi6n+XGOwwz035y9c3m8PNSKnRwyRfkZ99DoRnRWD9qk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325798; c=relaxed/simple;
	bh=3EIzMljfAaU3wCaMbC7Pba/i+sfkfKx7n6Gz4/CnmUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCRW8AJu169/4pu6dVqLeI7cWVYUBKmVUtBJ7sPozEyV3Dqnobc/YuIkhiuqeuoCRlBWpR8zv4NGz+x2pgKm4XZLtb/S0Q89ceD+/Blm7EVEz/9i1CtntbUdlas7ibQOB+1acKJ7P5znmYFU34Ry5HdwTEgZ3QflZPKsaRF36Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jj3Ro/Mb; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jj3Ro/Mb"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d35f1dfda2so3049116b6e.3
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719325795; x=1719930595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE7xcwL4aw1Y8733YCjFqr/6uCmUd8iYLZuXHEHpnO4=;
        b=Jj3Ro/Mbr4TSacb8Pe8f7pfEpsHvU1uwD5dbZ7p3O3Uj6AB2Kx6I4N4UF6RDE076lJ
         /LxCu5Gypf+woDL0TqtWOsrBZpBZjDO9vJU7k1scb8j8o8TH+3LP8W+XJL37KxiLUALl
         O0a+swcJ7oo3ebOestQ598RgKUjHNLWgPqARw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325795; x=1719930595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE7xcwL4aw1Y8733YCjFqr/6uCmUd8iYLZuXHEHpnO4=;
        b=mMbeu/WeW/0CSlgSGx81FvcOFXgm02EmUTp/LI445d7CXKlG7iLa2nuPXPU860LAJ/
         WZVJe6mFHP9RtAx3WI3zgG0Efg502g3OwKdNemfNG6EoxsDpzrOFFZSpE0O/F7wrla+8
         m/qLIKcR3+135vfaJEraPxU4H5HBg7orRwKgyRQUiRIas8w8jEE9XW4DiO3lvdivkivg
         GHv834XTbkv21QB+z6nAFtLcoLgu30e7i7KnMjUjKpjy1GQ6Z7c7numr8HBEHizbZe9J
         V3Jx69p9imDw8i38kjWf5fJj+D+f+EpaI4+fTsZAxkDJuoGVKONDuLCDWMvWhkqghmpW
         vsww==
X-Forwarded-Encrypted: i=1; AJvYcCWrfV+zuIvETQxW1+cUVor26/Q1qDzFlFXDJTQ74QGAc7Ut7dPWFKn7akXMfB+lWU7IwRaQ8aRivqhJBsIcjLJH/n81LG711fWEC2J5
X-Gm-Message-State: AOJu0Yxjfy5atrydE/6NEWPRIZnAw5LdJKIrOt6iNtQjKBIiR8n3p+1e
	uOGV3NjtuXXg527ERYkqXfE82BGOSzNEb6a91QxVEWS4eqWlbJISgi7q5esY6uy0zAe/pHCaoz0
	=
X-Google-Smtp-Source: AGHT+IFfQ3G2+kvtC4Mol6112tTrxO7q+XqydUrmJDCRSvgdc95K49U/xShzS1bF/Hiyfw1z62ZlaQ==
X-Received: by 2002:a05:6808:1295:b0:3d5:47a5:f7fe with SMTP id 5614622812f47-3d547a5f913mr9001186b6e.31.1719325795332;
        Tue, 25 Jun 2024 07:29:55 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b3680csm56001781cf.6.2024.06.25.07.29.55
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:29:55 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-445022f78e1so61271cf.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 07:29:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUblkIQuTcFT9Kd2H/cldW5CJYrM83wdS9lqy1GGYNTW492jQp4O4RWSWRi0FajHTXvaHFdKnGxeR8kfItpXHm+0iRp2tEFDKYIoduu
X-Received: by 2002:a05:622a:18a9:b0:444:ee24:8dc8 with SMTP id
 d75a77b69052e-444f2566c83mr3834021cf.22.1719325794420; Tue, 25 Jun 2024
 07:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid>
 <Znlp1_F1u-70D3QQ@hovoldconsulting.com> <CAD=FV=XmuKUKvCq7gG+wM-jAAgHLHnYw4NteFEKz5Fmczd=U7g@mail.gmail.com>
 <ZnqoKDnUMxqf7QRy@hovoldconsulting.com>
In-Reply-To: <ZnqoKDnUMxqf7QRy@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jun 2024 07:29:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ux+ro90xnEEnALiwtjnOk+LT_qaHmE8jS7adWgBPSDbg@mail.gmail.com>
Message-ID: <CAD=FV=Ux+ro90xnEEnALiwtjnOk+LT_qaHmE8jS7adWgBPSDbg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 4:21=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 24, 2024 at 02:15:07PM -0700, Doug Anderson wrote:
> > On Mon, Jun 24, 2024 at 5:43=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
>
> > > As I mentioned last week, the slowdown from this is quite noticeable
> > > (e.g. 25% slowdown at @115200), but this may be the price we need to =
pay
> > > for correctness, at least temporarily.
> > >
> > > An alternative might be to switch to using a 16 byte fifo. This shoul=
d
> > > reduce console latency even further, and may be able avoid the idling
> > > UART penalty by continuing to use the watermark interrupt for refilli=
ng
> > > the FIFO.
> >
> > I'm a bit confused. Right now we're using (effectively) a 64-byte
> > FIFO. The FIFO is 16-words deep and we have 4 bytes per word. ...so
> > I'm not sure what you mean by switching to a 16-byte FIFO. Do you mean
> > to make less use of the FIFO, or something else?
>
> I meant switching to using one-byte words so that we end up with a
> 16-byte FIFO where we don't have the issue of adding more data when the
> last word is not a full four-byte one.

Ah, I get it! I guess I would have described it as 1-byte per FIFO word.

Certainly that seems like something that's worth trying but, at least
in the past, I remember getting noticeably worse performance with it.
We used to be in that mode when kdb was enabled which I run with most
of the time. Depending on what you set the watermark level to you may
either end up spending a lot more resources servicing interrupts or
you might end up back in the case where you're stalling the transfer
because you couldn't service the interrupt fast enough. At 115.2, each
byte is about 87 microseconds, and draining a 16-byte FIFO is about
1.4ms. If you set the watermark at halfway then you'll get an
interrupt every 8 bytes or ~8x as many interrupts as with my patch
series. You'll also stall any time your interrupt latency is worse
than 694 microseconds. Hopefully that's not too often, though the
slowdowns you measured below make me worried.


> > Overall the big problem I found in all my testing was that I needed to
> > wait for a "command done" before kicking off a new command. When the
> > "command done" arrives then the UART has stopped transmitting and
> > you've got to suffer an interrupt latency before you can start
> > transferring again. Essentially:
> >
> > 1. Pick a transfer size.
> > 2. You can keep sending bytes / using the FIFO efficiently as long as
> > there are still bytes left in the transfer.
> > 3. When you get to the end of the transfer, you have to wait for the
> > UART to stop, report that it's done, and then suffer an interrupt
> > latency to start a new transfer.
> >
> > So to be efficient you want to pick a big transfer size but if there's
> > any chance that you might not need to transfer that many bytes then
> > you need to figure out what to do. If you can handle that properly
> > then that's great. If not then we have to make sure we never kick off
> > a transfer that we might not finish.
>
> Right. But with a 16 1-byte word FIFO, we may be able to kick of a
> really long transfer and just keep it running until it needs to be
> kicked again (cf. enabling TX). The console code can easily insert
> characters in the FIFO while the transfer is running (and would only
> have to wait for 16 characters to drain in the worst case).
>
> Effectively, most of the identified issues would just go away, as
> there's basically never any need to cancel anything except at port
> shutdown.

Yeah, though you'd still have to make sure that the corner cases
worked OK. You'll have to pick _some_ sort of fixed transfer size and
make sure that all the special cases / console / kdb work if they show
up right at the end of the transfer.

I was also a bit curious if there could be power implications with
leaving an active TX command always in place. Perhaps geni wouldn't be
able to drop some resources? Do you happen to know?


> > I'd also mention that, as talked about in my response to your other
> > patch [1], I'm not seeing a 25% slowdown. I tested both with my simple
> > proposal and with this whole series applied and my slowdown is less
> > than 2%. I guess there must be something different with your setup?
> > Trying to think about what kind of slowdown would be reasonable for my
> > patch series at 115200:
> >
> > a) We send 64 bytes efficiently, which takes 5.6ms (64 * 1000 / 11520)
> >
> > b) We stop transferring and wait for an interrupt.
> >
> > c) We start transferring 64 bytes again.
> >
> > Let's say that your interrupt latency is 1 ms, which would be really
> > terrible. In that case you'll essentially transfer 64 bytes in 6.6ms
> > instead of 5.6 ms, right? That would be an 18% hit. Let's imagine
> > something more sensible and say that most of the time you can handle
> > an interrupt in 100 ms. That would be about a 1.7% slowdown, which
> > actually matches what I was seeing. For reference, even an old arm32
> > rk3288-veyron device I worked with years ago could usually handle
> > interrupts in ~100-200 ms since dwc2 needs you to handle at least one
> > (sometimes more) interrupt per USB uFrame (250ms).
> >
> > ...so I'm confused about where your 25% number is coming from...
>
> I didn't do an in-depth analysis of the slowdown, but I did rerun the
> tests now and I'm still seeing a 22-24% slowdown on x1e80100 with rc5.
> This is a new platform so I compared with sc8280xp, which shows similar
> numbers even if it's slightly faster to begin with:
>
>                                         sc8280xp        x1e80100
>
>         rc5 full series                 61 s            67 s
>         rc5 last patch reverted         50 s            54 s
>
> I have a getty running and cat a 10x dmesg file of 543950 bytes to
> /dev/ttyMSM0 from an ssh session (just catting in a serial console gives
> similar numbers).

That's really weird / unexpected. Your hardware should be fancier than
mine so, if anything, I'd expect it to be faster. Is there something
causing you really bad interrupt latency or something? ...or is some
clock misconfigured and "geni" is behaving sub-optimally?

...although it wouldn't explain the slowness, I'd at least be a little
curious if you've confirmed that you're running with a 16-word FIFO
depth. See the function geni_se_get_tx_fifo_depth() where newer
hardware can actually have larger FIFO depths.

Just in case it matters, I'd be curious if you have
`CONFIG_IRQ_TIME_ACCOUNTING=3Dy`

Oh: one last thing to confirm: do you have kernel console output
disabled for your tests? I've been doing tests with the kernel console
_not_ enabled over the serial port and just an agetty there. I could
believe things might be different if the kernel console was sending
messages over the same port.

-Doug
