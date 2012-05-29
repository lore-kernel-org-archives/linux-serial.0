From: "Donald" <donald@asix.com.tw>
Subject: RE: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Tue, 29 May 2012 16:37:32 +0800
Message-ID: <005201cd3d76$4e2d0160$ea870420$@com.tw>
References: <00a301cd3719$b3faa370$1befea50$@com.tw> <20120521102848.7bfb49e0@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from asix.com.tw ([113.196.140.82]:56755 "EHLO asix.com.tw"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab2E2Ii5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 04:38:57 -0400
In-Reply-To: <20120521102848.7bfb49e0@pyramind.ukuu.org.uk>
Content-Language: zh-tw
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Hi Alan,

Sorry for my late reply. Below are my answers for your questions in previous emails:

1. Regarding how to detect the presence of the UART devices with this erratum, it's feasible to check the device's vendor
identification, which can be acquired by using " container_of" macro.

2. Regarding doing parity check by software, it's not feasible mainly because that the parity bit will be stripped off by the
hardware, the software can only get the data portion; hence no chance to do parity check.

3. Regarding the performance concern of the proposed software workaround, we had been verified this workaround and didn't see any
performance issue. For example, in a file transfer test at 115200 bps, the performance and CPU utilization rate are almost the same
between test drivers with and without this workaround.

4. Below is the complete patch for your preview, upon your approve, I will submit the formal patch by another email. Thank you for
your help.

drivers/tty/serial/8250/8250.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 5c27f7e..be493b0 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -38,6 +38,7 @@
 #include <linux/nmi.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #ifdef CONFIG_SPARC
 #include <linux/sunserialcore.h>
 #endif
@@ -2238,6 +2239,8 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, quot;
 
+	struct pci_dev *pdev = container_of(port->dev, struct pci_dev, dev);
+
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		cval = UART_LCR_WLEN5;
@@ -2351,6 +2354,13 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
+	if ((termios->c_cflag & PARENB) && (pdev->vendor == 0x9710)) {
+		fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+		up->ier &= ~UART_IER_RLSI;
+	} else {
+		up->ier |= UART_IER_RLSI;
+	}
+
 	serial_port_out(port, UART_IER, up->ier);
 
 	if (up->capabilities & UART_CAP_EFR) {
-- 
1.7.7.6

Regards,
Donald

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, May 21, 2012 5:29 PM
To: Donald
Cc: linux-serial@vger.kernel.org
Subject: Re: Questions regarding adding a patch in linux/drivers/char/8250.c

On Mon, 21 May 2012 14:19:34 +0800
"Donald" <donald@asix.com.tw> wrote:

> Hi,
> 
> This is Donald from ASIX Electronics Corp. My company has three PCI to Serial controllers, including MCS9845, MCS9835, and
MCS9820.
> Currently those serial devices using these three chips can directly 
> use the Linux kernel's serial driver in linux/drivers/char/8250.c. 
> Recently we find these three chips have a hardware bug relating to parity error count function. We have a software workaround for
this issue. Below for reference is a pseudo code for this workaround.
> 
> serial8250_do_set_termios() {
> 	If ((PID == MCS9845 || PID == MCS935 || PID == MCS9820) && ((termios->c_cflag & PARENB))) {
> 		port->fifosize = 1; /* Change RX FIFO size to 1 byte */
> 		up->ier &= ~UART_IER_RLSI; /* Disable RLSI interrupt */
> 	}	
> }
> 
> Is it possible to add a patch into linux/drivers/char/8250.c for our chips' hardware issue? 

Sure.

The only question I would have is how do we reliably detect the presence of the UART devices with this erratum. Can we do it from
the PCI identifier ?

Alan


