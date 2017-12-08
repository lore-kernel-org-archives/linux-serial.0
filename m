From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] tty/serial/ioc4: Adjustments for four function
 implementations
Date: Fri, 8 Dec 2017 22:50:16 +0100
Message-ID: <514232dd-7e91-00f9-b95c-3e8f740090ca@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pat Gefre <pfg@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 22:47:43 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete error messages for a failed memory allocation in two functions
  Improve four size determinations
  Adjust three function calls together with a variable assignment

 drivers/tty/serial/ioc4_serial.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

-- 
2.15.1

