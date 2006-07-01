From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PNPACPI: support shareable interrupts
Date: Fri, 30 Jun 2006 18:14:31 -0700
Message-ID: <20060630181431.6245202c.akpm@osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6E16DA1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6E16DA1@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: bjorn.helgaas@hp.com, ambx1@neo.rr.com, castet.matthieu@free.fr, shaohua.li@intel.com, linux-acpi@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"Brown, Len" <len.brown@intel.com> wrote:
>
> >pnpacpi confuses me.  Who maintains it?  Is it considered an 
> >APCI thing, or a PNP thing or a Bjorn thing?
> 
> PNP is Adam's generic Linux PNP layer.
> It has "drivers" underneath is, such as pnp-isa, and pnp-bios
> 
> Shaohua invented pnp-acpi as a driver to replace pnp-bios
> on ACPI-enabled systems.
> 
> So PNPACPI is the connection between ACPI and PNP,
> and folks who conribute to either might contribute to it.
> Most of the issues with it to date have been ACPI-specific,
> rather than PNP-specific, including this one.
> 
> Bjorn, of course, is qualified to contribute to just about
> any part of the kernel.  So a "Bjorn thing" could be just
> about anything;-)
> 

OK.  But that still didn't give me a how-to-get-this-to-mainline graph.

Bjorn, are these patches considered for-2.6.18 material?  (They look like
it).

