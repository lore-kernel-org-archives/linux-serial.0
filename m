From: David Kimdon <kimdon@esrf.fr>
Subject: [PATCH] : 8250.c don't iounmap() when no UPF_IOREMAP
Date: Mon, 21 Jun 2004 13:00:22 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040621110022.GE8110@wow.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from firewall.ill.fr ([193.49.43.1]:54502 "EHLO out.esrf.fr")
	by vger.kernel.org with ESMTP id S266186AbUFULAd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jun 2004 07:00:33 -0400
Received: (from uucp@localhost)
	by out.esrf.fr (1.0.0) id i5LB0WE25502
	for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2004 13:00:32 +0200 (MEST)
Received: from wow.esrf.fr (localhost [127.0.0.1])
	by esrf.esrf.fr (8.9.0/8.9.0) with ESMTP id NAA16152
	for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2004 13:00:23 +0200 (MET DST)
Received: from wow.esrf.fr (localhost [127.0.0.1])
	by wow.esrf.fr (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id i5LB0MU0010892
	for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2004 13:00:22 +0200
Received: (from kimdon@localhost)
	by wow.esrf.fr (8.12.7/8.12.7/Submit) id i5LB0MvO010890
	for linux-serial@vger.kernel.org; Mon, 21 Jun 2004 13:00:22 +0200
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have a PCI serial device, using 2.6.6 I get :

__iounmap: bad address fbc79200
__iounmap: bad address fbc79400
__iounmap: bad address fbc79600
. . . .

When the driver is unloaded.  Something like the included patch is, I
believe, necessary.  I don't see any drivers that actually use the
UPF_IOREMAP flag, so it isn't completely clear to me how it should be
used.


-David

* drivers/serial/8250.c 
  (serial8250_request_std_resource) : Only request a resource if
  UPF_IOREMAP is set.
  (serial8250_release_port) : If UPF_IOREMAP is not set then we
  didn't do an ioremap().  In that case we shouldn't do iounmap()
  or release_mem_region().

Index: linux/drivers/serial/8250.c
===================================================================
--- linux.orig/drivers/serial/8250.c	Mon May 10 11:48:00 2004
+++ linux/drivers/serial/8250.c	Mon Jun 21 12:26:42 2004
@@ -1634,7 +1634,7 @@ serial8250_request_std_resource(struct u
 
 	switch (up->port.iotype) {
 	case UPIO_MEM:
-		if (up->port.mapbase) {
+		if (up->port.mapbase && up->port.flags & UPF_IOREMAP) {
 			*res = request_mem_region(up->port.mapbase, size, "serial");
 			if (!*res)
 				ret = -EBUSY;
@@ -1698,7 +1698,7 @@ static void serial8250_release_port(stru
 
 	switch (up->port.iotype) {
 	case UPIO_MEM:
-		if (up->port.mapbase) {
+		if (up->port.mapbase && up->port.flags & UPF_IOREMAP) {
 			/*
 			 * Unmap the area.
 			 */

