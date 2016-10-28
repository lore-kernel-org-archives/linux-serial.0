From: Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] uart_close related fixes
Date: Fri, 28 Oct 2016 07:07:46 -0500
Message-ID: <20161028120748.27763-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Mike Galbraith <mgalbraith@suse.de>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-serial@vger.kernel.org

Greg,

As discussed, these are the 2 fixes needed to fix regressions with 
761ed4a94582ab29 ("tty: serial_core: convert uart_close to use 
tty_port_close"). Hopefully these fix all the fallout.

These apply on top of the previous patch from me which you applied.

Rob


Geert Uytterhoeven (1):
  tty: serial_core: Fix serial console crash on port shutdown

Rob Herring (1):
  tty: serial_core: fix NULL struct tty pointer access in
    uart_write_wakeup

 drivers/tty/serial/serial_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.10.1
