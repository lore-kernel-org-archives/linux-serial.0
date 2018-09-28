From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 0/3] serial: 8250_uniphier: remove unused code and add auto-flow-control
Date: Fri, 28 Sep 2018 11:05:06 +0900
Message-ID: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Dai Okamura <okamura.dai@socionext.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

 - Remove never-used DT property
 - Refactor code
 - Add auto-flow-control support


Dai Okamura (1):
  serial: 8250_uniphier: add auto-flow-control support

Masahiro Yamada (2):
  serial: 8250_uniphier: remove unused "fifo-size" property
  serial: 8250_uniphier: flatten probe function

 .../devicetree/bindings/serial/uniphier-uart.txt   |  3 +-
 drivers/tty/serial/8250/8250_uniphier.c            | 62 ++++++++--------------
 2 files changed, 22 insertions(+), 43 deletions(-)

-- 
2.7.4
