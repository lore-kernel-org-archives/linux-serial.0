From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 32/75] rio: Kill off ckmalloc
Date: Fri, 02 Jan 2009 13:45:12 +0000
Message-ID: <20090102134510.13472.18807.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37579 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756738AbZABNqJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:09 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

This was an alloc/clear wrapper but makes even less sense now it uses
kzalloc. Kill it off.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/rio/rio_linux.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)


diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
index ec2afd1..2e8a6ee 100644
--- a/drivers/char/rio/rio_linux.c
+++ b/drivers/char/rio/rio_linux.c
@@ -796,15 +796,6 @@ static int rio_init_drivers(void)
 	return 1;
 }
 
-
-static void *ckmalloc(int size)
-{
-	void *p;
-
-	p = kzalloc(size, GFP_KERNEL);
-	return p;
-}
-
 static const struct tty_port_operations rio_port_ops = {
 	.carrier_raised = rio_carrier_raised,
 };
@@ -827,18 +818,18 @@ static int rio_init_datastructures(void)
 #define TMIO_SZ sizeof(struct termios *)
 	rio_dprintk(RIO_DEBUG_INIT, "getting : %Zd %Zd %Zd %Zd %Zd bytes\n", RI_SZ, RIO_HOSTS * HOST_SZ, RIO_PORTS * PORT_SZ, RIO_PORTS * TMIO_SZ, RIO_PORTS * TMIO_SZ);
 
-	if (!(p = ckmalloc(RI_SZ)))
+	if (!(p = kzalloc(RI_SZ, GFP_KERNEL)))
 		goto free0;
-	if (!(p->RIOHosts = ckmalloc(RIO_HOSTS * HOST_SZ)))
+	if (!(p->RIOHosts = kzalloc(RIO_HOSTS * HOST_SZ, GFP_KERNEL)))
 		goto free1;
-	if (!(p->RIOPortp = ckmalloc(RIO_PORTS * PORT_SZ)))
+	if (!(p->RIOPortp = kzalloc(RIO_PORTS * PORT_SZ, GFP_KERNEL)))
 		goto free2;
 	p->RIOConf = RIOConf;
 	rio_dprintk(RIO_DEBUG_INIT, "Got : %p %p %p\n", p, p->RIOHosts, p->RIOPortp);
 
 #if 1
 	for (i = 0; i < RIO_PORTS; i++) {
-		port = p->RIOPortp[i] = ckmalloc(sizeof(struct Port));
+		port = p->RIOPortp[i] = kzalloc(sizeof(struct Port), GFP_KERNEL);
 		if (!port) {
 			goto free6;
 		}

