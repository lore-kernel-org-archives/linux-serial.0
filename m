From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 7/9] tty: serial: exar: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:07 +0530
Message-ID: <1500804069-11043-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500804069-11043-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500804069-11043-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jirislaby@gmail.com, jslaby@suse.com, gpiccoli@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   4030	   1280	      0	   5310	   14be	tty/serial/8250/8250_exar.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4958	    352	      0	   5310	   14be	tty/serial/8250/8250_exar.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b5c98e5..6f031fc 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -601,7 +601,7 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd			\
 	}
 
-static struct pci_device_id exar_pci_tbl[] = {
+static const struct pci_device_id exar_pci_tbl[] = {
 	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
 	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
 	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
-- 
2.7.4
