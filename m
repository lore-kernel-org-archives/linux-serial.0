From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Fix supprot for AFAVLAB 8port boards in 2.6.x
Date: Fri, 5 Mar 2004 20:38:21 +0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040305203821.D12413@flint.arm.linux.org.uk>
References: <20040305112404.GJ1105@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45324 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262695AbUCEUiZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2004 15:38:25 -0500
Content-Disposition: inline
In-Reply-To: <20040305112404.GJ1105@sunbeam.de.gnumonks.org>; from laforge@gnumonks.org on Fri, Mar 05, 2004 at 12:24:04PM +0100
List-Id: linux-serial@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-serial@vger.kernel.org

On Fri, Mar 05, 2004 at 12:24:04PM +0100, Harald Welte wrote:
> I didn't yet use one of my AFAVLAB boards with 2.6.x until now.  The
> upper 4 ports are not detected at all.  I suppose the bug was introduced
> while porting the driver from 2.4.x.

Yep, looks like I missed that subtle "bar = 4" part.  Applied, thanks.

> diff -Nru --exclude-from /sunbeam/home/laforge/scripts/dontdiff linuxppc25bh-040218-test/drivers/serial/8250_pci.c linuxppc25bh-040218-serial/drivers/serial/8250_pci.c
> --- linuxppc25bh-040218-test/drivers/serial/8250_pci.c	2004-02-16 09:44:28.000000000 +0100
> +++ linuxppc25bh-040218-serial/drivers/serial/8250_pci.c	2004-03-05 12:23:02.331325424 +0100
> @@ -141,13 +141,15 @@
>  	      struct serial_struct *req, int idx)
>  {
>  	unsigned int bar, offset = board->first_offset;
>  	
>  	bar = FL_GET_BASE(board->flags);
>  	if (idx < 4)
>  		bar += idx;
> -	else
> +	else {
> +		bar = 4;
>  		offset += (idx - 4) * board->uart_offset;
> +	}
>  
>  	return setup_port(dev, req, bar, offset, board->reg_shift);
>  }
>  

I detect patch editing here, which appears to have broken the patch (it
didn't apply.)  I've manually fixed it so you don't need to worry.

Please ensure that your patches apply and unapply cleanly to the base
kernel before sending, especially if you've edited the patch file.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
