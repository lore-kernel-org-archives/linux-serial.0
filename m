From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] serial: Add name field to uart_port
Date: Tue, 21 Mar 2017 19:06:34 +0530
Message-ID: <20170321133636.8814-1-vigneshr@ti.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This series adds name attribute to uart_port struct inorder to store
name of the tty port that will help in identify different uart
instances.
This patch series is based on discussion here[1].


[1] https://www.spinics.net/lists/arm-kernel/msg569188.html

Vignesh R (2):
  tty: serial_core: Add name field to uart_port struct
  serial: 8250: 8250_core: Fix irq name for 8250 serial irq

 drivers/tty/serial/8250/8250_core.c | 2 +-
 drivers/tty/serial/serial_core.c    | 2 ++
 include/linux/serial_core.h         | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.11.0
