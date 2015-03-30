From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
Date: Mon, 30 Mar 2015 17:07:44 +0100
Message-ID: <20150330160743.GD22949@e103592.cambridge.arm.com>
References: <20150327191040.1119319d@north>
 <20150330122840.GA22949@e103592.cambridge.arm.com>
 <20150330162652.0f0c7a18@north>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150330162652.0f0c7a18@north>
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
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 30, 2015 at 04:26:52PM +0200, Jakub Kicinski wrote:
> On Mon, 30 Mar 2015 13:28:40 +0100, Dave Martin wrote:

[...]

> > TXIS reflects the live status of the FIFO, except that it is
> > "spuriously" deasserted betweem reset/clear of the interrupt and the
> > first TX IRQ, even though the FIFO may be empty.
> 
> I missed that IRQ is cleared by writing data.

No worries, it took me a fair while to be sure of that myself.  The TRM
is not very clear on it.

Thanks for the careful review.

Cheers
---Dave
