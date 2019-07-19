From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] lpss8250_dma_setup: there is memory leak when second
 allocation fails
Date: Sat, 20 Jul 2019 01:35:51 +0300
Message-ID: <CAHp75VcRC0XA87N=cSFJnSZ31max1UxyB=tJmE++A_+-TxGX2Q@mail.gmail.com>
References: <20190719181200.25607-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719181200.25607-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: emamd001@umn.edu, Kangjie Lu <kjlu@umn.edu>, smccaman@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jul 20, 2019 at 1:23 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> in lpss8250_dma_setup, we need to release the first dma slave object
> allocated in case of the second allocation failure.
>

This will bring a double free instead of fixing anything.

NAK.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index d07e431110d9..6e1f86db88b2 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -259,8 +259,10 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
>                 return -ENOMEM;
>
>         tx_param = devm_kzalloc(dev, sizeof(*tx_param), GFP_KERNEL);
> -       if (!tx_param)
> +       if (!tx_param) {
> +               kfree(rx_param);
>                 return -ENOMEM;
> +       }
>
>         *rx_param = lpss->dma_param;
>         dma->rxconf.src_maxburst = lpss->dma_maxburst;
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
