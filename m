From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] serial: 8250: bind to ALi Fast Infrared Controller (ALI5123)
Date: Sun, 02 Aug 2015 23:15:05 +0200
Message-ID: <55BE8859.8090009@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

This way this device can be used with irtty-sir -
at least on Toshiba Satellite A20-S103 it is not configured by default
and needs PNP activation before it starts to respond on I/O ports.

This device has actually its own driver (ali-ircc),
but this driver seems to be non-functional for a very long time
(see http://permalink.gmane.org/gmane.linux.irda.general/484
http://permalink.gmane.org/gmane.network.protocols.obex.openobex.user/943
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=535070 ).

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/acpi/acpi_pnp.c            |    1 +
 drivers/tty/serial/8250/8250_pnp.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index ff6d8ad..fb76552 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -153,6 +153,7 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	{"AEI0250"},		/* PROLiNK 1456VH ISA PnP K56flex Fax Modem */
 	{"AEI1240"},		/* Actiontec ISA PNP 56K X2 Fax Modem */
 	{"AKY1021"},		/* Rockwell 56K ACF II Fax+Data+Voice Modem */
+	{"ALI5123"},		/* ALi Fast Infrared Controller */
 	{"AZT4001"},		/* AZT3005 PnP SOUND DEVICE */
 	{"BDP3336"},		/* Best Data Products Inc. Smart One 336F PnP Modem */
 	{"BRI0A49"},		/* Boca Complete Ofc Communicator 14.4 Data-FAX */
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 61fd3d3..658b392 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -41,6 +41,12 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{	"AEI1240",		0	},
 	/* Rockwell 56K ACF II Fax+Data+Voice Modem */
 	{	"AKY1021",		0 /*SPCI_FL_NO_SHIRQ*/	},
+	/*
+	 * ALi Fast Infrared Controller
+	 * Native driver (ali-ircc) is broken so at least
+	 * it can be used with irtty-sir.
+	 */
+	{	"ALI5123",		0	},
 	/* AZT3005 PnP SOUND DEVICE */
 	{	"AZT4001",		0	},
 	/* Best Data Products Inc. Smart One 336F PnP Modem */
