Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34A468C23
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117651; cv=none; b=LYc8pT//GEl5PDyHSu17UbAZTFBHKeOvDpTPqE8diRE9gKaUaxHoVvmtLxtvhTvIfUE6bo/k3/52Kbv3OHcL1zg35sLBkT/yXJUdf72e2rWnU1SVjQxSquq7qCH0nshZk9rFGY9+v++X8rXdXGztq8sDp6pH/W2NnznZLb7aaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117651; c=relaxed/simple;
	bh=/dL3pCPr3MM7dPLehJhDV3xFjQwplqUCQL5XgTxif+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKIR5MidipJoYzJFNz22Bdb7N9+D7wODp0YJ2qd/vEBB0eGWbgpZMsP/IbPbn5FUtZAg84pePWZxr+3MbPud4JHIq8cCROR0D6RlXCtv+o65a9v9/2uY+5hrPbI0m2DX4b4Sai54sJD8Iip9vuL+q4PCEeL+/sIIQ3ZVMPd9hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozwuuEUQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozwuuEUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952D61F0089E
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117650;
	bh=/VGcQS0ZeRYJfc9e784tdLXi12bCcFoGI0t9ozoHPBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ozwuuEUQ8Z5se6zO5/fvu0pYLAOc5jGBs3n7Ao8KmKbvgwFVyNUnWcGSZguymLUAt
	 RVKzsVQaratM2qCL/JX11MdyergavYIT/AlSFNnuGbejufqwsbMAaHjmmUCx7QSWAX
	 gkSSivPrnNsep6lmjwegM8eFlO37g5AD3iliEMWZVSB9ellqVprjaNTpKigOOglQX4
	 A07yKT36YEPA0DyRIxKNtXe/lzyMTs9aSi5aHQJz7Dato7ohCLajMILy+cSmGin6G+
	 dg8cO5vN/lLlf3Dj3aYxfuGDuqOkh2HnLG2wOopDnvUs9h4DBtVxyeNV0hoAqF2pr+
	 wf2Osx0fo8QlA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b5e5ab03afso659232e87.3
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 02:07:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByfisTEtSvyAEEKHzC86c1D5VO3q3yibWwDUZYza+OBP8Ybbulo6Lptln6W6H7Nx3loQlot6Jh9kMF9nQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++may6VXJiAZce9Ub5tpFTo6XJ03A6MOiUc2pOkf4UEf5Cs8yALi
	WzoLjSMsdYd70XvqVt/lXZ8Ywbmza1g7BsjQVy7FHPJcxqWnmvWFRoD/bpgd/uQ3YxyLh1h8JGL
	QOZgV9LuZIuRfMUogtKtJkNmRsVVCI2o=
X-Received: by 2002:a05:6512:3054:b0:5b6:1a7c:fd99 with SMTP id
 2adb3069b0e04-5b8a0348f4fmr751726e87.63.1789117648568; Fri, 11 Sep 2026
 02:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
In-Reply-To: <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 11:07:16 +0200
X-Gmail-Original-Message-ID: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
X-Gm-Features: AcwNN1VlOYTrU3ZTl5zPPP6nearnDuFcxxJJedZ2i25yyIxB1qlTUVLyGBWuTQs
Message-ID: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:44=E2=80=AFAM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:

> Because I think it's cool that the kernel still supports actual Acorn
> hardware, I patched gcc 16.2 to restore ARMv3m support:
> https://github.com/EthanNelson-Moore/gcc-arm-retro

For the record: I also think this is cool.

One question: is ARMv3m there in Clang/LLVM? I only
know that we have ARMv4t.

To the bigger question.

The community has a built in tension around this:

- One camp that are enthusiast like yourself. That kind of people
  are running the show inside arch/m68k on Amigas and Ataris.

- One camp who get their paycheck from present day companies
  and constantly on top of the latest technology. As can be
  seen Qualcomm just taped out a brand new ARMv7 SoC
  named Kuno, for example.

As you can see this leads to a bit of tension.

What I'm after here is not one camp is doing the right thing
and the other one is not, because that inevitably boils down
to the question of what is the meaning of life. Or "what is fun"
actually (Torvalds wrote a book named "just for fun") and
either case could be argued to be quite fun, or meaningful.

> I am working on a clocksource driver, which uses both timers (to
> hopefully fix the awful time drift), and removes the dependency on
> LEGACY_TIMER_TICK.
>
> I also have patches for several cleanups to Risc PC-related code.

As SoC maintainers I think we want to hear about a plan to
migrate RiscPC to device tree should it stay supported. And I
do not think it is that hard to achieve with the right focus by the
right people.

Actually testing it on actual hardware would be a further
requirement, so we're not doing dreamscapes here.

I want to heat from Russell on this.

The ARM kernel started as a passionate project by him, on that very
machine, and he should decide if we keep it going.

IIUC the Clang/LLVM compiler has essentially solved the compiler
issue.

> I am aware that this has no actual use case, but it was fun. No LLM
> was used for any part of the work.

My position is that using LLMs is good in many ways because
when used right by the right people it allows us to keep a wider
range of hardware supported.

Yours,
Linus Walleij
