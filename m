From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] tty/serial/ioc3: Adjustments for three function
 implementations
Date: Sat, 9 Dec 2017 19:02:28 +0100
Message-ID: <962f1172-3f27-c6b5-653f-c09f2e8fe431@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-ia64-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-ia64@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pat Gefre <pfg@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Dec 2017 19:00:19 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete error messages for a failed memory allocation in ioc3uart_probe()
  Improve size determinations in ioc3uart_probe()
  Adjust two function calls together with a variable assignment

 drivers/tty/serial/ioc3_serial.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

-- 
2.15.1

