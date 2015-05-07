From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Thu, 07 May 2015 18:37:42 -0400
Message-ID: <554BE936.2040508@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com> <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org> <554B9F43.6000702@hurleysoftware.com> <alpine.LFD.2.11.1505071942110.1538@eddie.linux-mips.org> <554BD56D.9010800@hurleysoftware.com> <alpine.LFD.2.11.1505072241140.1538@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1505072241140.1538@eddie.linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/07/2015 06:25 PM, Maciej W. Rozycki wrote:
> On Thu, 7 May 2015, Peter Hurley wrote:
> 
>>>  How does this overload interact with multiple `console=' options being 
>>> present BTW, which one is considered the early console?  Or do we support 
>>> driving multiple early consoles in parallel just as we do with regular 
>>> consoles?
>>
>> Please familiarize yourself with the existing 'console=' and 'earlycon='
>> command line options documented in Documentation/kernel-parameters.txt
> 
>  Thank you for your suggestion, however that documentation does not answer 
> my questions I am afraid (and neither does serial-console.txt).  Otherwise
> I wouldn't have asked them in the first place.  If you don't know the 
> answers either, then it's OK to say: "I don't know".
> 
>  E.g. (given the parameter aliasing we have) will:
> 
> `earlycon=uart8250,io,0x3f8 console=tty0'
> `console=tty0 earlycon=uart8250,io,0x3f8'
> 
> do what I expect it to, that is open the UART at 0x3f8 as an early console 
> and then hand it over to the ttyS0 device as respectively a secondary and 
> the primary (/dev/console) regular console?

No.

>From Documentation/kernel-parameters.txt:

	earlycon=	[KNL] Output early console device and options.

		.....

		uart[8250],io,<addr>[,options]
		uart[8250],mmio,<addr>[,options]
		uart[8250],mmio32,<addr>[,options]
			Start an early, polled-mode console on the 8250/16550
			UART at the specified I/O port or MMIO address.
			MMIO inter-register address stride is either 8-bit
			(mmio) or 32-bit (mmio32).
			The options are the same as for ttyS, above.

IOW, command line parameters of the form:

	earlycon=uart8250,...

does not perform earlycon-to-console handoff.

Also from Documentation/kernel-parameters.txt:

	console=	[KNL] Output console device and options.

		.....

		uart[8250],io,<addr>[,options]
		uart[8250],mmio,<addr>[,options]
			Start an early, polled-mode console on the 8250/16550
			UART at the specified I/O port or MMIO address,
			switching to the matching ttyS device later.  The
			options are the same as for ttyS, above.

IOW, command line parameters of the form:

	console=uart8250,...

performs earlycon-to-console handoff.

Furthermore, because of the way aliasing was implemented in 2007,
it has been possible since to start _any_ earlycon with command line
parameters of the form:

	console=<earlycon name>,....

However, only 8250 implemented the console handoff.

Regards,
Peter Hurley
