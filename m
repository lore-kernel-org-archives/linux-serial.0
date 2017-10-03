From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V1 0/3] High baud rate supports of F81866/F81216H
Date: Tue,  3 Oct 2017 11:08:32 +0800
Message-ID: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: rel+kernel@agilox.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The Fintek F81866/F81216H support high baud rate and it's up to 1.5Mbps
with 24MHz clock source. It's also support 500Kbps via 24MHz clock too.

We'll implements clock source checking in function fintek_8250_set_termios().

Ji-Ze Hong (Peter Hong) (3):
  serial: 8250_fintek: UART dynamic clocksource on Fintek F81866
  serial: 8250_fintek: UART dynamic clocksource on Fintek F81216H
  serial: 8250_fintek: fix warning reported from smatch

 drivers/tty/serial/8250/8250_fintek.c | 84 ++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

-- 
1.9.1
