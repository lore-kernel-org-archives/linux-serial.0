From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "serial/amba-pl011: Leave the TX IRQ alone when
 the UART is not open"
Date: Fri, 8 May 2015 14:17:00 +0200
Message-ID: <20150508121700.GA4781@kroah.com>
References: <20150507105934.GA18402@e103592.cambridge.arm.com>
 <20150507232835.GD5449@kroah.com>
 <20150508085029.GA17900@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150508085029.GA17900@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave P Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, May 08, 2015 at 09:50:29AM +0100, Dave P Martin wrote:
> On Fri, May 08, 2015 at 12:28:35AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, May 07, 2015 at 11:59:47AM +0100, Dave Martin wrote:
> > > Calling serial maintainers...
> > > 
> > > Please consider the following commit for merging in v4.1.
> > > 
> > > f28c1d0a78a8c6a217ac5362cb719efa169ae2a7 Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is not open"
> > > 
> > > This backs out a misguided optimisation that is causing pl011 driver
> > > deadlocks for some people in certain scenarios (my bad).
> > > 
> > > The revert is self-contained and independent of the other changes I
> > > posted.
> > > 
> > > Thanks
> > > ---Dave
> > > 
> > > 
> > > Original commit message:
> > > 
> > > This reverts commit f2ee6dfa0e8597eea8b98d240b0033994e20d215.
> > 
> > Please send this in a format I can apply it in...
> 
> The revert has been posted twice on this list and you already applied it
> to tty-next with commit ID f28c1d0a78a8c6a217ac5362cb719efa169ae2a7
> (thanks btw).  I could have made that clearer...

Yes, as I had no idea that is what you wanted here.

> I'm happy to post it again, but I assumed (wrongly?) that you'd prefer
> to cherry-pick it from your own branch.  If you really want me to
> post a duplicate, please confirm.

Please resend, and be more explicit, remember, I get over 1000 emails a
day...

greg k-h
