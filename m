From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] serial: 8250_uniphier: bug fix and suspend/resume support
Date: Tue,  8 Aug 2017 22:48:40 +0900
Message-ID: <1502200123-2558-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

1/3 is a bug-fix (the driver may unregister a different port)

2/3 and 3/3 add suspend/resume support.



Masahiro Yamada (3):
  serial: 8250_uniphier: fix serial port index in private data
  serial: 8250_uniphier: use CHAR register for canary to detect
    power-off
  serial: 8250_uniphier: add suspend/resume support

 drivers/tty/serial/8250/8250_uniphier.c | 63 ++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 9 deletions(-)

-- 
2.7.4
