From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 6/8] serial: 8250: Copy mctrl when register port.
Date: Wed, 6 Jun 2018 16:44:13 +0200
Message-ID: <c89a403a-b9cf-821f-ccaf-6afb63368a10@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-7-giulio.benetti@micronovasrl.com>
 <1533624932.66943.1528295462220.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533624932.66943.1528295462220.JavaMail.zimbra@xes-inc.com>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Aaron,

Il 06/06/2018 16:31, Aaron Sierra ha scritto:
> ----- Original Message -----
>> From: "Giulio Benetti" <giulio.benetti@micronovasrl.com>
>> Sent: Friday, June 1, 2018 7:40:19 AM
> 
>> RS485 can modify mctrl on startup, especially when RTS_AFTER_SEND is on
>> TIOCM_RTS is set, then need to keep it set when registering port.
>>
>> Copy mctrl to new port too.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>> drivers/tty/serial/8250/8250_core.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c
>> b/drivers/tty/serial/8250/8250_core.c
>> index c8c2b260c681..c8e62fbd6570 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -993,6 +993,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>> 		uart->port.unthrottle	= up->port.unthrottle;
>> 		uart->port.rs485_config	= up->port.rs485_config;
>> 		uart->port.rs485	= up->port.rs485;
>> +		uart->port.mctrl	= up->port.mctrl;
> 
> Hi Guilio,
> 
> I ran into this same thing about six months ago, but I was able to
> accomplish what I needed by assigning a set_mctrl() function in my
> port definition. Perhaps that would be enough for your case, too?

Thanks for pointing me.
But wouldn't it be better copying mctrl?
In any case, serial8250_register_8250_port() will call:
- uart_add_one_port()
- uart_configure_port()
- port->ops->set_mctrl(port, mctrl);

So it would be a double call IMHO.
Are there any drawbacks on doing what I'm saying?
Maybe I'm missing something.

> You should see a little lower in this file that set_mctrl is copied
> to the new port. > -Aaron
> 
>> 		uart->dma		= up->dma;
>> 		uart->em485		= up->em485;
>>
>> --
>> 2.17.0

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
