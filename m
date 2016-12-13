From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Tue, 13 Dec 2016 01:20:05 -0500
Message-ID: <3a27e455-dc5f-4fee-aa72-4eab752e91d0@redhat.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
 <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
 <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com>
 <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
 <CADaLNDmZQsmx6V8nveOUKJqEUAoeijxYhqWhKEhLGh_RiQo+ZA@mail.gmail.com>
 <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
 <1481124199.4751.50.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481124199.4751.50.camel@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/07/2016 10:23 AM, Mark Salter wrote:
> On Tue, 2016-12-06 at 01:34 -0500, Jon Masters wrote:
>> On 12/05/2016 10:55 PM, Duc Dang wrote:

>>> On Mon, Dec 5, 2016 at 6:27 PM, Jon Masters <jcm@redhat.com> wrote:

>>>> HOWEVER while the console does come up, the use of "earlycon" on the
>>>> command line (with no parameters) doesn't result in the early SPCR
>>>> console coming up correctly. I see some garbled characters that
>>>> suggest the baud (or register access width) is off somewhere.
>>> My bad that I did not catch this in the morning. Yes, earlycon does
>>> not seems to work as expected. I can see that earlycon parameters
>>> seems to be correct, but the bootconsole message does not come out
>>> (the following is from 'dmesg')
>>>
>>> [    0.000000] ACPI: SPCR: console: uart,mmio32,0x1c020000,115200
>>> [    0.000000] earlycon: uart0 at MMIO32 0x000000001c020000 (options '115200')
>>> [    0.000000] bootconsole [uart0] enabled
>> The difference appears to be in the baud rate. When I explicitly specify
>> "earlycon=uart8250,mmio32,0x1c021000" no baud is set. When booting with
>> the SPCR, the baud is set to 9600 in my case or 115200 in yours. But we
>> both know that the base clock on the X-Gene UART is weird. Maybe
>> somehow we can explain this through the lack of setting a baud.
> 
> BTW, this behavior is same with devicetree.

At least it's consistent :)

> If you specify a baudrate with earlycon=, the driver tries to set that
> baudrate and if you have an 8250 with some non-standard baud clock, then
> it will fail. Perhaps SPCR shouldn't pass baud option to setup_earlycon().

Yet they seem to explicitly want to do this...in my conversations with some
others we agree that, in many cases, you really want to say "leave the baud
whatever the firmware set it", which would work in this case, but might
break some others. Then again, nobody on x86 Linux is really using the
SPCR today due to it not having been something they used until now and
due to the location of the COM ports being fairly well known ;)

So who knows what folks will prefer, but we should at least get the spec
to cover both situations by explicitly calling out Applied as special.

> Then again, setup_earlycon() has this comment:
> 
>  *	setup_earlycon - match and register earlycon console
>  *	@buf:	earlycon param string
>  *
>  *	Registers the earlycon console matching the earlycon specified
>  *	in the param string @buf. Acceptable param strings are of the form
>  *	   <name>,io|mmio|mmio32|mmio32be,<addr>,<options>
>  *	   <name>,0x<addr>,<options>
>  *	   <name>,<options>
>  *	   <name>
>  *
>  *	Only for the third form does the earlycon setup() method receive the
>  *	<options> string in the 'options' parameter; all other forms set
>  *	the parameter to NULL.
> 
> That part about the 3rd form doesn't seem to be true. I don't see where
> options gets set to NULL for forms other than the third.

I saw that also, and agree that it appears totally bogus. We'll want to get
the documentation fixed as part of this cleanup.

So I've been discussing some changes to the SPCR and the current proposal
is that we have two new subtypes - one for 16550s that are non-standard
register width/stride but use the typical base clock, and a specific
additional type for SBSA level 0 compatible 16550 UARTs (Applied). I
will followup when the specification document has been revised.

Jon.

P.S. I had a lot of fun over my birthday reading the original 8250 spec
and learning about how the DLAB stuff works (I think those brain cells had
died). Which - on a total tangent - finally helps with a long standing issue
we have had. We (a small cabal) have wanted to sneak in an instruction into
the ARM ISA or specs referring to DLAB (the initials of a certain person
who owns the ARM ARM) and now we will get to do this into the SBBR ;)

-- 
Computer Architect | Sent from my Fedora powered laptop

