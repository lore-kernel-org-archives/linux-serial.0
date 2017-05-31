From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Wed, 31 May 2017 20:16:12 +0900
Message-ID: <20170531111612.GA6332@kroah.com>
References: <CA+55aFwgiAmy4Gw4RosbNVBJmOG-WQoZKOd76Ziuqx5CzPFMZQ@mail.gmail.com>
 <20170413183403.GA16022@kroah.com>
 <CAOMGZ=G9t7ih=ydr=fkKn6cbgu5-qbdQs7XChmn=d598H95QVA@mail.gmail.com>
 <20170414123029.GA17217@kroah.com>
 <CACT4Y+acU1xTZEo+oeBvZL__c12bzcSPa0CBfDiw4j7+CUjfDg@mail.gmail.com>
 <CAOMGZ=GJah0GNXzscGGkYgScbZaeSM_TpxmrLZuxhrqWmBX9BQ@mail.gmail.com>
 <20170503120101.GA21119@kroah.com>
 <CACT4Y+arELXuPr7psYFETt6NrDNgeS=tP=jGhP4a0_C_8Fa=LA@mail.gmail.com>
 <20170530130905.382487d5@alans-desktop>
 <CACT4Y+aoRRao41hGpVkO+qVk9TB5ZSPiRpQxp7H9EN+RqW-1-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+aoRRao41hGpVkO+qVk9TB5ZSPiRpQxp7H9EN+RqW-1-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Vegard Nossum <vegard.nossum@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 31, 2017 at 10:39:23AM +0200, Dmitry Vyukov wrote:
> On Tue, May 30, 2017 at 2:09 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> >> I'll think about possible solutions, but I have no prior experience
> >> >> with the tty code. In the meantime syzkaller also hit a couple of
> >> >> other fun tty/pty bugs including a write/ioctl race that results in
> >> >> buffer overflow :-/
> >
> > There are several of those, including some of that have been documented
> > for years but nobody ever volunteered to fix - in particular all the
> > interfaces that push characters to the tty other than via the normal
> > interrupt receive path are dodgy (console selection in particular)
> >
> > The original tty model btw was that setting the ldisc to n_tty cannot
> > fail, and the structure allocated was smaller than a page size so was
> > safe.
> >
> > The simple way to fix it is to restore that behaviour by adding a 'null'
> > ldisc that we can fail to instead of N_TTY since the N_TTY failback path
> > is long broken.
> 
> Greg, what do you think about this patch? Are you ready to accept
> something like this?
> Definitely shorter than changing all drivers.

Yes, it looks reasonable to me.
