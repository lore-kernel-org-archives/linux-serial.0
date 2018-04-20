From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Fri, 20 Apr 2018 08:13:16 +0200
Message-ID: <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Chris,

On Fri, Apr 20, 2018 at 09:07:59AM +0800, Chris Ruehl wrote:
> Fix a problem introduced with
> commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
> result in non dte-mode imx-uart fail receive data.
> By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 91f3a1a..3d09933 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
>  
>  		ucr3 = imx_uart_readl(sport, UCR3);
>  
> -		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
> +		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>  
>  		if (sport->dte_mode)
>  			/* disable broken interrupts */

Doesn't 6df765dca378bddf994cfd2044acafa501bd800f fix this for you?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
