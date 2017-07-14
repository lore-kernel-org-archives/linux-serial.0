From: "Fabio M. Di Nitto" <fdinitto@redhat.com>
Subject: Re: [PATCH 0/2] Avoid crashes by early (boot) consoles using init
 memory
Date: Fri, 14 Jul 2017 14:57:45 +0200
Message-ID: <956ce40c-1640-387a-0ec9-9045c7d8af4b@redhat.com>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500036673-7122-1-git-send-email-pmladek@suse.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Petr,

On 7/14/2017 2:51 PM, Petr Mladek wrote:
> Some early consoles have code and data in the init section. It makes some
> sense but this might cause problems when they are not replaced by
> the real console in time. The two patches fix the safequard and
> help to avoid the problems.
> 
> I though about removing keep_bootcon option completely. But it is useful
> at least for now.

Let´s just keep in mind that keep_bootcon was introduced only to debug
issues (read crashes or hangs) that could happen between disabling
bootconsole and enabling the real console. It shouldn´t be used for
anything else really.

If the new code can replace keep_bootcon, by all mean, go for it :-)

Cheers
Fabio

> There is not an easy way to disable a particular bootconsole
> when the related real console is installed. Instead all bootconsoles are
> removed when the preferred (last on the commandline) console is registered.
> But this is a bit cumbersome and non-intuitive.
> 
> In addition, the same problems might happen when the real console is
> registered using a deferred probe or when it is not registered at all
> for some reason.
> 
> The patchset is based on and inspired by the original patch from
> Matt Redfearn, see the discussion starting by the mail
> https://lkml.kernel.org/r/1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com
> 
> Matt Redfearn (1):
>   printk/console: Always disable boot consoles that use init memory
>     before it is freed
> 
> Petr Mladek (1):
>   printk/console: Enhance the check for consoles using init memory
> 
>  kernel/printk/printk.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
