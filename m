From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Tue, 6 Dec 2016 02:13:52 -0500
Message-ID: <0b8324fe-e564-226a-94b1-8ed2946db3d1@redhat.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
 <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
 <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com>
 <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
 <CADaLNDmZQsmx6V8nveOUKJqEUAoeijxYhqWhKEhLGh_RiQo+ZA@mail.gmail.com>
 <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
 <966938c5-4540-593d-e763-18cf879b325d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <966938c5-4540-593d-e763-18cf879b325d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/06/2016 01:53 AM, Jon Masters wrote:
> On 12/06/2016 01:34 AM, Jon Masters wrote:
>> On 12/05/2016 10:55 PM, Duc Dang wrote:
>>> On Mon, Dec 5, 2016 at 6:27 PM, Jon Masters <jcm@redhat.com> wrote:

>                         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
>                         Package (0x01)
>                         {
>                             Package (0x02)
>                             {
>                                 "clock-frequency", 
>                                 Zero
>                             }
>                         }

> I suspect Mustang is doing similar. So you read the magic frequency
                       ^^^^^^^^^^^^^
                     spoiler, it is :)

> info and pass this in through a DSD in the AML. It's ok, I've made my
> peace with this (but obviously we're trying to kill all DSD hacks),
> but it explains how this "works" after boot, but not for early console.
> 
> To fix this, we're going to need to be able to know that your 8250 is
> both needful of 32-bit accesses *AND* needs a different base UART clock.
> Fortunately our good friends at Microsoft are amenable to adding a
> subtype that covers this and are going to followup tomorrow for me.

For the earlycon setup, you'll probably benefit from figuring out
ahead of time how you'll want to handle this. The "easy" option
is to remove the baud in the case of X-Gene with new subtype
but that'll be potential fragile. You might also decide that
struct earlycon_device wants to grow a "quirks" flag that
you can set for this kind of thing (bound to be more).

Copying Rob as well in case he has suggestions for you. Rob, as
an FYI the AppliedMicro X-Gene 16550 "compatible" requires both
32-bit accesses (which Aleksey tried to address earlier in this
thread) but also has a special non-standard clock (to be fair,
it's not as if we architected a standard UART clock for arm64,
we just assumed it was like x86 but didn't mandate this early
when Applied were doing their design - another life lesson).
Microsoft will add a new DBG2 subtype that allows for both
of these situations. But you'll want to somehow convey this
information (quirks) in one of the earlycon structures.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
