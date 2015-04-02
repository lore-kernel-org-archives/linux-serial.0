From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Wed, 01 Apr 2015 23:22:07 -0400
Message-ID: <551CB5DF.1010108@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>	<1425932842-21812-12-git-send-email-peter@hurleysoftware.com> <CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Yinghai,

On 04/01/2015 10:04 PM, Yinghai Lu wrote:
> On Mon, Mar 9, 2015 at 1:27 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> setup_earlycon() will now match and register the desired earlycon
>> from the param string (as if 'earlycon=...' had been set on the
>> command line). Use setup_earlycon() from existing arch call sites
>> which start an earlycon directly.
>>
> 
> Hi,
> 
> Looks like this patcheset cause regression:
> when set grub console to 115200, and later kernel only have
> 
> console=uart8250,io,0x3f8
> 
> the kernel will revert baud rate to 9600 instead of keeping 115200.
> 
> in setup_earlycon: you say:
> 
>  *      Registers the earlycon console matching the earlycon specified
>  *      in the param string @buf. Acceptable param strings are of the form
>  *         <name>,io|mmio|mmio32,<addr>,<options>
>  *         <name>,0x<addr>,<options>
>  *         <name>,<options>
>  *         <name>
>  *
>  *      Only for the third form does the earlycon setup() method receive the
>  *      <options> string in the 'options' parameter; all other forms set
>  *      the parameter to NULL.
> 
> 
> so that change the old behavior that we defined in
> Documentation/kernel-parameters.txt
> 
>                 uart[8250],io,<addr>[,options]
>                 uart[8250],mmio,<addr>[,options]
>                 uart[8250],mmio32,<addr>[,options]
>                         Start an early, polled-mode console on the 8250/16550
>                         UART at the specified I/O port or MMIO address.
>                         MMIO inter-register address stride is either 8-bit
>                         (mmio) or 32-bit (mmio32).


>                         The options are the same as for ttyS, above.
                                      ^^^^^^^^^^^^
The documented behavior of console=ttyS options, to which your
quote refers, clearly states:

		Default is "9600n8".

> The old behavior: options is optional , and will use baud rate that is
> set by bootloader.

so the previous behavior was actually at odds with the documentation.

> Please fix the problem and restore to old behavior.

Is this really necessary (or even desirable)?
I think it's a bad idea to have one console type (ttyS) initialize its
options to default settings, but yet allow another console type (uart) to
probe the existing state.

Also, this expectation is an impediment when adding support for other
8250-like designs that don't have the same 8250 divisor registers
(ie., _every_ new design). To properly support this requirement for
just the existing 8250 hardware will require special probe_baud()
functions for: dw_8250, intel byt, intel mid, omap_8250, exar 17v35 series,
omap 1510.

Is specifying the line speed on the command line really a burden?

Regards,
Peter Hurley
