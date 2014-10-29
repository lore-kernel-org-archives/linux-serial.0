From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/2] Two msm_serial break fixes
Date: Wed, 29 Oct 2014 11:14:36 -0700
Message-ID: <1414606478-13709-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The first patch fixes a spinlock recursion. I suppose we can ship it back
to stable but I doubt anyone has noticed or cares. The second one adds
break support to the DM path, and allows sysrq to work.

Stephen Boyd (2):
  tty: serial: msm: Fix sysrq spinlock recursion on non-DM
  tty: serial: msm: Support sysrq on uartDM devices

 drivers/tty/serial/msm_serial.c | 47 +++++++++++++++++++++++++++++++----------
 drivers/tty/serial/msm_serial.h |  2 ++
 2 files changed, 38 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
