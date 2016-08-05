From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 05/11] tty/serial: at91: use of_property_read_bool
Date: Fri,  5 Aug 2016 10:56:45 +0200
Message-ID: <1470387411-15879-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use of_property_read_bool to check for the existence of a property.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S2,S1;
@@
-       if (of_get_property(e1,e2,NULL))
+       if (of_property_read_bool(e1,e2))
        S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/atmel_serial.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2eaa18d..c57a51d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1634,8 +1634,8 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
 
 	if (np) {
 		/* DMA/PDC usage specification */
-		if (of_get_property(np, "atmel,use-dma-rx", NULL)) {
-			if (of_get_property(np, "dmas", NULL)) {
+		if (of_property_read_bool(np, "atmel,use-dma-rx")) {
+			if (of_property_read_bool(np, "dmas")) {
 				atmel_port->use_dma_rx  = true;
 				atmel_port->use_pdc_rx  = false;
 			} else {
@@ -1647,8 +1647,8 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
 			atmel_port->use_pdc_rx  = false;
 		}
 
-		if (of_get_property(np, "atmel,use-dma-tx", NULL)) {
-			if (of_get_property(np, "dmas", NULL)) {
+		if (of_property_read_bool(np, "atmel,use-dma-tx")) {
+			if (of_property_read_bool(np, "dmas")) {
 				atmel_port->use_dma_tx  = true;
 				atmel_port->use_pdc_tx  = false;
 			} else {

