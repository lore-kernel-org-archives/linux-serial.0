From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Mon, 9 Dec 2013 09:44:25 +0100
Message-ID: <20131209084425.GO24559@pengutronix.de>
References: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <1386321003-8960-1-git-send-email-ynvich@gmail.com>
 <20131209083815.GA5231@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131209083815.GA5231@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sergei Ianovich <ynvich@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Zhou Zhu <zzhu3@marvell.com>, Andrew Morton <akpm@linux-foundation.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Stefan Seyfried <seife+kernel@b1-systems.com>, John Crispin <blogic@openwrt.org>, Paul Bolle <pebolle@tiscali.nl>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 09, 2013 at 10:38:15AM +0200, Heikki Krogerus wrote:
> Hi,
> 
> > +	return 0;
> > +
> > + err_clk:
> > +	clk_unprepare(data->clk);
> > + err_free_clk:
> > +	devm_clk_put(&pdev->dev, data->clk);
> > + err_free:
> > +	devm_kfree(&pdev->dev, data);
> 
> And there labels could be dropped.

This should really be fixed. Explicitly releasing devm_* allocated
resources invalidates the whole idea of the devm functions. People
looking for templates shouldn't find examples for this in the kernel.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
