From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Sat, 20 Jun 2015 11:09:37 +0200 (CEST)
Message-ID: <416658426.177742.1434791378036.JavaMail.open-xchange@oxbsltgw09.schlund.de>
References: <1434635669-23367-1-git-send-email-Dave.Martin@arm.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1434635669-23367-1-git-send-email-Dave.Martin@arm.com>
Sender: stable-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Martin <Dave.Martin@arm.com>
Cc: Robin Murphy <Robin.Murphy@arm.com>, popcorn mix <popcornmix@gmail.com>, =?UTF-8?Q?Jakub_Kici=C5=84ski?= <moorray3@wp.pl>, Andrew Jackson <Andrew.Jackson@arm.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Andre Przywara <Andre.Przywara@arm.com>, linux-arm-kernel@lists.infradead.org, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


> Dave Martin <Dave.Martin@arm.com> hat am 18. Juni 2015 um 15:54 geschrieben:
>
>
> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> sufficient to inhibit pl011_int() from being triggered by a local
> IRQ and trying to re-take the same lock. This can lead to
> deadlocks.
>
> This patch uses the _irq() locking variants instead to ensure that
> pl011_int() handling for a given port is deferred until any
> pl011_tx_softirq() work for that port is complete.
>
> Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Cc: stable <stable@vger.kernel.org> # 4.1
>

I also get info messages about inconsistent lock state on my mx28 board,
after applying the patch the messages disappeared.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Regards
Stefan
