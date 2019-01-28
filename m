From: shuah <shuah@kernel.org>
Subject: Re: [PATCH] tty: Fix WARNING in tty_set_termios
Date: Mon, 28 Jan 2019 14:29:22 -0700
Message-ID: <fe4018a7-19e4-cdd1-3095-bbe88a82788e@kernel.org>
References: <20190125232905.21727-1-shuah@kernel.org>
 <20190126041416.GF2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190126041416.GF2217@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca, samuel.thibault@ens-lyon.org, gregkh@linuxfoundation.org, robh@kernel.org, jslaby@suse.com, sameo@linux.intel.com, davem@davemloft.net, arnd@arndb.de, nishka.dasgupta_ug18@ashoka.edu.in, m.maya.nakamura@gmail.com, santhameena13@gmail.com, zhongjiang@huawei.com, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, speakup@linux-speakup.org, devel@driverdev.osuosl.org, linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, shuah <shuah@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 1/25/19 9:14 PM, Al Viro wrote:
> On Fri, Jan 25, 2019 at 04:29:05PM -0700, Shuah Khan wrote:
>> tty_set_termios() has the following WARMN_ON which can be triggered with a
>> syscall to invoke TIOCGETD __NR_ioctl.
>>
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                  tty->driver->subtype == PTY_TYPE_MASTER);
>> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
>>
>> A simple change would have been to print error message instead of WARN_ON.
>> However, the callers assume that tty_set_termios() always returns 0 and
>> don't check return value. The complete solution is fixing all the callers
>> to check error and bail out to fix the WARN_ON.
>>
>> This fix changes tty_set_termios() to return error and all the callers
>> to check error and bail out. The reproducer is used to reproduce the
>> problem and verify the fix.
> 
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -321,6 +321,8 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>>   		status = tty_set_termios(tty, &ktermios);
>>   		BT_DBG("Disabling hardware flow control: %s",
>>   		       status ? "failed" : "success");
>> +		if (status)
>> +			return;
> 
> Can that ldisc end up set on pty master?  And does it make any sense there?

The initial objective of the patch is to prevent the WARN_ON by making
the change to return error instead of WARN_ON. However, without changes
to places that don't check the return and keep making progress, there
will be secondary problems.

Without this change to return here, instead of WARN_ON, it will fail
with the following NULL pointer dereference at the next thing 
hci_uart_set_flow_control() attempts.

status = tty->driver->ops->tiocmget(tty);

kernel: [10140.649783] BUG: unable to handle kernel NULL pointer 
dereference at 0000000000000000
kernel: [10140.649786] #PF error: [INSTR]
kernel: [10140.649787] PGD 0 P4D 0
kernel: [10140.649790] Oops: 0010 [#1] SMP PTI
Jan 24 15:33:35 deneb kernel: [10140.649793] CPU: 2 PID: 55 Comm: 
kworker/u33:0 Tainted: G        W         5.0.0-rc3+ #5
kernel: [10140.649794] Hardware name: Dell Inc. OptiPlex 790/0HY9JP, 
BIOS A18 09/24/2013
Workqueue: hci0 hci_power_on [bluetooth]
kernel: [10140.649805] RIP: 0010:          (null)
kernel: [10140.649809] Code: Bad RIP value.
kernel: [10140.649810] RSP: 0018:ffffa01a8153fd28 EFLAGS: 00010282
kernel: [10140.649812] RAX: 0000000000000000 RBX: ffff8958d6bc4800 RCX: 
35ad8b0300000000
kernel: [10140.649814] RDX: ffffffff00000001 RSI: 0000000000000000 RDI: 
ffff8958d6bc4800
kernel: [10140.649816] RBP: ffffa01a8153fd78 R08: 0000000091773f09 R09: 
0000000000000003
kernel: [10140.649817] R10: ffff8958d6bc4a98 R11: 0000000000000720 R12: 
ffff895814500c00
kernel: [10140.649819] R13: ffff8958a858e000 R14: 0000000000000000 R15: 
ffff8958af1af440
kernel: [10140.649821] FS:  0000000000000000(0000) 
GS:ffff895925880000(0000) knlGS:0000000000000000
kernel: [10140.649823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [10140.649824] CR2: ffffffffffffffd6 CR3: 0000000083f46002 CR4: 
00000000000606e0
kernel: [10140.649826] Call Trace:
kernel: [10140.649830]  ? hci_uart_set_flow_control+0x20e/0x2c0 [hci_uart]
kernel: [10140.649836]  mrvl_setup+0x17/0x80 [hci_uart]
kernel: [10140.649840]  hci_uart_setup+0x56/0x160 [hci_uart]
kernel: [10140.649850]  hci_dev_do_open+0xe6/0x630 [bluetooth]
kernel: [10140.649860]  hci_power_on+0x52/0x220 [bluetooth]

> 
> IOW, I don't believe that this patch makes any sense.  If anything,
> we need to prevent unconditional tty_set_termios() on the path
> that *does* lead to calling it for pty.
> 

I don't think preventing unconditional tty_set_termios() is enough to
prevent secondary problems such as the one above.

For example, the following call chain leads to the WARN_ON that was
reported. Even if void hci_uart_set_baudrate() prevents the very first
tty_set_termios() call, its caller hci_uart_setup() continues with
more tty setup. It goes ahead to call driver setup callback. The
driver callback goes on to do more setup calling tty_set_termios().

WARN_ON call path:
  hci_uart_set_baudrate+0x1cc/0x250 drivers/bluetooth/hci_ldisc.c:378
  hci_uart_setup+0xa2/0x490 drivers/bluetooth/hci_ldisc.c:401
  hci_dev_do_open+0x6b1/0x1920 net/bluetooth/hci_core.c:1423

Once this WARN_ON is changed to return error, the following
happens, when hci_uart_setup() does driver setup callback.

kernel: [10140.649836]  mrvl_setup+0x17/0x80 [hci_uart]
kernel: [10140.649840]  hci_uart_setup+0x56/0x160 [hci_uart]
kernel: [10140.649850]  hci_dev_do_open+0xe6/0x630 [bluetooth]
kernel: [10140.649860]  hci_power_on+0x52/0x220 [bluetooth]

I think continuing to catch the invalid condition in tty_set_termios()
and preventing progress by checking return value is a straight forward
change to avoid secondary problems, and it might be difficult to catch
all the cases where it could fail. Here is the reproducer for reference:


#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[1] = {0xffffffffffffffff};

int main(void)
{
   syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
   long res = 0;
   memcpy((void*)0x20000100, "/dev/ptmx\x00", 10);
   res = syscall(__NR_openat, 0xffffffffffffff9c, 0x20000100, 0, 0);
   if (res != -1)
     r[0] = res;
   *(uint32_t*)0x200000c0 = 0xf;
   syscall(__NR_ioctl, r[0], 0x5423, 0x200000c0);
   syscall(__NR_ioctl, r[0], 0x400455c8, 0xb);
   return 0;
}


thanks,
-- Shuah
