From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/7] tty: core: Add tty_debug() for printk(KERN_DEBUG)
 messages
Date: Wed, 05 Aug 2015 14:33:37 -0400
Message-ID: <55C25701.8030305@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com> <1436755753-7746-3-git-send-email-peter@hurleysoftware.com> <20150724013544.GA13905@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150724013544.GA13905@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/23/2015 09:35 PM, Greg Kroah-Hartman wrote:
> On Sun, Jul 12, 2015 at 10:49:08PM -0400, Peter Hurley wrote:
>> Introduce tty_debug() macro to output uniform debug information for
>> tty core debug messages (function name and tty name).
>>
>> Note: printk(KERN_DEBUG) is retained here over pr_debug() since
>> messages can be enabled in non-DEBUG builds.
> 
> But pr_debug() is the "standard" way to enable/disable debugging
> messages, so I'd really like to see that be used here.

Ok, I can do that; I'll roll Joe's suggestions in at that time.

> Even better, this is a tty device, so it should be using dev_dbg(),
> which gives us tons of good information built-in for the tty and can
> properly be parsed by userspace tools to know exactly what device caused
> what message at what point in time.
> 
> So I'll take this for now, but moving it to use dev_dbg() would be best
> eventually.

The issue with using dev_dbg is that (SysV) ptys are not devices. However,
if you'd prefer, I could rework this macro to format output like dev_dbg;
ie., <driver> <tty name>: <fmt>

Regards,
Peter Hurley
