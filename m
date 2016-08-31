From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Wed, 31 Aug 2016 16:00:36 +0200
Message-ID: <20160831140036.GC13298@kroah.com>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 04, 2016 at 05:34:12PM +0200, Uwe Kleine-K=F6nig wrote:
> Add support for two led triggers per UART instance that blink on
> transmission and reception of data respectively.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 621e488cbb12..2b6ba3b8bdd5 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -39,6 +39,7 @@
>  #include <linux/of_device.h>
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/leds.h>
>  =

>  #include <asm/irq.h>
>  #include <linux/platform_data/serial-imx.h>
> @@ -227,6 +228,8 @@ struct imx_port {
>  	wait_queue_head_t	dma_wait;
>  	unsigned int            saved_reg[10];
>  	bool			context_saved;
> +	struct led_trigger	led_trigger_rx;
> +	struct led_trigger	led_trigger_tx;
>  };
>  =

>  struct imx_port_ucrs {
> @@ -293,6 +296,10 @@ static inline int is_imx6q_uart(struct imx_port *spo=
rt)
>  {
>  	return sport->devdata->devtype =3D=3D IMX6Q_UART;
>  }
> +
> +static unsigned long led_delay =3D 50;
> +module_param(led_delay, ulong, 0644);

I hate module parameters, and so should you, this isn't the 1990's
anymore :(

And I'm with Arnd, let's make this work for all tty drivers that want to
use it please.

thanks,

greg k-h
