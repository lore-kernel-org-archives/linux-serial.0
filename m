From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Wed, 26 Jul 2017 22:08:04 +0900
Message-ID: <20170726130804.GB2173@jagdpanzerIV.localdomain>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500036673-7122-3-git-send-email-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (07/14/17 14:51), Petr Mladek wrote:
> printk_late_init() is responsible for disabling boot consoles that
> use init memory. It checks the address of struct console for this.
> 
> But this is not enough. For example, there are several early
> consoles that have write() method in the init section and
> struct console in the normal section. They are not disabled
> and could cause fancy and hard to debug system states.
> 
> It is even more complicated by the macros EARLYCON_DECLARE() and
> OF_EARLYCON_DECLARE() where various struct members are set at
> runtime by the provided setup() function.
> 
> I have tried to reproduce this problem and forced the classic uart
> early console to stay using keep_bootcon parameter. In particular
> I used earlycon=uart,io,0x3f8 keep_bootcon console=ttyS0,115200.
> The system did not boot:
> 
> [    1.570496] PM: Image not found (code -22)
> [    1.570496] PM: Image not found (code -22)
> [    1.571886] PM: Hibernation image not present or could not be loaded.
> [    1.571886] PM: Hibernation image not present or could not be loaded.
> [    1.576407] Freeing unused kernel memory: 2528K
> [    1.577244] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> 
> The double lines are caused by having both early uart console and
> ttyS0 console enabled at the same time. The early console stopped
> working when the init memory was freed. Fortunately, the invalid
> call was caught by the NX-protexted page check and did not cause
> any silent fancy problems.
> 
> This patch adds a check for many other addresses stored in
> struct console. It omits setup() and match() that are used
> only when the console is registered. Therefore they have
> already been used at this point and there is no reason
> to use them again.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
