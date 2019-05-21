From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] uart: mediatek: support Rx in-band wakeup
Date: Tue, 21 May 2019 17:44:10 +0800
Message-ID: <CANMq1KAa6mOFJdhdXjV73wE8et8Cj+W-b73w=1kPaxmS6iimow@mail.gmail.com>
References: <20190521084701.100179-1-tientzu@chromium.org>
 <20190521084701.100179-3-tientzu@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190521084701.100179-3-tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, changqi.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 4:47 PM Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> In order to support Rx in-band wakeup, we need to enable irq wake on an
> edge sensitive interrupt of Rx pin before suspend and disable it when
> resuming.
>
> This interrupt is used only as wake source to resume the system when
> suspended. Note that the sent character will be lost as the controller is
> actually suspended.
>
> We use this to support wakeup on bluetooth. Bluetooth will repeatedly send
> 0xFD to wakeup host. Once host detects Rx falling, an interrupt is
> triggered, and the system leaves sleep state. Then, the bluetooth driver
> will send 0xFC to bluetooth and bluetooth can start to send normal HCI
> packets.
>
> Signed-off-by: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 417c7c810df9..61892abf707d 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
> @@ -70,6 +71,7 @@ struct mtk8250_data {
>  #ifdef CONFIG_SERIAL_8250_DMA
>         enum dma_rx_status      rx_status;
>  #endif
> +       int                     rx_wakeup_irq;
>  };
>
>  /* flow control mode */
> @@ -551,6 +553,8 @@ static int mtk8250_probe(struct platform_device *pdev)
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
>
> +       data->rx_wakeup_irq = platform_get_irq(pdev, 1);
> +
>         return 0;
>  }
>
> @@ -572,15 +576,44 @@ static int mtk8250_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk8250_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
> +       int irq = data->rx_wakeup_irq;
> +       int err;
>
>         serial8250_suspend_port(data->line);
>
> +       pinctrl_pm_select_sleep_state(dev);
> +       if (irq >= 0) {
> +               err = enable_irq_wake(irq);
> +               if (err) {
> +                       dev_err(dev,
> +                               "failed to enable irq wake on IRQ %d: %d\n",
> +                               irq, err);
> +                       pinctrl_pm_select_default_state(dev);
> +                       serial8250_resume_port(data->line);
> +                       return err;
> +               }
> +       }
> +
>         return 0;
>  }
>
>  static int __maybe_unused mtk8250_resume(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       int irq = data->rx_wakeup_irq;
> +       int err;
> +
> +       if (irq >= 0) {
> +               err = disable_irq_wake(irq);
> +               if (err) {
> +                       dev_err(dev,
> +                               "failed to disable irq wake on IRQ %d: %d\n",
> +                               irq, err);
> +                       return err;

I'd drop this return err in the resume path, still better to restore
the pinctrl and resume the port, even if we can't disable the irq_wake
(which, really, shouldn't happen if we could enable it earlier...).

Also, many other callers of disable_irq_wake just ignore the return
value, so maybe it's ok to do the same, but I'll let other people
comment.

> +               }
> +       }
> +       pinctrl_pm_select_default_state(dev);
>
>         serial8250_resume_port(data->line);
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
