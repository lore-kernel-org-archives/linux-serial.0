From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 15:52:48 -0800
Message-ID: <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com> <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Jon,

On Mon, Dec 5, 2016 at 3:27 PM, Jon Masters <jcm@redhat.com> wrote:
> Duc, Aleksey, all,
>
> I have a question about this...
>
> On 12/05/2016 01:51 PM, Duc Dang wrote:
>> On Mon, Dec 5, 2016 at 5:05 AM, Aleksey Makarov
>> <aleksey.makarov@linaro.org> wrote:
>>> Check the 'Register Bit Width' field of the ACPI Generic Address
>>> Structure that specifies the address of the UART registers to
>>> decide if the driver should use "mmio32" access instead of "mmio".
>>>
>>> If the driver is other than 16550 the access with is defined
>>> by the Interface Type field of the SPCR table.
>
> I have two questions about this:
>
> 1). Why is this not a full 16550 (ACPI_DBG2_16550_COMPATIBLE)?
>
> 2). Why is it a ACPI_DBG2_16550_SUBSET you are assuming here?

The patch is actually applied for both ACPI_DBG2_16550_COMPATIBLE and
ACPI_DBG2_16500_SUBSET. Or I misunderstood your question? The end
result after applying the patch on linux-next is like this:
        switch (table->interface_type) {
        case ACPI_DBG2_ARM_SBSA_32BIT:
                iotype = "mmio32";
                /* fall through */
        case ACPI_DBG2_ARM_PL011:
        case ACPI_DBG2_ARM_SBSA_GENERIC:
        case ACPI_DBG2_BCM2835:
                uart = "pl011";
                break;
        case ACPI_DBG2_16550_COMPATIBLE:
        case ACPI_DBG2_16550_SUBSET:
                if (table->serial_port.space_id ==
                        ACPI_ADR_SPACE_SYSTEM_MEMORY &&
                    table->serial_port.bit_width == 32)
                        iotype = "mmio32";
                uart = "uart";
                break;
        default:
                err = -ENOENT;
                goto done;
        }

>
> The SPCR and DBG2 spec clearly state that the _SUBSET is intended
> to represent a UART compatible with the earlier DGBP specification,
> not that a UART is a "subset" of a full 16550 (which seems to be
> the assumption in this patch). It's important we get this right.
>
> I built a test kernel with this patch and updated ACPI tables earlier,
> but it didn't boot with a console because I had left it a subtype 0,
> but just changed the width to 32 bit, which is what I expected.

On Mustang 3.06.25 firmware, DBG2 table has 'Port Type = 0x8000',
'Port subtype = 0x0001'

But I am still curious why setting subtype to '0' does not work on
your board. Are you using Mustang or m400?
>
> Further, I've heard back from Microsoft and they're looking at
> adding a specific subtype for this. If they do, I'm inclined to
> address existing designs with your patch (but I would favor this
> check because against the full 16550) and then switch newer APM
> based designs to the new subtype.

Yes, we will look out for the new subtype information.

>
> Jon.
>
> --
> Computer Architect | Sent from my Fedora powered laptop
>
Regards,
Duc Dang.
