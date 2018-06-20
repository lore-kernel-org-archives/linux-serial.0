From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
Date: Wed, 20 Jun 2018 11:44:13 +0900
Message-ID: <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop> <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz> <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619223447.4369748b@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 20, 2018 at 11:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Perhaps we should do an audit of the console drivers and remove all
> printk, pr_* , WARN*, BUG* from them.

Only the actual _printing_ parts.

Just randomly, look at drivers/tty/vt/vt.c that does a lot of
printing, and there's a lot of valid printing. Things like

        pr_warn("Unable to create device for %s; errno = %ld\n", ..

is fine - it's done at console registration time if things go sideways.

But there are a few commented-out calls to "printk()" that are
obviously bogus, because they are in the printing path.

And they damn well should be commented out. The existence of something
like that SHOULD ABSOLUTELY NOT be seen as a "hey, let's make up some
crazy garbage locking ruls that would allow printing there".

Just don't do it. It's that simple.

                  Linus
