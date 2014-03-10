From: =?iso-8859-1?Q?Mats_K=E4rrman?= <Mats.Karrman@tritech.se>
Subject: Suspecting kernel timing bug in ppp or tty drivers
Date: Mon, 10 Mar 2014 13:36:36 +0000
Message-ID: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ppp-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-ppp-owner@vger.kernel.org
To: "linux-ppp@vger.kernel.org" <linux-ppp@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Linux serial & PPP experts,

For a long time now I have been chasing a problem in my PPP connection.
The fault scenario is as follows:

- After reboot establishing a PPP connection works OK
- Network communication over PPP works OK
- The PPP connection is restarted - could be for any of several reasons; peer
  drops the connection gracefully, local restart due to network problems,
  local restart due to user request, et.c.
- After closing down the connection, it is not possible to re-connect again.
  The Error messages from pppd looks something like:

Jan  1 01:04:42 mymachine local2.err chat[631]: Can't get terminal parameters: Input/output error
Jan  1 01:04:42 mymachine daemon.debug pppd[629]: Script /usr/sbin/chat -v -f /etc/ppp/chats/gprs-conn -T my-apn (pid 630), status = 0x2
Jan  1 01:04:42 mymachine daemon.err pppd[629]: Connect script failed


Some data about the system:
- PPP daemon v2.4.5
- Linux kernel v3.2.51 (same error with v2.6.35 though)
- CPU PowerPC e300c4 (MPC5125)
- Cinterion GPRS modem
- The serial device driver is based on main-line drivers for MPC5200 and
  MPC5121 (mpc52xx_uart.c) but with some custom extensions. Works fine for
  other applications.

By running strace I have found that it is the ioctl's the PPPD tries to
execute on the tty device that fails after disconnect (I have also tried
including fcntl64 in the strace trace list but not found any such calls that
fails):

-------------------------------------------------------------------------------
root@mymachine:~# strace -e trace=open,close,ioctl pppd dump debug nodetach call gprs
<snip>
open("/etc/passwd", O_RDONLY|O_CLOEXEC) = 4
close(4)                                = 0
open("/home/root/.ppprc", O_RDONLY)     = -1 ENOENT (No such file or directory)
open("/etc/ppp/peers/gprs", O_RDONLY)   = 4
open("/etc/ppp/peers/ip-connect", O_RDONLY) = 5
close(5)                                = 0
close(4)                                = 0
open("/etc/ppp/options.ttyPSC4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/dev/ppp", O_RDWR)                = 4
close(4)                                = 0
open("/usr/share/zoneinfo/UTC", O_RDONLY) = -1 ENOENT (No such file or directory)
pppd options in effect:
debug           # (from command line)
nodetach                # (from command line)
holdoff 2               # (from /etc/ppp/peers/gprs)
linkname gprs           # (from /etc/ppp/peers/gprs)
maxfail 5               # (from /etc/ppp/peers/gprs)
unit 0          # (from /etc/ppp/peers/gprs)
dump            # (from command line)
noauth          # (from /etc/ppp/peers/gprs)
name mycon      # (from /etc/ppp/peers/ip-connect)
/dev/ttyPSC4            # (from /etc/ppp/peers/gprs)
115200          # (from /etc/ppp/peers/gprs)
lock            # (from /etc/ppp/options)
connect /usr/sbin/chat -v -f /etc/ppp/chats/gprs-conn -T my-apn    # (from /etc/ppp/peers/ip-connect)
crtscts         # (from /etc/ppp/peers/gprs)
modem           # (from /etc/ppp/peers/gprs)
lcp-echo-failure 3              # (from /etc/ppp/peers/gprs)
lcp-echo-interval 10            # (from /etc/ppp/peers/gprs)
ipcp-accept-local               # (from /etc/ppp/peers/gprs)
ipcp-accept-remote              # (from /etc/ppp/peers/gprs)
noipdefault             # (from /etc/ppp/peers/gprs)
defaultroute            # (from /etc/ppp/peers/gprs)
replacedefaultroute             # (from /etc/ppp/peers/gprs)
usepeerdns              # (from /etc/ppp/peers/gprs)
noccp           # (from /etc/ppp/peers/gprs)
open("/dev/null", O_RDWR)               = 4
open("/var/run/pppd2.tdb", O_RDWR|O_CREAT, 0644) = 6
ioctl(0, TCGETS, {B115200 opost isig icanon echo ...}) = 0
open("/var/run/utmp", O_RDWR|O_LARGEFILE|O_CLOEXEC) = 7
close(7)                                = 0
open("/var/run/ppp-gprs.pid", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 7
close(7)                                = 0
open("/var/lock/LCK..ttyPSC4", O_RDWR|O_CREAT|O_EXCL, 0644) = 7
close(7)                                = 0
open("/dev/ttyPSC4", O_RDWR|O_NONBLOCK) = 7
ioctl(7, TIOCMBIS, [TIOCM_DTR])         = -1 EIO (Input/output error)
ioctl(7, TCGETS, 0xbf817378)            = -1 EIO (Input/output error)
ioctl(7, TIOCMBIC, [TIOCM_DTR])         = -1 EIO (Input/output error)
ioctl(7, TIOCMBIS, [TIOCM_DTR])         = -1 EIO (Input/output error)
close(8)                                = 0
close(9)                                = 0
close(8)                                = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
Script /usr/sbin/chat -v -f /etc/ppp/chats/gprs-conn -T my-apn finished (pid 3770), status = 0x2
Connect script failed
ioctl(7, TCFLSH, 0x2)                   = -1 EIO (Input/output error)
ioctl(7, TIOCMBIC, [TIOCM_DTR])         = -1 EIO (Input/output error)
close(7)                                = 0
root@mymachine:~# 
-------------------------------------------------------------------------------


Something that makes the error difficult to debug is that it's occurence is
highly timing dependent. E.g. the use of strace can make the error occur when
it didn't or make it disappear when it did. Also it seems like something in
the network (timing?) also affects the occurance. Given an identical test
setup, some days it won't happen at all, some days it's intermittent and other
days it happens consistently. 

Rebooting linux makes it possible to connect again. Sometimes it is enough to
let pppd retry by itself (persist) for a couple of times and the error will go
away but sometimes this is not enough and the pppd will continue trying forever
with the same error.

I have tried chasing the error by inserting printk statements in the kernel code
(mainly in tty_io.c and serial_core.c) but every time the error has suddenly
stopped occuring, I guess as an effect of the changed timing caused by the
printk's.

The gut feeling I have (no hard evidence though) is that there is a state
corruption in the kernel. After the PPP is finnished negotiating a disconnect
it matters when the tty is "hung up". If one goes well before the other
everything is OK but sometimes they collide and leave the tty hanging in limbo.

The following is from a test-run where the peer disconnects and the pppd tries
to reconnect (persist) and fails on the first attempt but not the second
(additional printk's labeled "MAKR:", the calls to "hung_up_tty_ioctl" below
would all have returned EIO, kernel v2.6.35):

-------------------------------------------------------------------------------
<snip>
Jan  7 17:22:52 mymachine daemon.debug pppd[609]: Script /etc/ppp/ip-up finished (pid 32381), status = 0x0
Jan  7 18:22:51 mymachine daemon.debug pppd[609]: rcvd [LCP TermReq id=0x0 "Normal Termination by NCP"]
Jan  7 18:22:51 mymachine daemon.info pppd[609]: LCP terminated by peer (Normal Termination by NCP)
Jan  7 18:22:51 mymachine daemon.info pppd[609]: Connect time 60.0 minutes.
Jan  7 18:22:51 mymachine daemon.info pppd[609]: Sent 0 bytes, received 0 bytes.
Jan  7 18:22:51 mymachine daemon.debug pppd[609]: Script /etc/ppp/ip-down started (pid 1421)
Jan  7 18:22:51 mymachine daemon.debug pppd[609]: sent [LCP TermAck id=0x0]
Jan  7 18:22:51 mymachine daemon.debug pppd[609]: Script /etc/ppp/ip-down finished (pid 1421), status = 0x0
Jan  7 18:22:51 mymachine daemon.info pppd[609]: Hangup (SIGHUP) code 128
Jan  7 18:22:51 mymachine daemon.notice pppd[609]: Modem hangup
Jan  7 18:22:51 mymachine daemon.notice pppd[609]: Connection terminated.
Jan  7 18:22:51 mymachine user.debug kernel: MAKR: uart_shutdown set ttyPSC4 40a0a
Jan  7 18:22:51 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x5417,0xbfba0418) ENOTTY/EIO 1 ?
Jan  7 18:22:52 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x802c7416,0xbfba03d8) ENOTTY/EIO 1 ?
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: uart_startup set ttyPSC4 a02
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: uart_startup clr ttyPSC4 a00
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: uart_block_til_ready
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: tty_ioctl 0x5416 on ttyPSC4 ret 0 at 2
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: tty_ioctl 0x402c7413 on ttyPSC4 ret 0 at 5
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: tty_ioctl 0x802c7416 on ttyPSC4 ret 0 at 5
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: tty_ioctl 0x5417 on ttyPSC4 ret 0 at 2
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: uart_shutdown set ttyPSC4 40a02
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x5416,0xbfba0398) ENOTTY/EIO 1 ?
Jan  7 18:22:55 mymachine local2.err chat[1435]: Can't get terminal parameters: Input/output error
Jan  7 18:22:55 mymachine daemon.debug pppd[609]: Script /usr/sbin/chat -v -f /etc/ppp/chats/gprs-conn -T my-apn finished (pid 1434), status = 0x2
Jan  7 18:22:55 mymachine daemon.err pppd[609]: Connect script failed
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x402c7413,0xbf893768) ENOTTY/EIO 1 ?
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x2000741f,0x2) ENOTTY/EIO 1 ?
Jan  7 18:22:55 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x5417,0xbfba0428) ENOTTY/EIO 1 ?
Jan  7 18:22:56 mymachine daemon.info pppd[609]: Hangup (SIGHUP) code 128
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: hung_up_tty_ioctl(0x802c7416,0xbfba03e8) ENOTTY/EIO 1 ?
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: uart_startup set ttyPSC4 a02
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: uart_startup clr ttyPSC4 a00
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: uart_block_til_ready
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: tty_ioctl 0x5416 on ttyPSC4 ret 0 at 2
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: tty_ioctl 0x402c7413 on ttyPSC4 ret 0 at 5
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: tty_ioctl 0x802c7416 on ttyPSC4 ret 0 at 5
Jan  7 18:22:56 mymachine user.debug kernel: MAKR: tty_ioctl 0x5417 on ttyPSC4 ret 0 at 2
Jan  7 18:22:57 mymachine user.debug kernel: MAKR: tty_ioctl 0x5416 on ttyPSC4 ret 0 at 2
Jan  7 18:22:57 mymachine local2.info chat[1437]: abort on (ERROR)
Jan  7 18:22:57 mymachine local2.info chat[1437]: timeout set to 10 seconds
Jan  7 18:22:57 mymachine local2.info chat[1437]: send (AT^M)
Jan  7 18:22:57 mymachine user.debug kernel: MAKR: tty_ioctl 0x402c7413 on ttyPSC4 ret 0 at 5
Jan  7 18:22:57 mymachine user.debug kernel: MAKR: tty_ioctl 0x802c7414 on ttyPSC4 ret 0 at 5
Jan  7 18:22:57 mymachine local2.info chat[1437]: expect (OK)
Jan  7 18:22:57 mymachine local2.info chat[1437]: AT^M^M
Jan  7 18:22:57 mymachine local2.info chat[1437]: OK
<snip>
-------------------------------------------------------------------------------


If anyone have any good suggestion about where to go next, I'm eager to hear.
Need more information? Please ask!

Best regards,
Mats
