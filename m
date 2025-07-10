Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756025B2FD;
	Thu, 10 Jul 2025 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154563; cv=none; b=DYis5aJwCvMRbJu/ZzeeB1vv6XOjQRBq8X8VhKkwHsCc5HNZ70KUFQiHDKEE86ANZXT51ovwQq6aI+r3OMzBF5wmJM8lY1rlXiiLAI31KiTNKdftAkOOQt1b14A/hqE7e8w8+y0lf9a8KmEx7LOrxDCiEM18cO+wivsk82qHEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154563; c=relaxed/simple;
	bh=n8LT2zdLHtYhseIIoECgxMHsDjpoPMt0hJx24y56p3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1cJ0lzPbS3oUayZIy0bh0qfS6CbJg+QOSCWIHTw4vs+GkMhwYLjGfoeLcedHx+qnA4PI6kizEy1i7winrTp1ZZ5j348SJwgJEXpkvNOQXEevqZXLJkd77vc6bahz4aHf3GrUGr1NYn4AZFqqatWHqaXNFZEjiCsPDDdOs7G2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13EDB1EA6;
	Thu, 10 Jul 2025 06:35:49 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AE63F6A8;
	Thu, 10 Jul 2025 06:35:59 -0700 (PDT)
Date: Thu, 10 Jul 2025 14:35:57 +0100
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com,
	bwicaksono@nvidia.com, rmk+kernel@armlinux.org.uk,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <20250710133557.GA1093654@e132581.arm.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
 <aG0kYjl/sphGqd4r@gmail.com>
 <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>

Hi Breno,

On Wed, Jul 09, 2025 at 07:23:44AM -0700, Breno Leitao wrote:
> On Tue, Jul 08, 2025 at 07:00:45AM -0700, Breno Leitao wrote:
> > On Thu, Jul 03, 2025 at 05:31:09PM +0100, Mark Rutland wrote:
> > 
> > Here is more information I got about this problem. TL;DR: While the
> > machine is booting, it is throttled by the UART speed, while having IRQ
> > disabled.
> 
> quick update: I've identified a solution that significantly improves the
> situation. I've found that the serial issue was heavily affecting boot
> time, which is unleashed now.
> 
> After applying the following fix, the boot speed has improved
> dramatically. It's the fastest I've seen, and the CSD lockups are gone.

Thanks for trying to fix the issue.

> If no concerns raise in the next days, I will send it officially to the
> serial maintainers.

I am not an expert on the PL011 driver, however, I do have concerns
after review the change. Please see my comments below.

> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed Jul 9 05:57:06 2025 -0700
> 
>     serial: amba-pl011: Fix boot performance by switching to console_initcall()
> 
>     Replace arch_initcall() with console_initcall() for PL011 driver initialization
>     to resolve severe boot performance issues.

pl011_init() registers as an AMBA device, so the PL011 driver depends
on the AMBA bus initialization. The AMBA bus is initialized with:

    postcore_initcall(amba_init);

Therefore, the PL011 driver is initialized with arch_initcall(), which
occurs later than the postcore init.

My understanding is that console_initcall() is invoked much earlier
than other initcalls triggered by do_initcalls(). With your change, I
saw the PL011 driver fails to register on Juno-r2 board, due to AMBA bus
driver is not ready for a console init.

  Driver 'uart-pl011' was unable to register with bus_type 'amba'
  because the bus was not initialized.

>     The current arch_initcall() registration causes the console to initialize
>     before the printk subsystem is ready, forcing the driver into atomic mode
>     during early boot. This results in:
> 
>     - 5-8 second boot delay while ~700 boot messages are processed
>     - System freeze with IRQs disabled during message output
>     - Each character transmitted synchronously with cpu_relax() polling
> 
>     This is what is driving the driver to atomic mode in the early boot:
> 
>       static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>       {
>             ....
>             if (printk_kthreads_running)
>                     ft->nbcon_offload = true;
> 
>     The atomic path processes each character individually through
>     pl011_console_putchar(), waiting for UART transmission completion
>     before proceeding. With only one CPU online during early boot,
>     this creates a bottleneck where the system spends excessive time
>     in interrupt-disabled state.

The atomic path is introduced recently by the commit:

  2eb2608618ce ("serial: amba-pl011: Implement nbcon console")

My conclusion is that changing the initcall will not disable the atomic
path, changing to console_initcall() will cause AMBA device init
failure, and as a result, the clock operations will not be invoked.
Thus, I am curious if you have ruled out the issue is caused by the UART
clock (as I mentioned in another reply).

BTW, since the atomic path is enabled in the commit 2eb2608618ce, what
is the result after reverting the commit?

Thanks,
Leo

>     Here is how the code looks like:
> 
>       1) disable interrupt
>       2) for each of these 700 messages, call pl011_console_write_atomic()
>       3) for each character in the message, calls pl011_console_putchar(),
>          which waits for the character to be transmitted
>       4) once all the line is transmitted, wait for the UART to be idle
>       5) re-enable interrupt
> 
>     Here is the code representation of the above:
> 
>             pl011_console_write_atomic() {
>                     ...
>                     // For each char in the message
>                     pl011_console_putchar() {
>                             while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
>                                     cpu_relax();
>                     }
>                     while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
>                             cpu_relax();
> 
>     Using console_initcall() ensures proper initialization order,
>     allowing the printk subsystem to use threaded output instead
>     of atomic mode, eliminating the performance bottleneck.
> 
>     Performance improvement: 16x faster kernel boot time at my GRACE SoC
>     machine.
> 
>       - Before: 10.08s to reach init process
>       - After: 0.62s to reach init process
> 
>     Here are more timing details, collected from Linus' upstream, where the
>     only different is this patch:
> 
>     Linus upstream:
>       [    0.616203] printk: legacy console [netcon_ext0] enabled
>       [    0.627469] Run /init as init process
>       [    0.837477] loop: module loaded
>       [    8.354803] Adding 134199360k swap on /swapvol/swapfile.
> 
>     With this patch:
>       [    0.305109] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
>       [   10.081742] Run /init as init process
>       [   13.288717] loop: module loaded
>       [   22.919934] Adding 134199168k swap on /swapvol/swapfile.
> 
>     Link: https://lore.kernel.org/all/aGVn%2FSnOvwWewkOW@gmail.com/ [1]
> 
>     Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 22939841b1de..0cf251365825 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -3116,7 +3116,7 @@ static void __exit pl011_exit(void)
>   * While this can be a module, if builtin it's most likely the console
>   * So let's leave module_exit but move module_init to an earlier place
>   */
> -arch_initcall(pl011_init);
> +console_initcall(pl011_init);
>  module_exit(pl011_exit);
> 
>  MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
> 
> 
> 
> 
> 
