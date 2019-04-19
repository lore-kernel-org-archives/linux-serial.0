From: Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for
 the SiFive FU540 UART
Date: Thu, 18 Apr 2019 18:04:34 -0700
Message-ID: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
 <7hmukmew5j.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <7hmukmew5j.fsf@baylibre.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 4/18/19 4:22 PM, Kevin Hilman wrote:
> Hi Paul,
> 
> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
>> This series adds a serial driver, with console support, for the
>> UART IP block present on the SiFive FU540 SoC.  The programming
>> model is straightforward, but unique.
>>
>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>> open-source FSBL (with appropriate patches to the DT data).
>>
>> This fifth version fixes a bug in the set_termios handler,
>> found by Andreas Schwab <schwab@suse.de>.
>>
>> The patches in this series can also be found, with the PRCI patches,
>> DT patches, and DT prerequisite patch, at:
>>
>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
> 
> I tried this branch, and it doesn't boot on my unleashed board.
> 
> Here's the boot log when I pass the DT built from your branch via
> u-boot: https://termbin.com/rfp3.
> 

Unfortunately, that won't work. The current DT modifications by OpenSBI.

1. Change hart status to "masked" from "okay".
2. M-mode interrupt masking in PLIC node.
3. Add a chosen node for serial access in U-Boot.

You can ignore 3 for your use case. However, if you pass a dtb built 
from source code, that will have hart0 enabled and M-mode interrupts 
enabled in DT.

Not sure if we should do these DT modifications in U-Boot as well.

I also noticed that your kernel is booting only 1 hart.
Just FYI: RISC-V SMP for U-Boot patches are merged in master. So you 
should be able to boot all cpus. You can ingore FU540_ENABLED_HART_MASK 
in OpenSBI build as well.

Regards,
Atish
> I also tried the same thing, but using the DT that's hard-coded into
> SBI/u-boot.  That doesn't boot fully either[1], but one thing I noted is
> that with the DT from the kernel tree, the printk timestamps aren't
> moving.  Maybe I'm still missing some kconfig options to enable the
> right clock and/or IRQ controllers? I'm using this fragment[2] on top of
> the default defconfig (arch/riscv/configs/defconfig).
> 
> Could you share the defconfig you're using when testing your branch?
> 
> Also for reference, I'm able to successfully build/boot the
> 5.1-rc1-unleashed branch from Atish's tree[3] using that kconfig
> fragment[2] (and the hard-coded DT from u-boot/SBI).  Full log here[4].
> 
> Thanks,
> 
> Kevin
> 
> [1] https://termbin.com/wuc9
> [2]
> CONFIG_CLK_SIFIVE=y
> CONFIG_CLK_SIFIVE_FU540_PRCI=y
> 
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> 
> CONFIG_SIFIVE_PLIC=y
> CONFIG_SPI=y
> CONFIG_SPI_SIFIVE=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIO_SIFIVE=y
> CONFIG_PWM_SIFIVE=y
> 
> CONFIG_CLK_U54_PRCI=y
> CONFIG_CLK_GEMGXL_MGMT=y
> 
> [3] https://github.com/atishp04/linux/tree/5.1-rc1-unleashed
> [4] https://termbin.com/12bg
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
