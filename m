From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 0/4] serial: uartps: Driver updates
Date: Tue, 18 Dec 2018 13:18:38 +0100
Message-ID: <cover.1545135519.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

I am sending 4 patches in series to fix some issues we found.
Patches were sent separately but I have been asked to send them in
serial that's why I am also adding cover letter to explain this v2
version.

Thanks,
Michal

Changes in v2:
- Change description based on request from Greg
- Fix Nava's email address to align with patch email address

Michal Simek (1):
  serial: uartps: Fix error path when alloc failed

Nava kishore Manne (1):
  serial: uartps: Fix interrupt mask issue to handle the RX interrupts
    properly

Shubhrajyoti Datta (2):
  serial: uartps: Add the device_init_wakeup
  serial: uartps: Check if the device is a console

 drivers/tty/serial/xilinx_uartps.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
1.9.1
