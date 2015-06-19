From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Date: Fri, 19 Jun 2015 15:49:58 -0700
Message-ID: <20150619224958.GA27925@kroah.com>
References: <1434647946.861556@landley.net>
 <1434647946.861922@landley.net>
 <20150618175931.GA11748@kroah.com>
 <5584902C.5010309@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5584902C.5010309@landley.net>
Sender: linux-sh-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 19, 2015 at 04:57:00PM -0500, Rob Landley wrote:
> On 06/18/2015 12:59 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jun 18, 2015 at 10:19:19AM -0700, Rob Landley wrote:
> >> Changes to existing files to add 0pf j2 board support.
> >>
> > 
> > That's the second worse commit message and subject: line I've read
> > today.
> > 
> > And there's no signed off by line.
> 
> My bad. I've always sucked at filling out paperwork, and I didn't expect
> this to go in as is. But for the sake of following the official
> procedures (well, step 11 of of SubmittingPatches, it's not mentioned in
> any of the 26 steps of SubmitChecklist), here's the requested certification:
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> Reviewed-by: D. Jeff Dionne <jeff@uclinux.org>

You didn't do the 26 steps of SubmitChecklist, as step 5 would have
caught almost all of these issues.

> > And there was no 1/2 patch sent.
> 
> I sent one, which made it to the archive...
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1506.2/02539.html

But you didn't cc: me on that, how am I supposed to know?

> > And, most importantly:
> > 
> >> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > 
> > I don't care about arch/sh/ stuff, why are you sending this to me?
> 
> $ scripts/get_maintainer.pl j2-oldfiles.patch | grep Greg
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:SERIAL DRIVERS)
> 
> Sorry, my bad, I was trying to follow the documented procedure.
> Personally I'd have trimmed the cc: list but filling things out in
> triplicate seems to be all the rage these days.

No, you need to break your patch up properly, a single patch hitting all
of these files has never been ok.

> > You have a bit of work to do here...
> 
> As I mentioned in 0/2, yes. But "release early, release often" and all that.
> 
> (Or did we stop doing that now the Linux Foundation's in charge?

Seriously?  It's one thing to cc: a ton of people with a patch that for
90% of it, isn't relevant to them, and isn't even something they can do
anything with.  It's another thing to rant against those who try to
point out how to solve your issues.

> I'm still stuck in the hobbyist era from back before we had a
> foundation with committees and a hierarchy where you need to go
> through proper channels and three dozen patch submission steps in two
> different files and all that. I'm trying to keep up, but I've always
> been really bad at bureaucracy...)

There is no such thing here, you know better than that, stop trying to
troll, it's not very becoming.

greg k-h
