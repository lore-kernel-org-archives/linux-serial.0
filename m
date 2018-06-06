From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
Date: Wed, 6 Jun 2018 14:15:14 +0200
Message-ID: <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
 <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
 <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: matwey.kornilov@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>> em485 gets lost during serial8250_register_8250_port().
>>
>> Copy em485 to final uart port.
>>
> 
> Is it needed at all?
> 
> The individual driver decides either to use software emulation (and
> calls explicitly serial8250_em485_init() for that) or do HW assisted
> stuff.

In 8250_dw.c, during probe(), I need to call dw8250_rs485_config() 
against local struct uart_8250_port uart = {};
Inside serial8250_register_8250_port() not all uart fields are 
copied(em485 too).
So after probe, em485 is NULL.

Another way could be to call dw8250_rs485_config() against real uart 
port, after calling serial8250_register_8250_port(),
would it make sense?

> 
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/tty/serial/8250/8250_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c
>> b/drivers/tty/serial/8250/8250_core.c
>> index 9342fc2ee7df..c8c2b260c681 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -994,6 +994,7 @@ int serial8250_register_8250_port(struct
>> uart_8250_port *up)
>>   		uart->port.rs485_config	= up-
>>> port.rs485_config;
>>   		uart->port.rs485	= up->port.rs485;
>>   		uart->dma		= up->dma;
>> +		uart->em485		= up->em485;
>>   
>>   		/* Take tx_loadsz from fifosize if it wasn't set
>> separately */
>>   		if (uart->port.fifosize && !uart->tx_loadsz)
> 

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
