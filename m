From: Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH] amba-pl011: fix panic introduced by "clear pending
 interrupts"
Date: Mon, 26 Mar 2012 22:32:09 +0200
Message-ID: <20120326203209.GA8182@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

patch 9b96fba, currently in linux-next, clears interrupts using
uap->port.membase that has not been assigned.  My x86 system,
that uses a pci-to-amba bridge, panics with a message like:

   BUG: unable to handle kernel NULL pointer dereference at 00000038
   IP: [<c12c85ed>] pl011_probe+0x119/0x303

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 drivers/tty/serial/amba-pl011.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2b4e981..38c992d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1947,8 +1947,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	/* Ensure interrupts from this UART are masked and cleared */
-	writew(0, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	writew(0, base + UART011_IMSC);
+	writew(0xffff, base + UART011_ICR);
 
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
-- 
1.7.7.2
