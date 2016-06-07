From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: fix definition of msm_stop_dma
Date: Tue, 7 Jun 2016 13:00:41 -0700
Message-ID: <20160607200041.GJ1256@tuxbot>
References: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, David Brown <david.brown@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue 07 Jun 11:11 PDT 2016, Ben Dooks wrote:

> The msm_stop_dma() is not exported from the driver, so make
> it static to stop the following warning:
> 
> drivers/tty/serial/msm_serial.c:84:6: warning: symbol 'msm_stop_dma' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/tty/serial/msm_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index b7d80bd..187f2c0 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -81,7 +81,7 @@ struct msm_port {
>  static void msm_handle_tx(struct uart_port *port);
>  static void msm_start_rx_dma(struct msm_port *msm_port);
>  
> -void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
> +static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
>  {
>  	struct device *dev = port->dev;
>  	unsigned int mapped;
> -- 
> 2.8.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
