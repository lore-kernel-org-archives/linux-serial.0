From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v4 00/10] Add basic support for Socionext Milbeaut M10V
 SoC
Date: Mon, 4 Mar 2019 14:18:11 +0900
Message-ID: <e1da21a8-f369-a620-c149-521f10b7535e@socionext.com>
References: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a2oLYWR7uXcg-aL5MR0U24yk0ftoBahVuVCoq5Z3NyoAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2oLYWR7uXcg-aL5MR0U24yk0ftoBahVuVCoq5Z3NyoAA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 2019/03/01 23:34, Arnd Bergmann wrote:
> On Wed, Feb 27, 2019 at 5:51 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>>
>> Here is the series of patches the initial support for SC2000(M10V) of
>> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
>> source code.
>>
>> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
>> computer vision. It also features advanced functionalities such as 360-degree,
>> real-time spherical stitching with multi cameras, image stabilization for
>> without mechanical gimbals, and rolling shutter correction. More detail is
>> below:
>> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>>
>> Specifications for developers are below:
>>   - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>>   - NEON support
>>   - DSP
>>   - GPU
>>   - MAX 3GB DDR3
>>   - Cortex-M0 for power control
>>   - NAND Flash Interface
>>   - SD UHS-I
>>   - SD UHS-II
>>   - SDIO
>>   - USB2.0 HOST / Device
>>   - USB3.0 HOST / Device
>>   - PCI express Gen2
>>   - Ethernet Engine
>>   - I2C
>>   - UART
>>   - SPI
>>   - PWM
>>
>> Support is quite minimal for now, since it only includes timer, clock,
>> pictrl and serial controller drivers, so we can only boot to userspace
>> through initramfs. Support for the other peripherals  will come eventually.
> 
> I've merged these all into the arm/newsoc branch now, with the
> exception of the patch that Greg has already taken.
> 
> I'll do a little more build testing before that branch will be sent,
> but I expect it will be fine.
> 
>       Arnd
> 

Thanks a lot!
