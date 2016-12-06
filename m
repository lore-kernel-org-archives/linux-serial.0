From: Jason Uy <jason.uy@broadcom.com>
Subject: [PATCH v1 0/1] serial: 8250_dw: Allow hardware flow control to be used
Date: Tue,  6 Dec 2016 14:34:02 -0800
Message-ID: <1481063643-11951-1-git-send-email-jason.uy@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, Jason Uy <jason.uy@broadcom.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-serial@vger.kernel.org

This patchset contains changes to allow AUTOCTS to be set for the Synopsys DW UART driver.  There is currently no way to set AUTOCTS unless the platform adds a quirk entry and sets the termios callback function.  

There was a discussion about a similar proposed patch change.  It was mentioned in the discussion that the reason set_termios hook was not set by default is because someone might be using a certain type of clock that can't handle rate rounding and ended up using improper clock frequency for some baud rates.  See discussion thread here.

https://groups.google.com/forum/#!topic/fa.linux.kernel/oWrFOsw3rpQ

The current dw8250_set_termios is set such that it always call the standard serial8250_do_set_termios.  So if there are clock frequency issues, this will be resolved in serial8250_do_set_termios.

This patchset has been tested on Cygnus VOIP board bcm911360_entphn board.

This patchset is based on v4.9-rc1

repo: https://github.com/Broadcom/cygnus-linux.git

branch: cygnus-tty-v1


Jason Uy (1):
  serial: 8250_dw: Allow hardware flow control to be used

 drivers/tty/serial/8250/8250_dw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
1.9.1
