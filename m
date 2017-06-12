From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 2/7] tty/serial: meson_uart: update to stable bindings
Date: Mon, 12 Jun 2017 14:48:17 +0200
Message-ID: <4512095a-f4b7-54c4-520e-2ae65c04c361@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
 <1497001756-942-3-git-send-email-narmstrong@baylibre.com>
 <5096bbb9-aa11-ad9b-139e-e056463d1a1d@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5096bbb9-aa11-ad9b-139e-e056463d1a1d@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Moore <moore@free.fr>, gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: linux-kernel@vger.kernel.org, Helmut Klein <hgkr.klein@gmail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 06/12/2017 02:45 PM, Chris Moore wrote:
> Le 09/06/2017 à 11:49, Neil Armstrong a écrit :
>> From: Helmut Klein <hgkr.klein@gmail.com>
>>
>> This patch handle the stable UART bindings but also keeps compatibility
>> with the legacy non-stable bindings until all boards uses them.
>>
>> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 109 +++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 103 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 60f1679..d2c8136 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
> 
> [snip]
> 
>> +static int meson_uart_probe_clocks(struct platform_device *pdev,
>> +                   struct uart_port *port)
>> +{
>> +    struct clk *clk_xtal = NULL;
>> +    struct clk *clk_pclk = NULL;
>> +    struct clk *clk_baud = NULL;
>> +    int ret;
>> +
>> +    clk_pclk = devm_clk_get(&pdev->dev, "pclk");
>> +    if (IS_ERR(clk_pclk))
>> +        return PTR_ERR(clk_pclk);
>> +
>> +    clk_xtal = devm_clk_get(&pdev->dev, "xtal");
>> +    if (IS_ERR(clk_xtal))
>> +        return PTR_ERR(clk_xtal);
>> +
>> +    clk_baud = devm_clk_get(&pdev->dev, "baud");
>> +    if (IS_ERR(clk_xtal))
> 
> Copy/paste error: s/clk_xtal/clk_baud/
> 
>> +        return PTR_ERR(clk_baud);
> 

Good catch,
Thanks !
Neil
