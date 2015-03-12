From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH REPOST 2/2] serial/amba-pl011: Leave the TX IRQ alone
 when the UART is not open
Date: Thu, 12 Mar 2015 12:56:04 +0000
Message-ID: <20150312125604.GB15596@e103592.cambridge.arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-3-git-send-email-Dave.Martin@arm.com>
 <20150312110441.GM8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150312110441.GM8656@n2100.arm.linux.org.uk>
Content-Language: en-US
Content-Disposition: inline
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andre Przywara <Andre.Przywara@arm.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 12, 2015 at 11:04:41AM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 04, 2015 at 12:27:34PM +0000, Dave Martin wrote:
> > Getting the TX IRQ re-asserted from scratch can be inefficient in
> > some setups.
> > 
> > This patch avoids clearing the TX IRQ across pl011_shutdown()...
> > pl011_startup(), so that if the port is closed and reopened, the
> > IRQ will still work afterwards without having to bootstrap it again.
> 
> So if a port is being used as the console, we end up spraying the system
> with transmit interrupts?  This can't be right.

Nope, if the port is not open theough serial_core then TXIS remains
asserted but is masked off in IMSC.

This should be  just the same as the way we avoid a screaming TX interrupt
when the port *is* open but the transmitter is idle.


My commit message could have explained that better...

Cheers
---Dave
