From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v2 1/6] TTY: serial, remove BTM from wait_until_sent
Date: Wed, 10 Aug 2011 11:46:44 +0200
Message-ID: <4E425384.3040909@suse.cz>
References: <1310646915-3032-1-git-send-email-jslaby@suse.cz> <20110719003503.GA4138@amos.fritz.box> <4E3FE2D2.5020801@gmail.com> <20110810010933.GA4733@amos.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110810010933.GA4733@amos.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Bombe <aeb@debian.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On 08/10/2011 03:09 AM, Andreas Bombe wrote:
> On Mon, Aug 08, 2011 at 03:21:22PM +0200, Jiri Slaby wrote:
>> On 07/19/2011 02:35 AM, Andreas Bombe wrote:
>>> On Thu, Jul 14, 2011 at 02:35:10PM +0200, Jiri Slaby wrote:
>>>> This should also fix the issue Andreas is seeing (BTM in comparison to
>>>> BKL doesn't have any hidden functionality like unlocking during
>>>> sleeping).
>>>
>>> I tested the patch series and it does not appear to make a difference
>>> for the internal (16550A) serial ports on my system. Also, I am still
>>> unclear on why it freezes the X display during the timeout period.
>>
>> Sorry for the delay. Could you attach output of sysrq-t when this
>> happens? I mean with a kernel patched by my patch.
> 
> I did my simple test on ttyS0 again: "stty -F /dev/ttyS0 crtscts" then
> "echo >/dev/ttyS0". I attached the gzipped sysrq-t list in case you need
> the complete output. This is just the process while it is trying to
> close the device (bash's internal echo):
> 
> [  321.948012] bash            S ffff8800bcc85e80     0  4000   2828 0x00000000
> [  321.948012]  ffff880127079c38 0000000000000046 ffff880127079c50 0000000100002fff
> [  321.948012]  ffff880127079fd8 0000000000011fc0 ffff880127079fd8 0000000000011fc0
> [  321.948012]  ffff8801270dde80 ffff8800bcc85e80 ffff880127079c38 0000000100002fff
> [  321.948012] Call Trace:
> [  321.948012]  [<ffffffff813cdf2e>] schedule_timeout+0xb5/0xf2
> [  321.948012]  [<ffffffff8104ae2b>] ? call_timer_fn+0x154/0x154
> [  321.948012]  [<ffffffff81255d60>] tty_wait_until_sent+0xa3/0xec
> [  321.948012]  [<ffffffff8105a190>] ? __init_waitqueue_head+0x46/0x46
> [  321.948012]  [<ffffffff81268c05>] uart_close+0x12b/0x243
> [  321.948012]  [<ffffffff81250454>] ? __tty_fasync+0x5c/0x124
> [  321.948012]  [<ffffffff81251a00>] tty_release+0x1d3/0x4d7
> [  321.948012]  [<ffffffff813cfbd8>] ? _raw_spin_unlock+0x43/0x51
> [  321.948012]  [<ffffffff8110db81>] ? dput+0xfe/0x11d
> [  321.948012]  [<ffffffff810fdc86>] __fput+0x107/0x1a2
> [  321.948012]  [<ffffffff810fdd36>] fput+0x15/0x17
> [  321.948012]  [<ffffffff810fb014>] filp_close+0x69/0x75
> [  321.948012]  [<ffffffff81109654>] sys_dup3+0x12b/0x153
> [  321.948012]  [<ffffffff811096d5>] sys_dup2+0x59/0x60
> [  321.948012]  [<ffffffff813d0a12>] system_call_fastpath+0x16/0x1b
> 
> 
> [  321.948012] Sched Debug Version: v0.10, 3.1.0-rc1+ser-00011-g37ed45d #87

What tree is this? I cannot see the path through the code.

thanks,
-- 
js
suse labs
