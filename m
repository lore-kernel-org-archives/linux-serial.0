From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
Date: Sat, 3 Mar 2018 17:56:24 +0200
Message-ID: <CAHp75Veu=0w2sWpgn0mNFa0G3Gwp2SpHv55vPgLiWjrCAzaiGw@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
 <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com> <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Aaron Durbin <adurbin@chromium.org>, Brian Norris <briannorris@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <cdall@linaro.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, Tom Saeger <tom.saeger@oracle.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 2, 2018 at 8:35 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Thu, Mar 1, 2018 at 1:02 PM Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:
>> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> > On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <
> andy.shevchenko@gmail.com>
>> > wrote:

> the UART bitclock
> is
>> > always "BASE_BAUD * 16" (1843200).  While this may be true for many
> UARTs,
>> > it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48
> MHz
>> > clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk"
> and
>> > uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>> > actually a set up in acpi_apd.c when there is an acpi match for
> "AMD0020",
>> > with a rate read from the .fixed_clk_rate param of the corresponding
>> > apd_device_desc.

> As
>> > noted above, the information is actually already in the kernel and used
> by
>> > 8250_dw - I would happy be to hear recommendations for wiring this data
>> > into earlycon that doesn't require adding another command line arg.

Brief look at the code shows that ->setup() call back is executed
after setting initial (which is hardcoded) clock.

What you need is to either create another type of earlycon for your
device with accompanied ->setup() callback, or patch 8250_early.c.

>> > I see that support was also added recently to earlycon to let it use
> ACPI
>> > SPCR to choose a console and configure its parameters... but AFAICT,
> this
>> > path also doesn't allow specifying the uart clock.

It does specify baudrate. It means it's _firmware_ responsibility to
configure UART device properly.

>> Fix your firmware then. It should set console to 115200 like (almost)
>> everyone does.
>> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.
>
> The console is 115200 when it is enabled.  However, the firmware does not
> always enable it by default.

Another firmware bug.

> The problem is that the UART IP block has a fixed 48 MHz input clock, but
> earlycon assumes this clock is always 1843200.

> I looked a bit further, and I think this patch (or something similar) is
> still required to teach generic earlycon how to handle an explicit
> port->uartclk (ie, one that is not 1843200).
> The extended string can then be explicitly set on the kernel command line
> for this kind of hardware.

No.

> In addition, we can add another patch with a new quirk detector in
> drivers/acpi/spcr.c:acpi_parse_spcr() to handle this hardware.
> acpi_parse_spcr() can then use the extended option string to pass in the
> appropriate UART clock to setup_eralycon().

Definitely no. It's not defined in SPCR spec.

> This would again allow a user to just use the simple command line parameter
> "earlycon" if the device's firmware has a correctly confiured ACPI SPCR
> table.

NAK to the patch, see above alternatives.

-- 
With Best Regards,
Andy Shevchenko
