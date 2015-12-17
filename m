From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Thu, 17 Dec 2015 09:21:43 -0800
Message-ID: <20151217172143.GA20049@kroah.com>
References: <5672D18E.8000301@laposte.net>
 <5672E2CF.6080705@hurleysoftware.com>
 <5672E76A.3010506@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5672E76A.3010506@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 17, 2015 at 05:48:42PM +0100, Sebastian Frias wrote:
> On 12/17/2015 05:29 PM, Peter Hurley wrote:
> >On 12/17/2015 07:15 AM, Sebastian Frias wrote:
> >>---
> >>
> >>I think there are a few minor bugs on the 8250 UART code.
> >>
> >>Below you can find a patch with a proposed solution.
> >>
> >>In a nutshell:
> >>- probe_baud from 87515772c33ee8a0cc08d984a7d2401eeff074cd was
> >>converted into probe_port so that it reads all the parameters that
> >>uart_set_options require (namely baud, parity, bits, flow).
> >>- reading/writing to UART_DLL/UART_DLM directly are converted to
> >>using the read_dl/write_dl callbacks.
> >>- the port is always probed if there are no options (*).
> >
> >Because I don't want to probe the port at all.
> >
> >But must when using the
> >	earlycon=ttyS0,....
> >
> >command-line (because the original hack expects that behavior).
> 
> Ok, we are using:
> 
> "console=ttyS0 earlyprintk"
> 
> and the 8250 (with CONFIG_SERIAL_8250_RT288X=y) driver.
> 
> The hardware is setup prior to Linux boot.
> We don't want Linux to change the UART settings, just to pick up whatever
> settings the UART has and take over UART.

Don't do that :)
Linux can't "know" what happened before it started to the hardware and
expect to work properly.

> How do you suggest we do that? Right now, since it does not probe, it just
> messes up the UART config setup before booting Linux.

pass in the same settings as you previously set up, that way there is no
change.

thanks,

greg k-h
