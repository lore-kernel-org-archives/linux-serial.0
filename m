Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9F3DEAE3
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479345; cv=none; b=KKOT86YJigMb9C7tjtJg1YJbjS/sTriOS4Z1LFXtrdspflU7fhJcynU6VeNrFHBTMLPiugYtLIX1BN6qX40BLMKiXYOmIr9rMZ+lBrPbNb4RhB0eGbjLL36PSsfXnAV/lkt58g9h7grrsYxwfxQMOoXiLCtFzJScsE4LLObwe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479345; c=relaxed/simple;
	bh=CBrBeMUQW8d+i7L83djE5ZY0wiJIJ/OL03ZVrG4id0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNfedG4pOkwNUi7u2hAKoehSq6VP9y6cc4g3Osyx7zClYmDtgQ3qthvs68SVWObTyYMd2g++Vb/5DKnkrYkfCB6mfBKv/xJki/d6tVHUmFVEpZfCdZ+A2xMUgMDQ7AQU2nMWpCHgZZmP/+orRK4+hQO8sDOTPfaL7eBvWI0tMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=meLsD5Rk; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="meLsD5Rk"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so122625e0c.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786479343; x=1787084143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csDgwV25ON6IzhiyShbpMznG/bYKo4K3lwEKdXseO2U=;
        b=meLsD5Rkmv9dPKt5GvzyR0m5SCymvtdDWmyzk/gZ0RUZxLVROveA90+GsPI8vRcGF+
         /F/3rDxN+ryIrt6MJcEWr6ojnscPv6EDZdW0dXaGbsOZLJ8AfCZVNCl6f5g7EyzYJG9W
         d32U4At6PJJA7eOFEuJZ7tZFcybuITjEb5e7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479343; x=1787084143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csDgwV25ON6IzhiyShbpMznG/bYKo4K3lwEKdXseO2U=;
        b=V0lV5yJZ0bDLzP24pg+uQKB7mdxnJ+DkQxwsDOA0Egp5falixVoQllQyVbP7P+qn5d
         Q3xVtrSnPRYdpR31r0rFi/g+9BWha5ick18HkQLCsD99Fn16H6EzP9P/VcRDdVkxDyf/
         JoR3Js1XKbK3vQoPXS8sv+kwuGF/lKWxOQIFcEDhRY9gxHua3kqqKTB95ookI6UZyuzc
         OOsusYkvBRfmS87fE4I1T5VqPPKmjhIGfXrSmLiHS7dvOsR5CfIZgHO/ybwaf8yQepsM
         GPhnSZKbPK6W8CWh7TnKRXFNCcG+3OXdCBSXBxN4WlnrS1hTaXhD3wmqdQD89iUn9IuJ
         qmJw==
X-Forwarded-Encrypted: i=1; AHgh+Rqi8ANx9sq5fNVFZ7whPpmvOFgBaEXW2FS3KFl6brSQuxyNVO+nMleeEg94nya4g6cbZaxTw2Ymavb9Afc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZGAaS2mkksODK86JVMeavd77ybTEs5T7r4QthHDIWEVZN1zr
	hoKdrgwLWooMw+g4qVzW1lD79DEU1+/B/jPL8yhNfqyuFnZqalbd8B4zJuknTdzm35a2g3woxvX
	oL9U=
X-Gm-Gg: AR+sD12QQmbD+ysL0CHeuCQ1nj8R3VwO/PfsYxAqlJqQW8XzWx4jglQfvkdQc7KJh41
	XbHHDn9gtuBBtdK6PktQSPdL835dfS9bM8Nx8BNVU7lHhWI2K+7gZHGkdatb5M0gthTm+qXWz9U
	X8wVUs+OcLkLI5Vqd+gyQYQJcux++ZFkTloL5eQhaXLP7aKAMX8BskgxnB95Pl5gjL8ISXv2Of+
	MzZPBB/1dXcQmq0KNlZUNk7J4rLRPrTgSdWxb1dsOfePfUDwOKmlfH+YlppELcMUsJvAFIZXk1w
	9CKmq2IjBiLJv6ennVXS9qZrjzV6g543zSedNXSAQg0XvMcAAjgUQt13gDzhXEcmfIepzfGbWsh
	KYAzrUaQeTDDbbTm/lsBTS3STXejUWKn4VWNzKsDSxNrvbrm2IxoocXi3U/ZUqMC9Nb7UfIqBy0
	mw7waGN9rIipQA4cTUoDIGS4FlRDRMWcKZ02TxG7vf3pn9x595kYL2bihnIRSXYcx8/xoE6gYFc
	UKyd8hEdFkhBAiuIyVXqfLDvxA=
X-Received: by 2002:a05:6122:4f99:b0:5bd:fc23:c9d1 with SMTP id 71dfb90a1353d-5c4503b9c3bmr976043e0c.6.1786479342659;
        Tue, 11 Aug 2026 13:15:42 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c45b4c2fe9sm465582e0c.5.2026.08.11.13.15.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 13:15:41 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97727c2064fso166307241.0
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 13:15:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqSlKy7MTRJDI4cHC0x8pu12USSiN/PZckG88dmrsqVISqcF59/5TcUoN3yZsrm+z7WDbzZBJjJ+OccBe0=@vger.kernel.org
X-Received: by 2002:a05:6102:1626:b0:74a:9ac9:792c with SMTP id
 ada2fe7eead31-76b579db0b4mr1852833137.12.1786479338699; Tue, 11 Aug 2026
 13:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com> <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
 <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com> <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
In-Reply-To: <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Aug 2026 13:15:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
X-Gm-Features: AUfX_mxLuhyep_tioCHiLI3wXMU74EnJM_j562N9S8uWZwg0VDx18C2jCKFt1po
Message-ID: <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
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

On Tue, Aug 11, 2026 at 11:47=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
>
> Hi Doug,
>
> > > What if this is not good for all devices?
> >
> > At the moment, I couldn't find any device that the above rules would
> > break. Certainly I could have missed something.
>
> No you're right, nothing breaks other than the that for one
> instance of a driver the default/init semantics change.
> Which isn't elegant IMO, but it works.
>
> > Definitely the things Micha=C5=82 wants to achieve can be done without
> > changing the pinctrl core by using named pinctrl states and
> > transitioning at the right times.
>
> I think we need to do that. This approach is a hack, it will be
> hard for others to understand and lead to a lot of questions
> about why this is done and so on. Better use a custom state.

Sure, that's a fair argument. To me, it felt like adding the extra
state was more of a hack / working around the pinctrl limitations, but
I can certainly see both perspectives.


> > One of the solutions we looked at
> > together was functionally equivalent to what he proposed here: he
> > defined a state "unopened" that was a complete copy of "init". At the
> > end of probe he transitioned to "unopened" and then later transitioned
> > to "default" upon the first open, never to use "unopened" again.
>
> I think you should step back and thing about what state names
> are the most relevant for a UART.
>
> Why would you want "unopened"? Just use "default".
> The states are just state transitions such as any finite
> state machine.
>
> These are perfectly fine semantics:
>
>           open()         close()            open()
> "default" ------> "open" -------> "default" ------> "open"
>
> The device core doesn't touch the states after probe()
> so the "default" state can be reused without any problems.
> No need to have any "unopened" state.

The idea in my mind, at least, was that the state of the system isn't
all that well known at boot time. The bootloader may not have left
pins / peripherals in a consistent state. Until all system components
finish probing and finding each other, it may be hard to know the
correct pin state. It is during this unstable period of system boot
that I envision we'd want this "init" / "unopened" state. After we get
out of the uncertainty of boot, we'd never need to go back to this
"init" state. Said another way, the "init" state might account for
some uncertainty about the state of the device that the pins are
connected to. On the other hand, there should be no uncertainty in the
"closed" state. This is why I was thinking that they could/should be
different states.

This all being said, you're right that we may need to take a step back
and look again at all the options. In the specific case Micha=C5=82 is
trying to solve, the "init" state and the "closed" state probably can
be the same. Thus using a solution like you proposed can make sense.

One thing I guess we'd have to work out is whether we'd really want to
use "default" and "open". I usually think of "default" as the active
state and then the two common states "sleep" and "idle" as the
inactive states. I guess looking at all the states, maybe you'd
suggest:

* At probe time, select "default" state since the port is closed.
* At port open time, select "open" state if it exists.
* If a port runtime suspends while open, select "idle" state if it exists.
* If a port runtime resumes while open, try to select "open" if it
exists, or fallback to "default".
* If a port does system suspend while open, select "sleep" state if it exis=
ts.
* If a port does system resume while open, try to select "open" if it
exists, or fallback to "default".
* If any kind of suspend/resume happens while a port is closed, it
stays in "default"

The above assumes that if a port is closed that it doesn't need /
shouldn't transition to "sleep" / "idle" states. That's probably true
(?) for any port that defines an "open" state, implying that "default"
means "closed". If someone only defines "default" and "sleep" or
"idle", though, maybe they'd expect transitions to "sleep" / "idle" at
suspend time?

Does that sound roughly like what you're thinking?


-Doug
