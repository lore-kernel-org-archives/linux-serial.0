From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 0/2] Early 8250 fixlets
Date: Tue, 6 Jan 2015 16:59:09 +0530
Message-ID: <1420543751-17468-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, Peter Hurley <peter@hurleysoftware.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-serial@vger.kernel.org

Hi,

This series addresses some of the issues seen on early 8250 uart when
working with ARC SDP platform.

Changes since v2 [2]
	-Patch 2/3 dropped (see next bullet)
	-Remove the weak binding scheme and make BASE_BAUD simply call arch
	 function					[Peter Hurley]
	-Verified that IER optimization 1/3 is per line, not char - hence
	 Changelog updated				[Peter Hurley]

Changes since v1 [1]
	-Rebased to linux-next of 20150105
	-Patch 3/3 SNAFU fixed (arch over-ride was not correct due to mix up
	 of orig work based off 3.13 vs. 3.19+ based linux next submission
	 (different core earlycon code)
Thx,
-Vineet

[2] http://www.spinics.net/linux/lists/kernel/msg1896349.html
[1] http://www.spinics.net/lists/kernel/msg1893299.html

Vineet Gupta (2):
  serial: 8250_early: optimize early 8250 uart
  ARC: Dynamically determine BASE_BAUD from DeviceTree

 arch/arc/include/asm/serial.h        | 23 +++++------------------
 arch/arc/kernel/devtree.c            | 24 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_early.c |  7 +++++--
 3 files changed, 34 insertions(+), 20 deletions(-)

-- 
1.9.1
