From: Piotr Figiel <p.figiel@camlintechnologies.com>
Subject: Re: imx: Race when disabling RX in IMX.6 UART in half duplex
Date: Wed, 22 Feb 2017 12:16:31 +0100
Message-ID: <e2984ba6-391b-e21f-00ac-aaffead0335a@camlintechnologies.com>
References: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
 <20170220192001.eqomprbgrqkefkas@tarshish>
 <e95b9a6f-9d61-3759-3eae-48e2900ca9b4@camlintechnologies.com>
 <20170221081821.7n2345o4zacnfcvl@tarshish>
 <6151d423-da84-d497-d82a-7347357790a0@camlintechnologies.com>
 <20170222104439.oyuutpohvfosthdu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170222104439.oyuutpohvfosthdu@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>, gregkh@linuxfoundation.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hi,


On 22.02.2017 11:44, Sascha Hauer wrote:
> On Tue, Feb 21, 2017 at 09:48:54AM +0100, Piotr Figiel wrote:
>> Hi Baruch,
>>
>>
>> On 21.02.2017 09:18, Baruch Siach wrote:
>>> Hi Piotr,
>>>
>>> On Tue, Feb 21, 2017 at 09:00:39AM +0100, Piotr Figiel wrote:
>>>> On 20.02.2017 20:20, Baruch Siach wrote:
>>>>> On Mon, Feb 20, 2017 at 02:54:02PM +0100, Piotr Figiel wrote:
>>>>>>     I'm looking to find a correct way to disable RX in the I.MX6 UART during
>>>>>> TX-ing. I stumbled on the issue described below when working on
>>>>>> ~SER_RS485_RX_DURING_TX on custom 3.10 tree (branched from Freescale's/NXP's
>>>>>> BSP release) independently to what is now in the main line imx.c, but I see
>>>>>> now that the implementation in mainline also seem to have the same problem
>>>>>> I'm trying to solve now. I would like to request for comments to
>>>>>> confirm/deny whether the issue I raise here is valid and how to best
>>>>>> approach this.
>>>>>>
>>>>>>     I'm mostly concerned about the fact that the URXD register must not be
>>>>>> accessed (as documented in IMX.6 RM) when RX is disabled (RXEN=0). The issue
>>>>>> is that in the following sequence happening during imx_start_tx with
>>>>>> ~SER_RS485_RX_DURING_TX set:
>>>>>>
>>>>>> 1. Acquire spinlock, disable local interrupts (from serial_core.c),
>>>>>> 2. Disable RX receiver (RXEN=0 in UCR2),
>>>>>> 3. Release spinlock, reenable interrupts.
>>>>>>
>>>>>> The RX fifo may become not empty between #1 and #2. This will raise
>>>>>> interrupt which will be handled after re-enabling interrupts (after #3). ISR
>>>>>> in this case will check the status bit of the interrupt and fetch RX FIFO
>>>>>> contents, which I understand is forbidden by the documentation and may raise
>>>>>> error on the bus [1]. In addition disabling RX IRQ in this procedure, e.g.
>>>>>> after #1 doesn't seem to be enough, as the IRQ still may trigger after #1
>>>>>> and will need to be serviced.
>>>>> As I understand it, SER_RS485_RX_DURING_TX is for half-duplex RS-485 where
>>>>> only one device is allowed to transmit at any given time. Higher level code
>>>>> determines when any given device on the bus is allowed to transmit. If Rx FIFO
>>>>> becomes non-empty during Tx enable, you have a contention problem to solve.
>>>> That's correct, although I don't want bugs from the user-space or
>>>> misbehaving devices on RS-485 to cause errors on the AXI/AHB bus resulting
>>>> with possible crash/exception on the CPU core. The reason I write about this
>>>> is that the RM explicitly forbids accessing those registers in such case.
>>> The trivial solution might be to return early from imx_rxint() when RXEN=0.
>>> Would that be sufficient?
>> I'm not sure if it's best idea, I don't know if the UART will keep
>> triggering the interrupt if the source won't be cleared (FIFO drained), but
>> if it does we'll be irq flooded,
> And indeed that's what happens. The RX irq is acked by reading all
> characters from the FIFO. I had the same problem as you describe, see
> below for the patch I came up with (with the intention to mainline i
> t when I find the time). My "usecase" was to send a character while
> being flooded with received characters from the other side. That of
> course was only for testing purposes, but I could reliably crash
> the kernel with this setup.

Thanks for confirming this, this probably requires CVE, since user with 
tty access can crash mainline kernel by correctly timing a write 
(personally though I wasn't able to trigger this without putting delay 
in the code to trigger the race). Some comments regarding the 
implementation (thanks for sharing this btw):

> +static void imx_receiver_safe_disable(struct imx_port *sport)
> +{
> +	u32 ucr2, ucr1;
> +	int t = 50;
> +
> +	ucr1 = readl(sport->port.membase + UCR1);
> +	ucr1 &= ~UCR1_RRDYEN;
> +	writel(ucr1, sport->port.membase + UCR1);
> +
> +	ucr2 = readl(sport->port.membase + UCR2);
> +
> +	/*
> +	 * Disable the receiver and make sure that no characters are left
> +	 * in the FIFO. Otherwise an interrupt will be triggered even when
> +	 * UCR1_RRDYEN is cleared. We can't ack this interrupt because with
> +	 * disabled receiver we are not allowed to read from the FIFO.
> +	 */
> +	do {
> +		writel(ucr2 | UCR2_RXEN, sport->port.membase + UCR2);
> +
> +		while (readl(sport->port.membase + USR2) & USR2_RDR)
> +			readl(sport->port.membase + URXD0);
> +
> +		writel(ucr2 & ~UCR2_RXEN, sport->port.membase + UCR2);
> +
> +		if (!t--) {
> +			dev_err(sport->port.dev, "Failed to disable the receiver\n");
> +			return;
In this unlikely event perhaps an error should be returned so that the 
RXEN is not disabled in imx_start_tx() (i.e. I think it's better to 
ignore ~SER_RS485_RX_DURING_TX for a while than to crash).

> +		}
> +	} while (readl(sport->port.membase + USR2) & USR2_RDR);
> +}
> +
>   /*
>    * interrupts disabled on entry
>    */
> @@ -633,8 +669,10 @@ static void imx_start_tx(struct uart_port *port)
>   				imx_port_rts_active(sport, &temp);
>   			else
>   				imx_port_rts_inactive(sport, &temp);
> -			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> +			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
> +				imx_receiver_safe_disable(sport);
>   				temp &= ~UCR2_RXEN;
> +			}
>   			writel(temp, port->membase + UCR2);
>   			sport->tx_state = WAIT_AFTER_RTS;
>   			sport->tx_state_next_change =

Other than that I think it's OK (it's also consistent with the procedure 
from my first post [1]).

Best regards, Piotr.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/488957.html
