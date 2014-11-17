From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks in pxa-ssp
Date: Mon, 17 Nov 2014 19:44:28 +0100
Message-ID: <878uj98y5v.fsf@free.fr>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
	<1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:58391 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaKQSol (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 13:44:41 -0500
In-Reply-To: <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com> (Dmitry
	Eremin-Solenikov's message of "Mon, 17 Nov 2014 18:07:41 +0300")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>, Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/usb/gadget/udc/pxa25x_udc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
> index 42f7eeb..e4964ee 100644
> --- a/drivers/usb/gadget/udc/pxa25x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa25x_udc.c
> @@ -103,8 +103,8 @@ static const char ep0name [] = "ep0";
>  
>  /* IXP doesn't yet support <linux/clk.h> */
>  #define clk_get(dev,name)	NULL
> -#define clk_enable(clk)		do { } while (0)
> -#define clk_disable(clk)	do { } while (0)
> +#define clk_prepare_enable(clk)	do { } while (0)
> +#define clk_disable_unprepare(clk)	do { } while (0)
>  #define clk_put(clk)		do { } while (0)
>  
>  #endif
> @@ -932,7 +932,7 @@ static int pullup(struct pxa25x_udc *udc)
>  		if (!udc->active) {
>  			udc->active = 1;
>  			/* Enable clock for USB device */
> -			clk_enable(udc->clk);
> +			clk_prepare_enable(udc->clk);

Guess what, Russell's remark on i2c and serial made me cross-check.  And there
is a case where this will be called in irq context too ...

See :
-> do_IRQ
  -> lubbock_vbus_irq()
    -> pxa25x_udc_vbus_session()
      -> pullup()
        -> clk_prepare_enable()
          -> CRACK

Note that your patch is not really the faulty one, I think a threaded irq
instead of the "raw" irq should do the trick. And it is granted on UDC api that
vbus function is called in a "sleeping" context (Felipe correct me if I'm
wrong), so a patch to fix this before your current code would be fine.

Cheers.

--
Robert
