From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] tty: xilinx_uartps: move to arch_initcall for earlier console
Date: Thu, 31 Aug 2017 14:59:08 +0200
Message-ID: <CACRpkdZ2kNxM_MLFTXUy6bVxh5q2a_cFd+kwVWMHmOSDzG-cOQ@mail.gmail.com>
References: <1503487221-17950-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <20170823232424.GA9546@kroah.com> <62daa70c-0c6f-7628-efa4-308cfe93709c@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62daa70c-0c6f-7628-efa4-308cfe93709c@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, shubhrajyoti.datta@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 24, 2017 at 11:32 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 24.8.2017 01:24, Greg KH wrote:
>> On Wed, Aug 23, 2017 at 04:50:21PM +0530, Shubhrajyoti Datta wrote:
>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> I can't take patches without any changelog text at all :(
>
> ok. I see you have also commented this.
>
> Anyway this is kind of old discussion about moving serial drivers to
> arch_initcall from module_init.
>
> There is one patch in the tree.
>
> commit 4dd9e742df98f8f600b4302d3adbb087a68237f7
> Author:     Alessandro Rubini <rubini@gnudd.com>
> AuthorDate: Tue May 5 05:54:13 2009 +0100
> Commit:     Russell King <rmk+kernel@arm.linux.org.uk>
> CommitDate: Sun May 31 14:58:11 2009 +0100
>
>     [ARM] 5505/1: serial amba-pl011: move to arch_initcall for earlier
> console
>
>     Signed-off-by: Alessandro Rubini <rubini@unipv.it>"
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
>
> and then there was one patch (also sent to linux-serial but don't have link)
> https://patches.linaro.org/patch/14633/
>
> where that discussion wasn't finished.

Yeah Alessandro never came back on that.

I *guess* it is to get the console up really early, simply becaus it is
quite helpful for spotting early boot problems.

It is not for earlydebug, because for that we use another routine
that hammers out the characters on the console. That is what we use
before even going to console, with printascii(), I usually use a patch
like this:

--- a/init/main.c
+++ b/init/main.c
@@ -515,6 +515,12 @@ asmlinkage __visible void __init start_kernel(void)
        smp_setup_processor_id();
        debug_objects_early_init();

+#ifdef CONFIG_ARM
+       {
+         extern void printascii(char *);
+         printascii("start_kernel\n");
+       }
+#endif
        /*
         * Set up the initial canary ASAP:
         */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fc47863f629c..85edd1401406 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1726,6 +1726,13 @@ asmlinkage int vprintk_emit(int facility, int level,
                lflags |= LOG_NEWLINE;
        }

+#ifdef CONFIG_ARM
+       {
+               extern void printascii(char *);
+               printascii(textbuf);
+       }
+#endif
+
        /* strip kernel syslog prefix and extract log level or control flags */
        if (facility == 0) {
                int kern_level;


Yours,
Linus Walleij
