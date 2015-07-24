From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Fri, 24 Jul 2015 10:56:06 +0100
Message-ID: <20150724095605.GI10670@e103592.cambridge.arm.com>
References: <1436439433-10258-1-git-send-email-Dave.Martin@arm.com>
 <20150723220550.GA15032@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150723220550.GA15032@kroah.com>
Content-Language: en-US
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Robin Murphy <Robin.Murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 23, 2015 at 03:05:50PM -0700, Greg Kroah-Hartman wrote:
> On Thu, Jul 09, 2015 at 11:57:12AM +0100, Dave Martin wrote:
> > pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> > sufficient to inhibit pl011_int() from being triggered by a local
> > IRQ and trying to re-take the same lock.  This can lead to
> > deadlocks.
> > 
> > This patch uses the _irq() locking variants instead to ensure that
> > pl011_int() handling for a given port is deferred until any
> > pl011_tx_softirq() work for that port is complete.
> > 
> > Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Cc: stable <stable@vger.kernel.org> # 4.1
> > ---
> >  drivers/tty/serial/amba-pl011.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This doesn't apply at all to 4.2-rc3, so I can't apply it :(

This is applicable to 4.1 stable only, since the code this patch fixes
was replaced in 4.2-rc1.

Apologies, I didn't make that clear in the text.

Cheers
---Dave
