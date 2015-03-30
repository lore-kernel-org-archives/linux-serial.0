From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
Date: Mon, 30 Mar 2015 17:09:35 +0100
Message-ID: <20150330160934.GE22949@e103592.cambridge.arm.com>
References: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
 <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
 <20150330162811.3673482b@north>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150330162811.3673482b@north>
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
To: Jakub Kicinski <moorray3@wp.pl>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 30, 2015 at 04:28:11PM +0200, Jakub Kicinski wrote:
> On Fri, 27 Mar 2015 14:59:31 +0000, Dave Martin wrote:
> > To this end, the TX softirq mechanism is removed and instead

[...]

> > pl011_start_tx() will now simply stuff the FIFO until full
> > (guaranteeing future TX IRQs), or until there are no more chars
> > to write (in which case we don't care whether an IRQ happens).
> > 
> > [1] Thanks to Jakub Kicinski for his input and similar patch.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Signed-off-by: Jakub Kicinski <kubakici@wp.pl>

Agreed, shoulda had that (sorry!)

Greg, can you add Jakub's S-o-B when applying, or do you want me to
repost?

Cheers
---Dave
