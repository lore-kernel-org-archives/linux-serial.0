From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Check the data->pclk when get apb_pclk
Date: Thu, 25 Aug 2016 16:10:12 +0300
Message-ID: <1472130612.4887.304.camel@linux.intel.com>
References: <1472027613-6337-1-git-send-email-wangkefeng.wang@huawei.com>
         <1472129758.4887.303.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472129758.4887.303.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, guohanjun@huawei.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-08-25 at 15:55 +0300, Andy Shevchenko wrote:
> On Wed, 2016-08-24 at 16:33 +0800, Kefeng Wang wrote:
> > 
> > It should check the data->pclk, not data->clk when get apb_pclk.
> > 
> > Fixes: c8ed99d4f6a8("serial: 8250_dw: Add support for deferred
> > probing")
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> pclk is optional on Intel platforms. With your patch we always will
> get
> EPROBE_DEFER that obviously breaks things.

Ah, sorry, it was another culprit.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> > 
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c
> > b/drivers/tty/serial/8250/8250_dw.c
> > index e199696..b022f5a 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -462,7 +462,7 @@ static int dw8250_probe(struct platform_device
> > *pdev)
> >  	}
> >  
> >  	data->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
> > -	if (IS_ERR(data->clk) && PTR_ERR(data->clk) ==
> > -EPROBE_DEFER)
> > {
> > +	if (IS_ERR(data->pclk) && PTR_ERR(data->pclk) ==
> > -EPROBE_DEFER) {
> >  		err = -EPROBE_DEFER;
> >  		goto err_clk;
> >  	}
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
