From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 9/9] serial: 8250_dw: Use devm_request_and_ioremap()
Date: Thu, 11 Apr 2013 15:20:54 +0300
Message-ID: <20130411122053.GA2982@xps8300>
References: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1365602312-25436-10-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63184 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934711Ab3DKMU7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Apr 2013 08:20:59 -0400
Content-Disposition: inline
In-Reply-To: <1365602312-25436-10-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi,

I need to redo this patch.

On Wed, Apr 10, 2013 at 04:58:32PM +0300, Heikki Krogerus wrote:
> Use resource managed ioremap.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index b7c7d6a..bf2a6e2 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -250,7 +250,7 @@ static int dw8250_probe(struct platform_device *pdev)
>  	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
>  	uart.port.dev = &pdev->dev;
>  
> -	uart.port.membase = ioremap(regs->start, resource_size(regs));
> +	uart.port.membase = devm_request_and_ioremap(&pdev->dev, regs);

There is now function devm_ioremap_resource() that should be preferred
over devm_request_and_ioremap(), but I will change this to use
devm_ioremap(). There is no need to request the mem region here.

-- 
heikki
