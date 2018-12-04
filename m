From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Tue, 4 Dec 2018 20:03:53 +0900
Message-ID: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, sugaya.taichi@socionext.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette <mturquette@baylibre.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Stephen,


On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > Add Milbeaut M10V clock ( including PLL ) control.
>
> Please give some more details here.
>
> >
> > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > ---
> >  drivers/clk/Makefile   |   1 +
> >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
>
> And this is different from Uniphier? Maybe we need a socionext
> directory under drivers/clk/.



This is always a difficult question,
and I do not have a strong opinion.


I am fine with moving the files to drivers/clk/socionext
although no file would be shared.


FYI

UniPhier and Milbeaut are completely different platforms
developed/maintained by different teams.

They happen to live in the same company now
just because Socionext merged the LSI business from Panasonic and Fujitsu.

UniPhier originates in Panasonic, while Milbeaut in Fujitsu.


Thanks.




--
Best Regards
Masahiro Yamada
