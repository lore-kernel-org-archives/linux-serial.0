From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Thu, 07 Aug 2014 14:21:54 +0100
Message-ID: <1407417714.8334.8.camel@acox1-desk.ger.corp.intel.com>
References: <1407394292-26317-1-git-send-email-matthias.bgg@gmail.com>
	 <1407394292-26317-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407394292-26317-2-git-send-email-matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, yingjoe.chen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


> +	 * Some baudrates are not supported by the chip, so we use the next
> +	 * lower rate supported and update termios c_flag.

I don't see the termios updating being done now ?

> +	data->clk = of_clk_get(np, 0);
> +	if (IS_ERR(data->clk)) {
> +		pr_warn("Can't get timer clock");
> +		return PTR_ERR(data->clk);
> +	}
> +
> +	err = clk_prepare_enable(data->clk);
> +	if (err) {
> +		pr_warn("Can't prepare clock");

and these do need a newline on them. They are also not very useful as
they don't indicate what device was involved. If you passed pdev from
mtk8250_probe you'd be able to use dev_warn instead

Otherwise looks great and exactly as 8250_core is intended to be used.

Alan


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
