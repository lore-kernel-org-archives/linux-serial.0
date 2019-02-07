From: "Masson\, Julien" <jmasson@baylibre.com>
Subject: Re: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
Date: Thu, 07 Feb 2019 18:04:36 +0100
Message-ID: <86lg2rv8bf.fsf@baylibre.com>
References: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
 <20190201101056.GA10039@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20190201101056.GA10039@Red>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Julien Masson <jmasson@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


On Fri 01 Feb 2019 at 11:10, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> On Fri, Feb 01, 2019 at 10:59:22AM +0100, Julien Masson wrote:
>> The kgdb invokes the poll_put_char and poll_get_char when communicating
>> with the host. This patch implement the serial polling hooks for the
>> meson_uart to be used for KGDB debugging over serial line.
>> 
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> ---
>> It has been tested on "Le Potato" board:
>> https://libre.computer/products/boards/aml-s905x-cc/
>> 
>> Kernel command line arguments:
>> kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon
>> 
>> Kernel modules:
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_FRAME_POINTER=y
>> CONFIG_KGDB=y
>> CONFIG_KGDB_SERIAL_CONSOLE=y
>> 
>> Warning: for single step instruction I had to apply this patch:
>> https://lore.kernel.org/patchwork/patch/562423/
>> 
>>  drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 8a84259..49b20da 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_CONSOLE_POLL
>> +/*
>> + * Console polling routines for writing and reading from the uart while
>> + * in an interrupt or debug context (i.e. kgdb).
>> + */
>> +
>> +static int meson_uart_poll_get_char(struct uart_port *port)
>> +{
>> +	u32 c;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
>> +		c = NO_POLL_CHAR;
>> +	else
>> +		c = readl(port->membase + AML_UART_RFIFO);
>> +
>> +	spin_unlock_irqrestore(&port->lock, flags);
>> +
>> +	return c;
>> +}
>> +
>> +static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
>> +		cpu_relax();
>
> Hello
>
> Perhaps you could use read_poll_timeout() ?
> This will also permit to handle the timeout case.
>
> Regards

Thanks for the tips Corentin.

I tested with a poll of 5 usec and 1 msec of timeout.
I had to use readl_poll_timeout_atomic(...) since I'm in atomic context
(spinlock).

I'll send a v2 of this patch.

Regards
