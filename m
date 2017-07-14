From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] Avoid crashes by early (boot) consoles using init memory
Date: Fri, 14 Jul 2017 14:51:11 +0200
Message-ID: <1500036673-7122-1-git-send-email-pmladek@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

Some early consoles have code and data in the init section. It makes some
sense but this might cause problems when they are not replaced by
the real console in time. The two patches fix the safequard and
help to avoid the problems.

I though about removing keep_bootcon option completely. But it is useful
at least for now. There is not an easy way to disable a particular bootconsole
when the related real console is installed. Instead all bootconsoles are
removed when the preferred (last on the commandline) console is registered.
But this is a bit cumbersome and non-intuitive.

In addition, the same problems might happen when the real console is
registered using a deferred probe or when it is not registered at all
for some reason.

The patchset is based on and inspired by the original patch from
Matt Redfearn, see the discussion starting by the mail
https://lkml.kernel.org/r/1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com

Matt Redfearn (1):
  printk/console: Always disable boot consoles that use init memory
    before it is freed

Petr Mladek (1):
  printk/console: Enhance the check for consoles using init memory

 kernel/printk/printk.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
1.8.5.6
