From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: console=ttyS1 breaks ttyS1 termios and prevents me from logging in
Date: Wed, 8 Apr 2015 18:49:52 -0700
Message-ID: <CALCETrWXWTbVo-oY9ZmxwuHazRqnDqY+jHM46Dj2uZbKVjaEvg@mail.gmail.com>
References: <CALCETrVHeApB0_GxMkc88Giq6vLMpOz+wdZLmwhK7Ytumh2y6g@mail.gmail.com>
 <55259DB1.4080104@hurleysoftware.com> <CALCETrUmNKiJDvz2-Q5QBPuqOVA+z9S7As=Pmw1Ef4ZzTXhhSA@mail.gmail.com>
 <5525BA8D.8010708@hurleysoftware.com> <CALCETrX_ndZ6Df9D8fecK1QzWvJCJYNQFsTUhRVr5BzwRzkUrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrX_ndZ6Df9D8fecK1QzWvJCJYNQFsTUhRVr5BzwRzkUrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 8, 2015 at 5:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Apr 8, 2015 at 4:32 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 04/08/2015 05:40 PM, Andy Lutomirski wrote:
>>> On Wed, Apr 8, 2015 at 2:29 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> Hi Andy,
>>>>
>>>> On 04/08/2015 05:17 PM, Andy Lutomirski wrote:
>>>>> Something strange seems to have happened to my serial console setup.
>>>>> I boot with console=ttyS1,115200n8 and I have a getty running on
>>>>> /dev/ttyS1.
>>>>>
>>>>> On older kernels, or if I remove the console= boot parameter, then my
>>>>> getty works fine.  On 3.19.3 with the console= parameter, something's
>>>>> wrong with termios and I can't log in.  Running:
>>>>
>>>> Thanks for the report.
>>>> 1. Please attach your dmesg.
>>>> 2. Is this behavior new to 3.19.3? (iow, what was the last version
>>>>    that you noticed didn't do this)
>>>
>>> I didn't have the problem before I reinstalled this box, upgraded from
>>> 3.15 to 3.19.3, and updated by Dell iDRAC7 firmware.  Booting into
>>> 3.13-something does *not* fix the problem, so I'm not at all convinced
>>> that the kernel version matters much.  I'll try reverting the iDRAC7
>>> thing, but I don't see why that would make any difference at all to
>>> Linux.
>>
>> I think this is related to DRAC; maybe upgrading the firmware reset
>> the Serial communication settings in the system bios?
>>
>
> The DRAC pretends to be a 16550, so I don't understand how it could
> prevent Linux from reprogramming the line discipline.  Also, if I
> remove console=ttyS1,115200 from the kernel command line, it starts
> working again.
>
>> 1. What's your getty command line?
>
> /sbin/getty -8 115200 ttyS1
>
>
>> 2. Contents of /proc/tty/driver/serial when you think getty is running
>>    and waiting for login (shows line signals).
>
> With getty running:
>
> serinfo:1.0 driver revision:
> 0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
> 1: uart:16550A port:000002F8 irq:3 tx:19828 rx:2 RTS|CTS|DTR
> 2: uart:unknown port:000003E8 irq:4
> 3: uart:unknown port:000002E8 irq:3
> 4: uart:unknown port:00000000 irq:0
>
> (getty itself works fine)
>
> When I type a username, I get:
>
> serinfo:1.0 driver revision:
> 0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
> 1: uart:16550A port:000002F8 irq:3 tx:19848 rx:10 RTS|CTS|DTR
> 2: uart:unknown port:000003E8 irq:4
> 3: uart:unknown port:000002E8 irq:3
> 4: uart:unknown port:00000000 irq:0
>
> at that point, login is running, and it's login that doesn't work.
>
>>
>> Something to test is if you set getty to local line, does it work then.
>> I use agetty so my command line is:
>>         /sbin/getty --noreset -8L 115200 ttyS0 vt102
>
> I tried:
>
> # /sbin/getty --noreset -8L 115200 ttyS1 vt102
>
> it has exactly the same problem.
>
> By adding a whole bunch of printks, I see that both ttyS0 and ttyS1
> make it into uart_set_termios.  But now it's time to home...

OMFG I hate [insert long string of expletives] userspace bugs.

Some piece of crap user code regressed in some recent Ubuntu update
and left all the termios lock flags set on the console device,
presumably read from /proc/console.

So... false alarm, except that the kernel should maybe considering
disallowing such daft behavior or at least warning.  Now I get to
figure out *which* userspace program regressed.  I'm reasonably sure
it's either Plymouth or some horrendously buggy Debian/Ubuntu script
that controls it.

--Andy
