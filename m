From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Wed, 1 Apr 2015 19:04:55 -0700
Message-ID: <CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
	<1425932842-21812-12-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425932842-21812-12-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 9, 2015 at 1:27 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> setup_earlycon() will now match and register the desired earlycon
> from the param string (as if 'earlycon=...' had been set on the
> command line). Use setup_earlycon() from existing arch call sites
> which start an earlycon directly.
>

Hi,

Looks like this patcheset cause regression:
when set grub console to 115200, and later kernel only have

console=uart8250,io,0x3f8

the kernel will revert baud rate to 9600 instead of keeping 115200.

in setup_earlycon: you say:

 *      Registers the earlycon console matching the earlycon specified
 *      in the param string @buf. Acceptable param strings are of the form
 *         <name>,io|mmio|mmio32,<addr>,<options>
 *         <name>,0x<addr>,<options>
 *         <name>,<options>
 *         <name>
 *
 *      Only for the third form does the earlycon setup() method receive the
 *      <options> string in the 'options' parameter; all other forms set
 *      the parameter to NULL.


so that change the old behavior that we defined in
Documentation/kernel-parameters.txt

                uart[8250],io,<addr>[,options]
                uart[8250],mmio,<addr>[,options]
                uart[8250],mmio32,<addr>[,options]
                        Start an early, polled-mode console on the 8250/16550
                        UART at the specified I/O port or MMIO address.
                        MMIO inter-register address stride is either 8-bit
                        (mmio) or 32-bit (mmio32).
                        The options are the same as for ttyS, above.

The old behavior: options is optional , and will use baud rate that is
set by bootloader.

Please fix the problem and restore to old behavior.

Thanks

Yinghai
