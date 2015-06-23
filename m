From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Tue, 23 Jun 2015 12:13:10 +0100
Message-ID: <20150623111310.GB3645@e103592.cambridge.arm.com>
References: <1434635669-23367-1-git-send-email-Dave.Martin@arm.com>
 <416658426.177742.1434791378036.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <416658426.177742.1434791378036.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <Robin.Murphy@arm.com>, popcorn mix <popcornmix@gmail.com>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Andrew Jackson <Andrew.Jackson@arm.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Andre Przywara <Andre.Przywara@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jun 20, 2015 at 10:09:37AM +0100, Stefan Wahren wrote:
> 
> > Dave Martin <Dave.Martin@arm.com> hat am 18. Juni 2015 um 15:54 geschrieben:
> >
> >
> > pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> > sufficient to inhibit pl011_int() from being triggered by a local
> > IRQ and trying to re-take the same lock. This can lead to
> > deadlocks.
> >
> > This patch uses the _irq() locking variants instead to ensure that
> > pl011_int() handling for a given port is deferred until any
> > pl011_tx_softirq() work for that port is complete.
> >
> > Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > Cc: stable <stable@vger.kernel.org> # 4.1
> >
> 
> I also get info messages about inconsistent lock state on my mx28 board,
> after applying the patch the messages disappeared.
> 
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks for the confirmation.

Cheers
---Dave
