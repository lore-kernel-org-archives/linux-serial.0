From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
Date: Thu, 01 Mar 2018 19:22:52 +0000
Message-ID: <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>, corbet@lwn.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>, cdall@linaro.org, paulmck@linux.vnet.ibm.com, marc.zyngier@arm.com, frederic@kernel.org, dwmw@amazon.co.uk, tom.saeger@oracle.com, zohar@linux.vnet.ibm.com, alexander.levin@verizon.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Thu, Mar 1, 2018 at 8:43 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> Please, hold on with new versions.
> I'm not satisfied (yet?) by the approach.

Copying over your comment on v1:

> It needs to be discussed.

Sure.

> First of all, if you are going to do this you need to add a parse of
> human readable formats (IIRC kernel has helpers), i.e. "48M", "38.4M"
> and so on.

> Next, I was under impression that purpose of earlycon (in difference
> to earlyprintk) is to re-use existing drivers as fully as possible.

> So, what exactly happens in your case? Are your driver lacks of
> properly set clock? Or earlycon does simple not utilizing this
> information?

"earlycon simply does not utilize the information".

earlycon parses iotype, mapbase and baud (from options).  However, it is
hard-coded to assume that the clock used to generate the UART bitclock is
always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
with a rate read from the .fixed_clk_rate param of the corresponding
apd_device_desc.

This patch attempts to add a way to inform earlycon about this clock.  As
noted above, the information is actually already in the kernel and used by
8250_dw - I would happy be to hear recommendations for wiring this data
into earlycon that doesn't require adding another command line arg.

I see that support was also added recently to earlycon to let it use ACPI
SPCR to choose a console and configure its parameters... but AFAICT, this
path also doesn't allow specifying the uart clock.

-Dan
