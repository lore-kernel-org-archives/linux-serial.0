From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Tue, 2 May 2017 23:52:40 +0200
Message-ID: <CAOMGZ=GJah0GNXzscGGkYgScbZaeSM_TpxmrLZuxhrqWmBX9BQ@mail.gmail.com>
References: <20170326110432.GA9241@kroah.com> <CAOMGZ=F8xdUHnZaDo18DkkrYgacx6y8Cm=f8-8xnuvPupepnfg@mail.gmail.com>
 <CA+55aFwgiAmy4Gw4RosbNVBJmOG-WQoZKOd76Ziuqx5CzPFMZQ@mail.gmail.com>
 <20170413183403.GA16022@kroah.com> <CAOMGZ=G9t7ih=ydr=fkKn6cbgu5-qbdQs7XChmn=d598H95QVA@mail.gmail.com>
 <20170414123029.GA17217@kroah.com> <CACT4Y+acU1xTZEo+oeBvZL__c12bzcSPa0CBfDiw4j7+CUjfDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+acU1xTZEo+oeBvZL__c12bzcSPa0CBfDiw4j7+CUjfDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2 May 2017 at 18:35, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Apr 14, 2017 at 2:30 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Fri, Apr 14, 2017 at 11:41:26AM +0200, Vegard Nossum wrote:
>>> On 13 April 2017 at 20:34, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> > On Thu, Apr 13, 2017 at 09:07:40AM -0700, Linus Torvalds wrote:
>>> >> On Thu, Apr 13, 2017 at 3:50 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
>>> So the original problem is that the vmalloc() in n_tty_open() can
>>> fail, and that will panic in tty_set_ldisc()/tty_ldisc_restore()
>>> because of its unwillingness to proceed if the tty doesn't have an
>>> ldisc.
>>>
>>> Dmitry fixed this by allowing tty->ldisc == NULL in the case of memory
>>> allocation failure as we can see from the comment in tty_set_ldisc().
>>>
>>> Unfortunately, it would appear that some other bits of code do not
>>> like tty->ldisc == NULL (other than the crash in this thread, I saw
>>> 2-3 similar crashes in other functions, e.g. poll()). I see two
>>> possibilities:
>>>
>>> 1) make other code handle tty->ldisc == NULL.
>>>
>>> 2) don't close/free the old ldisc until the new one has been
>>> successfully created/initialised/opened/attached to the tty, and
>>> return an error to userspace if changing it failed.
>>>
>>> I'm leaning towards #2 as the more obviously correct fix, it makes
>>> tty_set_ldisc() transactional, the fix seems limited in scope to
>>> tty_set_ldisc() itself, and we don't need to make every other bit of
>>> code that uses tty->ldisc handle the NULL case.
>>
>> That sounds reasonable to me, care to work on a patch for this?
>
> Vegard, do you know how to do this?
> That was first thing that I tried, but I did not manage to make it
> work. disc is tied to tty, so it's not that one can create a fully
> initialized disc on the side and then simply swap pointers. Looking at
> the code now, there is at least TTY_LDISC_OPEN bit in tty. But as far
> as I remember there were more fundamental problems. Or maybe I just
> did not try too hard.

I had a look at it but like you said, the tty/ldisc relationship is
complicated :-/

Maybe we can split up ldisc initialisation into two methods so that
the first one (e.g. ->alloc) does all the allocation and is allowed to
fail and the second one (e.g. ->open) is not allowed to fail. Then you
can allocate a new ldisc without freeing the old one and only swap
them over if the allocation succeeded.

That would require fixing up ->open for all the ldisc drivers though,
I'm not sure how easy/feasible it is.

I'll think about possible solutions, but I have no prior experience
with the tty code. In the meantime syzkaller also hit a couple of
other fun tty/pty bugs including a write/ioctl race that results in
buffer overflow :-/


Vegard
