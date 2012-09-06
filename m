From: Tomas Hlavacek <tmshlvck@gmail.com>
Subject: Re: [PATCH v6] uartclk value from serial_core exposed to sysfs
Date: Thu, 6 Sep 2012 20:39:12 +0200
Message-ID: <CAEB7QLAWLuXFLWMYX70enP5X0z5EXTNo93hfOm7sH_kQteMAkA@mail.gmail.com>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
	<1346894238-12870-1-git-send-email-tmshlvck@gmail.com>
	<5048E35F.5020304@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5048E35F.5020304@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com
List-Id: linux-serial@vger.kernel.org

Hi Jiri,

On Thu, Sep 6, 2012 at 7:54 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 09/06/2012 03:17 AM, Tomas Hlavacek wrote:
>> @@ -2362,8 +2392,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>>        * Register the port whether it's detected or not.  This allows
>>        * setserial to be used to alter this ports parameters.
>>        */
>> -     tty_dev = tty_port_register_device(port, drv->tty_driver, uport->line,
>> -                     uport->dev);
>> +     tty_dev = tty_register_device_attr(drv->tty_driver, uport->line,
>> +                     uport->dev, port, tty_dev_attr_groups);
>
> This makes me believe you have not tested the change at all?

Thanks! I can't believe I missed that. (And I actually tested that,
but I have to admit that it was not enough apparently.)

I will re-send the patch (after some additional testing and double-checking).

Tomas
