From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 1/2] PNPACPI: support shareable interrupts
Date: Fri, 30 Jun 2006 20:59:20 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16DA1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21565 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751887AbWGAA7X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 Jun 2006 20:59:23 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ambx1@neo.rr.com, castet.matthieu@free.fr, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

>pnpacpi confuses me.  Who maintains it?  Is it considered an 
>APCI thing, or a PNP thing or a Bjorn thing?

PNP is Adam's generic Linux PNP layer.
It has "drivers" underneath is, such as pnp-isa, and pnp-bios

Shaohua invented pnp-acpi as a driver to replace pnp-bios
on ACPI-enabled systems.

So PNPACPI is the connection between ACPI and PNP,
and folks who conribute to either might contribute to it.
Most of the issues with it to date have been ACPI-specific,
rather than PNP-specific, including this one.

Bjorn, of course, is qualified to contribute to just about
any part of the kernel.  So a "Bjorn thing" could be just
about anything;-)

cheers,
-Len

