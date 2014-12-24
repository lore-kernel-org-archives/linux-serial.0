From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/3] Early 8250 fixlets
Date: Wed, 24 Dec 2014 12:42:13 +0530
Message-ID: <1419405136-14520-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-serial@vger.kernel.org

Hi,

This series addresses some of the issues seen on early 8250 uart when
working with ARC SDP platform.

Thx,
-Vineet

Vineet Gupta (3):
  serial: 8250_early: optimize early 8250 uart
  serial: 8250_early: prepare for dynamic BASE_BAUD
  ARC: runtime determine BASE_BAUD per machine

 arch/arc/include/asm/serial.h        | 24 ++++--------------------
 arch/arc/kernel/devtree.c            | 24 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_early.c |  7 +++++--
 drivers/tty/serial/earlycon.c        | 13 +++++++++++--
 4 files changed, 44 insertions(+), 24 deletions(-)

-- 
1.8.3.2
