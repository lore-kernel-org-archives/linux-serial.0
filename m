From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH 1/4] Documentation: dt: serial: Add TX FIFO load size
Date: Fri, 16 Sep 2016 15:47:41 -0500
Message-ID: <51b9cf7c-7989-b541-4eb1-9a38dc175284@opensource.altera.com>
References: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
 <1473351141-9239-2-git-send-email-tthayer@opensource.altera.com>
 <20160916191908.GA30710@rob-hp-laptop>
Reply-To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160916191908.GA30710@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, anton.wuerfel-d40JDW7QUjc@public.gmane.org, phillip.raffeck-d40JDW7QUjc@public.gmane.org, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, dongsheng.wang-3arQi8VN3Tc@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On 09/16/2016 02:19 PM, Rob Herring wrote:
> On Thu, Sep 08, 2016 at 11:12:18AM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>>
>> Add the device tree bindings needed to support the TX FIFO
>> load size.
>>
>> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/serial/8250.txt |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
>> index f5561ac..93de5ef 100644
>> --- a/Documentation/devicetree/bindings/serial/8250.txt
>> +++ b/Documentation/devicetree/bindings/serial/8250.txt
>> @@ -45,6 +45,7 @@ Optional properties:
>>  - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
>>    line respectively. It will use specified GPIO instead of the peripheral
>>    function pin for the UART feature. If unsure, don't specify this property.
>> +- tx-loadsz: the number of bytes that can be loaded into the TX FIFO.
>
> It seems you don't really need to know the loadsz, but just need the
> threshold trigger level. So just use that directly. And please check if
> any other UARTs have threshold properties. i.MX has programmable
> thresholds.
>
> Rob
>

Yes, it is correct that I only really need the loadsz, but there is a 
tx-loadsz parameter in the uart_8250_port structure. Since there 
currently isn't a way to update the default value of tx-loadsz from 
device tree, I thought this would be useful for other 8250 UARTs as well.

Yes, there are a couple of 8250 compatible UARTs that have programmable 
thresholds. The SC16654 and SC16C650 are 2 examples. However, I didn't 
see the programmable TX threshold implemented.

I looked at the i.MX UARTs but I don't see a programmable threshold 
parameter in the bindings( 
Documentation/devicetree/bindings/serial/fsl-imx-uart.txt).

I'm assuming you're saying that I should use the same binding names for 
this transmit threshold if they are available?

Thank you for reviewing and for the comments.

Thor


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
