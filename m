From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Hilscher NetX mach-netx refactorings
Date: Sun, 13 Jan 2019 23:39:42 +0100
Message-ID: <CACRpkdbHTi9=x7-_uEYWggfxt4jNUm3JhXy=AqarW3B11d=XKg@mail.gmail.com>
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
 <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
 <20190113155047.GA12829@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190113155047.GA12829@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Robert Schwebel <r.schwebel@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Olof Johansson <olof@lixom.net>, github@hilscher.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 13, 2019 at 4:50 PM Ladislav Michl <ladis@linux-mips.org> wrote:
> On Sun, Jan 13, 2019 at 01:14:36PM +0100, Linus Walleij wrote:

> > > On a related note, there does appear to be active work on
> > > newer netx machines that were never upstreamed, see
> > > https://github.com/Hilscher/netx4000-linux/commits/v4.9-netx4000-stable
> >
> > That RS485 addition to PL011 using GPIOs is a bit hacky but
> > looks like very useful for industrial applications.
> > Ladislav, have you been in contact with Hilscher?
>
> I guess I appeared on Cc list because of commit 797537a45450 ("amba-pl011:
> Add RS485 support (ioctl and devicetree)") from above github repo which
> is based on my hack originaly done for rPi3 as I got tired of all those
> experts implementing 'drive enable' in userspace. That's broken by design
> and works only by accident.

I suppose it is one of those GPIO hacks in userspace. Yeah that makes
the GPIO maintainer very unhappy I can tell you that :/

> But as I'm also considering every single
> device running from SD card broken by design - it was perfect match ;-)

Ha ha ;)

> But seriously, it is indeed needed for industrial applications and
> should be done a bit better - I mean regarding those delays in interrupt
> context.

I suppose this thing is a bit of an oddity since the PL011
does have an RTS signal, but in this case (for reasons such
as hardware doesn't do the right thing, or the hardware engineer
didn't care do make it possible to get the RTS line out of the
chip, or the board engineer didn't think of it) a GPIO is used
for RTS instead. So what the patch does is add that as an
option.

There are DT bindings for RTS (etc):
Documentation/devicetree/bindings/serial/serial.txt

I think that GPIO support code could be implemented using
the library in:
drivers/tty/serial/serial_mctrl_gpio.c

This makes it possible to handle any extra "modem control"
pins using GPIO. I think it is fine to just look for RTS if that is all
that's needed. Possibly those extra delay settings could be
added in mctrl and added as generic DT bindings as well.
(I'm not smart enough to tell if that is possible.)

Sorry for the sidetrack.

Yours,
Linus Walleij
