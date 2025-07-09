Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12917A586;
	Wed,  9 Jul 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071030; cv=none; b=KNq7nALbnT2HJ+Xn773oaRQgteKuOpCnAK5HzEA1Kw7KwGNOhDyS8sHbdR/AES4zL35FiW8mkrg2JG6rkK363ueyRfWN9CTqaTDkYo97TiEsk0ezU4p/Wo8ink3lFtBqdHekwOMwQvr4vLFH7IwTczBA/BHyxR0BECuRB/7T9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071030; c=relaxed/simple;
	bh=dP58uza0xYC6V284K6gSKLcGWxb6EsclH4uE5unKkUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0ri/NuzKUjNqU1Ln7bnJMxqtCPESIIVt/UDCettRIo4UDSNQrduE6ZWr+uh0Z53/IScZIK1Uj9HLfQYA3xbAhFNTfCu9dkaWwCAKAmnA9nUAlB7ahSvylE7bsdJ4UOMAHgMjIbASoLtPAPR7veSBhoDvm0nNruxnbNXPyyTI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so980918466b.1;
        Wed, 09 Jul 2025 07:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071027; x=1752675827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz3YgJnlUNW47E+9cHkUH8RMoEMBsNQYKP2VJAdtDRM=;
        b=V0mDc4Pgbwve+aNhuz1ZcEarFCRkNtPbCzLWtQiD48h1O9UFifNVC/k4cR09100RvT
         LIX4ya3+sflXdKrSCBDmKaHG7MilywXGWN6cre+hWf3R65OlLtvjkv/MLD8TgsiJ90v8
         AQApivudiEnpTbmJJgDeFY/KkQfF/rsUZlQFN1BUef+tB/Ecur9hnRcilATUz5tg3Kyg
         fFWyYA0xBIHX4qG39J6bWUO4f1obrdA4zSdhRyb6v0lY9p5WoZbIWvArKmRjGpGHgGa0
         mCmV5kDOt1c9csm6pHseMIZFpNsgrdkKYuTcYCzMBMtIb/IosB9vsTbbTXDYjZwpFm8v
         +PVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRXGV7Lnko5nY5nAKW1LvxNAoWE2QrJS0vbBwOm4xvsdLubQ7YieUPvwZMIVV7kNoZzlNbNgXAzgGaMU4=@vger.kernel.org, AJvYcCXXmlBrgSTqXHGnWxl/CbJaDf9zI05Acn93OmbwNWDBeFzwDNtSbwGI7BFYzKQT0vxb/dfGYD08NmiIDtUG@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAtSa0hkCSZy4zx9h0SSDGiCCOd6JvaSO9E1AwSFmKMnbyJwb
	8BfBZWjRCcgFAQKeENGB+Hg7MaCWFRiZsRTs56T6WAYuKrYzuxFgEcTO
X-Gm-Gg: ASbGnctXsv83YfaVyyRUGtIDqbizY9dLzxGg/FVebEB+BfYrGO9yr9Eq42fR/fD3ZEq
	IrPA+TnIrNb2z1WHCFa+Z4AaDy4S7ilUrRnIu1r7nX9vsmd6mv+qyGC32NxaBI4MK+u69/9rNlP
	QIVGMlgp/RmMZDu2PdvRCtTDYaATbs0hDvuFAnLWrLTn70i9PFvJPI4dGna627CMEsVxS1wQXUu
	d9E5vbzGfzUQbwp0R1SO0jmAthMQupuY/6yo5GsLx8cK6OCWheP4PMUGmbH41oO+4acKVofsOrg
	+YFI3rPlEAl+O2NAebcckfv1YDM/5V42uDlDKy87U3R0RWFJIrh9Ng==
X-Google-Smtp-Source: AGHT+IG9fbAxEwBEkk9DE/KSa7JmRtTm35JlrUR/YJvs45MqHuy9kT5yu1OfyqhuvJJX+KtoT208mA==
X-Received: by 2002:a17:907:268e:b0:ae3:53b3:b67d with SMTP id a640c23a62f3a-ae6cf5592c8mr297705066b.1.1752071027086;
        Wed, 09 Jul 2025 07:23:47 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f62e0e21sm1096020466b.0.2025.07.09.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:23:46 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:23:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com, 
	bwicaksono@nvidia.com
Cc: rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com, 
	linux-serial@vger.kernel.org, rmikey@meta.com, linux-arm-kernel@lists.infradead.org, 
	usamaarif642@gmail.com, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
 <aG0kYjl/sphGqd4r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG0kYjl/sphGqd4r@gmail.com>

On Tue, Jul 08, 2025 at 07:00:45AM -0700, Breno Leitao wrote:
> On Thu, Jul 03, 2025 at 05:31:09PM +0100, Mark Rutland wrote:
> 
> Here is more information I got about this problem. TL;DR: While the
> machine is booting, it is throttled by the UART speed, while having IRQ
> disabled.

quick update: I've identified a solution that significantly improves the
situation. I've found that the serial issue was heavily affecting boot
time, which is unleashed now.

After applying the following fix, the boot speed has improved
dramatically. It's the fastest I've seen, and the CSD lockups are gone.

If no concerns raise in the next days, I will send it officially to the
serial maintainers.

Author: Breno Leitao <leitao@debian.org>
Date:   Wed Jul 9 05:57:06 2025 -0700

    serial: amba-pl011: Fix boot performance by switching to console_initcall()

    Replace arch_initcall() with console_initcall() for PL011 driver initialization
    to resolve severe boot performance issues.

    The current arch_initcall() registration causes the console to initialize
    before the printk subsystem is ready, forcing the driver into atomic mode
    during early boot. This results in:

    - 5-8 second boot delay while ~700 boot messages are processed
    - System freeze with IRQs disabled during message output
    - Each character transmitted synchronously with cpu_relax() polling

    This is what is driving the driver to atomic mode in the early boot:

      static inline void printk_get_console_flush_type(struct console_flush_type *ft)
      {
            ....
            if (printk_kthreads_running)
                    ft->nbcon_offload = true;

    The atomic path processes each character individually through
    pl011_console_putchar(), waiting for UART transmission completion
    before proceeding. With only one CPU online during early boot,
    this creates a bottleneck where the system spends excessive time
    in interrupt-disabled state.

    Here is how the code looks like:

      1) disable interrupt
      2) for each of these 700 messages, call pl011_console_write_atomic()
      3) for each character in the message, calls pl011_console_putchar(),
         which waits for the character to be transmitted
      4) once all the line is transmitted, wait for the UART to be idle
      5) re-enable interrupt

    Here is the code representation of the above:

            pl011_console_write_atomic() {
                    ...
                    // For each char in the message
                    pl011_console_putchar() {
                            while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
                                    cpu_relax();
                    }
                    while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
                            cpu_relax();

    Using console_initcall() ensures proper initialization order,
    allowing the printk subsystem to use threaded output instead
    of atomic mode, eliminating the performance bottleneck.

    Performance improvement: 16x faster kernel boot time at my GRACE SoC
    machine.

      - Before: 10.08s to reach init process
      - After: 0.62s to reach init process

    Here are more timing details, collected from Linus' upstream, where the
    only different is this patch:

    Linus upstream:
      [    0.616203] printk: legacy console [netcon_ext0] enabled
      [    0.627469] Run /init as init process
      [    0.837477] loop: module loaded
      [    8.354803] Adding 134199360k swap on /swapvol/swapfile.

    With this patch:
      [    0.305109] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
      [   10.081742] Run /init as init process
      [   13.288717] loop: module loaded
      [   22.919934] Adding 134199168k swap on /swapvol/swapfile.

    Link: https://lore.kernel.org/all/aGVn%2FSnOvwWewkOW@gmail.com/ [1]

    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22939841b1de..0cf251365825 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -3116,7 +3116,7 @@ static void __exit pl011_exit(void)
  * While this can be a module, if builtin it's most likely the console
  * So let's leave module_exit but move module_init to an earlier place
  */
-arch_initcall(pl011_init);
+console_initcall(pl011_init);
 module_exit(pl011_exit);

 MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");





