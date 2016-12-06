From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 19:03:25 -0500
Message-ID: <0ac8dc36-38d9-0f08-9f5f-021f40b8ea7d@redhat.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
 <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/05/2016 06:52 PM, Duc Dang wrote:
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
> ACPI_DBG2_16500_SUBSET. Or I misunderstood your question?

No, I had missed the fall through for both conditions since it hadn't
worked in my quick boot test with the other type earlier. It's probably
only applicable in the general 16550 case, not in the subset case,
but I don't have any objections at this. My bad.

Now as to why it's not actually triggering on my test machine is
something I'll check. I set the port width in the address struct
in the ACPI table to 32-bit and it didn't see mmio32 just mmio, so
I then re-read the patch itself and had assumed Aleksey meant it
to be only for the subtype. Be right back after I poke...

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
