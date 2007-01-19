From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Date: Fri, 19 Jan 2007 14:18:01 +0000
Message-ID: <20070119141801.GA10735@linux-mips.org>
References: <45B00F65.6000406@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <45B00F65.6000406@pmc-sierra.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 18, 2007 at 04:23:01PM -0800, Marc St-Jean wrote:

> Index: linux_2_6/drivers/serial/8250.c
> ===================================================================
> RCS file: linux_2_6/drivers/serial/8250.c,v
> retrieving revision 1.1.1.7
> retrieving revision 1.9
> diff -u -r1.1.1.7 -r1.9
> --- linux_2_6/drivers/serial/8250.c	19 Oct 2006 21:00:58 -0000	1.1.1.7
> +++ linux_2_6/drivers/serial/8250.c	19 Oct 2006 22:08:15 -0000	1.9
> @@ -44,6 +44,10 @@
>   #include <asm/io.h>
>   #include <asm/irq.h>
> 
> +#ifdef CONFIG_PMC_MSP
> +#include <msp_regs.h>
> +#endif

CONFIG_PMC_MSP is not defined anywhere.  msp_regs.h does not exist.

  Ralf
