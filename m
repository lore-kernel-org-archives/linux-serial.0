From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Mon, 31 Oct 2016 20:55:49 -0600
Message-ID: <CAKU3ayXn4y+_Amu0FzL5ZhF2W8vFuEb0RR8b2hTBZ6rd+YZMqg@mail.gmail.com>
References: <20161019090719.GA1764@gofer.mess.org> <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org> <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org> <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org> <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org> <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
 <20161031202706.GA10263@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161031202706.GA10263@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Nathan <nzimmer@sgi.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 31, 2016 at 2:27 PM, Sean Young <sean@mess.org> wrote:
> On Sun, Oct 30, 2016 at 10:33:02AM -0500, Nathan wrote:
>> I think this should be PNP0501 instead of PNP0c02.
>> Once I alter that then when I boot the serial comes up on irq 3. However it
>> still hangs.
>> I'll keep digging.
>
> Well that's that theory out of the window. I'm not sure where to look now,
> I would start by enabling as many as possible of the "kernel hacking" config
> options and see if anything gets caught.
>
> Looking at your earlier messages, you have a collection of percpu allocation
> failures. That might be worth resolving before anything else.

Hi Nathan,

Couple of questions:
1. Was login over serial console setup and working on SLES 11?  or was
the 'console=ttyS1' only for debug output?
I ask because console output doesn't use IRQs; iow, maybe the serial
port w/ driver never actually worked.
2. Can you post dmesg for the SLES 11 setup?  That would show if there
were probe errors even on that.

An alternative that should be equivalent to your previous setup is to
build w/ CONFIG_SERIAL_8250_PNP=n
Seems like your ACPI BIOS is buggy, but also that something else is using IRQ 3?

Regards,
Peter Hurley
