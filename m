Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF2288C81
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520830; cv=none; b=cUd7+e2Pr6xsLHw0gaxDzIZ+LHsjW++WHQYWA3qZoEZ0xtj32JlzDbQi3hgsrABk8pRZxgQ81z2aqx3ui4V/Bab6yzeR/4cylHWxtBKUxFkvyK2bPZ7IdhkxJ1TJoQfbZbbKtewfM+/ajAyWFYxzrFEMEDYtFzF3KyZGVSuW2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520830; c=relaxed/simple;
	bh=sUiK7Fx/H+JDSm4/b+Shne5rP7OtJDFv8SjEMu2XlDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfoRj3owwTeid867D2f7rPJIoqlE+ob67bpRBSqg1Yd/AJ5L0xNYqpYrjSfVV8xC8IpzwWb+Rmbs/zVdnZArTfrwH/LrYZjBNUjZfhrd/8IlYMd3HbYypU6yk2Wnz0BhdUtaop0U4kj1ogrkjVNLkydQI1fnAHEi4E7FzQ5B4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZY6JpQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZY6JpQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6D01F00AC4
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520829;
	bh=sUiK7Fx/H+JDSm4/b+Shne5rP7OtJDFv8SjEMu2XlDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QZY6JpQEuKgX85dPRvSGmr3bH9qAroW0GR8zhFsvGh3VWcao3sMM4Moo4XaM3SOEP
	 O4bdYPcDWBVzEdkkPzhhSltYb1YvSak70l7e5cJLOUTsnP1jwIHqLp5M32CmtlaKSH
	 T1B9Y/kzFdT5lZ5qQ+KHqYwgup+ceGMaRlm3fxGz4zsBSDi9Y9BvhUjLEwrwvg4a3O
	 Lkfsvz0iw902zsQgsNW3WMrfodW1et5yFaNjxxBsBZFsKHC5boRsv7juGXvoO5LyKV
	 VXa/KcW3GdXYMRZb3I/E2FvVcF4IehIiZu5O+0tjPVFHapa73x+soXio0u/IwsaOvT
	 UIHXquD6Qj5sw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b2aab18795so716874e87.2
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 00:47:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqCUXFD1rCmZWHSEPWqBQou0YVUdVfhECbwySCLJrqp/8Rzl2t2tpj/XUXBbw91kT23lHZrfXhpM1I6ITM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfe7FlL6uAzIm1VybejtgXH2KbyWc0AOAoscVn4vsqIndS2Yv
	0D9U+B2BVLWYpfTf29bmDIjTE7AdWdBTZEjLLpydcsVU3ory98RQwnukK8C2kSkeZIMCBtb5X0x
	arSj4YCNCG/O9fK0uBX9lihssY37o6Zw=
X-Received: by 2002:a05:6512:15a0:b0:5ad:4cb6:fcf with SMTP id
 2adb3069b0e04-5b44e2e25edmr406738e87.12.1786520827820; Wed, 12 Aug 2026
 00:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com> <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
 <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
 <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com> <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
In-Reply-To: <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 12 Aug 2026 09:46:55 +0200
X-Gmail-Original-Message-ID: <CAD++jL=A+wkWudoDZLDy9mq-y3UT9Yvpi8cWM5Nr6zcXT4qskg@mail.gmail.com>
X-Gm-Features: AUfX_mxYz7-hp5qQbVQRpfBnrohWFDpJP9rhisrRcXR_wOY30NeSoikp25BhLNk
Message-ID: <CAD++jL=A+wkWudoDZLDy9mq-y3UT9Yvpi8cWM5Nr6zcXT4qskg@mail.gmail.com>
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

On Tue, Aug 11, 2026 at 10:15=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:

> One thing I guess we'd have to work out is whether we'd really want to
> use "default" and "open". I usually think of "default" as the active
> state and then the two common states "sleep" and "idle" as the
> inactive states. I guess looking at all the states, maybe you'd
> suggest:
>
> * At probe time, select "default" state since the port is closed.
> * At port open time, select "open" state if it exists.
> * If a port runtime suspends while open, select "idle" state if it exists=
.
> * If a port runtime resumes while open, try to select "open" if it
> exists, or fallback to "default".
> * If a port does system suspend while open, select "sleep" state if it ex=
ists.
> * If a port does system resume while open, try to select "open" if it
> exists, or fallback to "default".
> * If any kind of suspend/resume happens while a port is closed, it
> stays in "default"
>
> The above assumes that if a port is closed that it doesn't need /
> shouldn't transition to "sleep" / "idle" states. That's probably true
> (?) for any port that defines an "open" state, implying that "default"
> means "closed". If someone only defines "default" and "sleep" or
> "idle", though, maybe they'd expect transitions to "sleep" / "idle" at
> suspend time?
>
> Does that sound roughly like what you're thinking?

Attention to detail is officially your middle name Doug!

It's what I would have been thinking, if I had sat down and
had the same attention to detail.

So I really like what I'm seeing here, go ahead with this
design, provided it checks out and you can somewhat test
it. I guess you have hardware where you can actually test
the hairy transitions between open, idle, sleep etc and that
is more than most will do.

Yours,
Linus Walleij
