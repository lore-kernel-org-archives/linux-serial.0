From: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Mon, 27 May 2019 18:12:43 +0200
Message-ID: <86sgszq3k4.fsf@baylibre.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
        <7hmukmew5j.fsf@baylibre.com>
        <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> (Atish Patra's
        message of "Thu, 18 Apr 2019 18:04:34 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu 18 Apr 2019 at 18:04, Atish Patra <atish.patra@wdc.com> wrote:

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
> You can ignore 3 for your use case. However, if you pass a dtb built from source
> code, that will have hart0 enabled and M-mode interrupts enabled in DT.

Atish,
I'm trying to get the kernel boot with the current linux kernel DT from
Paul's patch series [0].

Could you point me to some documentation on 2. ?
Or do you know of a way to disable M-mode interrupts from U-boot ?

[0]: https://lore.kernel.org/patchwork/project/lkml/list/?series=390077

Thanks,
Loys

>
> Not sure if we should do these DT modifications in U-Boot as well.
>
