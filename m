From: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Subject: Re: [MIPS] Preliminary patch for ip32 ttyS* device
Date: Fri, 07 Dec 2007 14:08:39 +0100
Message-ID: <1197032919.8322.2.camel@scarafaggio>
References: <1196860832.19779.21.camel@scarafaggio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host93-214-dynamic.20-79-r.retail.telecomitalia.it ([79.20.214.93]:60364
	"EHLO eppesuigoccas.homedns.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658AbXLGOTK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Dec 2007 09:19:10 -0500
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J0dTx-00020m-Kl
	for linux-serial@vger.kernel.org; Fri, 07 Dec 2007 14:43:11 +0100
In-Reply-To: <1196860832.19779.21.camel@scarafaggio>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,
I don't even know if anyone is reading this mailing list :-(
but I really need a reply on this subject.
Is there any comment on this patch?

Thanks again,
Giuseppe

Il giorno mer, 05/12/2007 alle 14.20 +0100, Giuseppe Sacco ha scritto:
> Hi all,
> serial device on SGI O2 (mips64) is broken since 2.6.23. I proposed this
> patch on October on the linux-mips lists, and I tried to get a better
> patch. I would like to know if you think the change to
> drivers/serial/serial_core.c are correct or not.
> 
> Basically the problem is that we can setup membase but we cannot setup
> mapbase, so our 8250 uart seems to be unused by uart_match_port().
> 
> Any comments?
> 
> Thanks,
> Giuseppe
> 
> ---
> diff --git a/arch/mips/sgi-ip32/ip32-platform.c
> b/arch/mips/sgi-ip32/ip32-platform.c
> index 7309e48..77febd6 100644
> --- a/arch/mips/sgi-ip32/ip32-platform.c
> +++ b/arch/mips/sgi-ip32/ip32-platform.c
> @@ -42,7 +42,7 @@ static struct platform_device uart8250_device = {
>  static int __init uart8250_init(void)
>  {
>         uart8250_data[0].membase = (void __iomem *) &mace->isa.serial1;
> -       uart8250_data[1].membase = (void __iomem *) &mace->isa.serial1;
> +       uart8250_data[1].membase = (void __iomem *) &mace->isa.serial2;
>  
>         return platform_device_register(&uart8250_device);
>  }
> diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> index 3bb5d24..7caa877 100644
> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -2455,6 +2455,8 @@ int uart_match_port(struct uart_port *port1,
> struct uart_port *port2)
>         case UPIO_AU:
>         case UPIO_TSI:
>         case UPIO_DWAPB:
> +               if (port1->mapbase==0 && port2->mapbase==0)
> +                       return (port1->membase == port2->membase);
>                 return (port1->mapbase == port2->mapbase);
>         }
>         return 0;


