From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] serial: 8250: enable UART_BUG_NOMSR for Tegra
Date: Wed, 15 Jan 2014 10:30:05 -0700
Message-ID: <52D6C59D.4070402@wwwdotorg.org>
References: <1389132012-2257-1-git-send-email-swarren@wwwdotorg.org> <20140115111205.GA11732@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140115111205.GA11732@xps8300>
Sender: stable-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, olof@lixom.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/15/2014 04:12 AM, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Jan 07, 2014 at 03:00:12PM -0700, Stephen Warren wrote:
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index e33d38cb170f..61ecd709a722 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -2670,6 +2670,10 @@ static void serial8250_config_port(struct uart_port *port, int flags)
>>  	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
>>  		up->bugs |= UART_BUG_NOMSR;
>>  
>> +	/* HW bugs may trigger IRQ while IIR == NO_INT */
>> +	if (port->type == PORT_TEGRA)
>> +		up->bugs |= UART_BUG_NOMSR;
>> +
> 
> Is there any reason this needs to be in 8250_core.c? Why not set it in
> drivers/tty/serial/of_serial.c?

I imagine the code could go in either place.

I don't see any advantage moving it to of_serial.c, and it'd actively be
a disadvantage as far as I'm concerned; PORT_TEGRA is defined in 8250.c,
and other code which enable the same UART_BUG_NOMSR flag is in exactly
the same place, which keeps similar code co-located.
