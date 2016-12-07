From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Wed, 07 Dec 2016 10:23:19 -0500
Message-ID: <1481124199.4751.50.camel@redhat.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
         <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
         <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
         <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
         <CADaLND=t3O9J+KvaK=xb455HjaLYMA+4yodFVrozMEMtgPi-pw@mail.gmail.com>
         <3a6193ef-ca86-c113-b09a-5d6c882137e2@redhat.com>
         <CADaLNDmZQsmx6V8nveOUKJqEUAoeijxYhqWhKEhLGh_RiQo+ZA@mail.gmail.com>
         <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53421849-d031-77e1-9edb-53c9d673d462@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Masters <jcm@redhat.com>, Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-12-06 at 01:34 -0500, Jon Masters wrote:
> On 12/05/2016 10:55 PM, Duc Dang wrote:
> > 
> > On Mon, Dec 5, 2016 at 6:27 PM, Jon Masters <jcm@redhat.com> wrote:
> > > 
> > > Hi Duc, all,
> > > 
> > > So after regenerating the initrd override (I must have fat fingered)
> > > it is now detecting the correct bit width on boot (attached dmesg log).
> > > 
> > > HOWEVER while the console does come up, the use of "earlycon" on the
> > > command line (with no parameters) doesn't result in the early SPCR
> > > console coming up correctly. I see some garbled characters that
> > > suggest the baud (or register access width) is off somewhere.
> > My bad that I did not catch this in the morning. Yes, earlycon does
> > not seems to work as expected. I can see that earlycon parameters
> > seems to be correct, but the bootconsole message does not come out
> > (the following is from 'dmesg')
> > 
> > [    0.000000] ACPI: SPCR: console: uart,mmio32,0x1c020000,115200
> > [    0.000000] earlycon: uart0 at MMIO32 0x000000001c020000 (options '115200')
> > [    0.000000] bootconsole [uart0] enabled
> The difference appears to be in the baud rate. When I explicitly specify
> "earlycon=uart8250,mmio32,0x1c021000" no baud is set. When booting with
> the SPCR, the baud is set to 9600 in my case or 115200 in yours. But we
> both know that the base clock on the X-Gene UART is weird. Maybe
> somehow we can explain this through the lack of setting a baud.

BTW, this behavior is same with devicetree.
If you specify a baudrate with earlycon=, the driver tries to set that
baudrate and if you have an 8250 with some non-standard baud clock, then
it will fail. Perhaps SPCR shouldn't pass baud option to setup_earlycon().
Then again, setup_earlycon() has this comment:

 *	setup_earlycon - match and register earlycon console
 *	@buf:	earlycon param string
 *
 *	Registers the earlycon console matching the earlycon specified
 *	in the param string @buf. Acceptable param strings are of the form
 *	   <name>,io|mmio|mmio32|mmio32be,<addr>,<options>
 *	   <name>,0x<addr>,<options>
 *	   <name>,<options>
 *	   <name>
 *
 *	Only for the third form does the earlycon setup() method receive the
 *	<options> string in the 'options' parameter; all other forms set
 *	the parameter to NULL.

That part about the 3rd form doesn't seem to be true. I don't see where
options gets set to NULL for forms other than the third.

> 
> I am pondering some more currently. If it's X-Gene specific, let's add
> that to the quirk (and to perhaps a more APM specific SPCR subtype).
> 
> Jon.
> 
