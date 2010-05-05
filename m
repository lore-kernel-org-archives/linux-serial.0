From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] serial/imx: only parse for iomem resources once
Date: Wed, 05 May 2010 14:09:26 +0400
Message-ID: <4BE143D6.5060502@ru.mvista.com>
References: <1271838838.643120.804272014834.1.gpush@pororo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:44375 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab0EEKKJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 May 2010 06:10:09 -0400
Received: by ewy22 with SMTP id 22so1429182ewy.37
        for <linux-serial@vger.kernel.org>; Wed, 05 May 2010 03:10:08 -0700 (PDT)
In-Reply-To: <1271838838.643120.804272014834.1.gpush@pororo>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

Jeremy Kerr wrote:

> Currently, the iomem resources are parsed in serial_imx_probe, then
> again in imx_request_port and imx_release_port.
>
> This change uses the imx_port data to retrieve the start and size of the
> memory region, rather than re-parsing the resources through
> platform_get_resource.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>
> ---
>  drivers/serial/imx.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index e579d7a..7de6bf7 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
>   
[...]
> @@ -1245,6 +1238,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	sport->port.dev = &pdev->dev;
>  	sport->port.mapbase = res->start;
>  	sport->port.membase = base;
> +	sport->mapsize = res->end - res->start + 1;
>   

   There's resource_size() for this calculation.

WBR, Sergei

