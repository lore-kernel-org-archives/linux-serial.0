From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/7] tty: core: Add tty_debug() for printk(KERN_DEBUG)
 messages
Date: Wed, 5 Aug 2015 12:22:46 -0700
Message-ID: <20150805192246.GA32372@kroah.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
 <1436755753-7746-3-git-send-email-peter@hurleysoftware.com>
 <20150724013544.GA13905@kroah.com>
 <55C25701.8030305@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C25701.8030305@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 05, 2015 at 02:33:37PM -0400, Peter Hurley wrote:
> On 07/23/2015 09:35 PM, Greg Kroah-Hartman wrote:
> > On Sun, Jul 12, 2015 at 10:49:08PM -0400, Peter Hurley wrote:
> >> Introduce tty_debug() macro to output uniform debug information for
> >> tty core debug messages (function name and tty name).
> >>
> >> Note: printk(KERN_DEBUG) is retained here over pr_debug() since
> >> messages can be enabled in non-DEBUG builds.
> > 
> > But pr_debug() is the "standard" way to enable/disable debugging
> > messages, so I'd really like to see that be used here.
> 
> Ok, I can do that; I'll roll Joe's suggestions in at that time.
> 
> > Even better, this is a tty device, so it should be using dev_dbg(),
> > which gives us tons of good information built-in for the tty and can
> > properly be parsed by userspace tools to know exactly what device caused
> > what message at what point in time.
> > 
> > So I'll take this for now, but moving it to use dev_dbg() would be best
> > eventually.
> 
> The issue with using dev_dbg is that (SysV) ptys are not devices.

True :(

> However,
> if you'd prefer, I could rework this macro to format output like dev_dbg;
> ie., <driver> <tty name>: <fmt>

That would be good, as that's what userspace is expecting the messages
to look like.

thanks,

greg k-h
