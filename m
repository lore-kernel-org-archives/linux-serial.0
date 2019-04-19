From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Fri, 19 Apr 2019 12:18:21 -0700
Message-ID: <7h5zr9dcsi.fsf@baylibre.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Atish Patra <atish.patra@wdc.com> writes:

> On 4/18/19 4:22 PM, Kevin Hilman wrote:
>> Hi Paul,
>> 
>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>> 
>>> This series adds a serial driver, with console support, for the
>>> UART IP block present on the SiFive FU540 SoC.  The programming
>>> model is straightforward, but unique.
>>>
>>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>>> open-source FSBL (with appropriate patches to the DT data).
>>>
>>> This fifth version fixes a bug in the set_termios handler,
>>> found by Andreas Schwab <schwab@suse.de>.
>>>
>>> The patches in this series can also be found, with the PRCI patches,
>>> DT patches, and DT prerequisite patch, at:
>>>
>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
>> 
>> I tried this branch, and it doesn't boot on my unleashed board.
>> 
>> Here's the boot log when I pass the DT built from your branch via
>> u-boot: https://termbin.com/rfp3.
>> 
>
> Unfortunately, that won't work. The current DT modifications by OpenSBI.
>
> 1. Change hart status to "masked" from "okay".
> 2. M-mode interrupt masking in PLIC node.
> 3. Add a chosen node for serial access in U-Boot.
>
> You can ignore 3 for your use case. However, if you pass a dtb built 
> from source code, that will have hart0 enabled and M-mode interrupts 
> enabled in DT.

Hmm, so what you're saying is there not currently any way to pass a DT
built from source using OpenSBI + mainline u-boot?

As a short-term workaround, is there a way to make these changes from
the u-boot command-line after loading a DTB built from source into
memory?  If so, I could at least script that part.


> Not sure if we should do these DT modifications in U-Boot as well.

I guess so (and I'd be happy to test the patch.)

Either that, or the upstream DTs (or code) should have those features to
the right settings.

Speaking of which, I tried to patch the DT from Paul's recent series[1]
to make the necessary changes.  I can see where to change cpu0 from
"okay" to "masked", but I'm not so sure how to make the PLIC change.

I was hoping to be able to review/test Paul's DT patches, but now I'm a
bit confused as to how to do that.

> I also noticed that your kernel is booting only 1 hart.
> Just FYI: RISC-V SMP for U-Boot patches are merged in master. So you 
> should be able to boot all cpus. You can ingore FU540_ENABLED_HART_MASK 
> in OpenSBI build as well.

Ah, nice.

I've just updated to u-boot master branch with SMP enabled, and build a
new openSBI (also from master branch) with u-boot payload. Using your
v5.1-rc4_unleashed branch, I see 4 CPUs booting:
https://termbin.com/kg13

Thanks,

Kevin

[1] https://lore.kernel.org/lkml/20190413020111.23400-1-paul.walmsley@sifive.com/T/#m77daa2857b76ec7cbca0672ad03ae286f61ca0e6
