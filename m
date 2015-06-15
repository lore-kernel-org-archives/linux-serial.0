From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Mon, 15 Jun 2015 11:53:08 +0100
Message-ID: <20150615105308.GA3649@e103592.cambridge.arm.com>
References: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
 <20150613003945.GA10941@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150613003945.GA10941@kroah.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Robin Murphy <Robin.Murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jun 13, 2015 at 01:39:45AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jun 05, 2015 at 03:07:47PM +0100, Dave Martin wrote:
> > pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> > sufficient to inhibit pl011_int() from being triggered by a local
> > IRQ and trying to re-take the same lock.  This can lead to
> > deadlocks.
> > 
> > This patch uses the _irq() locking variants instead to ensure that
> > pl011_int() handling for a given port is deferred until any
> > pl011_tx_softirq() work for that port is complete.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > Cc: stable <stable@vger.kernel.org> # 4.1
> > ---
> > 
> > Another candidate for v4.1 if possible (sorry!) -- I thought this change
> > was already in, but it went astray when I was refactoring.
> 
> Too late for 4.1, sorry.  This doesn't apply to my tty-next branch,

No worries -- I was aware it was getting very late.  The code this fixes
is obsoleted by -next, so it is relevant only for stable now.

> otherwise I would have queued it up there.  Care to redo it and mark it
> for -stable, like I did above, and resend it?

Will do, thanks.
---Dave
