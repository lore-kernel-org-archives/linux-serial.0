From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 2/2] serial: MIPS: lantiq: make driver use pinctrl
Date: Thu, 8 Aug 2013 15:50:08 +0100
Message-ID: <5203B020.1080909@imgtec.com>
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org> <1375968687-8704-2-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:50127 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934251Ab3HHOuy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 10:50:54 -0400
In-Reply-To: <1375968687-8704-2-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>

On 08/08/13 14:31, John Crispin wrote:
> From: Thomas Langer <thomas.langer@lantiq.com>
> 
> Add use of devm_pinctrl_get_select_default to active default pinctrl settings.
> 
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Acked-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/tty/serial/lantiq.c |    7 +++++++
>  1 file changed, 7 insertions(+)


> @@ -719,6 +722,10 @@ lqasc_probe(struct platform_device *pdev)
>  	port->irq	= irqres[0].start;
>  	port->mapbase	= mmres->start;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "pins are not configured from the driver\n");

I believe since v3.9 (specifically commit ab78029) this happens
automatically.

Cheers
James

