From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 0/2] serial: mps2-uart: minor improvements
Date: Fri, 25 Jan 2019 14:13:15 +0000
Message-ID: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
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
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
List-Id: linux-serial@vger.kernel.org

This mini series is supposed to improve MPS2 uart driver for:
 1. platforms with number of virtual serial ports, like MPS3
 2. platforms with combined TX/RX irq

Vladimir Murzin (2):
  serial: mps2-uart: move to dynamic port allocation
  serial: mps2-uart: support combined tx and rx irq

 drivers/tty/serial/mps2-uart.c | 136 ++++++++++++++++++++++++++++-------------
 1 file changed, 95 insertions(+), 41 deletions(-)

-- 
2.7.4
