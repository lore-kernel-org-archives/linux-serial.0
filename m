From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH 0/5] tty: serial: msm: Fix checkpatch errors
Date: Tue,  5 Aug 2014 13:21:58 +0530
Message-ID: <1407225124-25074-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davidb@codeaurora.org
Cc: dwalker@fifo99.com, bryanh@codeaurora.org, sboyd@codeaurora.org, gregkh@linuxfoundation.org, jslaby@suse.cz, kiran.padwal@smartplayin.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Kiran Padwal (5):
  tty: serial: msm: remove braces {} in msm_serial.c
  tty: serial: msm: Fix 'Missing a blank line after declarations'
    warning
  tty: serial: msm: Fix style warnings relating to printk()
  tty: serial: msm: Fix 'else is not generally useful after a break or
    return' warning
  tty: serial: msm: Fix 'void function return statements are not
    generally useful' warning

 drivers/tty/serial/msm_serial.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
1.7.9.5
