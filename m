From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 0/3] RISC-V SBI earlycon
Date: Fri, 07 Dec 2018 10:30:33 -0800 (PST)
Message-ID: <mhng-e67fd38e-d244-43da-817b-0b703347aa83@palmer-si-x1c4>
References: <20181204135507.3706-1-anup@brainfault.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>, robh@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, anup@brainfault.org
List-Id: linux-serial@vger.kernel.org

On Tue, 04 Dec 2018 05:55:04 PST (-0800), anup@brainfault.org wrote:
> This patchset adds RISC-V SBI earlycon and removes RISC-V EARLY_PRINTK.
>
> We should use earlycon over existing EARLY_PRINTK for SBI console because:
> 1. It's a more generic way of implementing early console for debugging
> 2. Current RISC-V EARLY_PRINTK is a compile-time option whereas earlycon
>    is enabled at run-time via kernel parameters.
> 3. To use earlycon with SBI, we have to pass "earlycon=sbi" in kernel
>    parameters. If earlycon kernel parameter is not provided then kernel
>    boots much faster which is very useful in real-world RISC-V deployments.
>
> The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc5
> and can be found at riscv_earlycon_v1 branch of:
> https://github.com/avpatel/linux.git
>
> Anup Patel (3):
>   tty/serial: Add RISC-V SBI earlycon support
>   RISC-V: defconfig: Enable RISC-V SBI earlycon support
>   RISC-V: Remove EARLY_PRINTK support
>
>  arch/riscv/Kconfig.debug                |  2 --
>  arch/riscv/configs/defconfig            |  1 +
>  arch/riscv/kernel/setup.c               | 28 -------------------------
>  drivers/tty/serial/Kconfig              | 12 +++++++++++
>  drivers/tty/serial/Makefile             |  1 +
>  drivers/tty/serial/earlycon-riscv-sbi.c | 28 +++++++++++++++++++++++++
>  6 files changed, 42 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c

I'm adding these to my for-next.

Thanks!
