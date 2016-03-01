From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] serial: flush ldisc after hangup
Date: Tue, 1 Mar 2016 14:04:12 -0500
Message-ID: <56D5E7AC.9040405@fb.com>
References: <1456855375-17175-1-git-send-email-jbacik@fb.com>
 <56D5DCA0.2040201@hurleysoftware.com> <56D5DDA6.5080605@fb.com>
 <56D5E714.7030900@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D5E714.7030900@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/01/2016 02:01 PM, Peter Hurley wrote:
> On 03/01/2016 10:21 AM, Josef Bacik wrote:
>> On 03/01/2016 01:17 PM, Peter Hurley wrote:
>
>>> Yeah, the race is that the ldisc should not be attempting i/o to
>>> the driver at all. This problem is fixed in -next already, but in
>>> the tty core rather than in each individual tty driver.
>>>
>>
>> Great!  Which patch/patches fix this?  I looked at linux-next and
>> there's a lot of refactoring stuff, do I need all the things or is
>> there a specific one that fixes this problem?  Thanks,
>
> The series that fixes this design problem introduce in 3.10 are these
> patches:
>
>    staging: digi: Replace open-coded tty_wakeup()
>    serial: 68328: Remove bogus ldisc reset
>    bluetooth: hci_ldisc: Remove dead code
>    NFC: nci: Remove dead code
>    tty: Remove chars_in_buffer() line discipline method
>    tty: Fix unsafe ldisc reference via ioctl(TIOCGETD)
>    n_tty: Fix unsafe reference to "other" ldisc
>    tty: Reset c_line from driver's init_termios
>    staging/speakup: Use tty_ldisc_ref() for paste kworker
>    tty: Fix comments for tty_ldisc_get()
>    tty: Fix comments for tty_ldisc_release()
>    tty: Prepare for destroying line discipline on hangup
>    tty: Handle NULL tty->ldisc
>    tty: Move tty_ldisc_kill()
>    tty: Use 'disc' for line discipline index name
>    tty: Refactor tty_ldisc_reinit() for reuse
>    tty: Destroy ldisc instance on hangup
>
> 'tty: Fix unsafe ldisc reference via ioctl(TIOCGETD)' and
> 'tty: Fix unsafe reference to "other" ldisc' have already
> made their way to most stable trees, afaict.
>
> I doubt I'll submit any more of this series for stable;
> it's just too invasive. I'll probably do it per-driver, like
> your patch. Just an fyi.
>

That's fine, we aren't afraid to pull back lots of stuff to our kernels, 
as long as they are destined for upstream.  Thanks for the help!

Josef
