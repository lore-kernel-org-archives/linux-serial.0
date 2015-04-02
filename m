From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Thu, 02 Apr 2015 12:31:38 -0400
Message-ID: <551D6EEA.6050704@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>	<1425932842-21812-12-git-send-email-peter@hurleysoftware.com>	<CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>	<551CB5DF.1010108@hurleysoftware.com> <CAE9FiQVKY9KLeBOB0shqTPZZipsmAiU=3_8gzfFhsCW9kxo_uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQVKY9KLeBOB0shqTPZZipsmAiU=3_8gzfFhsCW9kxo_uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Yinghai,

On 04/02/2015 05:15 AM, Yinghai Lu wrote:
> On Wed, Apr 1, 2015 at 8:22 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> The documented behavior of console=ttyS options, to which your
>> quote refers, clearly states:
>>
>>                 Default is "9600n8".
> 
> drivers/tty/serial/8250/8250_early.c:early_serial8250_setup
> still have calling to probe_baud, but it is not triggered.
> 
> Here is root cause.
> The gap between entries in earlycon_table cause
> iteration fail to find next entry, so uart8250 handler is
> not called proplerly.

Thanks for finding that bug; so the earlycon never started, right?

> attached patch fix the problem.

Would you please try the patch below instead?

Regards,
Peter Hurley

--- >% ---
From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] earlycon: Fix __earlycon_table stride

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/serial_core.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b0ef49..2e11f31 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -151,7 +151,7 @@
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() . = ALIGN(8);				\
+#define EARLYCON_TABLE() STRUCT_ALIGN();			\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 *(__earlycon_table)			\
 			 *(__earlycon_table_end)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 34de168..025dad9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -342,7 +342,7 @@ struct earlycon_device {
 struct earlycon_id {
 	char	name[16];
 	int	(*setup)(struct earlycon_device *, const char *options);
-};
+} __aligned(32);
 
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr,
-- 
2.3.5
