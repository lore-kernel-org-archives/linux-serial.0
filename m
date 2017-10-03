From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.14-rc4
Date: Tue, 3 Oct 2017 14:20:53 +0200
Message-ID: <20171003122053.GA26300@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.14-rc4

for you to fetch changes up to c91261437985d481c472639d4397931d77f5d4e9:

  serial: sccnxp: Fix error handling in sccnxp_probe() (2017-09-18 18:19:21 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.14-rc4

Here are a small number (5) of patches for some reported TTY and serial
issues.  Nothing major, a documentation update, timing fix, error
handling fix, name reporting fix, and a timeout issue resolved.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Khoroshilov (1):
      serial: sccnxp: Fix error handling in sccnxp_probe()

Fugang Duan (1):
      tty: serial: lpuart: avoid report NULL interrupt

Jiri Slaby (1):
      mxser: fix timeout calculation for low rates

Russell Enderby (1):
      serial: bcm63xx: fix timing issue.

Sergei Shtylyov (1):
      serial: sh-sci: document R8A77970 bindings

 .../bindings/serial/renesas,sci-serial.txt         |  2 ++
 drivers/tty/mxser.c                                | 16 ++++++---
 drivers/tty/serial/bcm63xx_uart.c                  |  5 +++
 drivers/tty/serial/fsl_lpuart.c                    | 40 +++++++++-------------
 drivers/tty/serial/sccnxp.c                        | 13 +++++--
 5 files changed, 46 insertions(+), 30 deletions(-)
