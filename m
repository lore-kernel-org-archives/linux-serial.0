From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 2/3] RISC-V: defconfig: Enable RISC-V SBI earlycon support
Date: Fri, 07 Dec 2018 10:30:30 -0800 (PST)
Message-ID: <mhng-7d4e0657-9343-4a8d-b24a-3ea0acba45db@palmer-si-x1c4>
References: <20181204135507.3706-3-anup@brainfault.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135507.3706-3-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>, robh@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, anup@brainfault.org
List-Id: linux-serial@vger.kernel.org

On Tue, 04 Dec 2018 05:55:06 PST (-0800), anup@brainfault.org wrote:
> This patch enables RISC-V SBI earlycon support in default defconfig
> so that we can use "earlycon=sbi" in kernel parameters for early
> debug prints.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ef4f15df9adf..f399659d3b8d 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -46,6 +46,7 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_HVC_RISCV_SBI=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_DRM=y

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
