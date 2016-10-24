From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/4] serial: 8250_uniphier: some fixes and optimization
Date: Mon, 24 Oct 2016 17:00:26 +0900
Message-ID: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This series is mostly based on excellent observant comments
from Denys Vlasenko.

 - Add '\n' to a printk message
 - Fix a minor bug
 - Memory access optimization
 - Locking optimization



Denys Vlasenko (1):
  serial: 8250_uniphier: fix more unterminated string

Masahiro Yamada (3):
  serial: 8250_uniphier: fix clearing divisor latch access bit
  serial: 8250_uniphier: hardcode regshift to avoid unneeded memory read
  serial: 8250_uniphier: avoid locking for FCR register write

 drivers/tty/serial/8250/8250_uniphier.c | 50 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
1.9.1
