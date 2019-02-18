From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V SoC
Date: Mon, 18 Feb 2019 13:20:42 +0100
Message-ID: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 8, 2019 at 1:24 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
>
> Here is the series of patches the initial support for SC2000(M10V) of
> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
> source code.
>
> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
> computer vision. It also features advanced functionalities such as 360-degree,
> real-time spherical stitching with multi cameras, image stabilization for
> without mechanical gimbals, and rolling shutter correction. More detail is
> below:
> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>
> Specifications for developers are below:
>  - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>  - NEON support
>  - DSP
>  - GPU
>  - MAX 3GB DDR3
>  - Cortex-M0 for power control
>  - NAND Flash Interface
>  - SD UHS-I
>  - SD UHS-II
>  - SDIO
>  - USB2.0 HOST / Device
>  - USB3.0 HOST / Device
>  - PCI express Gen2
>  - Ethernet Engine
>  - I2C
>  - UART
>  - SPI
>  - PWM
>
> Support is quite minimal for now, since it only includes timer, clock,
> pictrl and serial controller drivers, so we can only boot to userspace
> through initramfs. Support for the other peripherals  will come eventually.

I've looked over the platform once more. Overall, it looks very good, and
I'd still like to merge this for linux-5.1, but we are running out of time
there. If you send the patches to soc@kernel.org quickly, we can try to
still merge them in, but if anything goes wrong, it will have to wait until
we start merging patches for 5.2, directly after 5.1 is out.

I did not look at the device driver patches (clk, clocksource, pinctrl, serial)
in much detail. If you have an Ack from the maintainers, feel free to
include them in the series, otherwise let's merge the rest now and then
you can send the updated patches for inclusion through the subsystem
trees in 5.2.

I have sent a few comments. The only one that is really important
here is the missing platform check in the suspend options. Please
try to address most of the other commentsm, either by changing the
code, or by explaining why your version is correct.



     Arnd
