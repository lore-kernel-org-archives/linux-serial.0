From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/22] serial: 8250_dw: Add optional reset control support
Date: Fri, 23 May 2014 10:19:47 +0200
Message-ID: <8689536.mXHvcWVbGA@wuerfel>
References: <1400831485-28576-1-git-send-email-wens@csie.org> <1400831485-28576-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62311 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaEWIUB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 May 2014 04:20:01 -0400
In-Reply-To: <1400831485-28576-2-git-send-email-wens@csie.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wens@csie.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org

On Friday 23 May 2014 15:51:04 Chen-Yu Tsai wrote:
>                 p->regshift = val;
>  
> +       data->rst = devm_reset_control_get_optional(p->dev, NULL);
> +
>         /* clock got configured through clk api, all done */
>         if (p->uartclk)
>                 return 0;
> @@ -362,6 +366,9 @@ static int dw8250_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>  
> +       if (!IS_ERR_OR_NULL(data->rst))
> +               reset_control_deassert(data->rst);
> +

You should basically never use IS_ERR_OR_NULL(). devm_reset_control_get_optional()
doesn't return NULL, so IS_ERR() should be safe.

Alternatively, change the code above to set data->rst to NULL if there
is no reset line or error out if you get a different error (e.g. EPROBE_DEFER).

	Arnd
