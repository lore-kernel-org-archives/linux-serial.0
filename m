From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Tue, 19 Jun 2018 22:34:47 -0400
Message-ID: <20180619223447.4369748b@vmware.local.home>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
        <20180618143818.50b2f2f9@alans-desktop>
        <20180619005308.GA405@jagdpanzerIV>
        <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
        <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 20 Jun 2018 11:01:49 +0900
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> There is no valid reason why an UART driver should do a printk() of
> any sort inside the critical region where the console is locked.
> 
> Just remove those printk's, don't add new crazy locking.

Perhaps we should do an audit of the console drivers and remove all
printk, pr_* , WARN*, BUG* from them.

-- Steve
