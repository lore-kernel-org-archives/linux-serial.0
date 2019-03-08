From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Date: Fri, 08 Mar 2019 03:56:19 +0100
Message-ID: <87ef7ioyzw.fsf@linutronix.de>
References: <cover.1551486732.git.calvinowens@fb.com>
        <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Owens <calvinowens@fb.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2019-03-02, Calvin Owens <calvinowens@fb.com> wrote:
> This patch embeds a device struct in the console struct, and registers
> them on a "console" bus so we can expose attributes in sysfs.

I expect that "class" would be more appropriate than "bus". These
devices really are grouped together based on their function and not the
medium by which they are accessed.

John Ogness
