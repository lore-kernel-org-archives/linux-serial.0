From: Andrew Jones <drjones@redhat.com>
Subject: SBSA UART bug report and questions
Date: Mon, 1 Aug 2016 14:50:47 +0200
Message-ID: <20160801125047.ofanssbufyjzuhrh@kamzik.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: andre.przywara@arm.com
Cc: graeme.gregory@linaro.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Hi Andre,

I have a couple questions and a bug report regarding the SBSA UART.

When AArch64 Linux is boot with QEMU and UEFI (AAVMF) we can enable
the use of ACPI. When we do that the PL011 model QEMU provides is
exposed via the _HID ARMH0011. The Linux driver (amba-pl011.c)
only associates this _HID with the SBSA UART. Is that _HID supposed
to be specifically the SBSA UART? The '11' in the ID makes me think
a full PL011 would be more appropriate.

My second question is about the SBSA UART specification. The spec
doesn't provide any registers to reset the FIFOs. Section 6.4 says
the FIFOs should be enabled by hardware-specific software. However,
even if that's done, then, if Linux does a driver-level shutdown of
the UART, and then starts it back up again, it seems a FIFO reset is
in order. Is there any way to reset the SBSA UART FIFOs that I don't
see?

The bug report is just my second question formulated differently;

While Linux is booting the UART is started and stopped a few times.
If the user sends characters to the UART during boot (just types on
the terminal), then when the boot completes, and a login is presented,
the user cannot input any characters and log in (Note, this is with
QEMU's PL011 model. I don't know the status of boots with hardware,
and it doesn't appear kvmtool emulates the PL011.) This is only seen
when booting with ACPI (or a modified QEMU mach-virt DT that claims
the UART is compatible with "arm,sbsa-uart"), as the problem is only
with the SBSA UART implementation, which doesn't toggle the enable bit
of the FIFO (UARTLCR_H.FEN) on startup/shutdown. When that bit is
toggled by the PL011 driver the QEMU PL011 model resets its read FIFO
and has no problem.

Patching the model to reset the read FIFO when UARTIMSC=0 and UARTICR
is being written as 0xffff, appears to resolve this issue, but it's a
hack.

Please let me know your thoughts on this.

Thanks,
drew
