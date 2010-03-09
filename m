From: James Lamanna <jlamanna@gmail.com>
Subject: Re: SIIG DP CyberSerial 4S PCIe Support
Date: Mon, 8 Mar 2010 21:15:26 -0800
Message-ID: <aa4c40ff1003082115x3e9e1492je90e5afb826b3408@mail.gmail.com>
References: <aa4c40ff1003081107n78e9f052n2a754680e5491c68@mail.gmail.com>
	 <aa4c40ff1003081313s7492513bk14a48c6097b90407@mail.gmail.com>
	 <4B95B028.3050106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36508 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab0CIFP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Mar 2010 00:15:27 -0500
In-Reply-To: <4B95B028.3050106@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Mar 8, 2010 at 6:19 PM, Robert Hancock <hancockrwd@gmail.com> w=
rote:
> On 03/08/2010 03:13 PM, James Lamanna wrote:
>>
>> On Mon, Mar 8, 2010 at 11:07 AM, James Lamanna<jlamanna@gmail.com> =A0=
wrote:
>>>
>>> Hi,
>>> I recently purchased a SIIG DP CyberSerial 4S PCIe card, however th=
e
>>> kernel doesn't seem to recognize it.
>>> There are no messages in dmesg or anything about it.
>>> Currently I'm at 2.6.24, but looking at drivers/serial/8250_pci.c
>>> between 2.6.24 and 2.6.32 there doesn't
>>> seem to be real changes with SIIG cards.
>>> Seems like other SIIG cards are supported, so are we just missing t=
he
>>> PCI IDs for this card?
>>>
>>> Here's the lspci -nnvvvvvv output:
>>>
>>> 01:00.0 Serial controller [0700]: Oxford Semiconductor Ltd Unknown
>>> device [1415:c208] (prog-if 06 [16950])
>>> =A0 =A0 =A0 =A0Subsystem: Siig Inc Unknown device [131f:2250]
>>> =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VG=
ASnoop-
>>> ParErr- Stepping- SERR- FastB2B-
>>> =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Df=
ast>TAbort-
>>> <TAbort-<MAbort->SERR-<PERR-
>>> =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 16
>>> =A0 =A0 =A0 =A0Region 0: Memory at fe8fc000 (32-bit, non-prefetchab=
le) [size=3D16K]
>>> =A0 =A0 =A0 =A0Region 1: Memory at fe600000 (32-bit, non-prefetchab=
le) [size=3D2M]
>>> =A0 =A0 =A0 =A0Region 2: Memory at fe400000 (32-bit, non-prefetchab=
le) [size=3D2M]
>>> =A0 =A0 =A0 =A0Capabilities: [40] Power Management version 3
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1+ D2+ AuxCurre=
nt=3D55mA
>>> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DSca=
le=3D0 PME-
>>> =A0 =A0 =A0 =A0Capabilities: [70] Express Endpoint IRQ 0
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: Supported: MaxPayload 128 by=
tes, PhantFunc 0,
>>> ExtTag-
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: Latency L0s<128ns, L1<2us
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: AtnBtn- AtnInd- PwrInd-
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: Errors: Correctable- Non-Fat=
al+ Fatal+
>>> Unsupported-
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: RlxdOrd+ ExtTag- PhantFunc- =
AuxPwr- NoSnoop-
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device: MaxPayload 128 bytes, MaxRea=
dReq 512 bytes
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: Supported Speed 2.5Gb/s, Width=
 x1, ASPM L0s L1, Port
>>> 0
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: Latency L0s<512ns, L1<64us
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: ASPM Disabled RCB 64 bytes Com=
mClk- ExtSynch-
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Link: Speed 2.5Gb/s, Width x1
>>> =A0 =A0 =A0 =A0Capabilities: [b0] MSI-X: Enable- Mask- TabSize=3D16
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Vector table: BAR=3D1 offset=3D001b3=
000
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PBA: BAR=3D1 offset=3D001b2000
>>
>> After some more digging I found these messages in dmesg which doesn'=
t
>> exactly sound good:
>>
>> [ =A0 52.104180] ACPI: PCI Interrupt 0000:01:00.0[A] -> =A0GSI 16 (l=
evel,
>> low) -> =A0IRQ 16
>> [ =A0 52.104189] ACPI: PCI interrupt for device 0000:01:00.0 disable=
d
>>
>> 01:00.0 is the device ID of the SIIG card.
>> Any reason ACPI would disable interrupts for this card?
>
> Probably just means some driver temporarily decided to enable the int=
errupt,
> then disabled it (maybe because it decided it couldn't run the device=
?)

That's probably the case.
It looks like 8250 doesn't know about this PCIe device at all.
The Oxford PCI ID is not in pci_ids.h nor is the SIIG subsystem ID.
I'll see if I can maybe work up a patch to support this device, since I=
've found
the datasheet for the Oxford 4 port UART controller, but I may need som=
e help.
Or if anyone else (who has more experience with this) wants to formulat=
e one,
it would be greatly appreciated.

-- James
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
