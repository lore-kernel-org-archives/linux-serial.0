From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 0/5] serial: 8250: 8250_dw changes and dynamic capabilities
Date: Mon,  3 Dec 2012 13:17:54 +0200
Message-ID: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


Changes since v1:
- rebased on top of Greg's tty-next

These are mainly small 8250_dw.c changes. The interesting patch is
probable the first one that changes 8250.c so the drivers are able to
deliver their UART's capabilities when they are registering ports.


Heikki Krogerus (5):
  serial: 8250: Allow drivers to deliver capabilities
  serial: 8250_dw: Don't use UPF_FIXED_TYPE
  serial: 8250_dw: Map IO memory
  serial: 8250_dw: Move device tree code to separate function
  serial: 8250_dw: Set FIFO size dynamically

 drivers/tty/serial/8250/8250.c    |   22 ++++--
 drivers/tty/serial/8250/8250_dw.c |  140 +++++++++++++++++++++++++++----------
 2 files changed, 120 insertions(+), 42 deletions(-)

-- 
1.7.10.4
