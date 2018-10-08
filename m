From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH stable v2 0/2] termios: Alpha BOTHER/IBSHIFT, tty_baudrate fix
Date: Sun,  7 Oct 2018 21:06:18 -0700
Message-ID: <20181008040620.1248277-1-hpa@zytor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tobias Klausmann <klausman@schwarzvogel.de>, "H. Peter Anvin (Intel)" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

It turns out that Alpha is the only architecture that never
implemented BOTHER and IBSHIFT, which is otherwise ages old. This is
one thing that has held up glibc support for this feature (all other
architectures have supported these for about a decade, at least before
the current 3.2 glibc cutoff.)

Furthermore, in the process of dealing with this, I discovered that
the current code in tty_baudrate.c can read past the end of the
baud_table[] on Alpha and PowerPC. The second patch in this series
fixes that, but it also cleans up the code substantially by
auto-generating the table and, since all architectures now have them,
removing all conditionals for BOTHER and IBSHIFT existing.

Tagging for stable because these are concrete and immediate
problems. I have a much bigger update in process, nearly done, which
will clean up a lot of duplicated code and make the uapi headers
usable for libc, but that is not critical on the same level.

Tested on x86, compile-tested on Alpha. SPARC, and PowerPC.

v2: the CBAUDEX masking-as-fallback code was wrong, but it could never
    be exercised on any architecture anyway (gcc would not even emit it)
    so just remove it. There are thus no object code changes from v1.

---
 arch/alpha/include/asm/termios.h       |   8 +-
 arch/alpha/include/uapi/asm/ioctls.h   |   5 +
 arch/alpha/include/uapi/asm/termbits.h |  17 +++
 drivers/tty/.gitignore                 |   1 +
 drivers/tty/Makefile                   |  16 +++
 drivers/tty/bmacros.c                  |   2 +
 drivers/tty/tty_baudrate.c             | 182 ++++++++++++---------------------
 7 files changed, 114 insertions(+), 117 deletions(-)

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>
