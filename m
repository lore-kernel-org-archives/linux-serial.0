From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] tty/serial: atmel_serial: fix compilation
Date: Fri, 28 Oct 2011 14:38:09 +0200
Message-ID: <4EAAA231.1020601@atmel.com>
References: <1319801631-14654-1-git-send-email-svens@stackframe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1319801631-14654-1-git-send-email-svens-yWSVVCS59A8YeIxN5WHPnw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Sven Schnelle <svens-yWSVVCS59A8YeIxN5WHPnw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 10/28/2011 01:33 PM, Sven Schnelle :
> If CONFIG_OF is disabled, compilation fails with:
> 
> drivers/tty/serial/atmel_serial.c: In function 'atmel_serial_probe':
> drivers/tty/serial/atmel_serial.c:1788: error: implicit declaration of function 'of_alias_get_id'
> 
> Fix this by adding the proper CONFIG_OF checks.

Yes, but I would like to avoid this and I have made a patch to address
this issue. I have sent it to the device tree guys yesterday:
"[PATCH] dt: add empty of_alias_get_id() for non-dt builds"

Maybe we can wait a little and see if it reaches Linus' tree on time. If
it is not, I will make sure that such a fix make it to mainline.

Best regards,

> Signed-off-by: Sven Schnelle <svens-yWSVVCS59A8YeIxN5WHPnw@public.gmane.org>
> ---
>  drivers/tty/serial/atmel_serial.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 4a0f86f..de338dd 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1777,16 +1777,20 @@ static int atmel_serial_resume(struct platform_device *pdev)
>  static int __devinit atmel_serial_probe(struct platform_device *pdev)
>  {
>  	struct atmel_uart_port *port;
> +#ifdef CONFIG_OF
>  	struct device_node *np = pdev->dev.of_node;
> +#endif
>  	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>  	void *data;
>  	int ret = -ENODEV;
>  
>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>  
> +#ifdef CONFIG_OF
>  	if (np)
>  		ret = of_alias_get_id(np, "serial");
>  	else
> +#endif
>  		if (pdata)
>  			ret = pdata->num;
>  


-- 
Nicolas Ferre
