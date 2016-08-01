From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: SBSA UART bug report and questions
Date: Mon, 1 Aug 2016 14:24:53 +0100
Message-ID: <93e0b28e-631d-b591-553d-097716919dc3@arm.com>
References: <20160801125047.ofanssbufyjzuhrh@kamzik.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160801125047.ofanssbufyjzuhrh@kamzik.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jones <drjones@redhat.com>
Cc: graeme.gregory@linaro.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>
List-Id: linux-serial@vger.kernel.org

Hi Drew,

(CC:ing Dave)

On 01/08/16 13:50, Andrew Jones wrote:
> 
> Hi Andre,
> 
> I have a couple questions and a bug report regarding the SBSA UART.
> 
> When AArch64 Linux is boot with QEMU and UEFI (AAVMF) we can enable
> the use of ACPI. When we do that the PL011 model QEMU provides is
> exposed via the _HID ARMH0011. The Linux driver (amba-pl011.c)
> only associates this _HID with the SBSA UART. Is that _HID supposed
> to be specifically the SBSA UART? The '11' in the ID makes me think
> a full PL011 would be more appropriate.

The SBSA UART is a subset of the PL011 UART, so any PL011 hardware can
be accessed by a SBSA UART driver, given that the UART has been properly
initialized before.
At least some months ago the ACPI spec wasn't powerful enough to
describe the required clock the PL011 needs, so the "clock-less" SBSA
was used to have a console on ACPI systems. I don't know if the ACPI ID
is meant to describe a fully-features PL011 in the future as well.

> My second question is about the SBSA UART specification. The spec
> doesn't provide any registers to reset the FIFOs. Section 6.4 says
> the FIFOs should be enabled by hardware-specific software. However,
> even if that's done, then, if Linux does a driver-level shutdown of
> the UART, and then starts it back up again, it seems a FIFO reset is
> in order. Is there any way to reset the SBSA UART FIFOs that I don't
> see?

The SBSA spec does (deliberately) not specify the registers needed to
initialize the UART, it is expected that this is done by firmware in an
implementation defined way (which could be using the respective PL011
way of setting things up).
So I am afraid there is no way of resetting the FIFOs.

> The bug report is just my second question formulated differently;
> 
> While Linux is booting the UART is started and stopped a few times.
> If the user sends characters to the UART during boot (just types on
> the terminal), then when the boot completes, and a login is presented,
> the user cannot input any characters and log in (Note, this is with
> QEMU's PL011 model. I don't know the status of boots with hardware,
> and it doesn't appear kvmtool emulates the PL011.) This is only seen
> when booting with ACPI (or a modified QEMU mach-virt DT that claims
> the UART is compatible with "arm,sbsa-uart"), as the problem is only
> with the SBSA UART implementation, which doesn't toggle the enable bit
> of the FIFO (UARTLCR_H.FEN) on startup/shutdown. When that bit is
> toggled by the PL011 driver the QEMU PL011 model resets its read FIFO
> and has no problem.

As mentioned above the UARTLCR register is not part of the SBSA spec -
on purpose. The FIFO is always meant to be turned on.

> Patching the model to reset the read FIFO when UARTIMSC=0 and UARTICR
> is being written as 0xffff, appears to resolve this issue, but it's a
> hack.

I don't fully get why an always-on FIFO would create a problem. I guess
this is due to the Linux PL011 driver way of getting things going, which
had issues with initial FIFO triggering the in past. I think Dave tried
hard to find a way to make it work with the SBSA - please don't tell us
now that this one has issues as well ;-)

Just checking: Is it possible that the QEMU model does not do the full
initialization that the SBSA UART requires? I guess it does (since you
said that it works initially, but breaks later on), but it could be
worth to check.

Cheers,
Andre.
