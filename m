From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: imx: Race when disabling RX in IMX.6 UART in half duplex
Date: Mon, 20 Feb 2017 21:20:01 +0200
Message-ID: <20170220192001.eqomprbgrqkefkas@tarshish>
References: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Piotr Figiel <p.figiel@camlintechnologies.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hi Piotr,

On Mon, Feb 20, 2017 at 02:54:02PM +0100, Piotr Figiel wrote:
>  I'm looking to find a correct way to disable RX in the I.MX6 UART during
> TX-ing. I stumbled on the issue described below when working on
> ~SER_RS485_RX_DURING_TX on custom 3.10 tree (branched from Freescale's/NXP's
> BSP release) independently to what is now in the main line imx.c, but I see
> now that the implementation in mainline also seem to have the same problem
> I'm trying to solve now. I would like to request for comments to
> confirm/deny whether the issue I raise here is valid and how to best
> approach this.
> 
>  I'm mostly concerned about the fact that the URXD register must not be
> accessed (as documented in IMX.6 RM) when RX is disabled (RXEN=0). The issue
> is that in the following sequence happening during imx_start_tx with
> ~SER_RS485_RX_DURING_TX set:
> 
> 1. Acquire spinlock, disable local interrupts (from serial_core.c),
> 2. Disable RX receiver (RXEN=0 in UCR2),
> 3. Release spinlock, reenable interrupts.
> 
> The RX fifo may become not empty between #1 and #2. This will raise
> interrupt which will be handled after re-enabling interrupts (after #3). ISR
> in this case will check the status bit of the interrupt and fetch RX FIFO
> contents, which I understand is forbidden by the documentation and may raise
> error on the bus [1]. In addition disabling RX IRQ in this procedure, e.g.
> after #1 doesn't seem to be enough, as the IRQ still may trigger after #1
> and will need to be serviced.

As I understand it, SER_RS485_RX_DURING_TX is for half-duplex RS-485 where 
only one device is allowed to transmit at any given time. Higher level code 
determines when any given device on the bus is allowed to transmit. If Rx FIFO 
becomes non-empty during Tx enable, you have a contention problem to solve.

What is your use case?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
