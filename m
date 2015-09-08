From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 0/3] serial: samsung: Fix UART status handling and other fixes
Date: Tue, 08 Sep 2015 11:38:44 +0200
Message-ID: <1441705127-24125-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hello,

This patch set contains three patches: two minor fixes and one quite
important bugfix enabling UART status handling in DMA mode, which was
missing so far. It enables, among others, 'break' contition handling,
which is necessary if we want to use Magic SysRq. So this patch fixes
Magic SysRq handling for serial consoles using UART in DMA mode,

Best regards,
Robert Baldyga

Robert Baldyga (3):
  serial: samsung: remove unused 'irq' parameter
  serial: samsung: remove unneded 'ignore_char' label
  serial: samsung: Fix UART status handling in DMA mode

 drivers/tty/serial/samsung.c | 151 ++++++++++++++++++-------------------------
 1 file changed, 64 insertions(+), 87 deletions(-)

-- 
1.9.1
