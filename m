From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Date: Fri, 8 Mar 2019 17:34:11 +0100
Message-ID: <20190308163411.GA12898@kroah.com>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
 <87ef7ioyzw.fsf@linutronix.de>
 <20190308155814.rzsjrzgwfcm4p5sk@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308155814.rzsjrzgwfcm4p5sk@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Calvin Owens <calvinowens@fb.com>, John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 08, 2019 at 04:58:14PM +0100, Petr Mladek wrote:
> On Fri 2019-03-08 03:56:19, John Ogness wrote:
> > On 2019-03-02, Calvin Owens <calvinowens@fb.com> wrote:
> > > This patch embeds a device struct in the console struct, and registers
> > > them on a "console" bus so we can expose attributes in sysfs.
> > 
> > I expect that "class" would be more appropriate than "bus". These
> > devices really are grouped together based on their function and not the
> > medium by which they are accessed.
> 
> Good point. "class" looks better to me as well.
> 
> Greg, any opinion, where to put the entries for struct console ?

Hang them off of the device that the console belongs to?

Classes and busses are almost identical except:
	- busses is the binding of a driver to a device (usb, pci, etc.)
	- classes are usually userspace interactions to a device (input,
	  tty, etc.)

So this sounds like a class to me.

If you want me to review this, I'll be glad to so do once 5.1-rc1 is
out...

thanks,

greg k-h
