From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] serial: sh-sci: Missing uart_unregister_driver() on
 error in sci_probe_single()
Date: Mon, 11 Mar 2019 10:22:01 +0300
Message-ID: <20190311072201.GA2434@kadam>
References: <20190308142310.112914-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308142310.112914-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 08, 2019 at 10:23:10PM +0800, Mao Wenan wrote:
> Add the missing uart_unregister_driver() before return
> from sci_probe_single() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/tty/serial/sh-sci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 64bbeb7d7e0c..dde4eac9d222 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3254,8 +3254,10 @@ static int sci_probe_single(struct platform_device *dev,
>  	mutex_unlock(&sci_uart_registration_lock);
>  
>  	ret = sci_init_single(dev, sciport, index, p, false);
> -	if (ret)
> +	if (ret) {
> +		uart_unregister_driver(&sci_uart_driver);
>  		return ret;

Why only this error path and not the next one?

> +	}
>  
>  	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>  	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
            ^^^^^^^^^^^^^^^^^^^^^
This one.

regards,
dan carpenter
