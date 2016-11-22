From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Tue, 22 Nov 2016 09:30:52 -0600
Message-ID: <52b88ea1-2aa2-3b1d-5f97-7cec25665256@sgi.com>
References: <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
 <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
 <20161031202706.GA10263@gofer.mess.org>
 <CAKU3ayXn4y+_Amu0FzL5ZhF2W8vFuEb0RR8b2hTBZ6rd+YZMqg@mail.gmail.com>
 <20161102152951.GA107664@stormcage.americas.sgi.com>
 <CAKU3ayVEsv0Qpk7AU9NwbAX5nOBkHVaj0SA2QnYFuHCQSWjv7A@mail.gmail.com>
 <20161104213348.GA30383@stormcage.americas.sgi.com>
 <CAKU3ayWH9najj+Gpw8Zmpxgq40s8J_dXAyo9oBbbdG55brO6Sw@mail.gmail.com>
 <alpine.LFD.2.20.1611052336380.17811@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1611052336380.17811@eddie.linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: Sean Young <sean@mess.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org



On 11/05/2016 06:44 PM, Maciej W. Rozycki wrote:
> On Fri, 4 Nov 2016, Peter Hurley wrote:
>
>>> These bios screens do not have any mention of PNP settings.
>>> I am getting output over the console (via ipmi) until the boot hangs.
>> Yeah, probably the device actually decodes io address access anyway,
>> but in the disabled state probably has not routed IRQ.
>>
>> I have no idea how to help you with the bios, sorry.
>   I'd look out for serial port, Super-I/O or COM1 port (which is how PC-DOS
> named the device some 35 years ago) settings rather than anything to do
> with PNP.  Typically you'd be able to choose from a few classic combined
> I/O space address and IRQ assignments in addition to a `Disabled' setting.
>
>   There might be a genuine BIOS bug there as well of course as serial ports
> seem to be less used these days and the issue may have escaped validation.
>
>    Maciej

After getting back to this after some other hot issues came up I am sure 
there is a bios bug, comparing acpidump of this box to other boxes 
really makes it obvious.

I found pnpacpi=off allows me to boot fine and get console traffic.
However I was hoping to find something that cast a little narrower net.


Nate
