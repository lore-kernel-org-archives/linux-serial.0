From: Jun Nie <jun.nie@linaro.org>
Subject: Re: earlycon issues in -next with amba-pl011 updates
Date: Wed, 16 Sep 2015 08:54:10 +0800
Message-ID: <CABymUCOSmGXJzZQGGABxgx5bbX+NfYP=E7AjAS5tHPvwBuSK-A@mail.gmail.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <CABymUCNYrDxciKrfWhcTp_kJT1cQFEpEYCkaZ7-sgBiJmgXuyQ@mail.gmail.com>
 <55E81F93.1020104@arm.com> <20150903155255.GA28336@kroah.com>
 <55E87095.4030600@arm.com>
 <CABymUCP4s+ePs-sphJkQ4b61EcNT51FQat2ADWoy1Tgww35GMg@mail.gmail.com>
 <20150909195402.GA7979@kroah.com>
 <CAKU3ayWkXxmF1cp=fOAL6kNKY3wY1u=XhPROKiLqkx4oZ9xZ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKU3ayWkXxmF1cp=fOAL6kNKY3wY1u=XhPROKiLqkx4oZ9xZ0g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <greg@kroah.com>, Tyler Baker <tyler.baker@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2015-09-16 7:20 GMT+08:00 Peter Hurley <peter@hurleysoftware.com>:
> On Wed, Sep 9, 2015 at 3:54 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
>>
>> On Sat, Sep 05, 2015 at 10:42:03PM +0800, Jun Nie wrote:
>> > 2015-09-04 0:08 GMT+08:00 Marc Zyngier <marc.zyngier@arm.com>:
>> > > On 03/09/15 16:52, Greg Kroah-Hartman wrote:
>> > >> On Thu, Sep 03, 2015 at 11:23:15AM +0100, Marc Zyngier wrote:
>> > >>> On 11/08/15 02:48, Jun Nie wrote:
>> > >>>> 2015-08-11 7:23 GMT+08:00 Leif Lindholm <leif.lindholm@linaro.org>:
>> > >>>>> Hi all,
>> > >>>>>
>> > >>>>> The kernelci.org bot picked up a complete boot failure (no output
>> > >>>>> past
>> > >>>>> UEFI stub) with next-20150806 and Tyler bisected it down to
>> > >>>>> somewhere
>> > >>>>> in
>> > >>>>> 8cd90e5 uart: pl011: Add support to ZTE ZX296702 uart
>> > >>>>> 09dcc7d uart: pl011: Improve LCRH register access decision
>> > >>>>> 2c096a9 uart: pl011: Introduce register look up table
>> > >>>>> 7b753f3 uart: pl011: Introduce register accessor
>> > >>>>>
>> > >>>>> The issue only appears with earlycon on command line, for pl011
>> > >>>>> consoles.
>> > >>>>>
>> > >>>>> Some investigation shows that the cause lies with
>> > >>>>> commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
>> > >>>>> and
>> > >>>>> commit 2c096a9eedc6 ("uart: pl011: Introduce register look up
>> > >>>>> table")
>> > >>>>>
>> > >>>>> Specifically, the changes to pl011_putc() are incorrect:
>> > >>>>> The new pl011_ accessors take a (struct uart_amba_port *) input,
>> > >>>>> but
>> > >>>>> pl011_putc() directly uses the incoming (struct uart_port *) for
>> > >>>>> this.
>> > >>>>>
>> > >>>>> Apart from ending up with an unintended/incorrect UART base
>> > >>>>> address,
>> > >>>>> the introduction of the lookup table for register offsets also
>> > >>>>> means
>> > >>>>> the accessors try to dereference (struct uart_amba_port
>> > >>>>> *)->reg_lut.
>> > >>>>>
>> > >>>>> The below is a hack that shows/resolves the issue, but some
>> > >>>>> refactoring of the original patches might be in order.
>> > >>>>>
>> > >>>>> /
>> > >>>>>     Leif
>> > >>>>
>> > >>>> Leif,
>> > >>>>
>> > >>>> Sorry for the inconvenience. I do not have idea of early console
>> > >>>> till
>> > >>>> now and I always have debug console for early panic debug. Learned
>> > >>>> more from this issue.
>> > >>>>
>> > >>>> Suppose Peter's patch will resolve your issue.
>> > >>>
>> > >>> [+ Greg KH]
>> > >>>
>> > >>> So -next has now been broken for a while on a number of ARM
>> > >>> platforms
>> > >>> because of this (they simply cannot boot), and no progress has been
>> > >>> made
>> > >>> towards resolving this problem.
>> > >>>
>> > >>> Can we please drop this series (at least commits 7b753f3 and
>> > >>> following)
>> > >>> from -next until is has been reworked and reviewed?
>> > >>
>> > >> I don't have any patches in my -next tree, everything is in Linus's
>> > >> tree
>> > >> now.  So if I've missed something, or need to revert something,
>> > >> please
>> > >> let me know specifcally what to do.
>> > >
>> > > Gahhh... Given that there is no obvious fix, that the discussion has
>> > > stalled and that the author of the series is apparently away, the
>> > > following patches should be reverted:
>> >
>> > Marc,
>> >
>> > There had a patch from Peter that revert early console part, which I
>> > thought will be merged to mainline. It's my fault for not fix the bug
>> > on time. Also sorry for late response to you as I took three days
>> > leave.
>> >
>> > Could you help test attached patch? Thank you in advance!
>> >
>> >
>> > Greg,
>> >
>> > Would you please hold the merging of revert patches for one or two
>> > days so that the fix can be verified? Thank you!
>>
>> Given that this took way more than a few days, Linus now has the reverts
>> in his tree.  Please feel free to resend the series, in a form that does
>> not break people's machines, for inclusion in 4.4-rc1.
>
>
> Jun,
>
> I suggest you keep the series largely as is, while leaving the earlycon
> support unmodified.
>
> Be sure to address the series to all in this email so they have adequate
> opportunity to test your driver changes, prior to inclusion in mainline.
>
> Regards,
> Peter Hurley

Will do in one month due to occupied in internal tasks. Thanks for
your suggestion!

Best Regards,
Jun
