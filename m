From: Piotr Figiel <p.figiel@camlintechnologies.com>
Subject: imx: Race when disabling RX in IMX.6 UART in half duplex
Date: Mon, 20 Feb 2017 14:54:02 +0100
Message-ID: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, baruch@tkos.co.il, Fabio Estevam <fabio.estevam@nxp.com>, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

  I'm looking to find a correct way to disable RX in the I.MX6 UART 
during TX-ing. I stumbled on the issue described below when working on 
~SER_RS485_RX_DURING_TX on custom 3.10 tree (branched from 
Freescale's/NXP's BSP release) independently to what is now in the main 
line imx.c, but I see now that the implementation in mainline also seem 
to have the same problem I'm trying to solve now. I would like to 
request for comments to confirm/deny whether the issue I raise here is 
valid and how to best approach this.

  I'm mostly concerned about the fact that the URXD register must not be 
accessed (as documented in IMX.6 RM) when RX is disabled (RXEN=0). The 
issue is that in the following sequence happening during imx_start_tx 
with ~SER_RS485_RX_DURING_TX set:

1. Acquire spinlock, disable local interrupts (from serial_core.c),
2. Disable RX receiver (RXEN=0 in UCR2),
3. Release spinlock, reenable interrupts.

The RX fifo may become not empty between #1 and #2. This will raise 
interrupt which will be handled after re-enabling interrupts (after #3). 
ISR in this case will check the status bit of the interrupt and fetch RX 
FIFO contents, which I understand is forbidden by the documentation and 
may raise error on the bus [1]. In addition disabling RX IRQ in this 
procedure, e.g. after #1 doesn't seem to be enough, as the IRQ still may 
trigger after #1 and will need to be serviced.

I came to the conclusion that the above problem can be solved by 
adjusting the procedure so that it's:

1. Acquire spinlock, disable local interrupts,
2. Disable RX interrupt,
3. Fetch RX fifo contents,
4. Disable RX receiver,
5. Check if RX fifo is not-empty by use of USR2, if it's not-empty it 
means the characters were not added between steps #3 and #4. If RX FIFO 
is not empty re-enable RX receiver and go to 3. Otherwise continue.
6. Release spinlock, reenable interrupts.

I wonder is this the only way to do that, as it doesn't seem clean. 
Other option would be to check in the ISR whether the RX is enabled 
before getting FIFO contents, but what would be correct behavior if it 
is not empty? (Interrupt would be handled but FIFO contents wouldn't be 
cleaned, when those should be fetched?).

Could you please comment?

Best regards, Piotr.

[1] 
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf 
(64.15.1)
