From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Fri, 22 Jun 2018 17:21:00 +0100
Message-ID: <20180622172100.2293b5e5@alans-desktop>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
        <20180618143818.50b2f2f9@alans-desktop>
        <20180619005308.GA405@jagdpanzerIV>
        <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
        <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
        <20180619223447.4369748b@vmware.local.home>
        <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 20 Jun 2018 11:44:13 +0900
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jun 20, 2018 at 11:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Perhaps we should do an audit of the console drivers and remove all
> > printk, pr_* , WARN*, BUG* from them.  
> 
> Only the actual _printing_ parts.

No because they are normally rather useful because that port isn't the
console. If you trylock it as I suggested then at least you'd just drop
the recursive cases and get messages otherwise.

Really that's all that you need - log the message to whichever console
targets you can currently safely do so. If it's none well there was
always the proposed morse code keyboard light driver 8)

Alan
