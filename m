From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH v2 05/10] serial: st-asc: Use generic DT
 binding for announcing RTS/CTS lines
Date: Wed, 1 Feb 2017 14:56:54 +0000
Message-ID: <20170201145654.GD28760@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170201143145.31962-1-lee.jones@linaro.org>
 <20170201143145.31962-6-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201143145.31962-6-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

On Wed, 01 Feb 2017, Lee Jones wrote:

> The initial binding 'st,hw-flow-control' isn't used anywhere, in neither
> in upstream nor downstream kernels.  It isn't even documented in
> dt-bindings, so we can safely assume it's safe to swap to the generic
> one.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

> ---
>  drivers/tty/serial/st-asc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index e521078..bcf1d33 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -794,7 +794,7 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
>  		return NULL;
>  
>  	asc_ports[id].hw_flow_control = of_property_read_bool(np,
> -							"st,hw-flow-control");
> +							"uart-has-rtscts");
>  	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force_m1");
>  	asc_ports[id].port.line = id;
>  	asc_ports[id].rts = NULL;
