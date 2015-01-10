From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/2] serial: fsl_lpuart: fix DMA issues for 3.19
Date: Sat, 10 Jan 2015 01:08:57 +0100
Message-ID: <1420848539-4519-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

This is patch 1 and 3 of the first version of this patchset.

Changes since v1:
- Reproduced on v3.19-rc3 and rebased ontop of that
- Make sure that RDMAS is cleared on startup

Stefan Agner (2):
  serial: fsl_lpuart: delete timer on shutdown
  serial: fsl_lpuart: avoid new transfer while DMA is running

 drivers/tty/serial/fsl_lpuart.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.2.1
