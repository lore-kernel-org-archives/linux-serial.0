Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792966281;
	b=x/fI1Cstig3HnN3nlpYkqsXcqQy27zos1Qv56TdlPDrjmiZ4sOQEaL70y3z1e0cA58d7
	 qUHI5YoOTKqz9UBbR+DvjRymWeTYxUJtDgCuHXcQLDrMEvjaDzpyw1OuZaNxz3DmWW9lb
	 uo4eWsozaIMtA5cIAinbZIHJk+xbE/xbV1flVAQjwMR7z+SbN3PaKSDKcycBFzrWD+cYL
	 zEFnoosG0fMTgoGAQtwhxXzIE8sON/Fat4PlablD4zEs4LaAg2XKpyqLwe55pp708DF3e
	 qYHon8gFdQOGV0IO2InlIi/vFoLv3Zv8D8Z3vH/+vqJwZ1bUrsp40FNYpx6DTAEsv8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
	b=1xFYIHRdtu4JN3SCXu3wjJiH4bfTx+oZ4dALWzi2LVLVRohih0AF1UaNbHooNMaLT83F
	 UWQEq9JkDdSp/W+dxaGJofwoFOpH7YOJO9iXZvleMhku4peKHfO+FfsN8beyBhl9aEzo6
	 AdpaTDct3GQQpsRcfe61AYCXaFFjW0s0f3URab2J/B5plCrrLIuABiXzE1wQi1mBBw+6/
	 Fj7SnST1YNWrGukVTQyBS4hJDgT1HyDX4o3VMbig7lsAhc39o36p/rtbC1s3lT5r8GsaD
	 OAiirmwyeYq48wofx0YuIAjMnVdWEn9J8vw1OmN8idzfsiA8ZRmFeddD9PiUrns+V+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="gyoUP5z/";
	arc=fail smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF35606A323
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 22:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF35606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gyoUP5z/
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7ce78f9d6baso393539137.0
        for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 15:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792966279; cv=none;
        d=google.com; s=arc-20260327;
        b=M7e1fAIo+3xffXhbDKQjvMAF9J8QXqS1snjyl6JiuvpNK0cg+gMCwXfnTxLzXkBpYK
         chCvwLHNwJuNx3WceqKN+Pcz16BC8f6eQnotntFSIxiRn25Rp23f3RqHu8bizAUg97vs
         kTqd+J/KFqNEnL39QJXKv5aLa653sGV6K8yF6mIZX2ZZY90WmR2OHRMsX7tAmHc++xwl
         g7U7++qhQdDMSHmQXFxZnvFMWUIYb+GUHt/vy/knas+qgV3PAkTGFc9vLUkfJZDK4mqq
         KX03GZOuDOeBfSFu0dyrwJoIcsxXc61fYQn8u+SssTAAD8yxgI8JLAO7jaOK3gU7asyx
         DXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
        fh=s/r8OCzOX/1rucfEcrby7pc3kHjBFEgHjV/fxochcoY=;
        b=DVgxVy8f9Mk4rD/bkdY89cVQAT/tUYHPd4sHAKhJpV6Cax4L7Xk54K7A2mbz6ERG6e
         djtWbUCXLRc2K/wSjxVvyzXjdNMCDByZlAPjU8JjPVhNtz6LYxo8t+gNC6dFi2LsmY1L
         7G6YxlHBIOUXj13dHhvLIXMrgtfUCVeqhgTMqF7Rl+8u/Q8o1MQ7Jkc1uqgTFqxadbnD
         oHQIrqceqDnJVGLACZPcSgzz4zG037EyuPga/KxfbdoRVYNu8TX4TVNCUG7nmsH52BGk
         7s3jJ7ZEBYB7CQRPL+REo63xufQ6oG+SsYqS72/0InqMI0CK4eMGkrIf1o3Y/PUql8cr
         ovLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792966279; x=1793571079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
        b=gyoUP5z/trcRB3TZ5w2FQDsLwbH1tgBPzGaL7wGyL03j1uzv6jHWSgDq5+ROWTMllB
         H6KrMw7+5GhAHkfaAUeMRKb1mkW4GxtY/1ha/DfrrIq7eFv7JkZI09DSeFQDpIW2F3jH
         0huBrNIZzccret7GuBhUGbnMOA5k/Y0IpHSoOzmDMrJnwGXg0Kt/WyieiiOrmUg9Nofh
         33/NmaAiX/bKuyFD0GRNg4vFWz6hQwJfHuSnQXzHWC/7QQUJRVos+izhilnCcRuT9HtG
         WibblWGpbjx/j7MLaHpG1dOStw1+KmRu4Sj7s8PH4H0VXLHfO7j52yF5GQmKb4ck5edH
         Weng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792966279; x=1793571079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
        b=RsG9/ZJCJApp7LUKCN84WT8/uZZFvKQ0+nvt4NrdcrIZhDxPiXHWevhm8hjk0mzOD2
         p6eBoO2ixUdB7OcB33fXBM9CXA9lppvCL9MIvs4T9ihWqFtyd+Ws51nE7nmuC6W1ysY+
         AcSM+ua1hCF8Opx63FXfZ9cYoaQVxR6K5aY7sU9oVlx/M9dXNjVL/fexzBS8vY1xRYZs
         AFFAUXiAB1eIKYd194ECh50CchMj0XgBXzg5aazmLYe6GJK32tliiRDRtQRVJcLhvOTH
         uXWs/44r3T13bdzp4Tgj0oB6OuTl/fhcrq40/PR9wIZLN20Px66D0+vYrozyGMCLSxdw
         SjUg==
X-Forwarded-Encrypted: i=1; AKwUvBwjQuxu3I3Egpu+Er3hnSm5clHh2+1fM8J+PexBY4VQ+rhEhnAWN6qhtwO942JqiWcpvL8a1QMr5L4qvoE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyXBaRj9hfvHfCyQfx46KeBlYzcLEO20D0NWgXiQ37vTpHSxXc
	yDcQCEuYa7XJe2vlrWGKCY8KMRIpFyWnVbWqPA1C78EtjYZ4h5M0drTamk8tpI7OSLzf7BjPgAh
	Q3Y4jlL0O/1cUenNdl1c/3YGSiFtnZoo=
X-Gm-Gg: AYBFou3LxlKJqt3FmcuouY4Q/WGUHYp/q6w4HdnVFYDLmQG//vcSplowdVVWCnD08Gi
	lnjIoBlbJ9N57Y8qterL250lbGnF9gMPVKpkNXFejwL+QBfmVyeRKX3wImzav0EXOYVlAQGOTNH
	7TUJsEBK4kfzKME2CILGL4F6SVqUnilvMM0vdj8y43RojvXC5S/wHwhCCWljLymOz016JJyr4d3
	1hc2ihaqENdHY78Vd2jxnJoj8JHa3Dxd8kn6PvZ7NMoN9BVTf1AoQA3GeCpsHA80oLLRuqO08eC
	bL3nSjURwxH6ZG4awkZsqjdyxsNeFbYaXnC/jnrYCE6daGP2NuBSiHCTTMlUbjaQzLwoIx1xpvq
	w67/prNbbdbNEg/5yOtmWZH7sqDOAFlSwfzX8e+V79opMVAEFDjJCBOpg920tmGMRIGOcPNsx9A
	6H5CywaOKIayGv/OtTsHYuX22UQtd5TJC/k+WIoT+/kdYe5RabxbO5E6aLJ1vu3QGX86Lz3VQhb
	zoOO9guAEb+nhvv4yqe8w4SFSv/sg==
X-Received: by 2002:a05:6102:54a4:b0:7bf:8ec:4996 with SMTP id
 ada2fe7eead31-7ce5cd56791mr1192565137.20.1792966279613; Sun, 25 Oct 2026
 15:11:19 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk> <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com> <at5qKehogAjTa-fA@ashevche-desk.local>
In-Reply-To: <at5qKehogAjTa-fA@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 16:11:08 -0600
X-Gm-Features: AclHuK8uppf4mumWz9vBy2Gysgc_7CSgy4TY8S57y0TXESxCvcndlkgEpAI5NvA
Message-ID: <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
> > On Sun, Oct 25, 2026 at 9:10=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> > > > On Sat, 24 Oct 2026, James Hilliard wrote:
> > > >
> > > > > uart_write_wakeup() expects the UART port lock to be held. Severa=
l worker,
> > > > > DMA completion and interrupt paths call it without that lock, inc=
luding
> > > > > indirect calls from uart_handle_cts_change() and the transmit hel=
pers.
> > > >
> > > >  Fair enough, and thank you for the cleanup and spotting the issue =
in the
> > > > first place, however...
> > >
> > > He already issues a v6. I think the tactics against AI contributions =
should be
> > > to not answer for a week or so until there will be a quiescent week.
> >
> > At least with the workflow I've been using, a good signal for quiescenc=
e is
> > simply whether or not the Sashiko reviewer found issues.
> >
> > I am feeding the Sashiko prompts into my local agent but it seems to
> > sometimes miss issues that get flagged by the public Sashiko reviewer
> > still.
> >
> > I've been attempting to peel off independently reviewable fixes where
> > feasible as well to minimize the amount of patches/code during respins
> > as well.
> >
> > > At least that's what I learn from this patch storm.
> >
> > Whenever my local branch accumulates significant refactoring/changes
> > due to Sashiko or manual reviews I generally try and send out the new
> > revision fairly quickly in an attempt to avoid reviewers wasting time
> > reviewing code that is obsoleted by the new fixes/changes in my local
> > branch.
> >
> > Locally I actually have far more UART related patches in an integration
> > tree that I've held off on sending for now since they are dependent upo=
n
> > the prerequisite fixes I have already sent. My unposted patches actuall=
y
> > have an even larger amount of code changes than all the UART related
> > patches that I've posted so far, at least when measured in terms of tot=
al
> > lines of code changed.
> >
> > The large amount of patches I ended up with seems to have mostly come
> > about due to the AI agent identifying most of these bugs while iteratin=
g on
> > and debugging new features(most of which are still largely unsent so fa=
r).
> >
> > The strategy I've been using is to send small isolated fixes separately=
 and
> > then reference them as needed in the larger series that depend on them.
> > I figure this should make the changes easier to review than having them
> > all in a larger series. I contributed the changes[0] to make this compa=
tible
> > with the Sashiko reviewer actually.
> >
> > I also use a custom AI agent controlled hardware in the loop test harne=
ss
> > which makes iterating/testing changes much faster since the AI agent ca=
n
> > autonomously test and iterate on changes far faster than is possible to=
 do
> > manually. This test setup also allows much more thorough testing as a l=
ot
> > of error handling or uncommonly hit code paths can then be tested using
> > AI generated fault injection tests on real hardware tailored to the spe=
cific
> > fix being validated. I manually review the final changes before sending=
 as
> > well of course.
> >
> > I'm constantly refining these patch development/review workflows as wel=
l
> > so feel free to give me any suggestions for anything I should change to
> > make review easier.
>
> I already gave one: slow down. Better think than loop through AI and keep
> Sashiko busy. Your patches are valuable, no questions, but they are way
> too complicated to catch on withing an hours or a couple of days time fra=
me.

Yeah, I was already slowing down quite a bit. I probably should have starte=
d
sending some of these earlier but I wanted to see how my final integration =
tree
would look like first so that I could better peel out what was actually nee=
ded
as preparatory fixes in ways that would fit well with subsequent features.

> Some people might want to test the stuff. And sending too often you actua=
lly
> will get the opposite results, people will be tired to even start reviewi=
ng
> and/or testing your code as it's changed way too quickly.

My thought process was that people wouldn't want to be testing code that
had known bugs flagged in Sashiko reviews.

> Settle down first
> with something, put on the cover letter the answer why not all Sashiko's
> comments are being addressed (for example, due to amount of patches or th=
e
> series being focused on a certain issue).

So, in general I've been always attempting to resolve known Sashiko issues
in every subsequent re-spin, so that would be a bit tricky since I wouldn't=
 be
aware of the Sashiko issues until after the series has already been sent.

Usually the subsequent issues that get flagged are new issues only discover=
ed
after each new re-spin.

I do have a bunch of UART/DMA related patches that don't have flagged Sashi=
ko
issues so it probably makes sense to try and review those first while the l=
arger
series that have Sashiko flagged issues are still stabilizing.

>
> > [0] https://github.com/sashiko-dev/sashiko/pull/389
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
