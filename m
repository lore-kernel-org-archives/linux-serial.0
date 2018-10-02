From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] sc16is7xx: Fix for multi-channel stall
Date: Tue, 2 Oct 2018 13:36:53 -0700
Message-ID: <20181002203653.GA2397@kroah.com>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
 <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
 <6028e8e5-f8a6-fbe0-8d2a-b6bb3c91aa14@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6028e8e5-f8a6-fbe0-8d2a-b6bb3c91aa14@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Phil Elwell <phil@raspberrypi.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, Stefan Wahren <stefan.wahren@i2se.com>, Mian Yousaf Kaukab <yousaf.kaukab@suse.com>, Matthias Brugger <mbrugger@suse.com>, Michael Allwright <allsey87@gmail.com>, Jakub Kicinski <kubakici@wp.pl>, Xue Liu <liuxuenetmail@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 29, 2018 at 04:04:48PM +0200, Andreas Färber wrote:
> Hi Phil and Greg,
> 
> Am 12.09.18 um 16:31 schrieb Phil Elwell:
> > The SC16IS752 is a dual-channel device. The two channels are largely
> > independent, but the IRQ signals are wired together as an open-drain,
> > active low signal which will be driven low while either of the
> > channels requires attention, which can be for significant periods of
> > time until operations complete and the interrupt can be acknowledged.
> > In that respect it is should be treated as a true level-sensitive IRQ.
> > 
> > The kernel, however, needs to be able to exit interrupt context in
> > order to use I2C or SPI to access the device registers (which may
> > involve sleeping).  Therefore the interrupt needs to be masked out or
> > paused in some way.
> > 
> > The usual way to manage sleeping from within an interrupt handler
> > is to use a threaded interrupt handler - a regular interrupt routine
> > does the minimum amount of work needed to triage the interrupt before
> > waking the interrupt service thread. If the threaded IRQ is marked as
> > IRQF_ONESHOT the kernel will automatically mask out the interrupt
> > until the thread runs to completion. The sc16is7xx driver used to
> > use a threaded IRQ, but a patch switched to using a kthread_worker
> > in order to set realtime priorities on the handler thread and for
> > other optimisations. The end result is non-threaded IRQ that
> > schedules some work then returns IRQ_HANDLED, making the kernel
> > think that all IRQ processing has completed.
> > 
> > The work-around to prevent a constant stream of interrupts is to
> > mark the interrupt as edge-sensitive rather than level-sensitive,
> > but interpreting an active-low source as a falling-edge source
> > requires care to prevent a total cessation of interrupts. Whereas
> > an edge-triggering source will generate a new edge for every interrupt
> > condition a level-triggering source will keep the signal at the
> > interrupting level until it no longer requires attention; in other
> > words, the host won't see another edge until all interrupt conditions
> > are cleared. It is therefore vital that the interrupt handler does not
> > exit with an outstanding interrupt condition, otherwise the kernel
> > will not receive another interrupt unless some other operation causes
> > the interrupt state on the device to be cleared.
> > 
> > The existing sc16is7xx driver has a very simple interrupt "thread"
> > (kthread_work job) that processes interrupts on each channel in turn
> > until there are no more. If both channels are active and the first
> > channel starts interrupting while the handler for the second channel
> > is running then it will not be detected and an IRQ stall ensues. This
> > could be handled easily if there was a shared IRQ status register, or
> > a convenient way to determine if the IRQ had been deasserted for any
> > length of time, but both appear to be lacking.
> > 
> > Avoid this problem (or at least make it much less likely to happen)
> > by reducing the granularity of per-channel interrupt processing
> > to one condition per iteration, only exiting the overall loop when
> > both channels are no longer interrupting.
> > 
> > Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> These two patches seem to be applied in linux-next tree, but are lacking
> a Fixes: header for backporting to affected stable trees.
> 
> openSUSE Tumbleweed's 4.18 appears to be affected, and I didn't see it
> in linux.git for upcoming 4.19 either.
> 
> Can the commit message still be updated to get this fixed everywhere?

I can't change the tree, sorry, I can not rebase.

If you want these applied to the stable tree, please email
stable@vger.kernel.org when they hit Linus's tree with the git commit
ids and I will be glad to queue them up then.

thanks,

greg k-h
