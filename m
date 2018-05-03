From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] tty: implement a rx led trigger
Date: Thu, 3 May 2018 13:33:10 +0100
Message-ID: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 03/05/18 11:04, Uwe Kleine-König wrote:
[...]
> @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>   
>   	tty_port_link_device(port, driver, index);
>   
> +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (!port->led_trigger_rx_name) {
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +		goto skip_trigger;

Hmm, isn't that a rather awkward way to spell "else"? ;)

Robin.

> +	}
> +
> +	led_trigger_register_simple(port->led_trigger_rx_name,
> +				    &port->led_trigger_rx);
> +
> +skip_trigger:
>   	dev = serdev_tty_port_register(port, device, driver, index);
>   	if (PTR_ERR(dev) != -ENODEV) {
>   		/* Skip creating cdev if we registered a serdev device */
