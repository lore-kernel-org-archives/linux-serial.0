From: James Lamanna <jlamanna@gmail.com>
Subject: Re: SIIG DP CyberSerial 4S PCIe Support
Date: Mon, 8 Mar 2010 13:13:10 -0800
Message-ID: <aa4c40ff1003081313s7492513bk14a48c6097b90407@mail.gmail.com>
References: <aa4c40ff1003081107n78e9f052n2a754680e5491c68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44861 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab0CHVNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Mar 2010 16:13:11 -0500
In-Reply-To: <aa4c40ff1003081107n78e9f052n2a754680e5491c68@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Mar 8, 2010 at 11:07 AM, James Lamanna <jlamanna@gmail.com> wro=
te:
> Hi,
> I recently purchased a SIIG DP CyberSerial 4S PCIe card, however the
> kernel doesn't seem to recognize it.
> There are no messages in dmesg or anything about it.
> Currently I'm at 2.6.24, but looking at drivers/serial/8250_pci.c
> between 2.6.24 and 2.6.32 there doesn't
> seem to be real changes with SIIG cards.
> Seems like other SIIG cards are supported, so are we just missing the
> PCI IDs for this card?
>
> Here's the lspci -nnvvvvvv output:
>
> 01:00.0 Serial controller [0700]: Oxford Semiconductor Ltd Unknown
> device [1415:c208] (prog-if 06 [16950])
> =A0 =A0 =A0 =A0Subsystem: Siig Inc Unknown device [131f:2250]
> =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGAS=
noop-
> ParErr- Stepping- SERR- FastB2B-
> =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfas=
t >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 16
> =A0 =A0 =A0 =A0Region 0: Memory at fe8fc000 (32-bit, non-prefetchable=
) [size=3D16K]
> =A0 =A0 =A0 =A0Region 1: Memory at fe600000 (32-bit, non-prefetchable=
) [size=3D2M]
> =A0 =A0 =A0 =A0Region 2: Memory at fe400000 (32-bit, non-prefetchable=
) [size=3D2M]
> =A0 =A0 =A0 =A0Capabilities: [40] Power Management version 3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=
=3D55mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=
=3D0 PME-
> =A0 =A0 =A0 =A0Capabilities: [70] Express Endpoint IRQ 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: Supported: MaxPayload 128 byte=
s, PhantFunc 0, ExtTag-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: Latency L0s <128ns, L1 <2us
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: AtnBtn- AtnInd- PwrInd-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: Errors: Correctable- Non-Fatal=
+ Fatal+ Unsupported-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: RlxdOrd+ ExtTag- PhantFunc- Au=
xPwr- NoSnoop-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: MaxPayload 128 bytes, MaxReadR=
eq 512 bytes
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: Supported Speed 2.5Gb/s, Width x=
1, ASPM L0s L1, Port 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: Latency L0s <512ns, L1 <64us
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: ASPM Disabled RCB 64 bytes CommC=
lk- ExtSynch-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: Speed 2.5Gb/s, Width x1
> =A0 =A0 =A0 =A0Capabilities: [b0] MSI-X: Enable- Mask- TabSize=3D16
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Vector table: BAR=3D1 offset=3D001b300=
0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PBA: BAR=3D1 offset=3D001b2000

After some more digging I found these messages in dmesg which doesn't
exactly sound good:

[   52.104180] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   52.104189] ACPI: PCI interrupt for device 0000:01:00.0 disabled

01:00.0 is the device ID of the SIIG card.
Any reason ACPI would disable interrupts for this card?

Thanks.

-- James

>
> Please CC me for I am not subscribed.
>
> Thanks.
>
> -- James
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
