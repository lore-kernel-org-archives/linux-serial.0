From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
Date: Fri, 02 Mar 2018 18:35:35 +0000
Message-ID: <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com> <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <cdall@linaro.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, marc.zyngier@arm.com, frederic@kernel.org, dwmw@amazon.co.uk, tom.saeger@oracle.com, zohar@linux.vnet.ibm.com, alexander.levin@verizon.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 1, 2018 at 1:02 PM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <
andy.shevchenko@gmail.com>
> > wrote:

> > "earlycon simply does not utilize the information".
> >
> > earlycon parses iotype, mapbase and baud (from options).  However, it is
> > hard-coded to assume that the clock used to generate the UART bitclock
is
> > always "BASE_BAUD * 16" (1843200).  While this may be true for many
UARTs,
> > it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48
MHz
> > clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk"
and
> > uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
> > actually a set up in acpi_apd.c when there is an acpi match for
"AMD0020",
> > with a rate read from the .fixed_clk_rate param of the corresponding
> > apd_device_desc.
> >
> > This patch attempts to add a way to inform earlycon about this clock.
As
> > noted above, the information is actually already in the kernel and used
by
> > 8250_dw - I would happy be to hear recommendations for wiring this data
> > into earlycon that doesn't require adding another command line arg.

> And it should not require that for sure!

> I would look to this later. It's late here. I need to do a bit of
> research for the answer.

> > I see that support was also added recently to earlycon to let it use
ACPI
> > SPCR to choose a console and configure its parameters... but AFAICT,
this
> > path also doesn't allow specifying the uart clock.

> Fix your firmware then. It should set console to 115200 like (almost)
> everyone does.
> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.

The console is 115200 when it is enabled.  However, the firmware does not
always enable it by default.
The problem is that the UART IP block has a fixed 48 MHz input clock, but
earlycon assumes this clock is always 1843200.

I looked a bit further, and I think this patch (or something similar) is
still required to teach generic earlycon how to handle an explicit
port->uartclk (ie, one that is not 1843200).
The extended string can then be explicitly set on the kernel command line
for this kind of hardware.

In addition, we can add another patch with a new quirk detector in
drivers/acpi/spcr.c:acpi_parse_spcr() to handle this hardware.
acpi_parse_spcr() can then use the extended option string to pass in the
appropriate UART clock to setup_eralycon().

This would again allow a user to just use the simple command line parameter
"earlycon" if the device's firmware has a correctly confiured ACPI SPCR
table.

Thanks,
-Dan
