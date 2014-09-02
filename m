From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Tue, 2 Sep 2014 12:35:30 +0100
Message-ID: <20140902113530.GC7241@leverpostej>
References: <1407852737-17265-1-git-send-email-matthias.bgg@gmail.com>
 <1407852737-17265-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44442 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbaIBLfc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 07:35:32 -0400
Content-Disposition: inline
In-Reply-To: <1407852737-17265-2-git-send-email-matthias.bgg@gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "varkabhadram@gmail.com" <varkabhadram@gmail.com>, "tklauser@distanz.ch" <tklauser@distanz.ch>, "heiko@sntech.de" <heiko@sntech.de>, "yingjoe.chen@gmail.com" <yingjoe.chen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

[...]

> +static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
> +			   struct mtk8250_data *data)
> +{
> +	int err;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	data->clk = of_clk_get(np, 0);
> +	if (IS_ERR(data->clk)) {
> +		dev_warn(&pdev->dev, "Can't get timer clock\n");
> +		return PTR_ERR(data->clk);
> +	}

Elsewhere you use devm_ interfaces. Can we not use devm_clk_get?

You might need to give the clock a name, but that's generally a good
thing -- it helps if a future revision has multiple clocks.

Mark.
