From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] tty/serial/sccnxp: Adjustments for sccnxp_probe()
Date: Thu, 7 Dec 2017 22:18:02 +0100
Message-ID: <90e7fa7a-c0e6-4819-9fa6-fae1a71685eb@users.sourceforge.net>
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
Date: Thu, 7 Dec 2017 22:14:32 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/tty/serial/sccnxp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.15.1
