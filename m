From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: [PATCH 0/2] tty: serial: kgdb support for fsl_lpuart
Date: Tue,  4 Oct 2016 15:46:15 +0300
Message-ID: <1475585177-28777-1-git-send-email-nicolae.rosia.oss@gmail.com>
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
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Agner <stefan@agner.ch>, Stefan Golinschi <stefan.golinschi@gmail.com>, Jiri Slaby <jslaby@suse.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nicolae Rosia <nicolae_rosia@mentor.com>

This patch series enables kgdb to be used with fsl_lpuart
on Vybrid processors.

Tested on Vybrid VF61

Nicolae Rosia (2):
  tty: serial: fsl_lpuart: add polled console functions
  tty: serial: Makefile: move kgdb to be initialized last

 drivers/tty/serial/Makefile     |  5 ++--
 drivers/tty/serial/fsl_lpuart.c | 66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.5.5
