From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon issues in -next with amba-pl011 updates
Date: Mon, 17 Aug 2015 12:04:16 -0400
Message-ID: <55D20600.6050204@hurleysoftware.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <55C94247.8020701@hurleysoftware.com>
 <20150811124043.GZ7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150811124043.GZ7557@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: jun.nie@linaro.org, tyler.baker@linaro.org, linux-arm-kernel@lists.infradead.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 08/11/2015 08:40 AM, Russell King - ARM Linux wrote:
> On Mon, Aug 10, 2015 at 08:31:03PM -0400, Peter Hurley wrote:
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 2af09ab..fd54991 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -2348,13 +2348,10 @@ static struct console amba_console = {
>>  
>>  static void pl011_putc(struct uart_port *port, int c)
>>  {
>> -	struct uart_amba_port *uap =
>> -	    container_of(port, struct uart_amba_port, port);
>> -
>> -	while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>>  		;
>> -	pl011_writeb(uap, c, REG_DR);
>> -	while (pl011_readw(uap, REG_FR) & uap->fr_busy)
>> +	writeb(c, port->membase + UART01x_DR);
>> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
>>  		;
> 
> These loops are wrong.  Kernel coding style is that loops like this
> will use cpu_relax() in them, just like the driver used to.  This
> was introduced by:
> 
> commit 0d3c673e7881e691991b2a4745bd4f149603baa2
> Author: Rob Herring <robh@kernel.org>
> Date:   Fri Apr 18 17:19:57 2014 -0500
> 
>     tty/serial: pl011: add generic earlycon support
> 
> Also, the above readl()s should be readl_relaxed(), we don't need
> barriered reads or to hit the L2 cache on those reads in the above code.

This patch just reverts pl011 earlycon back to the existing mainline
state.

The amba-pl011 driver has many places where cpu_relax() is not used,
so that seems like a good patch for -next during the 4.3-rc cycle.

Similarly for read_relaxed() use in earlycon.

Regards,
Peter Hurley
