From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 5/6] serial: imx: update the stop rx,tx procedures
Date: Thu, 21 Sep 2017 20:28:17 +0200
Message-ID: <20170921182817.wejxqp5e733systb@pengutronix.de>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
 <1506010697-22114-6-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506010697-22114-6-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 21, 2017 at 05:18:16PM +0100, Martyn Welch wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> According to "Documentation/serial/driver" both procedures should stop
> receiving or sending data. Based on this the procedures should stop the
> activity regardless if DMA is enabled or not.
> 
> This commit updates both imx_stop_{rx|tx} procedures to stop the
> activity and disable the interrupts related to that.
> 
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index ed02783..256b128 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -388,15 +388,14 @@ static void imx_stop_tx(struct uart_port *port)
>  	struct imx_port *sport = (struct imx_port *)port;
>  	unsigned long temp;
>  
> -	/*
> -	 * We are maybe in the SMP context, so if the DMA TX thread is running
> -	 * on other cpu, we have to wait for it to finish.
> -	 */

did you understand this comment you're removing here? I admit I don't
but unless it is non-sensical you're doing something wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
