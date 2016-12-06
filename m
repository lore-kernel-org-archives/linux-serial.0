From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 16:31:40 -0800
Message-ID: <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com> <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 5, 2016 at 3:52 PM, Duc Dang <dhdang@apm.com> wrote:
> Hi Jon,
>
> On Mon, Dec 5, 2016 at 3:27 PM, Jon Masters <jcm@redhat.com> wrote:
>> Duc, Aleksey, all,
>>
>> I have a question about this...
>>
>> On 12/05/2016 01:51 PM, Duc Dang wrote:
>>> On Mon, Dec 5, 2016 at 5:05 AM, Aleksey Makarov
>>> <aleksey.makarov@linaro.org> wrote:
>>>> Check the 'Register Bit Width' field of the ACPI Generic Address
>>>> Structure that specifies the address of the UART registers to
>>>> decide if the driver should use "mmio32" access instead of "mmio".
>>>>
>>>> If the driver is other than 16550 the access with is defined
>>>> by the Interface Type field of the SPCR table.
>>
>> I have two questions about this:
>>
>> 1). Why is this not a full 16550 (ACPI_DBG2_16550_COMPATIBLE)?
>>
>> 2). Why is it a ACPI_DBG2_16550_SUBSET you are assuming here?
>
> The patch is actually applied for both ACPI_DBG2_16550_COMPATIBLE and
> ACPI_DBG2_16500_SUBSET. Or I misunderstood your question? The end
> result after applying the patch on linux-next is like this:
>         switch (table->interface_type) {
>         case ACPI_DBG2_ARM_SBSA_32BIT:
>                 iotype = "mmio32";
>                 /* fall through */
>         case ACPI_DBG2_ARM_PL011:
>         case ACPI_DBG2_ARM_SBSA_GENERIC:
>         case ACPI_DBG2_BCM2835:
>                 uart = "pl011";
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
>                 if (table->serial_port.space_id ==
>                         ACPI_ADR_SPACE_SYSTEM_MEMORY &&
>                     table->serial_port.bit_width == 32)
>                         iotype = "mmio32";
>                 uart = "uart";
>                 break;
>         default:
>                 err = -ENOENT;
>                 goto done;
>         }
>
>>
>> The SPCR and DBG2 spec clearly state that the _SUBSET is intended
>> to represent a UART compatible with the earlier DGBP specification,
>> not that a UART is a "subset" of a full 16550 (which seems to be
>> the assumption in this patch). It's important we get this right.
>>
>> I built a test kernel with this patch and updated ACPI tables earlier,
>> but it didn't boot with a console because I had left it a subtype 0,
>> but just changed the width to 32 bit, which is what I expected.
>
> On Mustang 3.06.25 firmware, DBG2 table has 'Port Type = 0x8000',
> 'Port subtype = 0x0001'

To clarify, for SPCR table, this is what we have on Mustang:
[0004]                          Signature : "SPCR"    [Serial Port
Console Redirection table]
[0004]                       Table Length : 00000050
[0001]                           Revision : 02
[0001]                           Checksum : 62
[0006]                             Oem ID : "APMC0D"
[0008]                       Oem Table ID : "XGENESPC"
[0004]                       Oem Revision : 00000000
[0004]                    Asl Compiler ID : "INTL"
[0004]              Asl Compiler Revision : 20141107

[0001]                     Interface Type : 00
[0003]                           Reserved : 000000

[0012]               Serial Port Register : [Generic Address Structure]
[0001]                           Space ID : 00 [SystemMemory]
[0001]                          Bit Width : 20
[0001]                         Bit Offset : 00
[0001]               Encoded Access Width : 01 [Byte Access:8]
[0008]                            Address : 000000001c020000

[0001]                     Interrupt Type : 08
[0001]                PCAT-compatible IRQ : 00
[0004]                          Interrupt : 0000006C
[0001]                          Baud Rate : 07
[0001]                             Parity : 00
[0001]                          Stop Bits : 01
[0001]                       Flow Control : 00
[0001]                      Terminal Type : 00
[0001]                           Reserved : 00
[0002]                      PCI Device ID : FFFF
[0002]                      PCI Vendor ID : FFFF
[0001]                            PCI Bus : 00
[0001]                         PCI Device : 00
[0001]                       PCI Function : 00
[0004]                          PCI Flags : 00000000
[0001]                        PCI Segment : 00
[0004]                           Reserved : 00000000

So the "Interface Type" is also set to 00.

>
> But I am still curious why setting subtype to '0' does not work on
> your board. Are you using Mustang or m400?
>>
>> Further, I've heard back from Microsoft and they're looking at
>> adding a specific subtype for this. If they do, I'm inclined to
>> address existing designs with your patch (but I would favor this
>> check because against the full 16550) and then switch newer APM
>> based designs to the new subtype.
>
> Yes, we will look out for the new subtype information.
>
>>
>> Jon.
>>
>> --
>> Computer Architect | Sent from my Fedora powered laptop
>>
> Regards,
> Duc Dang.
Regards,
Duc Dang.
