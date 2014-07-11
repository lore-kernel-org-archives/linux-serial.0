From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCH 0/2] tty: serial: fsl_lpuart: add 32-bit register support and
 dt-binding
Date: Fri, 11 Jul 2014 13:41:40 +0800
Message-ID: <1405057302-26041-1-git-send-email-jingchang.lu@freescale.com>
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
To: gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This two patches change the fsl-lpuart dt-binding to exact SoC product revision
and add 32-bit big-endian register interface support which can be found on
Freescale LS1021A SoC platform.

----------------------------------------------------------------
Jingchang Lu (2):
	dt-binding: fsl-lpuart: use exact SoC revision to document binding
	tty: serial: fsl_lpuart: add 32-bit register interface support

 Documentation/devicetree/bindings/serial/fsl-lpuart.txt |   6 +-
 drivers/tty/serial/fsl_lpuart.c                         | 653 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 648 insertions(+), 11 deletions(-)
