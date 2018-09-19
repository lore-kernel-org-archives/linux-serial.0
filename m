From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] serial: 8250_uniphier: remove unused code and add
 auto-flow-control
Date: Wed, 19 Sep 2018 14:28:10 +0900
Message-ID: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Dai Okamura <okamura.dai@socionext.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
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
