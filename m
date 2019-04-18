From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 0/2]  tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Thu, 18 Apr 2019 16:22:32 -0700
Message-ID: <7hmukmew5j.fsf@baylibre.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413020111.23400-1-paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-serial@vger.kernel.org

Hi Paul,

Paul Walmsley <paul.walmsley@sifive.com> writes:

> This series adds a serial driver, with console support, for the
> UART IP block present on the SiFive FU540 SoC.  The programming
> model is straightforward, but unique.
>
> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
> open-source FSBL (with appropriate patches to the DT data).
>
> This fifth version fixes a bug in the set_termios handler,
> found by Andreas Schwab <schwab@suse.de>.
>
> The patches in this series can also be found, with the PRCI patches,
> DT patches, and DT prerequisite patch, at:
>
> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4

I tried this branch, and it doesn't boot on my unleashed board.

Here's the boot log when I pass the DT built from your branch via
u-boot: https://termbin.com/rfp3.

I also tried the same thing, but using the DT that's hard-coded into
SBI/u-boot.  That doesn't boot fully either[1], but one thing I noted is
that with the DT from the kernel tree, the printk timestamps aren't
moving.  Maybe I'm still missing some kconfig options to enable the
right clock and/or IRQ controllers? I'm using this fragment[2] on top of
the default defconfig (arch/riscv/configs/defconfig).

Could you share the defconfig you're using when testing your branch?

Also for reference, I'm able to successfully build/boot the
5.1-rc1-unleashed branch from Atish's tree[3] using that kconfig
fragment[2] (and the hard-coded DT from u-boot/SBI).  Full log here[4].

Thanks,

Kevin

[1] https://termbin.com/wuc9
[2]
CONFIG_CLK_SIFIVE=y
CONFIG_CLK_SIFIVE_FU540_PRCI=y

CONFIG_SERIAL_SIFIVE=y
CONFIG_SERIAL_SIFIVE_CONSOLE=y

CONFIG_SIFIVE_PLIC=y
CONFIG_SPI=y
CONFIG_SPI_SIFIVE=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_SIFIVE=y
CONFIG_PWM_SIFIVE=y

CONFIG_CLK_U54_PRCI=y
CONFIG_CLK_GEMGXL_MGMT=y

[3] https://github.com/atishp04/linux/tree/5.1-rc1-unleashed
[4] https://termbin.com/12bg
