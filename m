From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
Date: Mon, 17 Sep 2012 04:37:50 -0700
Message-ID: <20120917113750.GA28838@kroah.com>
References: <20120913150133.GA16238@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120913150133.GA16238@lizard>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Alan Cox <alan@linux.intel.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 13, 2012 at 08:01:33AM -0700, Anton Vorontsov wrote:
> Hi all,
> 
> Here comes the lucky v7:
> 
> - Per Alan Cox's suggestion added hangup method and removed a small
>   leftover;
> - Per Colin Cross' suggestion moved IRQ quiescing logic into
>   poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
>   result, clear_irq() callback dropped.
> 
> These patches can be found in the following repo (based on tty-next):
> 
> 	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master
> 
> Old changelogs and rationale for these patches can be found here:
> 
> 	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
> 	v6: http://lkml.org/lkml/2012/9/10/2

I have no objection to these patches, and as they are based on my
tty-next tree, should I be the ones accepting them?  If so, then I need
a bunch of acks from others involved in the kdb/kgdb code before I can
do so.

To make it easier, can I just take the tty driver patches now?  Will
that break anything?

thanks,

greg k-h
