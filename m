From: Dmitry Artamonow <mad_soft@inbox.lv>
Subject: [BUG] tty/serial: stty hangs for 30 seconds after interrupted
 transfer
Date: Thu, 25 May 2017 16:22:18 +0300
Message-ID: <c87da751-0692-e381-be16-a2adf0f0104f@inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hello.

While working on i.MX6-based board I found weird problem with serial ports.
When I do some write in serial port and then interrupt it prematurely with
Ctrl-C, following call to stty hangs for 30 seconds. Basic reproducing steps:

1. cat some_large_text_file.txt > /dev/ttymxc1
2. Press Ctrl-C
3. stty -F /dev/ttymxc1

If I send some more data over the port afterwards and don't interrupt it,
following call to stty doesn't hang.

Also issue can be reproduced by two small programs below. First one
forks itself and then child kills parent that writes to port after 1 second
timeout. After running first program, second hangs in close().

----- sendandkill.c
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

char buffer[2400]; /* ~2 sec at 9600 baud */

int main(int argc, char **argv)
{
    int fd, ret, i;
   
    for(i = 0; i < sizeof(buffer); i++)
        buffer[i] = '0' + (char)(i % 10);

    ret = fork();
    /* CHILD */
    if (ret == 0) {
        int parent_pid = getppid();
        sleep(1);
        kill(parent_pid, 9);
        return 0;
    }

    /* PARENT */
    fd = open("/dev/ttymxc1", O_RDWR);
    write(fd, buffer, sizeof(buffer));
    sleep(10);
    close(fd);
    return 0;
}

----- justopen.c
#include <fcntl.h>

int main(int argc, char **argv)
{
    int fd = open("/dev/ttymxc1", O_RDWR);
    close(fd);
    return 0;
}
-----

Here's how it looks with the latest Linus's kernel (4.12.0-rc2+):

# uname -a
Linux imx6 4.12.0-rc2-00052-g56fff1b #7 SMP PREEMPT Wed May 24 15:03:17 MSK 2017 armv7l armv7l armv7l GNU/Linux
# stty -F -a /dev/ttymxc1
stty: -a: No such file or directory
# stty -a -F /dev/ttymxc1                                                                                                                 
speed 9600 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z;
rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
-parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff -iuclc -ixany -imaxbel -iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt echoctl echoke -flusho -extproc
# time ./justopen

real    0m0.045s
user    0m0.000s
sys     0m0.008s
# cat /proc/tty/driver/IMX-uart
serinfo:1.0 driver revision:
0: uart:IMX mmio:0x02020000 irq:27 tx:2601 rx:200 RTS|CTS|DTR|DSR|CD
1: uart:IMX mmio:0x021E8000 irq:75 tx:0 rx:0 DSR|CD
3: uart:IMX mmio:0x021F0000 irq:76 tx:0 rx:0 DSR|CD
4: uart:IMX mmio:0x021F4000 irq:77 tx:0 rx:0 DSR|CD
# strace -f -ttt ./sendandkill
1494138555.023757 execve("./sendandkill", ["./sendandkill"], [/* 13 vars */]) = 0
1494138555.042630 uname({sysname="Linux", nodename="imx6", ...}) = 0
1494138555.046067 brk(NULL)             = 0x15a9000
1494138555.046198 brk(0x15a9d00)        = 0x15a9d00
1494138555.046373 set_tls(0x15a94c0, 0x69fc0, 0, 0x6ac30, 0x6ac28) = 0
1494138555.053349 brk(0x15cad00)        = 0x15cad00
1494138555.053496 brk(0x15cb000)        = 0x15cb000
1494138555.053765 clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x15a9068) = 510
1494138555.054141 open("/dev/ttymxc1", O_RDWR) = 3
1494138555.055081 write(3, "01234567890123456789012345678901"..., 2400) = 2400
1494138555.055331 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
1494138555.055496 rt_sigaction(SIGCHLD, NULL, {SIG_DFL, [], 0}, 8) = 0
1494138555.055635 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
1494138555.055768 nanosleep({10, 0}, strace: Process 510 attached
 <unfinished ...>
[pid   510] 1494138555.056109 getppid() = 509
[pid   510] 1494138555.056227 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
[pid   510] 1494138555.056382 rt_sigaction(SIGCHLD, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid   510] 1494138555.056524 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid   510] 1494138555.056704 nanosleep({1, 0}, 0x7edbfc80) = 0
[pid   510] 1494138556.056986 kill(509, SIGKILL) = 0
[pid   510] 1494138556.060856 exit_group(0) = ?
[pid   509] 1494138556.069794 +++ killed by SIGKILL +++
1494138556.070003 +++ exited with 0 +++
Killed
# cat /proc/tty/driver/IMX-uart
serinfo:1.0 driver revision:
0: uart:IMX mmio:0x02020000 irq:27 tx:4465 rx:259 RTS|CTS|DTR|DSR|CD
1: uart:IMX mmio:0x021E8000 irq:75 tx:0 rx:0 DSR|CD
3: uart:IMX mmio:0x021F0000 irq:76 tx:0 rx:0 DSR|CD
4: uart:IMX mmio:0x021F4000 irq:77 tx:0 rx:0 DSR|CD
# time ./justopen

real    0m31.940s
user    0m0.000s
sys     0m0.007s
# strace -f -ttt ./justopen                                                                                                               
1494138726.794853 execve("./justopen", ["./justopen"], [/* 13 vars */]) = 0
1494138726.795961 uname({sysname="Linux", nodename="imx6", ...}) = 0
1494138726.796176 brk(NULL)             = 0x6a2000
1494138726.796297 brk(0x6a2d00)         = 0x6a2d00
1494138726.796438 set_tls(0x6a24c0, 0x68fc0, 0, 0x69c30, 0x69c28) = 0
1494138726.796792 brk(0x6c3d00)         = 0x6c3d00
1494138726.796940 brk(0x6c4000)         = 0x6c4000
1494138726.797079 open("/dev/ttymxc1", O_RDWR) = 3
1494138726.798104 close(3)              = 0
1494138757.400997 exit_group(0)         = ?
1494138757.401223 +++ exited with 0 +++
# cat /proc/tty/driver/IMX-uart
serinfo:1.0 driver revision:
0: uart:IMX mmio:0x02020000 irq:27 tx:5475 rx:400 RTS|CTS|DTR|DSR|CD
1: uart:IMX mmio:0x021E8000 irq:75 tx:0 rx:0 DSR|CD
3: uart:IMX mmio:0x021F0000 irq:76 tx:0 rx:0 DSR|CD
4: uart:IMX mmio:0x021F4000 irq:77 tx:0 rx:0 DSR|CD
# echo -n "X" > /dev/ttymxc1
# cat /proc/tty/driver/IMX-uart
serinfo:1.0 driver revision:
0: uart:IMX mmio:0x02020000 irq:27 tx:5797 rx:400 RTS|CTS|DTR|DSR|CD
1: uart:IMX mmio:0x021E8000 irq:75 tx:2401 rx:0 DSR|CD
3: uart:IMX mmio:0x021F0000 irq:76 tx:0 rx:0 DSR|CD
4: uart:IMX mmio:0x021F4000 irq:77 tx:0 rx:0 DSR|CD
# time ./justopen

real    0m0.008s
user    0m0.000s
sys     0m0.007s
#

I located the place of the hang inside the tty_wait_until_sent() function.
Looks like it waits for UART to finish sending, but as the UART doesn't
actually send anything, it exits only after 30 second timeout.

After some digging I found that the problem seems to be caused by
commit 761ed4a94582 ("tty: serial_core: convert uart_close to use
tty_port_close"). Reverting this and related commits (a5a2b13074fd,
be2c92b8f164, 4dda864d7307) makes the problem go away.

Also note that statistics seems to be broken in the log above. After
running "sendandkill" it says that 0 bytes were sent while actually
about 970 bytes were transferred. And after sending one more character with
echo, it actually sends 2400+1 characters, i.e. resends the whole previously
interrupted buffer before sending 'X'. Reverts above fix this only partially.
UART doesn't resend previous characters anymore, but still statistics is
wrong about first interrupted transfer. But I suspect this could be a separate
problem in imx driver.

Any ideas how to fix this hang? I tried to put uart_flush_buffer() into
uart_close() before call to tty_port_close() and it kind of works, but
I'm not really sure whether it's a proper fix. Given my lack of experience
with TTY subsystem and level of its complexity I suspect that I can
easily miss something.

--
Best regards
Dmitry Artamonow
