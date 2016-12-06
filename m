From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Tue, 6 Dec 2016 01:53:21 -0500
Message-ID: <966938c5-4540-593d-e763-18cf879b325d@redhat.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
 <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
 <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com>
 <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
 <CADaLNDmZQsmx6V8nveOUKJqEUAoeijxYhqWhKEhLGh_RiQo+ZA@mail.gmail.com>
 <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/06/2016 01:34 AM, Jon Masters wrote:
> On 12/05/2016 10:55 PM, Duc Dang wrote:
>> On Mon, Dec 5, 2016 at 6:27 PM, Jon Masters <jcm@redhat.com> wrote:
>>> Hi Duc, all,
>>>
>>> So after regenerating the initrd override (I must have fat fingered)
>>> it is now detecting the correct bit width on boot (attached dmesg log).
>>>
>>> HOWEVER while the console does come up, the use of "earlycon" on the
>>> command line (with no parameters) doesn't result in the early SPCR
>>> console coming up correctly. I see some garbled characters that
>>> suggest the baud (or register access width) is off somewhere.
>>
>> My bad that I did not catch this in the morning. Yes, earlycon does
>> not seems to work as expected. I can see that earlycon parameters
>> seems to be correct, but the bootconsole message does not come out
>> (the following is from 'dmesg')
> 
>> [    0.000000] ACPI: SPCR: console: uart,mmio32,0x1c020000,115200
>> [    0.000000] earlycon: uart0 at MMIO32 0x000000001c020000 (options '115200')
>> [    0.000000] bootconsole [uart0] enabled
> 
> The difference appears to be in the baud rate. When I explicitly specify
> "earlycon=uart8250,mmio32,0x1c021000" no baud is set. When booting with
> the SPCR, the baud is set to 9600 in my case or 115200 in yours. But we
> both know that the base clock on the X-Gene UART is weird. Maybe
> somehow we can explain this through the lack of setting a baud.
> 
> I am pondering some more currently. If it's X-Gene specific, let's add
> that to the quirk (and to perhaps a more APM specific SPCR subtype).

Yeah, that's it. Here's the logic (8250_early.c):

       if (!device->baud) {
                struct uart_port *port = &device->port;
                unsigned int ier;

                /* assume the device was initialized, only mask interrupts */
                ier = serial8250_early_in(port, UART_IER);
                serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
        } else
                init_port(device);

If we have a baud set we will call init_port and go messing with the
8250 UART clock and so on. While if we don't have one set we'll assume
whatever the firmware gave to us. We know the base clock frequency is
different, which made me wonder how the full 8250_dw drive was working
on your hardware...until I noticed the following ;)

Here's a snippet of the DSDT on m400:

        Device (UAR0)
        {
            Name (_HID, "APMC0D08")  // _HID: Hardware ID
            Name (_DDN, "UAR0")  // _DDN: DOS Device Name
            Name (_UID, "UAR0")  // _UID: Unique ID
            Name (_STR, Unicode ("APM88xxxx UART0 Controller"))  // _STR: Descri
ption String
            Name (_ADR, 0x1C021000)  // _ADR: Address
            Name (_CID, "NS16550A")  // _CID: Compatible ID
        ...
                    Method (_DSD, 0, NotSerialized)  // _DSD: Device-Specific Data
            {
                Local0 = Package (0x02)
                    {
                        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                        Package (0x01)
                        {
                            Package (0x02)
                            {
                                "clock-frequency", 
                                Zero
                            }
                        }
                    }
                DerefOf (DerefOf (Local0 [One]) [Zero]) [One]
                     = UCLK /* External reference */
                Return (Local0)
            }

...and here's what's sneakily in the first SSDT table:

DefinitionBlock ("", "SSDT", 2, "HPE   ", "UARTCLKS", 0x00000001)
{
    Name (\UCLK, Package (0x01)
    {
        0x02FAF080
    })
}

I suspect Mustang is doing similar. So you read the magic frequency
info and pass this in through a DSD in the AML. It's ok, I've made my
peace with this (but obviously we're trying to kill all DSD hacks),
but it explains how this "works" after boot, but not for early console.

To fix this, we're going to need to be able to know that your 8250 is
both needful of 32-bit accesses *AND* needs a different base UART clock.
Fortunately our good friends at Microsoft are amenable to adding a
subtype that covers this and are going to followup tomorrow for me.

We'll need to accept that on X-Gene platforms earlycon doesn't quite
work properly for the moment until we can add the correct quirk. So
Aleksey's patch kinda improves things in that it brings up the
console (which didn't work before) and therefore is hugely
beneficial, but it won't be able to enable the earlycon.

Aleksey: you might want to annotate your patch thusly:

"Discussion is still underway to add a new DBG2 (the table used to
enumerate the various subtypes of serial port covered by the SPCR)
16550 UART subtype that may be needed for some additional platforms,
such as those based upon AppliedMicro X-Gene ARMv8 SoCs"

Your patch as-is /is/ useful because it enables the console, and
most users care far more about that than the earlycon.

Jon.

P.S. I would note my usual anal pedantry. The reason I'm being a
pedant here is that we need to test this stuff as a user would use
it - making sure we get console output at the right moment - rather
than just boot testing and checking logs. That's never the same.

-- 
Computer Architect | Sent from my Fedora powered laptop

