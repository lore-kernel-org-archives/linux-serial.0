From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: [PATCH v2 0/7] TTY Keyboard Status Request
Date: Tue, 25 Jun 2019 19:11:46 +0300
Message-ID: <20190625161153.29811-1-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
List-Id: linux-serial@vger.kernel.org

This patch series introduces TTY keyboard status request, a feature of
the n_tty line discipline that reserves a character in struct termios
(^T by default) and reacts to it by printing a short informational line
to the terminal and sending a Unix signal to the tty's foreground
process group. The processes may, in response to the signal, output a
textual description of what they're doing.

The feature has been present in a similar form at least in
Free/Open/NetBSD; it would be nice to have something like this in Linux
as well. There is an LKML thread[1] where users have previously
expressed the rationale for this.

The current implementation does not break existing kernel API in any
way, since, fortunately, all the architectures supported by the kernel
happen to have at least 1 free byte in the termios control character
array.

The series should cleanly apply to tty-next.

To thoroughly test these, one might need at least a patched stty among
other tools, so I've brought up a simple initrd generator[2] which can
be used to create a lightweight environment to boot up in a VM and to
fiddle with.

[1] https://lore.kernel.org/lkml/1415200663.3247743.187387481.75CE9317@webmail.messagingengine.com/
[2] https://github.com/porrided/tty-kb-status-userspace

v2 <- v1: removed useless debugging bits.

Discussion of v1:
https://lore.kernel.org/lkml/20190605081906.28938-1-ar@cs.msu.ru/

Arseny Maslennikov (7):
  signal.h: Define SIGINFO on all architectures
  tty: termios: Reserve space for VSTATUS in .c_cc
  n_tty: Send SIGINFO to fg pgrp on status request character
  linux/signal.h: Ignore SIGINFO by default in new tasks
  tty: Add NOKERNINFO lflag to termios
  n_tty: ->ops->write: Cut core logic out to a separate function
  n_tty: Provide an informational line on VSTATUS receipt

 arch/alpha/include/asm/termios.h         |   4 +-
 arch/alpha/include/uapi/asm/termbits.h   |   2 +
 arch/arm/include/uapi/asm/signal.h       |   1 +
 arch/h8300/include/uapi/asm/signal.h     |   1 +
 arch/ia64/include/asm/termios.h          |   4 +-
 arch/ia64/include/uapi/asm/signal.h      |   1 +
 arch/ia64/include/uapi/asm/termbits.h    |   2 +
 arch/m68k/include/uapi/asm/signal.h      |   1 +
 arch/mips/include/asm/termios.h          |   4 +-
 arch/mips/include/uapi/asm/signal.h      |   1 +
 arch/mips/include/uapi/asm/termbits.h    |   2 +
 arch/parisc/include/asm/termios.h        |   4 +-
 arch/parisc/include/uapi/asm/signal.h    |   1 +
 arch/parisc/include/uapi/asm/termbits.h  |   2 +
 arch/powerpc/include/asm/termios.h       |   4 +-
 arch/powerpc/include/uapi/asm/signal.h   |   1 +
 arch/powerpc/include/uapi/asm/termbits.h |   2 +
 arch/s390/include/asm/termios.h          |   4 +-
 arch/s390/include/uapi/asm/signal.h      |   1 +
 arch/sparc/include/asm/termios.h         |   4 +-
 arch/sparc/include/uapi/asm/signal.h     |   2 +
 arch/sparc/include/uapi/asm/termbits.h   |   2 +
 arch/x86/include/uapi/asm/signal.h       |   1 +
 arch/xtensa/include/uapi/asm/signal.h    |   1 +
 arch/xtensa/include/uapi/asm/termbits.h  |   2 +
 drivers/tty/Makefile                     |   3 +-
 drivers/tty/n_tty.c                      |  70 ++++-
 drivers/tty/n_tty_status.c               | 337 +++++++++++++++++++++++
 include/asm-generic/termios.h            |   4 +-
 include/linux/sched.h                    |   7 +
 include/linux/signal.h                   |   5 +-
 include/linux/tty.h                      |   7 +-
 include/uapi/asm-generic/signal.h        |   1 +
 include/uapi/asm-generic/termbits.h      |   2 +
 34 files changed, 457 insertions(+), 33 deletions(-)
 create mode 100644 drivers/tty/n_tty_status.c

-- 
2.20.1
