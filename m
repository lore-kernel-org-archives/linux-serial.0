From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
Date: Tue, 5 Jan 2016 18:43:02 -0800
Message-ID: <20160106024302.GA20634@kroah.com>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
 <20151224164723.GK8644@n2100.arm.linux.org.uk>
 <CAPKp9ubdS+R8U-W+LxYEp_sGxZVBDGBJ48+N7Pw3k9A+=F4pww@mail.gmail.com>
 <20160105123018.GU19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160105123018.GU19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, andre.przywara@arm.com, Timur Tabi <timur@codeaurora.org>, andrew.jackson@arm.com, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, shijie.huang@arm.com, jslaby@suse.com, jun.nie@linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 05, 2016 at 12:30:19PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 05, 2016 at 12:12:31PM +0000, Sudeep Holla wrote:
> > Hi Russell,
> > 
> > On Thu, Dec 24, 2015 at 4:47 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> > >> The REG_x macros are indices into a table, not register offsets.  Since
> > >> earlycon does not have access to the vendor data, we can currently only
> > >> support standard ARM PL011 devices.
> > >>
> > >> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> > >
> > > Please credit me with the change; this was obviously a change I made
> > > when I posted the updated patches, which Greg had failed to take
> > > instead of the original set.  Thanks.
> > >
> > 
> > I don't see this patch in linux-next. Without this it fails to boot(panics) on
> > ARM64 when earlycon is enabled.
> 
> I guess that's the way 4.4 is going to be then, because GregKH has not
> been anywhere near "responsive" during the last cycle, but he did say
> yesterday (in response to questions about driver model stuff) that he's
> closed his trees for the merge window last week.
> 
> All in all, this situation is entirely GregKH's making, as he took the
> wrong set of patches, and has yet to respond to _any_ of the resulting
> mails about it... I guess GregKH knows what he's doing as he's one of
> the top (and vocal) kernel developers far more than I do, so I guess he
> has his reasons for crapping up the AMBA PL011 driver...

"plenty of time"?  I see Timur's patches to fix this were sent on
December 24th.  Then fixed up and resent on January 4th. I see nothing
in my todo queue that were sent earlier to resolve any of this horrid
mess.

So yes, I haven't done anything with the Jan 04 patch, given that it's
been 24 hours since it was sent, that's totally reasonable.

> I rather wish that I'd decided to do the same with the AMBA PL011 driver,
> because this seems to be the only sensible way of ensuring that the right
> set of patches get to Linus.
> 
> I had put the _right_ set of AMBA PL011 driver changes into linux-next
> just before Christmas, but Stephen Rothwell tells me that they merge
> without conflict with the set that Greg merged, and we still end up with
> the broken code.  So there's nothing I can do about it at this point.
> 
> As far as 4.4 goes, I think it's fate was sealed when Greg took the
> wrong set of patches.  It's Greg's problem to sort out now.

You all were throwing huge numbers of patches here for this tiny driver
and digging through the mess was a major pain.  Turned out I guessed
wrong, and asked for a patch to fix up the mess once that was
determined.  That didn't arrive until the yesterday in a format that
might be acceptable.  Quite a while after this all was determined to be
"broken".

If you all think you could do better with the patch load you all were
throwing at me, well, good for you.  It's mighty easy to complain when
it isn't your inbox...  And I really don't care at all about this little
driver, you all do, and yet you all can't agree what to do about it, so
to somehow claim that I know better is a joke.

greg k-h
