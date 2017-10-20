From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] serial: meson: add Magic SysRq support
Date: Fri, 20 Oct 2017 10:48:38 +0200
Message-ID: <a37790aa-3721-76f5-1db8-80568191f98d@baylibre.com>
References: <20170906135239.29531-1-dlan@gentoo.org>
 <d727b350-7936-2671-45c2-cf32dfda1a2a@baylibre.com>
 <20171020083227.GA20623@ofmlt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020083227.GA20623@ofmlt>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yixun Lan <dlan@gentoo.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I Yixun,

On 20/10/2017 10:32, Yixun Lan wrote:
> Hi Greg-KH
> 
> I think you've already accepted this patch (and merged into your git repo)
> 
> so, is it possible for you to amend the commit message? or do you want me
> to send a PATCH v3 then?

I was not aware greg applied it, no need to amen anything, ignore my tag.

Neil

> 
> On 10:10 Fri 20 Oct     , Neil Armstrong wrote:
>> Hi Yixun,
>>
>> On 06/09/2017 15:52, Yixun Lan wrote:
>>> This dirver try to implement the Magic SysRq support[1] for
>>> Amlogic Inc's meson platfo
>>
>> Please fix these typos.
>>
> oops, not sure why this line is broken..
> 
> s/platfo/platform./
> and should squash next line .
> 
>>> From the hardware perspective, the UART IP can't detect the 'BREAK' command
>>> clearly via the status register. Instead, we rely on the combination of
>>> 'FRAME_ERR bit && ch == 0', and it works fine.
>>>
>>> [1] Documentation/admin-guide/sysrq.rst
>>>
>>> Signed-off-by: Yixun Lan <dlan@gentoo.org>
>>>
>>> ---
>>> Changes since v1 at [0]:
>>> - add changelog & a few more comments
>>>
>>> [0] https://patchwork.kernel.org/patch/9728475/
>>> ---
>>>  drivers/tty/serial/meson_uart.c | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>> index 42e4a4c7597f..3fea24bafd80 100644
>>> --- a/drivers/tty/serial/meson_uart.c
>>> +++ b/drivers/tty/serial/meson_uart.c
>>> @@ -14,6 +14,10 @@
>>>   *
>>>   */
>>>  
>>> +#if defined(CONFIG_SERIAL_MESON_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
>>> +#define SUPPORT_SYSRQ
>>> +#endif
>>> +
>>>  #include <linux/clk.h>
>>>  #include <linux/console.h>
>>>  #include <linux/delay.h>
>>> @@ -183,12 +187,12 @@ static void meson_receive_chars(struct uart_port *port)
>>>  {
>>>  	struct tty_port *tport = &port->state->port;
>>>  	char flag;
>>> -	u32 status, ch, mode;
>>> +	u32 ostatus, status, ch, mode;
>>>  
>>>  	do {
>>>  		flag = TTY_NORMAL;
>>>  		port->icount.rx++;
>>> -		status = readl(port->membase + AML_UART_STATUS);
>>> +		ostatus = status = readl(port->membase + AML_UART_STATUS);
>>>  
>>>  		if (status & AML_UART_ERR) {
>>>  			if (status & AML_UART_TX_FIFO_WERR)
>>> @@ -216,6 +220,16 @@ static void meson_receive_chars(struct uart_port *port)
>>>  		ch = readl(port->membase + AML_UART_RFIFO);
>>>  		ch &= 0xff;
>>>  
>>> +		if ((ostatus & AML_UART_FRAME_ERR) && (ch == 0)) {
>>> +			port->icount.brk++;
>>> +			flag = TTY_BREAK;
>>> +			if (uart_handle_break(port))
>>> +				continue;
>>> +		}
>>> +
>>> +		if (uart_handle_sysrq_char(port, ch))
>>> +			continue;
>>> +
>>>  		if ((status & port->ignore_status_mask) == 0)
>>>  			tty_insert_flip_char(tport, ch, flag);
>>>  
>>>
>>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
