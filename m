From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/4] tty: serial: samsung: Increase maximum baudrate
Date: Fri, 21 Dec 2018 11:23:32 +0100
Message-ID: <9be9bcd6-5b8a-da40-b232-a650eaa88d38@samsung.com>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316@eucas1p2.samsung.com>
        <20181214113410.22848-4-m.szyprowski@samsung.com>
        <20181221101553.GI13248@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221101553.GI13248@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi

On 2018-12-21 11:15, Lee Jones wrote:
> On Fri, 14 Dec 2018, Marek Szyprowski wrote:
>> From: Seung-Woo Kim <sw0312.kim@samsung.com>
>>
>> This driver can be used to communicate with Bluetooth chip in high-speed
>> UART mode, so increase the maximum baudrate to 3Mbps.
>>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> [mszyprow: rephrased commit message]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index 2a49b6d876b8..9fc3559f80d9 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -1287,7 +1287,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>>  	 * Ask the core to calculate the divisor for us.
>>  	 */
>>  
>> -	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
>> +	baud = uart_get_baud_rate(port, termios, old, 0, 3000000);
> Does that mean the low speed devices will stop working?  It looks like
> this should be dynamically configurable based on what device is
> connected to it, no?

The changed parameter is maximum supported rate, so this change doesn't
affect any low speed device.

>>  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
>>  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
>>  		quot = port->custom_divisor;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
