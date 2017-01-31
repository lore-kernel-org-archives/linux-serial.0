From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 3/8] serial: st-asc: Read in all Pinctrl
 states
Date: Tue, 31 Jan 2017 11:31:31 +0000
Message-ID: <20170131113131.GA6427@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-4-lee.jones@linaro.org>
 <20170125112142.GE5680@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170127115458.k4edg42nnna3bv4v@dell>
 <20170130142356.GA18710@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170130153211.j75qemvwsq3cwqve@dell>
 <20170130161041.GA21001@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170130191159.zv5jegvu4fetcmzo@dell>
 <20170130223521.GA12847@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170131101356.bpg5hamkfgprdbpt@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170131101356.bpg5hamkfgprdbpt@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Lee,

On Tue, 31 Jan 2017, Lee Jones wrote:

> On Mon, 30 Jan 2017, Peter Griffin wrote:
> > On Mon, 30 Jan 2017, Lee Jones wrote:
> > > On Mon, 30 Jan 2017, Peter Griffin wrote:
> > > > On Mon, 30 Jan 2017, Lee Jones wrote:
> > > > > On Mon, 30 Jan 2017, Peter Griffin wrote:
> > > > > > On Fri, 27 Jan 2017, Lee Jones wrote:
> > > > > > > On Wed, 25 Jan 2017, Peter Griffin wrote:
> > > > > > > > On Tue, 24 Jan 2017, Lee Jones wrote:
> > > > > > > > 
> > > > > > > > > There are now 2 possible separate/different Pinctrl states which can
> > > > > > > > > be provided from platform data.  One which encompasses the lines
> > > > > > > > > required for HW flow-control (CTS/RTS) and another which does not
> > > > > > > > > specify these lines, such that they can be used via GPIO mechanisms
> > > > > > > > > for manually toggling (i.e. from a request by `stty`).
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/tty/serial/st-asc.c | 28 ++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 28 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> > > > > > > > > index 397df50..03801ed 100644
> > > > > > > > > --- a/drivers/tty/serial/st-asc.c
> > > > > > > > > +++ b/drivers/tty/serial/st-asc.c
> > > 
> > > [...]
> > > 
> > > > > > > > > +		pinctrl_lookup_state(ascport->pinctrl, "manual-rts");
> > > > > > > > > +	if (IS_ERR(ascport->states[MANUAL_RTS]))
> > > > > > > > > +		ascport->states[MANUAL_RTS] = NULL;
> > > > > > > > > +
> > > > > > > > 
> > > > > > > > The different pinctrl states looks like a neat solution to the problem.
> > > > > > > > 
> > > > > > > > My only concern here is that 'default' state is implying a hw-flow-control
> > > > > > > > pinmux config, and manual-rts is implying what is the current upstream
> > > > > > > > 'default' pinmux config.
> > > > > > > > 
> > > > > > > > Which maybe ok if you update all uarts, but currently only serial0
> > > > > > > > is updated. So the other uarts current 'default' is actually the same as serial0
> > > > > > > > 'manual-rts' grouping, which conceptually is odd.
> > > > > > > > 
> > > > > > > > Would it not be better to make 'manual-rts' the default state? As that aligns
> > > > > > > > to what is currently already the default for the other UARTS? And then make
> > > > > > > > hw-flow-control the optional state for serial0?
> > > > > > > > 
> > > > > > > > That also has the advantage that 'default' has the same meaning with older DT's.
> > > > > > > 
> > > > > > > The reason it was done is this was because none of the other UARTs
> > > > > > > require 2 separate Pinctrl configurations, only this one.  Moreover,
> > > > > > > if they support RTS/CTS then I believe that the lines should be
> > > > > > > defined in Pinctrl.
> > > > > > 
> > > > > > Yes I agree with that.
> > > > > > 
> > > > > > > Thus, it was my plan to update all UART's default
> > > > > > > Pinctrl configs to include the RTS/CTS lines.
> > > > > > > 
> > > > > > 
> > > > > > I still don't see the point in changing the meaning of 'default' group and breaking
> > > > > > ABI if you don't need to?
> > > > > > 
> > > > > > As far as I can tell if you swap the meaning of 'default' and 'maunal-rts'
> > > > > > groups you get all the benefits of this series whilst also maintaining backwards
> > > > > > compatbility with older DT's.
> > > > > 
> > > > > What makes you think this will break ABI?
> > > > 
> > > > I've not tried it, but an older DT defines one group, 'default' which contains
> > > > the same pin config as your new optional 'manual-rts' group.
> > > > 
> > > > The driver now reads like the manual-rts pin config is optional and should be stored in
> > > > ascport->states[MANUAL_RTS]. An older DT will pass that same pin config as the default
> > > > group and it will be stored in ascport->states[DEFAULT].
> > > > 
> > > > That seems wrong to me, and if it executes OK it wouldn't be what you
> > > > expect by reading the code.
> > > 
> > > This makes no sense at a functional level.
> > > 
> > > Old kernel, old DTB:
> > > 
> > > ASC driver doesn't understand Pinctrl, but since only the "default"
> > > state is defined, that's what will be used as a matter of course.
> > > RTS/CTS aren't configured, but that doesn't matter because the DTS
> > > does not advertise that HW flow-control is available.  In this
> > > use-case neither HW flow-control, nor manual toggling of the RTS line
> > > is possible.
> > > 
> > > New kernel, old DTB:
> > > 
> > > ASC driver demands "default" and requests "manual-rts" Pinctrl states,
> > > but "manual-rts" isn't available so "default" will be the only
> > > utilised state.  Unlike the first example above, "default" now
> > > contains the RTS and CTS lines,
> > 
> > No it doesn't, default just contains 'tx' & 'rx' pins, as it has always
> > done until now.
> > 
> > Which is IMO where the condusion arises, as it is the same pin configuration
> > as what you are now calling 'manual-rts' which the driver just tried and failed
> > to obtain (although in reality it has actually obtained those pins but stored
> > them in DEFAULT instead.
> > 
> > I presume this is why it didn't make sense to you above.
> 
> I guess this is what happens when you try to explain semantics last
> thing, after a long day at work.  I chopped and changed the
> descriptions and the ordering of these and it looks like some
> peculiarities arose as a result.  Let me try again with a fresh(ish)
> mind.

It is what happens when your semantics are overly complicated ;)

> 
> New kernel, old DTB:
> 
> ASC driver demands "default" and requests "manual-rts" Pinctrl states,
> but "manual-rts" isn't available so "default" will be the only
> utilised state.  The RTS and CTS lines will not be present, but since
> the DTB is not advertising HW flow-control as a possibility, the IP
> will not try to use those lines anyway.  [DEFAULT] will contain the
> "default" state as proposed by the current DTB, so that is also
> semantically correct.
> 
> > >but since the DTS does not advertise
> > > HW flow-control as available they will be harmlessly unused.  This
> > > configuration culminates in the same result as the first example
> > > i.e. no HW flow-control and no manual toggling.  However, there are no
> > > detremental effects to the driver's functions. 
> > >
> > 
> > <snip>
> > 
> > >New kernel, new DTB:
> > > 
> > > ASC driver demands "default" and requests "manual-rts" Pinctrl
> > > states.  If DTS advertises that HW flow-control is possible and the
> > > client requests it, ASC will use the "default" state and HW
> > > flow-control will commence.  If HW flow-control is not requested by
> > > the client and "manual-rts" is available, then ASC will request the
> > > RTS line is handled by GPIO until such times as the client requests
> > > HW flow-control, at which point ASC will disable GPIO and request the
> > > "default" state again.
> > 
> > Unless it is uart 1 or 2, in which case 'default' still only contains
> > tx & rx pins, and you have the same situation as above. 
> 
> Doesn't matter. "default" is non-descriptive.  I could understand an
> argument were you to say that the "manual-rts" should not contain a
> non-manual-rts state, but the "default" state should just contain
> whatever the default configuration is, and in the case of UART 1 and
> UART 2 the default state (until they are HW flow-control enabled --
> which I plan to do as a follow-up) is not to provide HW flow-control
> pins.  These semantics are unchanged since authorship of the driver.
> 
> > > It is not possible to read C-code and make assumptions that the DTB
> > > will be in a particular state as you suggest.
> > > No disparity ever
> > > exists and the code is always clear IMHO.
> > > 
> > 
> > Really?
> 
> Yes.
> 
> > ascport->states[DEFAULT]: may contain "tx, rx" or "tx, rx, cts & rts"
> 
> Correct.  "DEFAULT" does not mean "HW flow-control only".  It's
> whatever the default is, so can correctly contain either state,
> depending on what the default state of the DTB is.
> 
> > ascport->states[MANUAL_RTS]: may contain "tx, rx", or it could be stored in DEFAULT
> 
> The last part of this is reiterating your previous point, which I
> just answered.  The correct description would be; "may contain *only*
> "tx, rx", allowing "rts" to be manually controlled OR, may not be
> populated".  In the latter case it would not be semantically incorrect
> for DEFAULT to be either HW flow-control capable "tx, rx, rts, cts" or
> not "tx, rx" -- whichever is the default of the supplied DTB.
> 
> > And as the series currently is you have a mixture of the two in the same kernel
> > depending on what instance of the UART you are.
> 
> Again, doesn't matter, since it's the DTB that provides the default
> state.  So, back when it was authored, the default state was HW
> flow-control disabled.  And in a newer DTB (again, until I follow-up
> with more changes), the defaults for UART 1 and UART 2 are HW
> flow-control disabled.
> 
> Your issue seems to be that you've assumed since we now provide the
> possibility of a "manual-rts" state, then the "default" state should
> *only* be HW flow-control capable, which is not the case.

No my feedback was that it would be clearer & simpler to make manual-rts the
'default' state, and 'hw-flow-control' the optional state.

> It's the
> 'uart-has-rtscts' property which determines this *not* whether the
> second state has been provided.

Yep, which is why IMO it makes more sense for the optional pin group to be the hw
flow control pins which are obtained if the uart-has-rtscts property is present.

>It is not logical to make any
> inference using solely the presence or absence of the "manual-rts"
> state.

My suggestion would mean 'default' continues to mean 'tx & rx' pins, and the presence
of 'uart-has-rtscts' would mean the driver attempts to obtain a hw-flow-control
pin group.

In this setup

ascport->states[DEFAULT]: always contains tx, rx
ascport->states[HWFLOW]: always contains tx, rx, cts, rts or nothing

and the presence or lack of rts-gpio controls manual RTS toggling. This seems
simpler than your current semantics, and still understandable even late at night
after a long day :)

regards,

Peter.
