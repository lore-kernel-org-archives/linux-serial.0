From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 19:55:39 -0800
Message-ID: <CADaLNDmZQsmx6V8nveOUKJqEUAoeijxYhqWhKEhLGh_RiQo+ZA@mail.gmail.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com> <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
 <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com> <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 5, 2016 at 6:27 PM, Jon Masters <jcm@redhat.com> wrote:
> Hi Duc, all,
>
> So after regenerating the initrd override (I must have fat fingered)
> it is now detecting the correct bit width on boot (attached dmesg log).
>
> HOWEVER while the console does come up, the use of "earlycon" on the
> command line (with no parameters) doesn't result in the early SPCR
> console coming up correctly. I see some garbled characters that
> suggest the baud (or register access width) is off somewhere.

My bad that I did not catch this in the morning. Yes, earlycon does
not seems to work as expected. I can see that earlycon parameters
seems to be correct, but the bootconsole message does not come out
(the following is from 'dmesg')
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc7-next-20161202-00001-gbf2919a
(dhdang@dhdang-workstation-01) (gcc version 4.9.3 20150218
(prerelease) (APM-8.0.10-le) ) #10 SMP PREEMPT Mon Dec 5 19:21:14 PST
2016
[    0.000000] Boot CPU: AArch64 Processor [500f0001]
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.40 by X-Gene Mustang Board EFI Oct 17 2016 13:54=
:05
[    0.000000] efi:  ACPI=3D0x47fa700000  ACPI 2.0=3D0x47fa700014  SMBIOS
3.0=3D0x47fa9db000  ESRT=3D0x47ff006d18
[    0.000000] esrt: Reserving ESRT space from 0x00000047ff006d18 to
0x00000047ff006d78.
[    0.000000] cma: Reserved 16 MiB at 0x00000040ff000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000047FA700014 000024 (v02 APM   )
[    0.000000] ACPI: XSDT 0x00000047FA6F00E8 000084 (v01 APM    XGENE
  00000003      01000013)
[    0.000000] ACPI: FACP 0x00000047FA6C0000 00010C (v05 APM    XGENE
  00000003 INTL 20140724)
[    0.000000] ACPI: DSDT 0x00000047FA6D0000 005922 (v05 APM
APM88xxx 00000001 INTL 20140724)
[    0.000000] ACPI: DBG2 0x00000047FA6E0000 0000AA (v00 APMC0D
XGENEDBG 00000000 INTL 20140724)
[    0.000000] ACPI: GTDT 0x00000047FA6A0000 000060 (v02 APM    XGENE
  00000001 INTL 20140724)
[    0.000000] ACPI: MCFG 0x00000047FA690000 00003C (v01 APM    XGENE
  00000002 INTL 20140724)
[    0.000000] ACPI: SPCR 0x00000047FA680000 000050 (v02 APMC0D
XGENESPC 00000000 INTL 20140724)
[    0.000000] ACPI: SSDT 0x00000047FA670000 00002D (v02 APM    XGENE
  00000001 INTL 20140724)
[    0.000000] ACPI: BERT 0x00000047FA660000 000030 (v01 APM    XGENE
  00000002 INTL 20140724)
[    0.000000] ACPI: HEST 0x00000047FA650000 0002A8 (v01 APM    XGENE
  00000002 INTL 20140724)
[    0.000000] ACPI: APIC 0x00000047FA640000 0002A4 (v03 APM    XGENE
  00000003      01000013)
[    0.000000] ACPI: SSDT 0x00000047FA630000 000063 (v02 REDHAT
MACADDRS 00000001      01000013)
[    0.000000] ACPI: SSDT 0x00000047FA620000 000032 (v02 REDHAT
UARTCLKS 00000001      01000013)
[    0.000000] ACPI: PCCT 0x00000047FA610000 000300 (v01 APM    XGENE
  00000003      01000013)
[    0.000000] ACPI: SPCR: console: uart,mmio32,0x1c020000,115200
[    0.000000] earlycon: uart0 at MMIO32 0x000000001c020000 (options '11520=
0')
[    0.000000] bootconsole [uart0] enabled

>
> Here are the first few lines from my screen boot log:
>
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> ^E^B^B^B<8A>r<A2><92><A2><92>=CA=BA<EA><81>console [ttyS0] enabled

I do not see garbage characters on Mustang. The garbage characters you
saw may relate to the same issue that I asked a few weeks ago:
https://www.spinics.net/lists/arm-kernel/msg537958.html
There seems to be a race condition in accessing the UART hardware
during switching between the bootconsole and the real console.

> [    1.424297] console [ttyS0] enabled
> [    1.507860] bootconsole [uart0] disabled
>
> Can you double check you've actually seen the SPCR used for earlycon,
> as the machine was booting, and actually generating correct output?
>
> Here's the SPCR override I am using on that machine:
>
> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20160527-64
>  * Copyright (c) 2000 - 2016 Intel Corporation
>  *
>  * Disassembly of SPCR.aml, Sat Dec  3 03:49:54 2016
>  *
>  * ACPI Data Table [SPCR]
>  *
>  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>  */
>
> [000h 0000   4]                    Signature : "SPCR"    [Serial Port Con=
sole Redirection table]
> [004h 0004   4]                 Table Length : 00000050
> [008h 0008   1]                     Revision : 02
> [009h 0009   1]                     Checksum : 41
> [00Ah 0010   6]                       Oem ID : "HPE   "
> [010h 0016   8]                 Oem Table ID : "ProLiant"
> [018h 0024   4]                 Oem Revision : 00001337
> [01Ch 0028   4]              Asl Compiler ID : "INTL"
> [020h 0032   4]        Asl Compiler Revision : 20160527
>
> [024h 0036   1]               Interface Type : 00
> [025h 0037   3]                     Reserved : 000000
>
> [028h 0040  12]         Serial Port Register : [Generic Address Structure=
]
> [028h 0040   1]                     Space ID : 00 [SystemMemory]
> [029h 0041   1]                    Bit Width : 20
> [02Ah 0042   1]                   Bit Offset : 00
> [02Bh 0043   1]         Encoded Access Width : 00 [Undefined/Legacy]
> [02Ch 0044   8]                      Address : 000000001C021000
>
> [034h 0052   1]               Interrupt Type : 08
> [035h 0053   1]          PCAT-compatible IRQ : 00
> [036h 0054   4]                    Interrupt : 0000006D
> [03Ah 0058   1]                    Baud Rate : 03
> [03Bh 0059   1]                       Parity : 00
> [03Ch 0060   1]                    Stop Bits : 01
> [03Dh 0061   1]                 Flow Control : 02
> [03Eh 0062   1]                Terminal Type : 01
> [04Ch 0076   1]                     Reserved : 00
> [040h 0064   2]                PCI Device ID : FFFF
> [042h 0066   2]                PCI Vendor ID : FFFF
> [044h 0068   1]                      PCI Bus : 00
> [045h 0069   1]                   PCI Device : 00
> [046h 0070   1]                 PCI Function : 00
> [047h 0071   4]                    PCI Flags : 00000000
> [04Bh 0075   1]                  PCI Segment : 00
> [04Ch 0076   4]                     Reserved : 00000000
>
> Raw Table Data: Length 80 (0x50)
>
>   0000: 53 50 43 52 50 00 00 00 02 41 48 50 45 4A 43 4D  // SPCRP....AHPE=
JCM
>   0010: 50 72 6F 4C 69 61 6E 74 01 00 00 00 49 4E 54 4C  // ProLiant....I=
NTL
>   0020: 27 05 16 20 0D 00 00 00 00 08 00 00 00 10 02 1C  // '.. .........=
...
>   0030: 00 00 00 00 08 00 6D 00 00 00 03 00 01 02 01 00  // ......m......=
...
>   0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // .............=
...
>
> Jon.
>
> --
> Computer Architect | Sent from my Fedora powered laptop
>
Regards,
Duc Dang.
