From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Tue, 04 Dec 2018 10:14:08 -0800
Message-ID: <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: sugaya.taichi@socionext.com, DTML <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Quoting Masahiro Yamada (2018-12-04 03:03:53)
> Hi Stephen,
> =

> =

> On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > > Add Milbeaut M10V clock ( including PLL ) control.
> >
> > Please give some more details here.
> >
> > >
> > > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > > ---
> > >  drivers/clk/Makefile   |   1 +
> > >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++=
++++++++++
> >
> > And this is different from Uniphier? Maybe we need a socionext
> > directory under drivers/clk/.
> =

> =

> =

> This is always a difficult question,
> and I do not have a strong opinion.
> =

> =

> I am fine with moving the files to drivers/clk/socionext
> although no file would be shared.
> =

> =

> FYI
> =

> UniPhier and Milbeaut are completely different platforms
> developed/maintained by different teams.
> =

> They happen to live in the same company now
> just because Socionext merged the LSI business from Panasonic and Fujitsu.
> =

> UniPhier originates in Panasonic, while Milbeaut in Fujitsu.
> =


Thanks for the background info. I'd prefer to defer to however the dts
files are getting split up into directories. If they're all put under
arch/arm64/boot/dts/socionext/ then I would say combine the two clk
drivers into a socionext directory. Otherwise, keep them split out.
