From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/2] serial: fsl_lpuart: DMA improvements
Date: Sat, 10 Jan 2015 09:33:44 +0100
Message-ID: <1420878826-10214-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

This are the remaining to patches 2 and 4 from the first version of
this patchset. The patchset is based on the fixes patchset.
https://lkml.org/lkml/2015/1/9/757

Changes since v1:
- Reorderred and rebased on v3.19-rc3

Stefan Agner (2):
  serial: fsl_lpuart: move DMA channel request to probe
  serial: fsl_lpuart: update RX timer on successful DMA transfer

 drivers/tty/serial/fsl_lpuart.c | 97 +++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

-- 
2.2.1
