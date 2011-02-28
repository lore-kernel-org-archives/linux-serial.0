From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5 v3] tty: serial: altera_jtaguart: Add device tree
 support
Date: Mon, 28 Feb 2011 01:26:22 -0700
Message-ID: <20110228082622.GD13690@angua.secretlab.ca>
References: <c28550ba11ed228f4137ced1ab34761c08ad38ad.1297974227.git.tklauser@distanz.ch>
 <1298016601-19111-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63529 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab1B1I00 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Feb 2011 03:26:26 -0500
Received: by iwn34 with SMTP id 34so2886757iwn.19
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2011 00:26:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298016601-19111-1-git-send-email-tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nios2-dev@sopc.et.ntust.edu.tw

On Fri, Feb 18, 2011 at 09:10:01AM +0100, Tobias Klauser wrote:
> Advertise the possibility to use this driver with device tree if
> CONFIG_OF is set.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks.

g.

> ---
> v3:
>  - put device tree binding documentation in the correct place (thanks Grant
>    Likely)
> v2:
>  - add missing semicolon after definition of altera_jtaguart_match
> 
>  .../devicetree/bindings/serial/altera_jtaguart.txt |    4 ++++
>  drivers/tty/serial/altera_jtaguart.c               |   15 +++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/altera_jtaguart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/altera_jtaguart.txt b/Documentation/devicetree/bindings/serial/altera_jtaguart.txt
> new file mode 100644
> index 0000000..c152f65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/altera_jtaguart.txt
> @@ -0,0 +1,4 @@
> +Altera JTAG UART
> +
> +Required properties:
> +- compatible : should be "ALTR,juart-1.0"
> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> index 8f014bb..60e049b 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -466,12 +466,23 @@ static int __devexit altera_jtaguart_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id altera_jtaguart_match[] = {
> +	{ .compatible = "ALTR,juart-1.0", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
> +#else
> +#define altera_jtaguart_match NULL
> +#endif /* CONFIG_OF */
> +
>  static struct platform_driver altera_jtaguart_platform_driver = {
>  	.probe	= altera_jtaguart_probe,
>  	.remove	= __devexit_p(altera_jtaguart_remove),
>  	.driver	= {
> -		.name	= DRV_NAME,
> -		.owner	= THIS_MODULE,
> +		.name		= DRV_NAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= altera_jtaguart_match,
>  	},
>  };
>  
> -- 
> 1.7.0.4
> 
