From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 0/4] serial: samsung: Fix UART status handling and other
 fixes
Date: Thu, 10 Sep 2015 15:41:12 +0200
Message-ID: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hello,

This patch set contains four patches: two minor fixes and two patches
fixing quite importatn bug which was missing UART status handling in
DMA mode. It fixes, among others, 'break' contition handling, which is
necessary if we want to use Magic SysRq. So this patch fixes Magic SysRq
handling for serial consoles using UART in DMA mode,

Best regards,
Robert Baldyga

Changelog:

v2:
- address comments from Krzysztof Kozlowski:
  - add comment in patch removing 'ignore_char' label
  - split patch "Fix UART status handling in DMA mode"
    into two patches for better code readability

v1: https://lkml.org/lkml/2015/9/8/190

Robert Baldyga (4):
  serial: samsung: remove unused 'irq' parameter
  serial: samsung: remove unneded 'ignore_char' label
  serial: samsung: introduce s3c24xx_serial_rx_drain_fifo() function
  serial: samsung: Fix UART status handling in DMA mode

 drivers/tty/serial/samsung.c | 66 ++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 45 deletions(-)

-- 
1.9.1
