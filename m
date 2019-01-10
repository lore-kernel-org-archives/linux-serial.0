From: Andreas Schwab <schwab@suse.de>
Subject: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL early
 console
Date: Thu, 10 Jan 2019 18:11:39 +0100
Message-ID: <mvmsgy0cu9g.fsf_-_@suse.de>
References: <20181204135507.3706-1-anup@brainfault.org>
        <20181204135507.3706-2-anup@brainfault.org>
        <mvmbm4oehd5.fsf_-_@suse.de>
        <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
        <mvm7efcedop.fsf@suse.de>
        <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
        (Anup Patel's message of "Thu, 10 Jan 2019 21:47:07 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup@brainfault.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This enables proper NLCR processing.

Suggested-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 drivers/tty/serial/earlycon-riscv-sbi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index e1a551aae3..ce81523c31 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -10,13 +10,16 @@
 #include <linux/serial_core.h>
 #include <asm/sbi.h>
 
-static void sbi_console_write(struct console *con,
-			      const char *s, unsigned int n)
+static void sbi_putc(struct uart_port *port, int c)
 {
-	int i;
+	sbi_console_putchar(c);
+}
 
-	for (i = 0; i < n; ++i)
-		sbi_console_putchar(s[i]);
+static void sbi_console_write(struct console *con,
+			      const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+	uart_console_write(&dev->port, s, n, sbi_putc);
 }
 
 static int __init early_sbi_setup(struct earlycon_device *device,
-- 
2.20.1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
