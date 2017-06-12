From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 2/7] tty/serial: meson_uart: update to stable bindings
Date: Mon, 12 Jun 2017 14:48:00 +0200
Message-ID: <e540bf3c-c689-10fb-984a-c2458000cab7@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
 <1497001756-942-3-git-send-email-narmstrong@baylibre.com>
 <1497260344.3086.8.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497260344.3086.8.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: linux-kernel@vger.kernel.org, Helmut Klein <hgkr.klein@gmail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 06/12/2017 11:39 AM, Jerome Brunet wrote:
> On Fri, 2017-06-09 at 11:49 +0200, Neil Armstrong wrote:
>> From: Helmut Klein <hgkr.klein@gmail.com>
>>
>> This patch handle the stable UART bindings but also keeps compatibility
>> with the legacy non-stable bindings until all boards uses them.
>>
>> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/tty/serial/meson_uart.c | 109 +++++++++++++++++++++++++++++++++++++
>> ---
>>  1 file changed, 103 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 60f1679..d2c8136 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -579,8 +579,12 @@ static void meson_serial_early_console_write(struct
>> console *co,
>>  	device->con->write = meson_serial_early_console_write;
>>  	return 0;
>>  }
>> +/* Legacy bindings, should be removed when no more used */
>>  OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
>>  		    meson_serial_early_console_setup);
>> +/* Stable bindings */
>> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>> +		    meson_serial_early_console_setup);
>>  
>>  #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>>  #else
>> @@ -595,11 +599,95 @@ static void meson_serial_early_console_write(struct
>> console *co,
>>  	.cons		= MESON_SERIAL_CONSOLE,
>>  };
>>  
>> +/*
>> + * This function gets clocks in the legacy non-stable DT bindings.
>> + * This code will be remove once all the platforms switch to the
>> + * new DT bindings.
>> + */
>> +static int meson_uart_probe_clocks_legacy(struct platform_device *pdev,
>> +					  struct uart_port *port)
>> +{
>> +	struct clk *clk = NULL;
>> +	int ret;
>> +
>> +	clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	ret = clk_prepare_enable(clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "couldn't enable clk\n");
>> +		return ret;
>> +	}
>> +
>> +	devm_add_action_or_reset(&pdev->dev,
>> +			(void(*)(void *))clk_disable_unprepare,
>> +			clk);
>> +
>> +	port->uartclk = clk_get_rate(clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_uart_probe_clocks(struct platform_device *pdev,
>> +				   struct uart_port *port)
>> +{
>> +	struct clk *clk_xtal = NULL;
>> +	struct clk *clk_pclk = NULL;
>> +	struct clk *clk_baud = NULL;
>> +	int ret;
>> +
>> +	clk_pclk = devm_clk_get(&pdev->dev, "pclk");
>> +	if (IS_ERR(clk_pclk))
>> +		return PTR_ERR(clk_pclk);
>> +
>> +	clk_xtal = devm_clk_get(&pdev->dev, "xtal");
>> +	if (IS_ERR(clk_xtal))
>> +		return PTR_ERR(clk_xtal);
>> +
>> +	clk_baud = devm_clk_get(&pdev->dev, "baud");
>> +	if (IS_ERR(clk_xtal))
>> +		return PTR_ERR(clk_baud);
>> +
>> +	ret = clk_prepare_enable(clk_pclk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "couldn't enable pclk\n");
>> +		return ret;
>> +	}
>> +
>> +	devm_add_action_or_reset(&pdev->dev,
>> +			(void(*)(void *))clk_disable_unprepare,
>> +			clk_pclk);
>> +
>> +	ret = clk_prepare_enable(clk_xtal);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "couldn't enable xtal\n");
>> +		return ret;
>> +	}
>> +
>> +	devm_add_action_or_reset(&pdev->dev,
>> +			(void(*)(void *))clk_disable_unprepare,
>> +			clk_xtal);
>> +
>> +	ret = clk_prepare_enable(clk_baud);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "couldn't enable baud clk\n");
>> +		return ret;
>> +	}
>> +
>> +	devm_add_action_or_reset(&pdev->dev,
>> +			(void(*)(void *))clk_disable_unprepare,
>> +			clk_baud);
> 
> It's not critical but there is a lot of duplication here. Should we add an
> helper function doing "get, prepare_enable, add_reset_action" with the clock
> name as argument ?

Yep, will do.

> 
> Apart from this:
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> 
>> +
>> +	port->uartclk = clk_get_rate(clk_baud);
> 
> This was already like this, but I wonder if we should store the *clk instead of
> caching the rate. Then call get_rate when appropriate
> 
> Could be done in separate patch.

Well, this is the limit of the TTY framework, I'll leave it like this until we find
a good way to pass a context structure with the proper baud clock pointer and
don't rely anymore on the tty structure for this.

> 
>> +
>> +	return 0;
>> +}
>> +
>>  static int meson_uart_probe(struct platform_device *pdev)
>>  {
>>  	struct resource *res_mem, *res_irq;
>>  	struct uart_port *port;
>> -	struct clk *clk;
>>  	int ret = 0;
>>  
>>  	if (pdev->dev.of_node)
>> @@ -625,11 +713,15 @@ static int meson_uart_probe(struct platform_device
>> *pdev)
>>  	if (!port)
>>  		return -ENOMEM;
>>  
>> -	clk = clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(clk))
>> -		return PTR_ERR(clk);
>> +	/* Use legacy way until all platforms switch to new bindings */
>> +	if (of_device_is_compatible(pdev->dev.of_node, "amlogic,meson-uart"))
>> +		ret = meson_uart_probe_clocks_legacy(pdev, port);
>> +	else
>> +		ret = meson_uart_probe_clocks(pdev, port);
>> +
>> +	if (ret)
>> +		return ret;
>>  
>> -	port->uartclk = clk_get_rate(clk);
>>  	port->iotype = UPIO_MEM;
>>  	port->mapbase = res_mem->start;
>>  	port->irq = res_irq->start;
>> @@ -668,9 +760,14 @@ static int meson_uart_remove(struct platform_device
>> *pdev)
>>  	return 0;
>>  }
>>  
>> -
>>  static const struct of_device_id meson_uart_dt_match[] = {
>> +	/* Legacy bindings, should be removed when no more used */
>>  	{ .compatible = "amlogic,meson-uart" },
>> +	/* Stable bindings */
>> +	{ .compatible = "amlogic,meson6-uart" },
>> +	{ .compatible = "amlogic,meson8-uart" },
>> +	{ .compatible = "amlogic,meson8b-uart" },
>> +	{ .compatible = "amlogic,meson-gx-uart" },
>>  	{ /* sentinel */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
> 

Thanks,
Neil
