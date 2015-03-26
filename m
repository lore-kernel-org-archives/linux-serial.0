From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] amba-pl011: simplify TX handling
Date: Thu, 26 Mar 2015 22:28:37 +0100
Message-ID: <20150326212837.GA21648@kroah.com>
References: <1426636967-9124-1-git-send-email-moorray3@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1426636967-9124-1-git-send-email-moorray3@wp.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jakub Kicinski <moorray3@wp.pl>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Andre Przywara <andre.przywara@arm.com>, Karol =?utf-8?B?RMSZYm9nw7Nyc2tp?= <k.debogorski@a2s.pl>, linux-serial@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 18, 2015 at 01:02:47AM +0100, Jakub Kicinski wrote:
> From: Jakub Kicinski <kubakici@wp.pl>
> 
> Since pre-git era PL011 used an elaborate scheme to load data
> to TX FIFO.  Only TX IRQ handler was loading data into the FIFO,
> which required the IRQ to fire before any transmission started
> (to load the first batch of characters).  Initial IRQ was fired
> by putting UART into loopback mode and writing an arbitrary
> character during .startup().
> 
> Unfortunately some PL011-compatible UART (most notably BCM2708
> in Raspberry Pi) would transmit the arbitrary character even
> though the device was in loopback mode.  Commit 734745caeb9f
> ("serial/amba-pl011: Activate TX IRQ passively") solved this
> issue by loading the first batch explicitly from .start_tx()
> handler.  It employed quite a complex scheme involving IRQ
> counting and a delayed work.
> 
> f2ee6dfa0e85 ("serial/amba-pl011: Leave the TX IRQ alone when
> the UART is not open") was an attempt to optimise the loading
> by assuming that when the device is opened second time TX IRQ
> from the previous transmission will still be pending.  This
> assumption is incorrect if the device is closed with FIFO full
> because FIFO will be programmatically flushed and therefore no
> IRQ will be pending on next .open().
> 
> This patch simplifies the code and fixes above problem. It should
> also make things a bit more efficient as the FIFO was not filled
> properly after the driver seen more than two IRQs.
> 
> Fixes: f2ee6dfa0e85 ("serial/amba-pl011: Leave the TX IRQ alone when the UART is not open")
> Signed-off-by: Jakub Kicinski <kubakici@wp.pl>
> ---
> v2:
>  - don't try to load FIFO from outside of IRQ handler
>    if IRQ is unmasked (change to pl011_start_tx_pio());
>  - don't check for FIFO_FULL at the end of load from IRQ;
>  - remove unnecessary newlines.
> ---
>  drivers/tty/serial/amba-pl011.c | 113 +++++++++++++---------------------------
>  1 file changed, 35 insertions(+), 78 deletions(-)

As I think this does much the same thing Dave Martin's patch does, I
want him to ack this before I can accept it.

thanks,

greg k-h
