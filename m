From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] serial: vt8500_serial: Fix a parameter of find_first_zero_bit.
Date: Wed, 24 Aug 2016 07:06:58 +0200
Message-ID: <1472015218-31826-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@prisktech.co.nz, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

The 2nd parameter of 'find_first_zero_bit' is the number of bits to search.
In this case, we are passing 'sizeof(vt8500_ports_in_use)'.
'vt8500_ports_in_use' is an 'unsigned long'. So the sizeof is likely to
return 4 on a 32 bits kernel.

A few lines below, we check if it is below VT8500_MAX_PORTS, which is 6.

It is likely that the number of bits in a long was expected here.

In order to fix it:
   - use DECLARE_BITMAP when declaring the vt8500_ports_in_use
   - use VT8500_MAX_PORTS as a maximum value when checking/setting bits in
     this bitmap
   - modify code now that 'vt8500_ports_in_use' has become a pointer
     because of the use of DECLARE_BITMAP


It has been spotted by the following coccinelle script:
@@
expression ret, x;

@@
*  ret = \(find_first_bit \| find_first_zero_bit\) (x, sizeof(...));

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: - use of VT8500_MAX_PORTS instead of BITS_PER_LONG to better self
      document the code
    - declare vt8500_ports_in_use with DECLARE_BITMAP in order to self
      document even better and to be foolproof should VT8500_MAX_PORTS
      be changed one day
---
 drivers/tty/serial/vt8500_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 23cfc5e16b45..6b85adce0ac9 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -118,7 +118,7 @@ struct vt8500_port {
  * have been allocated as we can't use pdev->id in
  * devicetree
  */
-static unsigned long vt8500_ports_in_use;
+static DECLARE_BITMAP(vt8500_ports_in_use, VT8500_MAX_PORTS);
 
 static inline void vt8500_write(struct uart_port *port, unsigned int val,
 			     unsigned int off)
@@ -663,15 +663,15 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 
 	if (port < 0) {
 		/* calculate the port id */
-		port = find_first_zero_bit(&vt8500_ports_in_use,
-					sizeof(vt8500_ports_in_use));
+		port = find_first_zero_bit(vt8500_ports_in_use,
+					   VT8500_MAX_PORTS);
 	}
 
 	if (port >= VT8500_MAX_PORTS)
 		return -ENODEV;
 
 	/* reserve the port id */
-	if (test_and_set_bit(port, &vt8500_ports_in_use)) {
+	if (test_and_set_bit(port, vt8500_ports_in_use)) {
 		/* port already in use - shouldn't really happen */
 		return -EBUSY;
 	}
-- 
2.7.4


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
