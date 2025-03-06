Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F71C6FF3;
	Thu,  6 Mar 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244815; cv=none; b=OEFPVzDbA+9DQYWUWBHwGMhTlDGTDERqOcRxFV2bLjvtPU+ujzgCY0wyLxj92lau7ysVUjfRMoyzLZ53dRkIpU+F9kmCWzy4r21Kh4dilrMNo86j2GpSfKNf0044yDltdRGc5S8adzUjUrM7plliuFkdvRCSBz5f3XDShvYqW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244815; c=relaxed/simple;
	bh=G5oqjKQ03OlbMtkRr3PoC89Z6LTisg9v9G3hFW2R3Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV1LBBIPyZpaexzHtDBoaHSIce+ksv4I5huQsQ+iUiecFou11XomPSqiSSkXQq6K8BagnoYVwMeWKuhWXJ0sNAOYETzeFLeT43XUb11keN111lC8sHoxalf0Aj17qJcp5XvFYJSM31Zk2pDVLCqvvyYXlyVClPelEHT0cOXifeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqnP0M5K; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqnP0M5K"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so50042066b.0;
        Wed, 05 Mar 2025 23:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741244812; x=1741849612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ/JM3QEbP54B+br4sg8MdVS9Z+LacVEvzYVxrXGBAE=;
        b=RqnP0M5KjAlhwKSz7Q/mPg4b5KliM3/RcMn2vLHKKou6WTrs91/ktDBTWaBt82aHK2
         efoTCSfBTKOpgphLNunJBeHbNRADKipPncNjSrBhQifF4Ln3LtUQD8ISHf+ATwXZkZE+
         dWpk8QGqQvbBVzedA8Wtc49xue0yc5kBPumSiypIz5IFJiTQjZA+Q7p1JPwC/z58oBNz
         SRvVR6o6gIdABUrf+Q+1QfHfRYfRdejakzYFgR8+GDeJe05khm0rdkmxR/bK4ghDIh1X
         4Y6p5r7Cj2cxQ6h/vyBnbH7PKlGsPxnGynPXHFp/0Tf/AB0A6dn39obKUxrWVOLhlWPB
         YUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741244812; x=1741849612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ/JM3QEbP54B+br4sg8MdVS9Z+LacVEvzYVxrXGBAE=;
        b=w52tp+jFkMrGDjCW1uv19TtP+/w3YtyiqlnEWyt+SSgUoBNuB/2qOxsCOe6Fs7FPEX
         bLlKNPfPvd3vgJCc3fGmpVyyuLi1/lBGli+uVcWq5CT3Ur8LLoGHkxTNks4fLHH87Wg2
         m5oSrnzFzN64WpuEJuPJxH8/nP3IojBEyPvN1vKzmcFmyCyvV5xTKetD9S/maFjAKksB
         0E7sMC0VE/tjZpqJDnLJ2n5IoyLeyDKtXyz8AApO+cbDGgU320/k24AiBwV+p3HDatYG
         oc6q6Tiz+M+HevYeTPMdAxRTZzuWsLtscAlI6MdxgwvbtssGopUxO6kiBPd5A03a6OUZ
         DbNw==
X-Forwarded-Encrypted: i=1; AJvYcCVf6Sceli/XpObIPGjRLuTCswnN6ebL+kyhXoJDc9m8rOcr2ZpkIz3mDllTcXdh2VDc2D20s/SVcUSik08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOunEddmBSSE+PKDb7YhP1pxbipz0ciVAOmpX50qXJDeMVVkk5
	BG9UagN/8NbjpzIdgZWZIp9ubRnctnKsfjwXNa7CnYteHuTKuD3RSmmEqIu8AVlYCUubeDPLIbV
	S5LkWxtcIehGyLBjtnzZH21euums=
X-Gm-Gg: ASbGncuCGhRLjU6Fb0Z/iQch4afNQYFip/YewOAiUFqSJYBj5XZFPyZqTX9nn5NLAKH
	08dnyDYjvQrhVS1GObd8dfLLtOEeAB1PLgoHUc0/jQOVKvFqeTPLWXQPJx7hs58roO/3RrOoHXc
	mH5xhXIsJHxDJLhrG6Pmb8fCErvw==
X-Google-Smtp-Source: AGHT+IFiKId/s4iGWCCCoPdg4WdFjgQN3IbuGS6b5Pr8Cl60laDu+A9dkfJIVJ+2rA6I1vskKVsjMaP7NHa1sHTg6Ek=
X-Received: by 2002:a05:6402:1e91:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5e59f39d009mr12034112a12.2.1741244811750; Wed, 05 Mar 2025
 23:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305042930.3453265-1-adamsimonelli@gmail.com>
 <20250305042930.3453265-3-adamsimonelli@gmail.com> <CAHp75Veuo9L8Y7=9XKCeFHzhtNK9x4pQ19kcMoAkL-0mFPq1Hg@mail.gmail.com>
 <4264609.3VsfAaAtOV@nerdopolis2>
In-Reply-To: <4264609.3VsfAaAtOV@nerdopolis2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Mar 2025 09:06:14 +0200
X-Gm-Features: AQ5f1JpXrRLQEJsm9sPXIH8dftDR1R-exc3XvVSq-JgBDKmyRHYgm7fwS2xh4CI
Message-ID: <CAHp75Ve9RDSLwsEt4a7ugtYNQokiRjyO6BR_rJXvf7r41C2hmw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] ttynull: Add an option to allow ttynull to be used
 as a console device
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:30=E2=80=AFAM Adam Simonelli <adamsimonelli@gmail.=
com> wrote:
> On Wednesday, March 5, 2025 2:18:39 PM EST Andy Shevchenko wrote:
> > On Wed, Mar 5, 2025 at 6:30=E2=80=AFAM <adamsimonelli@gmail.com> wrote:

...

> > >           In order to use this driver, you should redirect the consol=
e to this
> > > -         TTY, or boot the kernel with console=3Dttynull.
> > > +         TTY, boot the kernel with console=3Dttynull, or enable
> > > +         CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> >
> > I haven't checked what it looks like in menuconfig / nconfig / etc,
> > but I think that CONFIG_ is redundant here.
> >
> OK, I didn't know what one is more typical. Doing a loose grep for
> "^<tab><space><space>" and "[A-Z]_[A-Z]" (excluding CONFIG_) seems like t=
here
> are more help text lines that mention other config options (~622) than in=
clude
> the CONFIG (174). I will change it

Thanks, it's better to follow the common practices.

> > > +         If unsure, say N.
> > > +
> > > +config NULL_TTY_DEFAULT_CONSOLE
> > > +       bool "Support for console on ttynull"
> > > +       depends on NULL_TTY=3Dy && !VT_CONSOLE
> > > +       help
> > > +         Say Y here if you want the NULL TTY to be used as a /dev/co=
nsole
> > > +         device.
> > > +
> > > +         This is similar to CONFIG_VT_CONSOLE, but without the depen=
dency on
> > > +         CONFIG_VT. It uses the ttynull driver as the system console=
.
> >
> > Btw, do those `make nconfig` and friends render the options?
> Seems like `make nconfig` works, as well as `make xconfig` I will attempt=
 to
> attach a png screenshot.

Thanks. Have you checked the search? I believe it should work with and
without CONFIG_ in the same way.

> > >           If unsure, say N.

--=20
With Best Regards,
Andy Shevchenko
