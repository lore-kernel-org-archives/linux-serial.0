From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH] serial: Add Milbeaut serial control
Date: Wed, 27 Mar 2019 18:39:13 +0900
Message-ID: <875480bf-42d1-1c88-1dc7-4895e15cb87f@socionext.com>
References: <1553591536-3760-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0Sx5vxbserW27KMPYnpLabPkGJZ_2iuW9y082oHiO+aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0Sx5vxbserW27KMPYnpLabPkGJZ_2iuW9y082oHiO+aQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi

Thank you for your comments.

On 2019/03/26 18:57, Arnd Bergmann wrote:
> On Tue, Mar 26, 2019 at 10:13 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 72966bc..961519b 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1582,6 +1582,32 @@ config SERIAL_RDA_CONSOLE
>>            Say 'Y' here if you wish to use the RDA8810PL UART as the system
>>            console. Only earlycon is implemented currently.
>>
>> +config SERIAL_MILBEAUT_USIO
>> +       tristate "Milbeaut USIO/UART serial port support"
>> +       depends on ARCH_MILBEAUT
>> +       default y
>> +       select SERIAL_CORE
>> +       help
>> +         This selects the USIO/UART IP found in Socionext Milbeaut SoCs.
> 
> In general, it would be good to make it possible to build this on
> other architectures for better compile test coverage, e.g. like
> 
> config SERIAL_MILBEAUT_USIO
>       tristate "Milbeaut USIO/UART serial port support"
>       depends on ARCH_MILBEAUT || COMPILE_TEST
>       default ARCH_MILBEAUT
> 
All right.
I agree with the style.

> You might need additional dependencies like 'depends on OF'
> to make this work reliably.
> 
I got it.
I think the way is inserting "depends on OF" as a new line.

Thanks,
Sugaya Taichi


>          Arnd
> 
