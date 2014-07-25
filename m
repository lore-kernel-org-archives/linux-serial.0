From: Jon Ringle <jon@ringle.org>
Subject: re: serial: sc16is7xx
Date: Fri, 25 Jul 2014 12:54:50 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1407251157450.20117@jringle-ubuntu>
References: <20140725122047.GB528@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:55991 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbaGYQzA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jul 2014 12:55:00 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so5336064qge.11
        for <linux-serial@vger.kernel.org>; Fri, 25 Jul 2014 09:54:58 -0700 (PDT)
In-Reply-To: <20140725122047.GB528@mwanda>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Ringle, Jonathan" <Jonathan.Ringle@gridpoint.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>



On Fri, 25 Jul 2014, Dan Carpenter wrote:

> Hello Jon Ringle,
> 
> The patch dfeae619d781: "serial: sc16is7xx" from Apr 24, 2014, leads
> to the following static checker warning:
> 
> 	drivers/tty/serial/sc16is7xx.c:1168 sc16is7xx_probe()
> 	warn: 's->clk' isn't an ERR_PTR
> 
> drivers/tty/serial/sc16is7xx.c
>   1167  out_clk:
>   1168          if (!IS_ERR(s->clk))
>                      ^^^^^^^^^^^^^
> This check isn't needed because we return directly but also I don't
> think we ever set s->clk so it is leaked on the remove() path as well.
> 
>   1169                  clk_disable_unprepare(s->clk);
>   1170  
>   1171          return ret;
>   1172  }

I'm not too familiar with the clk interface, but we have this code:

| static int sc16is7xx_probe(struct device *dev,
| 			   struct sc16is7xx_devtype *devtype,
| 			   struct regmap *regmap, int irq, unsigned long flags)
| {
| 	unsigned long freq, *pfreq = dev_get_platdata(dev);
| 	struct clk *clk;
| 	int i, ret;
| 	struct sc16is7xx_port *s;
| 
| 	if (IS_ERR(regmap))
| 		return PTR_ERR(regmap);
| 
| 	/* Alloc port structure */
| 	s = devm_kzalloc(dev, sizeof(*s) +
| 			 sizeof(struct sc16is7xx_one) * devtype->nr_uart,
| 			 GFP_KERNEL);
| 	if (!s) {
| 		dev_err(dev, "Error allocating port structure\n");
| 		return -ENOMEM;
| 	}
| 
| 	clk = devm_clk_get(dev, NULL);

should this be s->clk = devm_clk_get(dev, NULL); ??

| 	if (IS_ERR(clk)) {
| 		if (pfreq)
| 			freq = *pfreq;
| 		else
| 			return PTR_ERR(clk);
| 	} else {
| 		freq = clk_get_rate(clk);
| 	}

Would the above change make the clk_disable_unprepare(s->clk) then 
correct? Or should the clk member of struct sc16is7xx_port be removed?

Jon
