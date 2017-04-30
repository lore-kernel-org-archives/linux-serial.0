From: Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Sun, 30 Apr 2017 17:39:38 -0400
Message-ID: <78013fd3-0313-8e96-16d4-99c5e0af8db2@jonmasters.org>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
 <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
 <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com>
 <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
 <CADaLNDmZQsmx6V8nveOUKJqEUAoeijxYhqWhKEhLGh_RiQo+ZA@mail.gmail.com>
 <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
 <1481124199.4751.50.camel@redhat.com>
 <3a27e455-dc5f-4fee-aa72-4eab752e91d0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3a27e455-dc5f-4fee-aa72-4eab752e91d0@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/13/2016 01:20 AM, Jon Masters wrote:
> On 12/07/2016 10:23 AM, Mark Salter wrote:

>> If you specify a baudrate with earlycon=, the driver tries to set that
>> baudrate and if you have an 8250 with some non-standard baud clock, then
>> it will fail. Perhaps SPCR shouldn't pass baud option to setup_earlycon().
> 
> Yet they seem to explicitly want to do this...in my conversations with some
> others we agree that, in many cases, you really want to say "leave the baud
> whatever the firmware set it", which would work in this case, but might
> break some others. Then again, nobody on x86 Linux is really using the
> SPCR today due to it not having been something they used until now and
> due to the location of the COM ports being fairly well known ;)
> 
> So who knows what folks will prefer, but we should at least get the spec
> to cover both situations by explicitly calling out Applied as special.

<snip>

> So I've been discussing some changes to the SPCR and the current proposal
> is that we have two new subtypes - one for 16550s that are non-standard
> register width/stride but use the typical base clock, and a specific
> additional type for SBSA level 0 compatible 16550 UARTs (Applied). I
> will followup when the specification document has been revised.

As an update. I've been speaking with friends at Microsoft on and off
about this for quite some time. They've been very helpful (as usual) and
we should get an SPCR update soon covering Applied's case. I have pinged
the APM team to make sure that they're ready to post a patch.

I would like this small fix squeezed in 4.12, but before 4.13.

Jon.

