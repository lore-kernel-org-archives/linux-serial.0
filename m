From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 2/2] serial: earlycon: allow to specify uartclk in
 earlycon kernel-parameter
Date: Wed, 21 Oct 2015 08:27:23 -0400
Message-ID: <562784AB.4040709@hurleysoftware.com>
References: <1445312189-28876-1-git-send-email-yamada.masahiro@socionext.com>
 <1445312189-28876-3-git-send-email-yamada.masahiro@socionext.com>
 <5626491A.8040908@hurleysoftware.com>
 <CAK7LNAQYbg4L9dX4riQ8Zb_NN7pbhx60aXwb4rZJgdTz-pocsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQYbg4L9dX4riQ8Zb_NN7pbhx60aXwb4rZJgdTz-pocsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, Stefan Agner <stefan@agner.ch>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 10/20/2015 09:20 PM, Masahiro Yamada wrote:
> Hi Peter,
> (+ Rob Herring, Stefan Agner)
> 
> 2015-10-20 23:00 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
>> On 10/19/2015 11:36 PM, Masahiro Yamada wrote:
>>> The input clock frequency varies from device to device, but the
>>> earlycon uses the fixed frequency (BASE_BAUD * 16).  It makes
>>> impossible to set the correct divisor to the register.
>>
>> So the bootloader hasn't setup the serial port?
> 
> It does.
> I use U-boot and the serial port is already set up by U-boot.
> 
> 
> But, earlycon setup functions update hardware registers.
> See  early_serial8250_setup(), ingenic_early_console_setup(), etc.
> 
> 
> Without port->uartclk set to a valid value,
> the init code in earlycon setup does not make sense.
> 
> 
> What I want to clarify is,
> what should we do in the earlycon setup function?
> 
> Currently, I see
>  [1] set device->con->write callback
>  [2] initialize UART port registers
> 
> 
> For [2], we need to know baudrate and input clock frequency.
> (and the latter is missing, that's why my patch is here.)
> 
> 
> In order to be independent of a boot loader, we also need
>   [3]  pinctrl (pin-muxing)
> 
> But, it is difficult to handle pinctrl in the earlycon framework.
> 
> 
> If we depend on a boot loader, [2] is meaningless.   [1] is enough.

The 8250 earlycon doesn't try to initialize the hardware (other than
masking interrupts) if the baud rate is uninitialized
(!device->baud in early_serial8250_setup()).

Rather than initializing the h/w to a default of 115200 in
ingenic_early_console_setup() when device->baud == 0, it should just
mask interrupts. That way the bootloader initialization will be
preserved when the options are unspecified on the command line, such as:

	earlycon=jz4740_uart,mmio32,0x43fb0000


Regards,
Peter Hurley

PS - Apologies for not reviewing the Ingenic 8250 driver at submission
time.
