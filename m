From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: sysfs: wait for GPIO interrupt
Date: Fri, 23 May 2014 14:29:56 +0200
Message-ID: <CACRpkdaDdsJx8FNQ0D-_bmKkSDjjGaO81C+Wzx6tfkZ9053CSw@mail.gmail.com>
References: <CAGm1_kuKvjAguez85MKWk+gw5T4-oa8thHEao6Rz0nES-woYiA@mail.gmail.com>
	<CABxcv=k7QTiNWNbHTLFKkjHdgk9o9xB4E4uq75wuKyvXYhqWMQ@mail.gmail.com>
	<CACRpkdZU+P_8NK_YX6aqcp5WtbAzgv7V73Uzj0_RxAQaQgaDzg@mail.gmail.com>
	<CAGm1_kuZGs0=hzPwUs7aC34PQVn7pL2r7V_rdbwXAtwCHxXBkA@mail.gmail.com>
	<CABxcv=m8go203DcdAy6kdQm0=vOo9TxFSKKdt1bwDMbW_72W-g@mail.gmail.com>
	<CACRpkdZcDQPKxehZkPjeJ5yGsHPs_xvDu0Mn5UgE-azCi4m=-Q@mail.gmail.com>
	<CABxcv=nev4vuD9VAwZvcZJX9VXJa5czeF=8Zr1yaVV=oa5GZ8w@mail.gmail.com>
	<CAGm1_kuLPC__09jEJyVmjNyYOEygZCz5nNF5aTPO=WMA55xg+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAGm1_kuLPC__09jEJyVmjNyYOEygZCz5nNF5aTPO=WMA55xg+A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Grant Likely <grant.likely@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux GPIO List <linux-gpio@vger.kernel.org>, jack@embed.me.uk
List-Id: linux-serial@vger.kernel.org

On Mon, May 19, 2014 at 12:54 PM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:

>> It would be nice if Yegor can give more details about the device tha=
t
>> are using those GPIO and what he wants to achieve from user-space to
>> see if an existing device driver can be used or in any case if a
>> generic driver can be written like is done for GPIO leds, keys, etc.
>
> Let's take VScom Alekto 2 (http://www.visionsystems.de/produkte/6820.=
html).

This seems like a quite straight-forward single-board computer not
much unlike e.g. the BeagleBoard or similar.

> It has a combi RS232/422/485 driver IC, that has 4 configuration
> inputs to set one of the desired modes.

Do you mean it can configure the pins into one of
these four modes:

RS232: TxD,RxD, RTS,CTS, DTR,DSR, DCD, RI, GND
RS422: Tx+/-, Rx+/-, GND
RS485 2=E2=88=92wire: Data+/-, GND
RS485 4=E2=88=92wire: Tx+/-, Rx+/-, GND

> These pins are connected via
> GPIOs (SoC GPIOs or i2c GPIO expander doesn't matter). The user can
> configure these option at run-time.

But the above, if I understand correctly are by definition NOT GPIO
at *all*.

GPIO means "general purpose input output", i.e. something that
can emit low/high signals (GPIO out) or read them (GPIO in).

This looks much more like 9 pins that can be configured into
one of four mission modes, corresponding to one of four
serial port types, and that is pin multiplexing not GPIO.

> Now he can make it via sysfs by
> exporting these GPIOs, setting them to output and changing their
> values. What would be the proper kernel driver/interface for this
> purpose.

Something or other in the TTY/serial layer which may have
special features for configuring this from user space.
I'm not an expert on that part of the kernel so ask around on
the linux-serial list.

If there needs to be a pin control driver inbetween dealing
with just the registers handling the multiplexing of pins,
then surely the serial layer can use that, but that sounds very
complex for this usecase.

I think the serial subsystem would be handling this?

> It also has an IO connector with configurable inputs and outputs. The
> problem here it has somewhat complicated structure, because you can
> switch direction of the IO pins but this involves enabling/disabling
> some hardware ICs.

This is quite common and straight-forward GPIO. If we have the
datasheet of how to actually program the hardware we can
say more about how this should be done.

> The whole mechanism is  hidden from user through a
> library, but the library itself is still using sysfs.

Not a sysfs and library designed by the kernel community
I suspect?

> As for simple designs where the direction of the pins is fixed the
> keys driver can be used for inputs, what were the proper driver for
> outputs (relays etc.)?

Relays is actually one of those cases when userspace control
over GPIOs make a lot of sense. We certainly cannot have a
kernel driver for every factory line in the world for example.

But I want to identify and isolate such use cases. Very often
input, leds, PWM etc is what is actually desired.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
