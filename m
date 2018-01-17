From: Shankara Pailoor <sp3485@columbia.edu>
Subject: Re: RCU stall in 8250 serial driver Linux 4.15-rc1
Date: Wed, 17 Jan 2018 09:24:32 -0800
Message-ID: <CAASgV=tRY1ioh4vZi3ZyugDJzCiADwo+Mg+HNoEwCzAaV_G=jQ@mail.gmail.com>
References: <CAASgV=tHtf88=h-wtUrnoC74M6BEnNXcCg8d3DyWJfx21dnLYg@mail.gmail.com>
 <20180117170520.GA12606@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117170520.GA12606@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Sorry for that. Here is the stack trace. C Program below

TCP: request_sock_TCP: Possible SYN flooding on port 20003. Sending
cookies.  Check SNMP counters.
TCP: request_sock_TCP: Possible SYN flooding on port 20003. Sending
cookies.  Check SNMP counters.
TCP: request_sock_TCP: Possible SYN flooding on port 20003. Sending
cookies.  Check SNMP counters.
INFO: rcu_sched detected stalls on CPUs/tasks:
1-....: (5686 ticks this GP) idle=59e/140000000000000/0
softirq=13217/13218 fqs=15550
(detected by 3, t=65002 jiffies, g=3309, c=3308, q=1338676)
Sending NMI from CPU 3 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3206 Comm: syzkaller260107 Not tainted 4.15.0-rc1 #1
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
task: ffff8800b5688000 task.stack: ffff8800b5ae0000
RIP: 0010:inb arch/x86/include/asm/io.h:348 [inline]
RIP: 0010:io_serial_in+0x60/0x80 drivers/tty/serial/8250/8250_port.c:434
RSP: 0018:ffff880105086320 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffb7699720
RBP: ffffffffb76996e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffff10016ad112c R12: 0000000000000020
R13: fffffbfff6ed3323 R14: fffffbfff6ed32e6 R15: ffffffffb769991a
FS:  00000000012d3880(0000) GS:ffff880105080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200007b6 CR3: 00000000ba7eb004 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:111 [inline]
 wait_for_xmitr+0x8a/0x1d0 drivers/tty/serial/8250/8250_port.c:2033
 serial8250_console_putchar+0x19/0x50 drivers/tty/serial/8250/8250_port.c:3170
 uart_console_write+0x98/0xc0 drivers/tty/serial/serial_core.c:1858
 serial_port_out include/linux/serial_core.h:265 [inline]
 serial8250_console_write+0x2ad/0x890 drivers/tty/serial/8250/8250_port.c:3243
 trace_console_rcuidle include/trace/events/printk.h:10 [inline]
 call_console_drivers kernel/printk/printk.c:1556 [inline]
 console_unlock+0x635/0xb40 kernel/printk/printk.c:2233
 log_output kernel/printk/printk.c:1675 [inline]
 vprintk_emit+0x391/0x480 kernel/printk/printk.c:1745
 vprintk_func+0x52/0xc0 kernel/printk/printk_safe.c:379
 printk+0xaa/0xca kernel/printk/printk.c:1829
 tcp_syn_flood_action net/ipv4/tcp_input.c:6171 [inline]
 tcp_conn_request+0x2c91/0x2fc0 net/ipv4/tcp_input.c:6215
 tcp_v4_conn_request+0x14f/0x200 net/ipv4/tcp_ipv4.c:1318
 tcp_rcv_state_process+0x900/0x4770 net/ipv4/tcp_input.c:5819
 tcp_v4_do_rcv+0x550/0x7c0 net/ipv4/tcp_ipv4.c:1490
 tcp_v4_rcv+0x2c2d/0x2d30 net/ipv4/tcp_ipv4.c:1719
 ip_local_deliver_finish+0x317/0xbf0 net/ipv4/ip_input.c:216
 NF_HOOK include/linux/netfilter.h:250 [inline]
 ip_local_deliver+0x1ba/0x640 net/ipv4/ip_input.c:257
 dst_input include/net/dst.h:466 [inline]
 ip_rcv_finish+0x867/0x1970 net/ipv4/ip_input.c:397
 NF_HOOK include/linux/netfilter.h:250 [inline]
 ip_rcv+0xb9d/0x1650 net/ipv4/ip_input.c:493
 __netif_receive_skb_core+0x1e56/0x3330 net/core/dev.c:4461
 __netif_receive_skb+0x27/0x1a0 net/core/dev.c:4526
 rcu_read_unlock include/linux/rcupdate.h:683 [inline]
 process_backlog+0x1d8/0x6b0 net/core/dev.c:5206
 napi_poll net/core/dev.c:5604 [inline]
 net_rx_action+0x66b/0x1330 net/core/dev.c:5669
 trace_softirq_exit include/trace/events/irq.h:142 [inline]
 __do_softirq+0x25e/0xabe kernel/softirq.c:286
 do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:984
 </IRQ>
 do_softirq.part.16+0x70/0x90 kernel/softirq.c:88
 __local_bh_enable_ip+0x17c/0x1b0 kernel/softirq.c:161
 local_bh_enable include/linux/bottom_half.h:32 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:727 [inline]
 ip_finish_output2+0x8ad/0x1370 net/ipv4/ip_output.c:231
 ip_finish_output+0x727/0xb20 net/ipv4/ip_output.c:317
 NF_HOOK_COND include/linux/netfilter.h:239 [inline]
 ip_output+0x1cf/0x720 net/ipv4/ip_output.c:405
 dst_output include/net/dst.h:460 [inline]
 ip_local_out+0x8e/0x160 net/ipv4/ip_output.c:124
 ip_queue_xmit+0x934/0x1890 net/ipv4/ip_output.c:504
 tcp_transmit_skb+0x19a9/0x35d0 net/ipv4/tcp_output.c:1176
 tcp_connect+0x2824/0x3890 net/ipv4/tcp_output.c:3498


C program:

// autogenerated by syzkaller (http://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <sys/syscall.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <sys/prctl.h>

__attribute__((noreturn)) static void doexit(int status)
{
volatile unsigned i;
syscall(__NR_exit_group, status);
for (i = 0;; i++) {
}
}
#define NORETURN __attribute__((noreturn))

#include <stdint.h>
#include <string.h>

const int kFailStatus = 67;
const int kRetryStatus = 69;

NORETURN static void fail(const char* msg, ...)
{
int e = errno;
fflush(stdout);
va_list args;
va_start(args, msg);
vfprintf(stderr, msg, args);
va_end(args);
fprintf(stderr, " (errno %d)\n", e);
doexit((e == ENOMEM || e == EAGAIN) ? kRetryStatus : kFailStatus);
}

NORETURN static void exitf(const char* msg, ...)
{
int e = errno;
fflush(stdout);
va_list args;
va_start(args, msg);
vfprintf(stderr, msg, args);
va_end(args);
fprintf(stderr, " (errno %d)\n", e);
doexit(kRetryStatus);
}

static uint64_t current_time_ms()
{
struct timespec ts;

if (clock_gettime(CLOCK_MONOTONIC, &ts))
fail("clock_gettime failed");
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void test();

void loop()
{
int iter;
for (iter = 0;; iter++) {
int pid = fork();
if (pid < 0)
fail("clone failed");
if (pid == 0) {
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
test();
doexit(0);
}
int status = 0;
uint64_t start = current_time_ms();
for (;;) {
int res = waitpid(-1, &status, __WALL | WNOHANG);
if (res == pid)
break;
usleep(1000);
if (current_time_ms() - start > 5 * 1000) {
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
while (waitpid(-1, &status, __WALL) != pid) {
}
break;
}
}
}
}

long r[28];
void test()
{
memset(r, -1, sizeof(r));
r[0] = syscall(__NR_mmap, 0x20000000ul, 0x3b8000ul, 0x3ul, 0x32ul,
0xfffffffffffffffful, 0x0ul);
r[1] = syscall(__NR_socket, 0x2ul, 0x1ul, 0x0ul);
*(uint16_t*)0x200007b6 = (uint16_t)0x2;
*(uint16_t*)0x200007b8 = (uint16_t)0x234e;
*(uint32_t*)0x200007ba = (uint32_t)0x0;
*(uint8_t*)0x200007be = (uint8_t)0x0;
*(uint8_t*)0x200007bf = (uint8_t)0x0;
*(uint8_t*)0x200007c0 = (uint8_t)0x0;
*(uint8_t*)0x200007c1 = (uint8_t)0x0;
*(uint8_t*)0x200007c2 = (uint8_t)0x0;
*(uint8_t*)0x200007c3 = (uint8_t)0x0;
*(uint8_t*)0x200007c4 = (uint8_t)0x0;
*(uint8_t*)0x200007c5 = (uint8_t)0x0;
r[13] = syscall(__NR_bind, r[1], 0x200007b6ul, 0x10ul);
r[14] = syscall(__NR_listen, r[1], 0x0ul);
r[15] = syscall(__NR_socket, 0x2ul, 0x1ul, 0x0ul);
*(uint16_t*)0x200008e6 = (uint16_t)0x2;
*(uint16_t*)0x200008e8 = (uint16_t)0x234e;
*(uint32_t*)0x200008ea = (uint32_t)0x100007f;
*(uint8_t*)0x200008ee = (uint8_t)0x0;
*(uint8_t*)0x200008ef = (uint8_t)0x0;
*(uint8_t*)0x200008f0 = (uint8_t)0x0;
*(uint8_t*)0x200008f1 = (uint8_t)0x0;
*(uint8_t*)0x200008f2 = (uint8_t)0x0;
*(uint8_t*)0x200008f3 = (uint8_t)0x0;
*(uint8_t*)0x200008f4 = (uint8_t)0x0;
*(uint8_t*)0x200008f5 = (uint8_t)0x0;
r[27] = syscall(__NR_connect, r[15], 0x200008e6ul, 0x10ul);
}

int main()
{
int i; for (i = 0; i < 8; i++) {
if (fork() == 0) {
loop();
return 0;
}
}
sleep(1000000);
return 0;
}

Regards,
Shankara

On Wed, Jan 17, 2018 at 9:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 17, 2018 at 08:53:06AM -0800, Shankara Pailoor wrote:
>> Hi,
>>
>> Syzkaller found the following rcu stall report in Linux 4.15-rc1:
>> https://pastebin.com/NyZ9JdRv
>>
>> The following C program reproduces it: https://pastebin.com/gqwDWWpA
>>
>> Configs Here: https://pastebin.com/v6M3iKi1
>
> I don't visit random web sites for random bugs. Please include all of
> the information in the email itself.
>
> thanks,
>
> greg k-h
