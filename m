From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH] msm_serial: add missing iounmap() on error in
 msm_request_port()
Date: Wed, 17 Jul 2013 14:28:42 +0300
Message-ID: <1374060522.2657.30.camel@iivanov-dev>
References: <CAPgLHd_LGRtkqcPbm=snHOsFOzX6vfafw3EnZtcJmDGCHKHq=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPgLHd_LGRtkqcPbm=snHOsFOzX6vfafw3EnZtcJmDGCHKHq=Q@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2013-07-17 at 13:34 +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing iounmap() before return from msm_request_port()
> in the error handling case.
> 

Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Regards,
Ivan


> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/tty/serial/msm_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 2c6cfb3..0b38b28 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -637,7 +637,7 @@ static int msm_request_port(struct uart_port *port)
>  		if (!request_mem_region(gsbi_resource->start, size,
>  						 "msm_serial")) {
>  			ret = -EBUSY;
> -			goto fail_release_port;
> +			goto fail_release_port_membase;
>  		}
>  
>  		msm_port->gsbi_base = ioremap(gsbi_resource->start, size);
> @@ -651,6 +651,8 @@ static int msm_request_port(struct uart_port *port)
>  
>  fail_release_gsbi:
>  	release_mem_region(gsbi_resource->start, size);
> +fail_release_port_membase:
> +	iounmap(port->membase);
>  fail_release_port:
>  	release_mem_region(port->mapbase, size);
>  	return ret;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
