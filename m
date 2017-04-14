From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Fri, 14 Apr 2017 11:41:26 +0200
Message-ID: <CAOMGZ=G9t7ih=ydr=fkKn6cbgu5-qbdQs7XChmn=d598H95QVA@mail.gmail.com>
References: <20170326110432.GA9241@kroah.com> <CAOMGZ=F8xdUHnZaDo18DkkrYgacx6y8Cm=f8-8xnuvPupepnfg@mail.gmail.com>
 <CA+55aFwgiAmy4Gw4RosbNVBJmOG-WQoZKOd76Ziuqx5CzPFMZQ@mail.gmail.com> <20170413183403.GA16022@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413183403.GA16022@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 13 April 2017 at 20:34, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 13, 2017 at 09:07:40AM -0700, Linus Torvalds wrote:
>> On Thu, Apr 13, 2017 at 3:50 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
>> >
>> > I've bisected a syzkaller crash down to this commit
>> > (5362544bebe85071188dd9e479b5a5040841c895). The crash is:
>> >
>> > [   25.137552] BUG: unable to handle kernel paging request at 0000000000002280
>> > [   25.137579] IP: mutex_lock_interruptible+0xb/0x30
>>
>> It would seem to be the
>>
>>                 if (mutex_lock_interruptible(&ldata->atomic_read_lock))
>>
>> call in n_tty_read(), the offset is about right for a NULL 'ldata'
>> pointer (it's a big structure, it has a couple of character buffers of
>> size N_TTY_BUF_SIZE).
>>
>> I don't see the obvious fix, so I suspect at this point we should just
>> revert, as that commit seems to introduce worse problems that it is
>> supposed to fix. Greg?
>
> Unless Dmitry has a better idea, I will just revert it and send you the
> pull request in a day or so.

I don't think we need to rush a revert, I'd hope there's a way to fix
it properly.

So the original problem is that the vmalloc() in n_tty_open() can
fail, and that will panic in tty_set_ldisc()/tty_ldisc_restore()
because of its unwillingness to proceed if the tty doesn't have an
ldisc.

Dmitry fixed this by allowing tty->ldisc == NULL in the case of memory
allocation failure as we can see from the comment in tty_set_ldisc().

Unfortunately, it would appear that some other bits of code do not
like tty->ldisc == NULL (other than the crash in this thread, I saw
2-3 similar crashes in other functions, e.g. poll()). I see two
possibilities:

1) make other code handle tty->ldisc == NULL.

2) don't close/free the old ldisc until the new one has been
successfully created/initialised/opened/attached to the tty, and
return an error to userspace if changing it failed.

I'm leaning towards #2 as the more obviously correct fix, it makes
tty_set_ldisc() transactional, the fix seems limited in scope to
tty_set_ldisc() itself, and we don't need to make every other bit of
code that uses tty->ldisc handle the NULL case.


Vegard
