From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date: Fri, 26 Apr 2019 18:54:05 +0200
Message-ID: <871s1og11u.fsf@haabendal.dk>
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426143946.GX9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Fri, 26 Apr 2019 17:39:46 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Apr 26, 2019 at 10:40:37AM +0200, Esben Haabendal wrote:
>> With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
>> is not possible to register a port without having
>> serial8250_request_std_resource() called.
>> 
>> For adding a 8250 port to an MFD device, this is problematic, as the
>> request_mem_region() call will fail, as the MFD device (and rightly  so)
>> has requested the region.  For this case, the 8250 port should accept
>> having passed mapbase and membase, and just use that.
>
> You need to simple set port type and use UPF_FIXED_TYPE.
> No need for this patch.

The reason for this patch is to be able to do exactly that (set port
type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.

In the current serial8250_register_8250_port() there is:

    uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;

So, even though I set UPF_FIXED_TYPE, I get
UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.  So I need this patch.

I think it is unfortunate that UPF_BOOT_AUTOCONF is or'ed to flags like
that, but changing that will surely break stuff.

/Esben

>
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 36 +++++++++++++++++++++---------------
>>  include/linux/serial_8250.h         |  2 ++
>>  2 files changed, 23 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index e441221..ddbb0a0 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -957,20 +957,8 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
>>  	spin_unlock_irqrestore(&port->lock, flags);
>>  }
>>  
>> -/**
>> - *	serial8250_register_8250_port - register a serial port
>> - *	@up: serial port template
>> - *
>> - *	Configure the serial port specified by the request. If the
>> - *	port exists and is in use, it is hung up and unregistered
>> - *	first.
>> - *
>> - *	The port is then probed and if necessary the IRQ is autodetected
>> - *	If this fails an error is returned.
>> - *
>> - *	On success the port is ready to use and the line number is returned.
>> - */
>> -int serial8250_register_8250_port(struct uart_8250_port *up)
>> +int __serial8250_register_8250_port(struct uart_8250_port *up,
>> +				    unsigned int extra_flags)
>>  {
>>  	struct uart_8250_port *uart;
>>  	int ret = -ENOSPC;
>> @@ -993,7 +981,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>>  		uart->port.fifosize     = up->port.fifosize;
>>  		uart->port.regshift     = up->port.regshift;
>>  		uart->port.iotype       = up->port.iotype;
>> -		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> +		uart->port.flags        = up->port.flags | extra_flags;
>>  		uart->bugs		= up->bugs;
>>  		uart->port.mapbase      = up->port.mapbase;
>>  		uart->port.mapsize      = up->port.mapsize;
>> @@ -1086,6 +1074,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>>  
>>  	return ret;
>>  }
>> +
>> +/**
>> + *	serial8250_register_8250_port - register a serial port
>> + *	@up: serial port template
>> + *
>> + *	Configure the serial port specified by the request. If the
>> + *	port exists and is in use, it is hung up and unregistered
>> + *	first.
>> + *
>> + *	The port is then probed and if necessary the IRQ is autodetected
>> + *	If this fails an error is returned.
>> + *
>> + *	On success the port is ready to use and the line number is returned.
>> + */
>> +int serial8250_register_8250_port(struct uart_8250_port *up)
>> +{
>> +	return __serial8250_register_8250_port(up, UPF_BOOT_AUTOCONF);
>> +}
>>  EXPORT_SYMBOL(serial8250_register_8250_port);
>>  
>>  /**
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index 5a655ba..9d1fe2e 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -145,6 +145,8 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
>>  	return container_of(up, struct uart_8250_port, port);
>>  }
>>  
>> +extern int __serial8250_register_8250_port(struct uart_8250_port *,
>> +					   unsigned int);
>>  int serial8250_register_8250_port(struct uart_8250_port *);
>>  void serial8250_unregister_port(int line);
>>  void serial8250_suspend_port(int line);
>> -- 
>> 2.4.11
>> 
