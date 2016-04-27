From: =?UTF-8?q?David=20M=C3=BCller?= <d.mueller@elsoft.ch>
Subject: [PATCH v3] serial: 8250_pci: fix divide error bug if baud rate is 0
Date: Wed, 27 Apr 2016 11:58:32 +0200
Message-ID: <1461751112-3194-1-git-send-email-d.mueller@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Since commit 21947ba654a6 ("serial: 8250_pci: replace switch-case by
formula"), the 8250 driver crashes in the byt_set_termios() function
with a divide error. This is caused by the fact that a baud rate of 0 (=
B0)
is not handled properly. Fix it by falling back to B9600 in this case.

Signed-off-by: David M=C3=BCller <d.mueller@elsoft.ch>
=46ixes: 21947ba654a6 ("serial: 8250_pci: replace switch-case by formul=
a")
Cc: stable@vger.kernel.org
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: minor rewording of commit message and comment, added various tags
v2: use a more elegant fix as suggested by Andy Shevchenko

 drivers/tty/serial/8250/8250_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index 98862aa..4eedd1d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1377,6 +1377,9 @@ byt_set_termios(struct uart_port *p, struct kterm=
ios *termios,
 	unsigned long m, n;
 	u32 reg;
=20
+	/* Gracefully handle the B0 case: fall back to B9600 */
+	fuart =3D fuart ? fuart : 9600 * 16;
+
 	/* Get Fuart closer to Fref */
 	fuart *=3D rounddown_pow_of_two(fref / fuart);
=20
--=20
2.7.4
