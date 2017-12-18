From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 8/8] serdev: ttyport: do not used keyed wakeup in
 write_wakeup
Date: Mon, 18 Dec 2017 12:03:06 +0100
Message-ID: <20171218110306.GH5185@localhost>
References: <20171103143059.20749-1-johan@kernel.org>
 <20171103143059.20749-9-johan@kernel.org>
 <20171128150418.GA3341@kroah.com>
 <20171128151629.GA8177@localhost>
 <20171128193926.GA1696@kroah.com>
 <20171129094802.GA2708@localhost>
 <20171215192608.GB27395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171215192608.GB27395@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 15, 2017 at 08:26:08PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 29, 2017 at 10:48:02AM +0100, Johan Hovold wrote:
> > On Tue, Nov 28, 2017 at 08:39:26PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 28, 2017 at 04:16:29PM +0100, Johan Hovold wrote:
> > > > On Tue, Nov 28, 2017 at 04:04:18PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Fri, Nov 03, 2017 at 03:30:59PM +0100, Johan Hovold wrote:
> > > > > > Serdev does not use the file abstraction and specifically there will
> > > > > > never be anyone polling a file descriptor for POLLOUT events.
> > > > > > 
> > > > > > Just use plain wake_up_interruptible() in the write_wakeup callback and
> > > > > > document why it's there.
> > > > > > 
> > > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > > > ---
> > > > > >  drivers/tty/serdev/serdev-ttyport.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > This patch didn't apply, perhaps because I split this series across my
> > > > > "for-next" and "for-linus" branches?
> > > > 
> > > > That's right, this one depends on patch 4/8.
> > > > 
> > > > Perhaps you can take also this one through tty-linus? Or even better,
> > > > just take the whole series through tty-linus?
> > > 
> > > They all didn't feel like patches to go in after -rc1, right?
> > > Documentation updates?  Minor tweaks?  Would you want to defend them?
> > > :)
> > 
> > I agree that it's borderline, but the documentation update (patch 3/8)
> > is related to the first two bug fixes, where a negative return value
> > from a serdev driver could have triggered those bugs, so in a sense we
> > are fixing the docs.
> > 
> > Patch 6 and 8 are clean ups, but the open lock clean up in patch 6 is
> > related to the close lock fix in patch 5.
> > 
> > Patch 7 avoids a potential crash, albeit something that would not affect
> > any mainline drivers (as serial-core sets CLOCAL by default).
> > 
> > But I'm perfectly fine with holding them off for 4.16. Perhaps you can
> > just merge back rc2 and I can resubmit the final patch which didn't
> > apply after that.
> 
> I've "merged back" now, care to resend the remaining patches?

Just did so. It was just this this single patch that had not yet been
applied.

Thanks,
Johan
