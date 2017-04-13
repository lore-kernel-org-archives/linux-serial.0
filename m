From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Thu, 13 Apr 2017 09:07:40 -0700
Message-ID: <CA+55aFwgiAmy4Gw4RosbNVBJmOG-WQoZKOd76Ziuqx5CzPFMZQ@mail.gmail.com>
References: <20170326110432.GA9241@kroah.com> <CAOMGZ=F8xdUHnZaDo18DkkrYgacx6y8Cm=f8-8xnuvPupepnfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMGZ=F8xdUHnZaDo18DkkrYgacx6y8Cm=f8-8xnuvPupepnfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 13, 2017 at 3:50 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
>
> I've bisected a syzkaller crash down to this commit
> (5362544bebe85071188dd9e479b5a5040841c895). The crash is:
>
> [   25.137552] BUG: unable to handle kernel paging request at 0000000000002280
> [   25.137579] IP: mutex_lock_interruptible+0xb/0x30

It would seem to be the

                if (mutex_lock_interruptible(&ldata->atomic_read_lock))

call in n_tty_read(), the offset is about right for a NULL 'ldata'
pointer (it's a big structure, it has a couple of character buffers of
size N_TTY_BUF_SIZE).

I don't see the obvious fix, so I suspect at this point we should just
revert, as that commit seems to introduce worse problems that it is
supposed to fix. Greg?

              Linus
