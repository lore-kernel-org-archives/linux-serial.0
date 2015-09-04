From: Will Deacon <will.deacon@arm.com>
Subject: Re: earlycon issues in -next with amba-pl011 updates
Date: Fri, 4 Sep 2015 17:16:51 +0100
Message-ID: <20150904161651.GE6190@arm.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <CABymUCNYrDxciKrfWhcTp_kJT1cQFEpEYCkaZ7-sgBiJmgXuyQ@mail.gmail.com>
 <55E81F93.1020104@arm.com> <20150903155255.GA28336@kroah.com>
 <55E87095.4030600@arm.com> <20150904110651.GE4818@arm.com>
 <20150904161510.GA15055@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150904161510.GA15055@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Tyler Baker <tyler.baker@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jun Nie <jun.nie@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 04, 2015 at 05:15:10PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Sep 04, 2015 at 12:06:52PM +0100, Will Deacon wrote:
> > On Thu, Sep 03, 2015 at 05:08:53PM +0100, Marc Zyngier wrote:
> > > Gahhh... Given that there is no obvious fix, that the discussion has
> > > stalled and that the author of the series is apparently away, the
> > > following patches should be reverted:
> > > 
> > > 8cd90e50d140 uart: pl011: Add support to ZTE ZX296702 uart
> > > 09dcc7dfc05b uart: pl011: Improve LCRH register access decision
> > > 2c096a9eedc6 uart: pl011: Introduce register look up table
> > > 7b753f318d14 uart: pl011: Introduce register accessor
> > > 534e14e2293d uart: pl011: Rename regs with enumeration
> > > 
> > > (7b753f318d14 being the one breaking everything, but it makes more sense
> > > to revert the whole series until it is properly fixed and reviewed).
> > 
> > For the reverts (git revert 534e14e2293d~1..8cd90e50d140):
> > 
> >   Acked-by: Will Deacon <will.deacon@arm.com>
> >   Tested-by: Will Deacon <will.deacon@arm.com>
> > 
> > We can discuss what could've and should've happened 'til we're blue in
> > the face but, in the meantime, I'd like my serial console back.
> > 
> > Greg -- any chance you could send these for -rc1, please?
> 
> Ok, now reverted, I'll send the pull request later today.

Brilliant, thanks Greg.

Will
