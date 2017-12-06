From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] tty/serial/ucc_uart: Adjustments for two functions
Date: Wed, 6 Dec 2017 22:10:06 +0100
Message-ID: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@tabi.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Dec 2017 22:06:44 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in ucc_uart_probe()
  Improve a size determination in ucc_uart_probe()
  Fix a typo in a comment line

 drivers/tty/serial/ucc_uart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.15.1
