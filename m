From: "Mendez Salinas, Fernando" <fernando.mendez.salinas@intel.com>
Subject: RE: [PATCH v1 1/1] serial: 8250_mid: fix divide error bug if baud
 rate is 0
Date: Wed, 10 Aug 2016 16:38:17 +0000
Message-ID: <AEF21428FBDEDA4B9EB58EA55089A4FE30870F17@FMSMSX106.amr.corp.intel.com>
References: <1467382909-118812-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1467382909-118812-1-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


Hi Greg,

Do you know when this patch will be included in the kernel or if there is anything pending to do?

Thanks
Fernando

-----Original Message-----
From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com] 
Sent: Friday, July 1, 2016 9:22 AM
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Heikki Krogerus <heikki.krogerus@linux.intel.com>; linux-serial@vger.kernel.org; Mendez Salinas, Fernando <fernando.mendez.salinas@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; stable@vger.kernel.org
Subject: [PATCH v1 1/1] serial: 8250_mid: fix divide error bug if baud rate is 0

Since the commit c1a67b48f6a5 ("serial: 8250_pci: replace switch-case by formula for Intel MID"), the 8250 driver crashes in the byt_set_termios() function with a divide error. This is caused by the fact that a baud rate of 0
(B0) is not handled properly. Fix it by falling back to B9600 in this case.

Reported-by: "Mendez Salinas, Fernando" <fernando.mendez.salinas@intel.com>
Fixes: c1a67b48f6a5 ("serial: 8250_pci: replace switch-case by formula for Intel MID")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index ac37f67..44c71f4 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -173,6 +173,9 @@ static void mid8250_set_termios(struct uart_port *p,
 	unsigned long w = BIT(24) - 1;
 	unsigned long mul, div;
 
+	/* Gracefully handle the B0 case: fall back to B9600 */
+	fuart = fuart ? fuart : 9600 * 16;
+
 	if (mid->board->freq < fuart) {
 		/* Find prescaler value that satisfies Fuart < Fref */
 		if (mid->board->freq > baud)
--
2.8.1
