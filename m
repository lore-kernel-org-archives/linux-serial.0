From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Fri, 4 Nov 2016 16:18:40 -0600
Message-ID: <CAKU3ayWH9najj+Gpw8Zmpxgq40s8J_dXAyo9oBbbdG55brO6Sw@mail.gmail.com>
References: <20161024135235.GA29984@gofer.mess.org> <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org> <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org> <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
 <20161031202706.GA10263@gofer.mess.org> <CAKU3ayXn4y+_Amu0FzL5ZhF2W8vFuEb0RR8b2hTBZ6rd+YZMqg@mail.gmail.com>
 <20161102152951.GA107664@stormcage.americas.sgi.com> <CAKU3ayVEsv0Qpk7AU9NwbAX5nOBkHVaj0SA2QnYFuHCQSWjv7A@mail.gmail.com>
 <20161104213348.GA30383@stormcage.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161104213348.GA30383@stormcage.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: Sean Young <sean@mess.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 4, 2016 at 3:33 PM, Nathan Zimmer <nzimmer@sgi.com> wrote:
> On Thu, Nov 03, 2016 at 06:25:46PM -0600, Peter Hurley wrote:
>> On Wed, Nov 2, 2016 at 9:29 AM, Nathan Zimmer <nzimmer@sgi.com> wrote:
>> > On Mon, Oct 31, 2016 at 08:55:49PM -0600, Peter Hurley wrote:
>> >> On Mon, Oct 31, 2016 at 2:27 PM, Sean Young <sean@mess.org> wrote:
>> >> > On Sun, Oct 30, 2016 at 10:33:02AM -0500, Nathan wrote:
>> >> >> I think this should be PNP0501 instead of PNP0c02.
>> >> >> Once I alter that then when I boot the serial comes up on irq 3. However it
>> >> >> still hangs.
>> >> >> I'll keep digging.
>> >> >
>> >> > Well that's that theory out of the window. I'm not sure where to look now,
>> >> > I would start by enabling as many as possible of the "kernel hacking" config
>> >> > options and see if anything gets caught.
>> >> >
>> >> > Looking at your earlier messages, you have a collection of percpu allocation
>> >> > failures. That might be worth resolving before anything else.
>> >>
>> >> Hi Nathan,
>> >>
>> >> Couple of questions:
>> >> 1. Was login over serial console setup and working on SLES 11?  or was
>> >> the 'console=ttyS1' only for debug output?
>> >> I ask because console output doesn't use IRQs; iow, maybe the serial
>> >> port w/ driver never actually worked.
>> >> 2. Can you post dmesg for the SLES 11 setup?  That would show if there
>> >> were probe errors even on that.
>> >>
>> >> An alternative that should be equivalent to your previous setup is to
>> >> build w/ CONFIG_SERIAL_8250_PNP=n
>> >> Seems like your ACPI BIOS is buggy, but also that something else is using IRQ 3?
>> >>
>> >> Regards,
>> >> Peter Hurley
>> >
>> >
>> >
>> > 1) Yes I can confirm I used it to login sometimes.
>> >
>> > I built with CONFIG_SERIAL_8250_PNP=n and that seemed to work better, in that the system did not hang.
>> > However I couldn't login on the serial and got these error messages, I suspect I broke something while trying different permutations.
>> >
>> > gdm[5206]: WARNING: GdmDisplay: display lasted 0.136636 seconds
>> > gdm[5206]: WARNING: GdmDisplay: display lasted 0.180955 seconds
>> > gdm[5206]: WARNING: GdmDisplay: display lasted 0.161415 seconds
>> > gdm[5206]: WARNING: GdmLocalDisplayFactory: maximum number of X display failures reached: check X server log for errors
>> >
>> > It did boot all the way though.
>> >
>> > 2) attached log
>>
>> So I'm confused where this leaves us.
>>
>> In your OP, you claim to have gotten it working with a partial revert
>> of commit 835d844d1a28 (but you didn't attach the partial revert so no
>> one knows what you did); however, my suggestion should have been
>> equivalent.
>
> I apologize, if I was unclear.  Your suggestion of CONFIG_SERIAL_8250_PNP=n did successfully boot and provide messages
> across the console, and yes is basically equivelent to the revert.

Ok, so the partial revert didn't get the login working then?

> Those warnings I just noticed in the dmesg and they weren't there before.
>
>>
>> Note that you have the serial port disabled in BIOS; that's why you're
>> getting the probe error for PNP.
>
> Now when you say its diabled in bios, how can I be sure and double check that?

Well, the ACPI BIOS is reporting it as disabled. Even the SLES11 log says:

[    2.136899] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (disabled)


> These bios screens do not have any mention of PNP settings.
> I am getting output over the console (via ipmi) until the boot hangs.

Yeah, probably the device actually decodes io address access anyway,
but in the disabled state probably has not routed IRQ.

I have no idea how to help you with the bios, sorry.

Regards,
Peter Hurley
