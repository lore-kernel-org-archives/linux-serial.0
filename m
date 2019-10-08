From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] Documentation: admin-guide: add earlycon documentation for
 the sifive serial driver
Date: Tue, 8 Oct 2019 16:08:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, schwab@suse.de, hch@lst.de
List-Id: linux-serial@vger.kernel.org


Document earlycon usage for the SiFive serial port driver in the same
fashion as for the other serial port IP blocks, since the SiFive
serial port driver supports it.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reported-by: Andreas Schwab <schwab@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3ac99f..90becb00221b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1106,6 +1106,12 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+		sifive,<addr>
+			Start an early, polled-mode console on a SiFive
+			serial port at the specified address.  The port must
+			already be setup and configured.  Options are not
+			yet supported.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
-- 
2.23.0
