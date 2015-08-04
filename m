From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] serial: don't announce CIR serial ports
Date: Tue, 4 Aug 2015 02:40:01 +0200
Message-ID: <55C009E1.3090400@maciej.szmigiero.name>
References: <55BE8725.6090303@maciej.szmigiero.name>
 <20150803234012.GA31555@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803234012.GA31555@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04.08.2015 01:40, Greg Kroah-Hartman wrote:
> On Sun, Aug 02, 2015 at 11:09:57PM +0200, Maciej S. Szmigiero wrote:
>> CIR type serial ports aren't real serial ports.
>> This is just a way to prevent legacy serial driver
>> from probing and eventually binding some resources
>> so don't announce them like normal serial ports.
>>
>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>  drivers/tty/serial/serial_core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index f368520..99f944d 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -2237,7 +2237,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>>  		port->ops->config_port(port, flags);
>>  	}
>>  
>> -	if (port->type != PORT_UNKNOWN) {
>> +	if (port->type != PORT_UNKNOWN && port->type != PORT_8250_CIR) {
>>  		unsigned long flags;
>>  
>>  		uart_report_port(drv, port);
> 
> This does not seem correct, why is this type of "port" somehow special
> that it should be skiped?

PORT_8250_CIR is not an actual serial port, it is a way to tell serial driver
to not really bind to some resources (I/O port, memory range, IRQ). 

The 8250 driver does scan a few predefined locations (I/O ports on x86) to
discover legacy serial ports there.

The problem is that some of devices that shouldn't been driven by 8250 driver
implement enough of serial port interface to be identified as a serial port
(and bound to) during this scan by this driver.
This prevents their native driver from binding to them since their resources
are already taken.

When a serial port has PORT_8250_CIR type the relevant resources won't be
reserved by 8250 driver and trying to use this port will result in ENODEV or
EIO (drivers/tty/serial/8250/8250_core.c:serial8250_do_startup()
returns -ENODEV unconditionally for such type of port).

Marking port as PORT_8250_CIR type is done by 8250 PNP driver which
will do this for a some of PNP IDs
(besides marking them it also won't bind to these devices).

Currently only Winbond CIR port PNP ID is on the list,
but I have also submitted other patch to add SMSC IR port too, as it has the
same problem.

Overall, I guess the announcement purpose is for user to tell him what serial
ports he has on the system, and by extension, which ones he can use.
Since user can't really use this type of serial port it would be nice to not
announce it.
That's why I've submitted this patch.

> thanks,
> 
> greg k-h
> 

Thanks and best regards,
Maciej Szmigiero
