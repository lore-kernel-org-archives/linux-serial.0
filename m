From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 3/4] tty/serial: meson_uart: add the core clock
 handling to the driver
Date: Mon, 3 Apr 2017 08:31:37 -0700
Message-ID: <CAOi56cWW4CxwQ=JYaJHp_kpj=fr6Tvj5jzYKTdeGec0Drx3fLw@mail.gmail.com>
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
 <20170331165437.26227-4-hgkr.klein@gmail.com>
 <1491231478.3480.12.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1491231478.3480.12.camel@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Helmut Klein <hgkr.klein@gmail.com>, linux-serial <linux-serial@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic <linux-amlogic@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 3, 2017 at 7:57 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Fri, 2017-03-31 at 18:54 +0200, Helmut Klein wrote:
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
>>       struct resource *res_mem, *res_irq;
>>       struct uart_port *port;
>>       struct clk *clk;
>> +     struct clk *core_clk;
>>       int ret = 0;
>>
>>       if (pdev->dev.of_node)
>> @@ -625,6 +626,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>>       if (!port)
>>               return -ENOMEM;
>>
>> +     core_clk = devm_clk_get(&pdev->dev, "core");
>> +     if (!IS_ERR(core_clk)) {
>> +             ret = clk_prepare_enable(core_clk);
>
> This needs to be balanced with a clk_disable_unprepare() in remove.
>
> You could try play with devm_add_action_or_reset, maybe like this:
>
> devm_add_action_or_reset(dev,
>                         (void(*)(void *))clk_disable_unprepare,
>                         core_clk);
>
> Sorry I did not notice it on the v2.
>
>
>> +             if (ret) {
>> +                     dev_err(&pdev->dev, "couldn't enable clkc\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>>       clk = clk_get(&pdev->dev, NULL);
>
> I still think you should name this one. Otherwise, what the non AO UART will get
> here will depends on the order it was declared in DT.

Unfortunately, it has to be even a little more complicated.

This driver will need to work with current DT (no clock-names) as well
as newer DT using clock-names for "core" and "xtal".  So, you'll have
to first try for "xtal" here, and if it fails, then try NULL.

> To answer your question from the v2, yes I think it is ok to add clock-names to
> the AO-UART. You are doing it for non AO ones so, why not ?

Agreed.   And another good reason the driver needs to handle with and
without clock-names.

Kevin
