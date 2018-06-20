From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
Date: Wed, 20 Jun 2018 12:38:01 +0900
Message-ID: <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop> <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz> <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180620025050.GE650@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620025050.GE650@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 20, 2018 at 11:50 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> It's not UART on its own that immediately calls into printk(), that would
> be trivial to fix, it's all those subsystems that serial console driver
> can call into.

We already have the whole PRINTK_SAFE_CONTEXT_MASK model that only
adds it to a secondary buffer if you get recursion.  Why isn't that
triggering? That's the whole point of it.

I absolutely do *not*  want to see any crazy changes to tty drivers.  No no no.

                   Linus
