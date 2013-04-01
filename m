From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: n_tty_write() going into schedule but NOT coming out
Date: Mon, 1 Apr 2013 19:27:47 +0530
Message-ID: <5159925B.5050806@synopsys.com>
References: <5156DC21.20901@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5156DC21.20901@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Any thoughts: I observe the same issue even with CONFIG_PREEMPT and
CONFIG_PREEMPT_COUNT

-Vineet

On 03/30/2013 06:05 PM, Vineet Gupta wrote:
> Hi,
> 
> I've been stress testing ARC Linux 3.8 (same happens for 3.9-rc3 as well). The
> setup has 3 telnet sessions, each running find . -name "*" in a loop.
> The platform is a FPGA @ 80 MHz, running a single core ARC700 so kernel .config
> has !SMP and PREEMPT_NONE.
> 
> After ~10 mins of run, I see that one of the telnet session gets stuck (and later
> the 2nd one as well), while system is still alive, 3rd telnet is running find merrily.
> 
> [ARCLinux]$ ps
> ....
>     7 root       0:00 inetd
>    62 root       0:00 -/bin/sh
>    64 root       1:34 telnetd -i -l /bin/sh
>    65 root       0:00 /bin/sh
>    75 root       1:47 telnetd -i -l /bin/sh
>    76 root       0:00 /bin/sh
>    79 root       0:53 telnetd -i -l /bin/sh
>    80 root       0:00 /bin/sh
>   281 root       0:00 find / -name *	<--- stuck
>   358 root       0:03 find / -name *	<--- stuck
>   377 root       0:00 find / -name *
>   378 root       0:00 ps
> 
> Hung find task is sitting in the schedule() call in n_tty_write()
> 
> [ARCLinux]$ cat /proc/281/stack
> [<8065945e>] n_tty_write+0x23a/0x424
> [<80655cd4>] tty_write+0x1ac/0x2d4
> [<805976ba>] vfs_write+0x92/0x110
> [<80597816>] sys_write+0x4e/0x88
> [<8050e780>] ret_from_system_call+0x0/0x4
> 
> This task never resumes out of schedule() - verified by putting a hardware
> breakpoint on next insn - using a JTAG host debugger.
> 
> Attached are .config, /proc/281/sched, /proc/schedstat, /proc/sched_debug
> 
> My knowledge of schedular is close to none, hence any tips to debug this further
> would be much appreciated.
> 
> 
> TIA,
> -Vineet
> 
