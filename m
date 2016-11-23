From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Wed, 23 Nov 2016 10:57:13 -0800
Message-ID: <e9fc12b8-d4a7-067d-ef87-03f0aae39bd7@gmail.com>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123100106.15969-2-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/23/2016 02:01 AM, Sascha Hauer wrote:
> With this patch the serial core provides LED triggers for RX and TX.
> 
> As the serial core layer does not know when the hardware actually sends
> or receives characters, this needs help from the UART drivers.

Looking at 8250, we call serial8250_tx_chars from __start_tx which is
called form the uart_ops::start_tx, for RX I sort of agree, since this
happens in interrupt handler. I suppose some drivers could actually
queue work but not do it right away though?

> The LED triggers are registered in uart_add_led_triggers() called from
> the UART drivers which want to support LED triggers. All the driver
> has to do then is to call uart_led_trigger_[tx|rx] to indicate
> activity.

Could we somehow remedy the lack of knowledge from the core as whether
the HW sends/receives characters first before adding support for LED
triggers? It would be more generic and future proof to require UART
drivers to report to the core when they actually TX/RX, and then at the
core level, utilize that knowledge to perform the LED trigger.

Side note: are you positive using drv->dev_name is robust enough on
systems with many different UART drivers, yet all of them being ttyS*?

Thanks!
-- 
Florian
