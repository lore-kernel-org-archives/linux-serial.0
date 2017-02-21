From: Piotr Figiel <p.figiel@camlintechnologies.com>
Subject: Re: imx: Race when disabling RX in IMX.6 UART in half duplex
Date: Tue, 21 Feb 2017 09:00:39 +0100
Message-ID: <e95b9a6f-9d61-3759-3eae-48e2900ca9b4@camlintechnologies.com>
References: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
 <20170220192001.eqomprbgrqkefkas@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170220192001.eqomprbgrqkefkas@tarshish>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hi Baruch,


On 20.02.2017 20:20, Baruch Siach wrote:
> Hi Piotr,
>
> On Mon, Feb 20, 2017 at 02:54:02PM +0100, Piotr Figiel wrote:
>>   I'm looking to find a correct way to disable RX in the I.MX6 UART during
>> TX-ing. I stumbled on the issue described below when working on
>> ~SER_RS485_RX_DURING_TX on custom 3.10 tree (branched from Freescale's/NXP's
>> BSP release) independently to what is now in the main line imx.c, but I see
>> now that the implementation in mainline also seem to have the same problem
>> I'm trying to solve now. I would like to request for comments to
>> confirm/deny whether the issue I raise here is valid and how to best
>> approach this.
>>
>>   I'm mostly concerned about the fact that the URXD register must not be
>> accessed (as documented in IMX.6 RM) when RX is disabled (RXEN=0). The issue
>> is that in the following sequence happening during imx_start_tx with
>> ~SER_RS485_RX_DURING_TX set:
>>
>> 1. Acquire spinlock, disable local interrupts (from serial_core.c),
>> 2. Disable RX receiver (RXEN=0 in UCR2),
>> 3. Release spinlock, reenable interrupts.
>>
>> The RX fifo may become not empty between #1 and #2. This will raise
>> interrupt which will be handled after re-enabling interrupts (after #3). ISR
>> in this case will check the status bit of the interrupt and fetch RX FIFO
>> contents, which I understand is forbidden by the documentation and may raise
>> error on the bus [1]. In addition disabling RX IRQ in this procedure, e.g.
>> after #1 doesn't seem to be enough, as the IRQ still may trigger after #1
>> and will need to be serviced.
> As I understand it, SER_RS485_RX_DURING_TX is for half-duplex RS-485 where
> only one device is allowed to transmit at any given time. Higher level code
> determines when any given device on the bus is allowed to transmit. If Rx FIFO
> becomes non-empty during Tx enable, you have a contention problem to solve.

That's correct, although I don't want bugs from the user-space or 
misbehaving devices on RS-485 to cause errors on the AXI/AHB bus 
resulting with possible crash/exception on the CPU core. The reason I 
write about this is that the RM explicitly forbids accessing those 
registers in such case.

> What is your use case?

My use-case is as you wrote - RS-485 in half duplex. I need to disable 
acquisition of data on RX on UART ip core level when TXing. Upper layer 
protocol in normal conditions does not let the issue I mentioned here 
happen.

Best regards, Piotr.
