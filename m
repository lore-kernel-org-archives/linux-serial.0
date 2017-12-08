From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] tty/serial/pch_uart: Adjustments for four function
 implementations
Date: Fri, 8 Dec 2017 19:08:09 +0100
Message-ID: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 19:03:45 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in dma_handle_tx()
  Use kcalloc() in dma_handle_tx()
  Delete an unnecessary return statement in two functions
  Improve a size determination in pch_uart_init_port()

 drivers/tty/serial/pch_uart.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.15.1
