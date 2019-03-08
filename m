From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Date: Fri, 8 Mar 2019 16:53:52 +0100
Message-ID: <20190308155352.g43mt44adau6cgh6@pathway.suse.cz>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Owens <calvinowens@fb.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri 2019-03-01 16:48:19, Calvin Owens wrote:
> This patch embeds a device struct in the console struct, and registers
> them on a "console" bus so we can expose attributes in sysfs.
> 
> Early console structures must still be static, since they're required
> before we're able to allocate memory. The least ugly way I can come up
> with to handle this is an "is_static" flag in the structure which makes
> the gets and puts NOPs, and is checked in ->release() to catch mistakes.

I wonder if it might get detected by is_kernel_inittext().

Best Regards,
Petr
