From: Helmut Klein <hgkr.klein@gmail.com>
Subject: Re: [PATCH v2, 3/3] tty/serial: meson_uart: add the core clock
 handling to the driver
Date: Wed, 29 Mar 2017 11:47:27 +0200
Message-ID: <a699370f-b1b9-8a0b-c998-5c0432e030a6@gmail.com>
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
 <20170328092545.4644-4-hgkr.klein@gmail.com>
 <1490728562.20764.9.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490728562.20764.9.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, gregkh@linuxfoundation.org, carlo@caione.org, khilman@baylibre.com
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 28.03.2017 21:16, Jerome Brunet wrote:
> On Tue, 2017-03-28 at 11:25 +0200, Helmut Klein wrote:
>> This patch gets the core clock as provided by the DT and enables it.
>> The code was taken from Amlogic's serial driver, and was tested on my
>> board.
>>
>> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
>> ---
>>  drivers/tty/serial/meson_uart.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 60f16795d16b..cb99112288eb 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -600,6 +600,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>>  	struct resource *res_mem, *res_irq;
>>  	struct uart_port *port;
>>  	struct clk *clk;
>> +	struct clk *core_clk;
>>  	int ret = 0;
>>
>>  	if (pdev->dev.of_node)
>> @@ -625,6 +626,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>>  	if (!port)
>>  		return -ENOMEM;
>>
>> +	core_clk = devm_clk_get(&pdev->dev, "core");
>> +	if (!IS_ERR(core_clk)) {
>> +		ret = clk_prepare_enable(core_clk);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "couldn't enable clkc\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	clk = clk_get(&pdev->dev, NULL);
> Now that you have 2 clocks, shouldn't this be named as well ?
>
if i change the call to "clk = clk_get(&pdev->dev, "xtal");", then IMHO 
i must add the
"clock-names" parameter (clock-names = "xtal") to the sections of the 2 
AO-UARTs
(uart_AO & uart_AO_B).

Is this ok?  (or is my assumption wrong?)

I'm going to add a patch meson-gx.dtsi anyway, so 2 lines more to add, 
isn't a big deal.

Helmut

>>  	if (IS_ERR(clk))
>>  		return PTR_ERR(clk);
>> --
>> 2.11.0
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>
