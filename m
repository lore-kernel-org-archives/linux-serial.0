From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] tty/serial/max3100: Adjustments for max3100_probe()
Date: Fri, 8 Dec 2017 21:10:48 +0100
Message-ID: <82c37f92-b4ee-8bea-bd10-de3b6691151d@users.sourceforge.net>
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
Date: Fri, 8 Dec 2017 21:05:43 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
  Improve a size determination
  Improve unlocking of a mutex

 drivers/tty/serial/max3100.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.15.1
