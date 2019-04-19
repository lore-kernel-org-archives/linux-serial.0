From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Fri, 19 Apr 2019 13:34:17 -0700
Message-ID: <7htvetbupi.fsf@baylibre.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Atish Patra <atish.patra@wdc.com> writes:

> On 4/19/19 12:18 PM, Kevin Hilman wrote:
>> Atish Patra <atish.patra@wdc.com> writes:
>> 
>>> On 4/18/19 4:22 PM, Kevin Hilman wrote:
>>>> Hi Paul,
>>>>
>>>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>>>>
>>>>> This series adds a serial driver, with console support, for the
>>>>> UART IP block present on the SiFive FU540 SoC.  The programming
>>>>> model is straightforward, but unique.
>>>>>
>>>>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>>>>> open-source FSBL (with appropriate patches to the DT data).
>>>>>
>>>>> This fifth version fixes a bug in the set_termios handler,
>>>>> found by Andreas Schwab <schwab@suse.de>.
>>>>>
>>>>> The patches in this series can also be found, with the PRCI patches,
>>>>> DT patches, and DT prerequisite patch, at:
>>>>>
>>>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
>>>>
>>>> I tried this branch, and it doesn't boot on my unleashed board.
>>>>
>>>> Here's the boot log when I pass the DT built from your branch via
>>>> u-boot: https://termbin.com/rfp3.
>>>>
>>>
>>> Unfortunately, that won't work. The current DT modifications by OpenSBI.
>>>
>>> 1. Change hart status to "masked" from "okay".
>>> 2. M-mode interrupt masking in PLIC node.
>>> 3. Add a chosen node for serial access in U-Boot.
>>>
>>> You can ignore 3 for your use case. However, if you pass a dtb built
>>> from source code, that will have hart0 enabled and M-mode interrupts
>>> enabled in DT.
>> 
>> Hmm, so what you're saying is there not currently any way to pass a DT
>> built from source using OpenSBI + mainline u-boot?
>> 
>
> OpenSBI can accept DT built from source with following build option.
>
> FW_PAYLOAD_FDT="<unleashed>.dtb"
>
> More documentation:
> https://github.com/riscv/opensbi/blob/master/docs/firmware/fw_payload.md

I'm aware of that method, but I'm looking for a way that doesn't require
me to rebuild/reflash SBI every time.

Basically, I want u-boot to TFTP the DTB (along with kernel and ramdisk)
and boot it from memory.

On all other DT platforms in kernelCI, we build DTB(s) along with the
kernel (but not built into the kernel.)  We then use the bootloader to
load the kernel, DTB and ramdisk that we built.

>> As a short-term workaround, is there a way to make these changes from
>> the u-boot command-line after loading a DTB built from source into
>> memory?  If so, I could at least script that part.
>> 
>> 
>>> Not sure if we should do these DT modifications in U-Boot as well.
>> 
>> I guess so (and I'd be happy to test the patch.)
>> 
>> Either that, or the upstream DTs (or code) should have those features to
>> the right settings.
>> 
>> Speaking of which, I tried to patch the DT from Paul's recent series[1]
>> to make the necessary changes.  I can see where to change cpu0 from
>> "okay" to "masked", but I'm not so sure how to make the PLIC change.
>> 
>
> Here is the code snippet of how OpenSBI modifies the DT.
>
> https://github.com/riscv/opensbi/blob/master/platform/sifive/fu540/platform.c#L53

Thanks, based on that, I was able to modify the DTB I'm builing from
source[1], but it still doesn't fully boot.

Looks like Paul has so far only tested this with BBL + FSBL, so I think
I'll wait to hear from him how that setup might be different from using
OpenSBI + u-boot.

Thanks for all the help,

Kevin

[1]
diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index dd3b9395cedf..299398c4201d 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -30,7 +30,7 @@
                        i-cache-size = <16384>;
                        reg = <0>;
                        riscv,isa = "rv64imac";
-                       status = "okay";
+                       status = "masked";
                        cpu0_intc: interrupt-controller {
                                #interrupt-cells = <1>;
                                compatible = "riscv,cpu-intc";
@@ -148,11 +148,11 @@
                        reg = <0x0 0xc000000 0x0 0x4000000>;
                        interrupt-controller;
                        interrupts-extended = <
-                               &cpu0_intc 11
-                               &cpu1_intc 11 &cpu1_intc 9
-                               &cpu2_intc 11 &cpu2_intc 9
-                               &cpu3_intc 11 &cpu3_intc 9
-                               &cpu4_intc 11 &cpu4_intc 9>;
+                               &cpu0_intc 0xffffffff
+                               &cpu1_intc 0xffffffff &cpu1_intc 9
+                               &cpu2_intc 0xffffffff &cpu2_intc 9
+                               &cpu3_intc 0xffffffff &cpu3_intc 9
+                               &cpu4_intc 0xffffffff &cpu4_intc 9>;
                };
                prci: clock-controller@10000000 {
                        compatible = "sifive,fu540-c000-prci";
