From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH 0/3] serial: mxs-auart: flush_buffer hook and interrupt
 processing
Date: Fri, 29 Nov 2013 17:35:24 +0100
Message-ID: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
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
Cc: fabio.estevam@freescale.com, marex@denx.de, gregkh@linuxfoundation.org, b32955@freescale.com, hector.palacios@digi.com, u.kleine-koenig@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

This series implement several fixes to the mxs-auart serial driver.

The first patch implements the flush_buffer hook. Currently the driver
can be shut down and pending data in the FIFO will be lost.

The second patchs adds a check of the BUSY flag in the tx_empty hook
to make sure the UART is not about to fill data into the FIFO.

The third patch moves the interrupt handling from the ISR out to a
tasklet. This was motivated due to different transmission problems
with hardware and software flow control at high baudrates whereby
transmission was interrupted or data lost. 
The problem can be reproduced by setting two AUARTs at 576000/N/8 
with CRTSCTS and sending a large file from one port to the other
 with 'cat'.

Hector Palacios (3):
  serial: mxs-auart: implement flush_buffer hook
  serial: mxs-auart: check BUSY flag on tx_empty hook
  serial: mxs-auart: move irq handling to a tasklet

 drivers/tty/serial/mxs-auart.c | 93 ++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 25 deletions(-)
