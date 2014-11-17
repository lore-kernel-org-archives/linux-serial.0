From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 2/5] i2c: pxa: prepare/unprepare clocks
Date: Mon, 17 Nov 2014 15:51:07 +0000
Message-ID: <20141117155107.GU4042@n2100.arm.linux.org.uk>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43345 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751834AbaKQPvb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 10:51:31 -0500
Content-Disposition: inline
In-Reply-To: <1416236863-20898-2-git-send-email-dbaryshkov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Mon, Nov 17, 2014 at 06:07:40PM +0300, Dmitry Eremin-Solenikov wrote:
> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..2e75375 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1297,7 +1297,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
>  
> -	clk_disable(i2c->clk);
> +	clk_disable_unprepare(i2c->clk);

Since clk_unprepare() and clk_prepare() can sleep, it is unwise to call
these with IRQs disabled - the _noirq variants of these are run with
IRQs disabled.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
