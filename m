From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 0/3] RISC-V SBI earlycon
Date: Mon, 25 Mar 2019 17:23:15 +0100
Message-ID: <mvm4l7qvs7g.fsf@suse.de>
References: <20181204135507.3706-1-anup@brainfault.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org> (Anup Patel's message
        of "Tue, 4 Dec 2018 19:25:04 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup@brainfault.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Dez 04 2018, Anup Patel <anup@brainfault.org> wrote:

> This patchset adds RISC-V SBI earlycon and removes RISC-V EARLY_PRINTK.
>
> We should use earlycon over existing EARLY_PRINTK for SBI console because:
> 1. It's a more generic way of implementing early console for debugging
> 2. Current RISC-V EARLY_PRINTK is a compile-time option whereas earlycon
>    is enabled at run-time via kernel parameters.
> 3. To use earlycon with SBI, we have to pass "earlycon=sbi" in kernel
>    parameters. If earlycon kernel parameter is not provided then kernel
>    boots much faster which is very useful in real-world RISC-V deployments.

Why doesn't this earlycon disable itself when the real console kicks in?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
