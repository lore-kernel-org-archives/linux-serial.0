From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: earlycon: no match?
Date: Thu, 7 May 2015 23:25:23 +0100 (BST)
Message-ID: <alpine.LFD.2.11.1505072241140.1538@eddie.linux-mips.org>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com>
 <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org> <554B9F43.6000702@hurleysoftware.com> <alpine.LFD.2.11.1505071942110.1538@eddie.linux-mips.org> <554BD56D.9010800@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554BD56D.9010800@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Thu, 7 May 2015, Peter Hurley wrote:

> >  How does this overload interact with multiple `console=' options being 
> > present BTW, which one is considered the early console?  Or do we support 
> > driving multiple early consoles in parallel just as we do with regular 
> > consoles?
> 
> Please familiarize yourself with the existing 'console=' and 'earlycon='
> command line options documented in Documentation/kernel-parameters.txt

 Thank you for your suggestion, however that documentation does not answer 
my questions I am afraid (and neither does serial-console.txt).  Otherwise
I wouldn't have asked them in the first place.  If you don't know the 
answers either, then it's OK to say: "I don't know".

 E.g. (given the parameter aliasing we have) will:

`earlycon=uart8250,io,0x3f8 console=tty0'
`console=tty0 earlycon=uart8250,io,0x3f8'

do what I expect it to, that is open the UART at 0x3f8 as an early console 
and then hand it over to the ttyS0 device as respectively a secondary and 
the primary (/dev/console) regular console?  I've skipped options such as 
baud rates for brevity.

  Maciej
