From: <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v4] serial/arc-uart: Add New Driver
Date: Thu, 25 Oct 2012 12:00:07 +0530
Message-ID: <1351146608-21044-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: arc-linux-dev@synopsys.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-serial@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

Hi Greg,

Rebased off of tty-next and verfied that it builds fine.
Please consider applying.

Thanks,
Vineet

v4:
* UAPI disintegration fallout for serial_core.h
* rebased off of tty-next

v3:
* Removed empty arc_serial_set_ldisc()
* More set_termios fixes - CSIZE forced to CS8 (for 8N1)
* global @running_on_iss replaced with platform data, saved in device
  specific port structure.

v2:
* ttyARC used as device name
* Dynamic assignment of major/minor numbers.
* Ref counting tty in rx routine to prevent it from disappearing in
  case of a hangup
* set_termios fixes:
  - hardware flow control/parity are marked as unsupported
  - baud written back to termios
* cosmetics such as commenting the need for @running_on_iss, empty lines
  etc

Vineet Gupta (1):
  serial/arc-uart: Add new driver

 drivers/tty/serial/Kconfig       |   25 ++
 drivers/tty/serial/Makefile      |    1 +
 drivers/tty/serial/arc_uart.c    |  747 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |    2 +
 4 files changed, 775 insertions(+), 0 deletions(-)
 create mode 100644 drivers/tty/serial/arc_uart.c

-- 
1.7.4.1
