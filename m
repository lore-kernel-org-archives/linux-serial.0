From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] tty: serial: 8250_mtk: Use devm_clk_get
Date: Fri, 24 Apr 2015 12:31:51 +0200
Message-ID: <20150424103151.GP6325@pengutronix.de>
References: <1429779066-21406-1-git-send-email-s.hauer@pengutronix.de>
 <1429779066-21406-2-git-send-email-s.hauer@pengutronix.de>
 <CABuKBe+bACg_5uDQc3BF4BaBUG1-CQ3mH199o3nMsaMfH3ad3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABuKBe+bACg_5uDQc3BF4BaBUG1-CQ3mH199o3nMsaMfH3ad3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 24, 2015 at 12:28:33PM +0200, Matthias Brugger wrote:
> 2015-04-23 10:51 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > Just because of_clk_get() doesn't mean it should be used. Use devm_clk_get
> > which is the correct function when a struct device * is available. Also
> > since it's a devm function we can drop the calls to clk_put(). While at
> > it also fix a wrong debug message.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/tty/serial/8250/8250_mtk.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > index 7a11fac..c6901dc 100644
> > --- a/drivers/tty/serial/8250/8250_mtk.c
> > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > @@ -131,18 +131,16 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
> >                            struct mtk8250_data *data)
> >  {
> >         int err;
> > -       struct device_node *np = pdev->dev.of_node;
> >
> > -       data->uart_clk = of_clk_get(np, 0);
> > +       data->uart_clk = devm_clk_get(&pdev->dev, NULL);
> >         if (IS_ERR(data->uart_clk)) {
> > -               dev_warn(&pdev->dev, "Can't get timer clock\n");
> > +               dev_warn(&pdev->dev, "Can't get uart clock\n");
> >                 return PTR_ERR(data->uart_clk);
> >         }
> >
> >         err = clk_prepare_enable(data->uart_clk);
> >         if (err) {
> >                 dev_warn(&pdev->dev, "Can't prepare clock\n");
> > -               clk_put(data->uart_clk);
> >                 return err;
> >         }
> >         p->uartclk = clk_get_rate(data->uart_clk);
> > @@ -216,7 +214,6 @@ static int mtk8250_remove(struct platform_device *pdev)
> >         serial8250_unregister_port(data->line);
> >         if (!IS_ERR(data->uart_clk)) {
> >                 clk_disable_unprepare(data->uart_clk);
> > -               clk_put(data->uart_clk);
> >         }
> 
> Please delete the braces.

The if() is removed completly in the next patch anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
