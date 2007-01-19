From: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Subject: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast er
Date: Fri, 19 Jan 2007 10:40:40 -0800
Message-ID: <5C1FD43E5F1B824E83985A74F396286E03AD762A@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mother.pmc-sierra.com ([216.241.224.12]:56865 "HELO
	mother.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964813AbXASSkx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Jan 2007 13:40:53 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Ralf Baechle' <ralf@linux-mips.org>
Cc: "'linux-serial@vger.kernel.org'" <linux-serial@vger.kernel.org>



> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org]
> Sent: Friday, January 19, 2007 8:18 AM
> To: Marc St-Jean
> Cc: linux-mips@linux-mips.org; linux-serial@vger.kernel.org
> Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git 
> master
> 
> On Thu, Jan 18, 2007 at 04:23:01PM -0800, Marc St-Jean wrote:
> 
> > Index: linux_2_6/drivers/serial/8250.c 
> > ===================================================================
> > RCS file: linux_2_6/drivers/serial/8250.c,v retrieving revision
> > 1.1.1.7 retrieving revision 1.9 diff -u -r1.1.1.7 -r1.9
> > --- linux_2_6/drivers/serial/8250.c	19 Oct 2006 21:00:58 
> -0000	1.1.1.7
> > +++ linux_2_6/drivers/serial/8250.c	19 Oct 2006 22:08:15 
> -0000	1.9
> > @@ -44,6 +44,10 @@
> >   #include <asm/io.h>
> >   #include <asm/irq.h>
> > 
> > +#ifdef CONFIG_PMC_MSP
> > +#include <msp_regs.h>
> > +#endif
> 
> CONFIG_PMC_MSP is not defined anywhere.  msp_regs.h does not exist.
> 
>   Ralf
> 

Hi Ralf,

CONFIG_PMC_MSP is defined in the main platform patch (arch/mips/Kconfig). I doesn't apply against the git HEAD yet. I'm still working on it and will post as soon as it does.

msp_regs.h defines the UART0_STATUS_REG and UART1_STATUS_REG SoC addresses for the DesignWare UART. I thought of putting them in include/linux/serial_reg.h but it contains register offsets only, no platform addresses.

That is one of the main issues, how to add MSP71xx specific register mapping without platform tests/includes?

Marc
