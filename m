From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 1/2] printk/console: Always disable boot consoles that
 use init memory before it is freed
Date: Wed, 26 Jul 2017 22:07:31 +0900
Message-ID: <20170726130731.GA2173@jagdpanzerIV.localdomain>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-2-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500036673-7122-2-git-send-email-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (07/14/17 14:51), Petr Mladek wrote:
> From: Matt Redfearn <matt.redfearn@imgtec.com>
> 
> Commit 4c30c6f566c0 ("kernel/printk: do not turn off bootconsole in
> printk_late_init() if keep_bootcon") added a check on keep_bootcon to
> ensure that boot consoles were kept around until the real console is
> registered.
> 
> This can lead to problems if the boot console data and code are in the
> init section, since it can be freed before the boot console is
> unregistered.
> 
> Commit 81cc26f2bd11 ("printk: only unregister boot consoles when
> necessary") fixed this a better way. It allowed to keep boot consoles
> that did not use init data. Unfortunately it did not remove the check
> of keep_bootcon.
> 
> This can lead to crashes and weird panics when the bootconsole is
> accessed after free, especially if page poisoning is in use and the
> code / data have been overwritten with a poison value.
> 
> To prevent this, always free the boot console if it is within the init
> section. In addition, print a warning about that the console is removed
> prematurely.
> 
> Finally there is a new comment how to avoid the warning. It replaced
> an explanation that duplicated a more comprehensive function
> description few lines above.
> 
> Fixes: 4c30c6f566c0 ("kernel/printk: do not turn off bootconsole in printk_late_init() if keep_bootcon")
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> [pmladek@suse.com: print the warning, code and comments clean up]
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
