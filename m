From: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] uart: mediatek: support Rx in-band wakeup
Date: Mon, 27 May 2019 15:11:40 +0800
Message-ID: <CALiNf2-Z+xnz4PB1jRbzWmG_EApOXbbAGBb53Rw==B-=fv25Gg@mail.gmail.com>
References: <20190527065559.66056-1-tientzu@chromium.org>
 <20190527065559.66056-3-tientzu@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190527065559.66056-3-tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, changqi.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> @@ -572,15 +576,36 @@ static int mtk8250_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk8250_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
Sorry. This line doesn't belong to this patch. I'll send a v3.

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
