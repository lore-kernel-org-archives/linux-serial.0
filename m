From: Johannes Weiner <hannes-kernel@saeurebad.de>
Subject: Re: [PATCH][KJ] 8250: remove unnecessary variable tmout from  wait_for_xmitr()
Date: Thu, 13 Dec 2007 15:51:54 +0100
Message-ID: <x7hcim4ph1.fsf@saeurebad.de>
References: <11975548843528-git-send-email-andre@bitwigglers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762109AbXLMOxI@vger.kernel.org>
In-Reply-To: <11975548843528-git-send-email-andre@bitwigglers.org> (Andre
	Haupt's message of "Thu, 13 Dec 2007 15:08:04 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Andre Haupt <andre@bitwigglers.org>
Cc: kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Andre Haupt <andre@bitwigglers.org> writes:

> This fixes a sparse warning about symbol tmout shadowing an earlier one.
>
> Signed-off-by: Andre Haupt <andre@bitwigglers.org>
> ---
>  drivers/serial/8250.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

The whole timeout loops look somewhat odd.  How about the following,
totally untested, solution?

This converts the function to use more common timeout-loop constructs,
gets rid of the shadowed variable and localises another variable even
more! Hooray!

	Hannes

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
---

 drivers/serial/8250.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..7215f6a 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1712,30 +1712,30 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
  */
 static inline void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
-	unsigned int status, tmout = 10000;
+	unsigned int tmout;
 
 	/* Wait up to 10ms for the character(s) to be sent. */
+	tmout = jiffies + jiffies_to_msecs(10);
 	do {
-		status = serial_in(up, UART_LSR);
+		unsigned int status = serial_in(up, UART_LSR);
 
-		up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;
-
-		if (--tmout == 0)
+		up->lsr_saved_flags |= (status & LSR_SAVE_FLAGS);
+		if ((status & bits) == bits)
 			break;
 		udelay(1);
-	} while ((status & bits) != bits);
+	} while (time_after_eq(tmout, jiffies));
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
-		unsigned int tmout;
-		for (tmout = 1000000; tmout; tmout--) {
+		tmout = jiffies + jiffies_to_msecs(1000);
+		do {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
 			if (msr & UART_MSR_CTS)
 				break;
 			udelay(1);
 			touch_nmi_watchdog();
-		}
+		} while (time_after_eq(tmout, jiffies));
 	}
 }
 
