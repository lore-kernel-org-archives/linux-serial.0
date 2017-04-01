From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for embedded
 systems
Date: Sat,  1 Apr 2017 18:21:14 -0400
Message-ID: <20170401222119.25106-1-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Many embedded systems don't need the full TTY layer support. Most of the
time, the TTY layer is only a conduit for outputting debugging messages
over a serial port. The TTY layer also implements many features that are
very unlikely to ever be used in such a setup. There is great potential
for both code and dynamic memory size reduction on small systems. This is
what this patch series is achieving.

The existing TTY code is quite large and complex. Trying to shrink it
is risky as the potential for breakage is non negligeable, and its
interchangeable layers impose a lower limit on the code to implement it.
Therefore, the approach used here consists in the creation of a parallel
implementation with the very minimal amount of code collapsed together
that interfaces with existing UART drivers directly and provides TTY-like
character devices to user space. When the regular TTY layer is disabled,
then this minitty alternative layer is proposed by Kconfig.

For more details on the rationale and motivations driving this approach
please see: https://lkml.org/lkml/2017/3/24/634

Of course, making it "mini" means there are limitations to what it does:

- This supports serial ports only. No VT's, no PTY's.

- The default n_tty line discipline is hardcoded and no other line
  discipline are supported.

- The line discipline features are not all implemented. Notably, XON/XOFF
  is currently not implemented (although this might not require a lot of
  code to do it if someone were to need it).

- Hung-up state is not implemented.

- No error handling on RX bytes other than counting them.

- Job control is currently not supported (this may change in the future and 
  be configurable).

But again, most small embedded systems simply don't need those things.

This can be used on any architecture of course, but here's some numbers
using a minimal ARM config.

When CONFIG_TTY=y, the following files are linked into the kernel:

   text	   data	    bss	    dec	    hex	filename
   8796	    128	      0	   8924	   22dc	drivers/tty/n_tty.o
  11809	    276	      0	  12085	   2f35	drivers/tty/serial/fulltty_serial.o
   1376	      0	      0	   1376	    560	drivers/tty/tty_buffer.o
  13571	    172	    132	  13875	   3633	drivers/tty/tty_io.o
   3072	      0	      0	   3072	    c00	drivers/tty/tty_ioctl.o
   2457	      2	    120	   2579	    a13	drivers/tty/tty_ldisc.o
   1328	      0	      0	   1328	    530	drivers/tty/tty_ldsem.o
    316	      0	      0	    316	    13c	drivers/tty/tty_mutex.o
   2516	      0	      0	   2516	    9d4	drivers/tty/tty_port.o
  45241	    578	    252	  46071	   b3f7	(TOTALS)

When CONFIG_TTY=n and CONFIG_MINITTY_SERIAL=y, the above files are replaced
by the following:

   text	   data	    bss	    dec	    hex	filename
   8063	      8	     64	   8135	   1fc7	drivers/tty/serial/minitty_serial.o

That's it!  And the runtime buffer usage is much less as well. Future plans
such as removing runtime baudrate handling for those targets with a known
fixed baudrate will shrink the code even more.

Changes from v1:

- Added an entry to the MAINTAINERS file.
- Factored out more common core code into serial_lib.c.
- Implemented a few more TTY callback functions to be compatible with
  more UART drivers.

Overall diffstat:

 MAINTAINERS                                     |    8 +-
 drivers/tty/Kconfig                             |   10 +-
 drivers/tty/Makefile                            |    3 +-
 drivers/tty/serial/Kconfig                      |   12 +-
 drivers/tty/serial/Makefile                     |    7 +-
 .../serial/{serial_core.c => fulltty_serial.c}  |  419 +---
 drivers/tty/serial/minitty_serial.c             | 1793 +++++++++++++++++
 drivers/tty/serial/serial_lib.c                 |  440 ++++
 drivers/tty/tty_baudrate.c                      |  232 +++
 drivers/tty/tty_io.c                            |   24 -
 drivers/tty/tty_ioctl.c                         |  222 --
 include/linux/console.h                         |    2 +
 include/linux/serial_core.h                     |    1 +
 include/linux/tty.h                             |    7 +-
 include/linux/tty_flip.h                        |    9 +
 init/main.c                                     |    2 +-
 kernel/printk/printk.c                          |   24 +
 17 files changed, 2538 insertions(+), 677 deletions(-)
