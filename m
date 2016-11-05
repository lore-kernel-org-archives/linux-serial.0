From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Sat, 5 Nov 2016 23:44:34 +0000 (GMT)
Message-ID: <alpine.LFD.2.20.1611052336380.17811@eddie.linux-mips.org>
References: <20161024135235.GA29984@gofer.mess.org> <20161024214925.GA143272@stormcage.americas.sgi.com> <20161025204139.GA22268@gofer.mess.org> <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com> <20161027201916.GA7718@gofer.mess.org> <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
 <20161031202706.GA10263@gofer.mess.org> <CAKU3ayXn4y+_Amu0FzL5ZhF2W8vFuEb0RR8b2hTBZ6rd+YZMqg@mail.gmail.com> <20161102152951.GA107664@stormcage.americas.sgi.com> <CAKU3ayVEsv0Qpk7AU9NwbAX5nOBkHVaj0SA2QnYFuHCQSWjv7A@mail.gmail.com>
 <20161104213348.GA30383@stormcage.americas.sgi.com> <CAKU3ayWH9najj+Gpw8Zmpxgq40s8J_dXAyo9oBbbdG55brO6Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: from localhost.localdomain ([127.0.0.1]:34790 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993135AbcKEXoeTgYvZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sun, 6 Nov 2016 00:44:34 +0100
In-Reply-To: <CAKU3ayWH9najj+Gpw8Zmpxgq40s8J_dXAyo9oBbbdG55brO6Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Nathan Zimmer <nzimmer@sgi.com>, Sean Young <sean@mess.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 4 Nov 2016, Peter Hurley wrote:

> > These bios screens do not have any mention of PNP settings.
> > I am getting output over the console (via ipmi) until the boot hangs.
> 
> Yeah, probably the device actually decodes io address access anyway,
> but in the disabled state probably has not routed IRQ.
> 
> I have no idea how to help you with the bios, sorry.

 I'd look out for serial port, Super-I/O or COM1 port (which is how PC-DOS 
named the device some 35 years ago) settings rather than anything to do 
with PNP.  Typically you'd be able to choose from a few classic combined 
I/O space address and IRQ assignments in addition to a `Disabled' setting.

 There might be a genuine BIOS bug there as well of course as serial ports 
seem to be less used these days and the issue may have escaped validation.

  Maciej
