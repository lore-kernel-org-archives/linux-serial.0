From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH REPOST 1/2] serial/amba-pl011: Activate TX IRQ passively
Date: Thu, 12 Mar 2015 11:03:45 +0000
Message-ID: <20150312110344.GL8656@n2100.arm.linux.org.uk>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-2-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1425472054-7543-2-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 12:27:33PM +0000, Dave Martin wrote:
> The current PL011 driver transmits a dummy character when the UART
> is opened, to assert the TX IRQ for the first time
> (see pl011_startup()).  The UART is put in loopback mode temporarily,
> so the receiver presumably shouldn't see anything.

We do this so that we know for certain that the PL011 has room to accept
at least one character.

> However...
> 
> At least some platforms containing a PL011 send characters down the
> wire even when loopback mode is enabled.  This means that a
> spurious NUL character may be seen at the receiver when the PL011 is
> opened through the TTY layer.

... which is an annoyance.

> The current code also temporarily sets the baud rate to maximum and
> the character width to the minimum, to that the dummy TX completes
> as quickly as possible.  If this is seen by the receiver it will
> result in a framing error and can knock the receiver out of sync --
> turning subsequent output into garbage until synchronisation
> is reestablished.  (Particularly problematic during boot with systemd.)

Yea, I have my own issues with systemd, but let's stay away from that
potential argument. :)

> To avoid spurious transmissions, this patch removes assumptions about
> whether the TX IRQ will fire until at least one TX IRQ has been seen.
> 
> Instead, the UART will unmask the TX IRQ and then slow-start via
> polling and timer-based soft IRQs initially.  If the TTY layer writes
> enough data to fill the FIFO to the interrupt threshold in one go,
> the TX IRQ should assert, at which point the driver changes to
> fully interrupt-driven TX.

I'm concerned about this.  What happens if the PL011 is also being used
as a console, and the UART TX FIFO is fully stuffed?

Reading the updated code, it seems that we can call pl011_tx_chars()
irrespective of whether the TX FIFO is full or not.  pl011_tx_chars()
makes the assumption that the TX FIFO can always accept the next
character, and it results in (eg, in the x_char handling) the next
character being written, even if the FIFO is full.

If hardware CTS flow control is enabled, the problem gets worse - in
that mode, the TX FIFO can remain fully occupied for an indeterminant
amount of time.

This introduces a whole new unreliability to the driver which wasn't
there to start with.

So, I'm afraid this gets a NAK.

You need to check the TX FIFO status before trying to stuff it with
characters.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
