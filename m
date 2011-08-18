From: "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Subject: RE: [PATCH 3/5] mips: msp71xx/serial: convert to pr_foo() helpers
Date: Thu, 18 Aug 2011 11:40:53 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201406358752@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com> <1313399875-11006-4-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:59315 "EHLO
	bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752349Ab1HRTIR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Aug 2011 15:08:17 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1313399875-11006-4-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org
Cc: arnd@arndb.de, Ralf Baechle <ralf@linux-mips.org>

Acked-by:  Anoop P A<Anoop_P.A@pmc-sierra.com>


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Jamie Iles
> Sent: Monday, August 15, 2011 2:48 PM
> To: linux-serial@vger.kernel.org
> Cc: arnd@arndb.de; Jamie Iles; Ralf Baechle
> Subject: [PATCH 3/5] mips: msp71xx/serial: convert to pr_foo() helpers
> 
> Convert to pr_foo() helpers rather than printk(KERN_.*).
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/mips/pmc-sierra/msp71xx/msp_serial.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
b/arch/mips/pmc-
> sierra/msp71xx/msp_serial.c
> index f726162..c3247b5 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
> @@ -65,7 +65,7 @@ void __init msp_serial_setup(void)
>  	up.line         = 0;
>  	up.private_data		= (void*)UART0_STATUS_REG;
>  	if (early_serial_setup(&up))
> -		printk(KERN_ERR "Early serial init of port 0 failed\n");
> +		pr_err("Early serial init of port 0 failed\n");
> 
>  	/* Initialize the second serial port, if one exists */
>  	switch (mips_machtype) {
> @@ -89,5 +89,5 @@ void __init msp_serial_setup(void)
>  	up.line         = 1;
>  	up.private_data		= (void*)UART1_STATUS_REG;
>  	if (early_serial_setup(&up))
> -		printk(KERN_ERR "Early serial init of port 1 failed\n");
> +		pr_err("Early serial init of port 1 failed\n");
>  }
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
linux-serial" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

