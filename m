From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed the
 kernel will hung up
Date: Fri, 6 Mar 2015 19:01:57 -0800
Message-ID: <CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>
References: <54F96F5B.2090601@huawei.com>
	<54F9DACA.3020103@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F9DACA.3020103@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tim Kryger <tim.kryger@linaro.org>, gregkh@linuxfoundation.org, jamie@jamieiles.com, alan@linux.intel.com, arnd@arndb.de, shenjiangjiang@huawei.com, long.wanglong@huawei.com
List-Id: linux-serial@vger.kernel.org

You only hit the silicon bug if you bombard the uart with characters
and simultaneously request a baud rate or framing change.

I'm not sure why you would do either to the uart console.  Is it
possible your host machine is doing something weird?

If you have the leverage, remind the SoC vendor to upgrade the serial
block.  Synopsys fixed this a long time ago.

-Tim

On Fri, Mar 6, 2015 at 8:50 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi Zhang,
>
> On 03/06/2015 04:11 AM, Zhang Zhen wrote:
>> Hi,
>>
>>       I'm testing 4.0-rc1 kernel on my board with 8250 Designware UART.(ARM Cortex-a15 single core).
>>
>>       I found if serial is busy and writes to the LCR failed after tried 1000 times.
>>       The kernel will hung up.
>>
>>       The system boot success after changed from:
>>
>>  95 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
>>  96 {
>>  97         struct dw8250_data *d = p->private_data;
>>  98
>> ...
>> ...
>> 112                         writeb(value, p->membase + (UART_LCR << p->regshift));
>> 113                 }
>> 114                 dev_err(p->dev, "Couldn't set LCR to %d\n", value);
>> 115         }
>> 116 }
>>
>>       to:
>>
>>  95 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
>>  96 {
>>  97         struct dw8250_data *d = p->private_data;
>>  98
>> ...
>> ...
>> 112                         writeb(value, p->membase + (UART_LCR << p->regshift));
>> 113                 }
>> 114                 dev_info(p->dev, "Couldn't set LCR to %d\n", value);            //changed here
>> 115         }
>> 116 }
>>
>>       The reason is serial8250_console_write can't get port->lock because serial8250_do_set_termios has
>>       got port->lock.
>>       So i think here we should change from dev_err to dev_info ?
>
> That's not really going to help because this will still hang if the
> console_loglevel is set to < KERN_INFO.
>
>>       Any suggestions are welcome.
>
> Check that the port is not the uart_console() before logging the error,
> like;
>
>         if (!uart_console(p))
>                 dev_err(p->dev, "Couldn't .....");
>
> Use a global flag to note the error and check it from other contexts.
> Plus, find out why you can't write LCR there.
>
> Also, consider re-designing how the 8250_dw driver implements that
> "feature".
>
> Regards,
> Peter Hurley
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
