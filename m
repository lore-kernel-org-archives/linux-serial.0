From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 00/10] Add basic support for Socionext Milbeaut M10V SoC
Date: Fri, 1 Mar 2019 15:34:34 +0100
Message-ID: <CAK8P3a2oLYWR7uXcg-aL5MR0U24yk0ftoBahVuVCoq5Z3NyoAA@mail.gmail.com>
References: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 27, 2019 at 5:51 AM Sugaya Taichi
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

I've merged these all into the arm/newsoc branch now, with the
exception of the patch that Greg has already taken.

I'll do a little more build testing before that branch will be sent,
but I expect it will be fine.

     Arnd
