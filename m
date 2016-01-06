From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
Date: Wed, 6 Jan 2016 10:07:00 +0000
Message-ID: <20160106100700.GA19062@n2100.arm.linux.org.uk>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
 <20151224164723.GK8644@n2100.arm.linux.org.uk>
 <CAPKp9ubdS+R8U-W+LxYEp_sGxZVBDGBJ48+N7Pw3k9A+=F4pww@mail.gmail.com>
 <20160105123018.GU19062@n2100.arm.linux.org.uk>
 <20160106024302.GA20634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160106024302.GA20634@kroah.com>
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
Cc: Peter Hurley <peter@hurleysoftware.com>, andre.przywara@arm.com, Timur Tabi <timur@codeaurora.org>, andrew.jackson@arm.com, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, shijie.huang@arm.com, jslaby@suse.com, jun.nie@linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 05, 2016 at 06:43:02PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Jan 05, 2016 at 12:30:19PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 05, 2016 at 12:12:31PM +0000, Sudeep Holla wrote:
> > > Hi Russell,
> > > 
> > > On Thu, Dec 24, 2015 at 4:47 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> > > >> The REG_x macros are indices into a table, not register offsets.  Since
> > > >> earlycon does not have access to the vendor data, we can currently only
> > > >> support standard ARM PL011 devices.
> > > >>
> > > >> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> > > >
> > > > Please credit me with the change; this was obviously a change I made
> > > > when I posted the updated patches, which Greg had failed to take
> > > > instead of the original set.  Thanks.
> > > >
> > > 
> > > I don't see this patch in linux-next. Without this it fails to boot(panics) on
> > > ARM64 when earlycon is enabled.
> > 
> > I guess that's the way 4.4 is going to be then, because GregKH has not
> > been anywhere near "responsive" during the last cycle, but he did say
> > yesterday (in response to questions about driver model stuff) that he's
> > closed his trees for the merge window last week.
> > 
> > All in all, this situation is entirely GregKH's making, as he took the
> > wrong set of patches, and has yet to respond to _any_ of the resulting
> > mails about it... I guess GregKH knows what he's doing as he's one of
> > the top (and vocal) kernel developers far more than I do, so I guess he
> > has his reasons for crapping up the AMBA PL011 driver...
> 
> "plenty of time"?  I see Timur's patches to fix this were sent on
> December 24th.  Then fixed up and resent on January 4th. I see nothing
> in my todo queue that were sent earlier to resolve any of this horrid
> mess.
> 
> So yes, I haven't done anything with the Jan 04 patch, given that it's
> been 24 hours since it was sent, that's totally reasonable.

The first series of 11 patches was sent on November 3rd.  The problem at
the root of this issue was discovered on the very same day, and is a part
of the thread.  People reviewed and tested it, and other comments were
made.

These were addressed, and the next series of 12 patches were sent on the
16th November.

On the 12th November, you decided it was time to pick up the first series
of patches and ignore the second series, despite the comments against the
first series indicating that there were problems.

It was only realised on the 24th that you'd picked up the wrong set of
patches.

> You all were throwing huge numbers of patches here for this tiny driver
> and digging through the mess was a major pain.

That statement is doing nothing but trying to deflect the blame for
this mistake on to other people.

11 or 12 patches is not "huge numbers of patches" and a driver of 2600
lines is not "tiny".  In total, it's _only_ 11 + 12 patches.  That is
not "huge" by any sense of the word.

What would you prefer?  One patch making multiple changes?  Aren't we
always telling people to split up their changes?  I guess you're
different because of your patch load...

> Turned out I guessed
> wrong, and asked for a patch to fix up the mess once that was
> determined.

I don't see why there should've been any guessing.  One series of 11
patches posted on 3rd November vs a second series of 12 patches posted
on the 16th November.  Later date, one more patch.  How could there
have been any guessing?

> That didn't arrive until the yesterday in a format that
> might be acceptable.  Quite a while after this all was determined to be
> "broken".

The original patch set was found to be broken on the 3rd November, and
there's emails to prove it.

> If you all think you could do better with the patch load you all were
> throwing at me, well, good for you.  It's mighty easy to complain when
> it isn't your inbox...  And I really don't care at all about this little
> driver, you all do, and yet you all can't agree what to do about it, so
> to somehow claim that I know better is a joke.

Right, so what you're saying is that you're overloaded, and can't cope
with the amount of work that you've chosen to take on.  The one thing
that's missing from your message is to ask whether someone is willing
to take on maintanence of the driver.  Well, that's an interesting
subject, because in theory, I _never_ delegated maintanence and patch
handling to anyone else:

ARM PRIMECELL UART PL010 AND PL011 DRIVERS
M:      Russell King <linux@arm.linux.org.uk>
S:      Maintained
F:      drivers/tty/serial/amba-pl01*.c
F:      include/linux/amba/serial.h

but someone decided "I own drivers/tty..., so all patches _must_
come through me" which is a frequent pattern I've seen forming over
the years that we've had the kernel in SCMs.

So, I guess the answer is for me to take back responsibility for
merging patches for this driver and send pull requests for it
directly to Linus.

Please merge what you have, and when it's merged, I'll resolve the
differences between what you have merged and what _should_ have been
merged.  I'll send fixes directly to Linus, and from then on I'll be
looking after this driver.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
