From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Wed, 25 Mar 2009 17:04:21 -0600
Message-ID: <200903251704.22377.bjorn.helgaas@hp.com>
References: <20090324151034.GC6859@ports.donpac.ru> <20090324223632.66680ebd@lxorguk.ukuu.org.uk> <20090324225812.GA30827@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:19557 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZCYXE1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 19:04:27 -0400
In-Reply-To: <20090324225812.GA30827@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org, williams@redhat.com

On Tuesday 24 March 2009 04:58:12 pm Matthew Garrett wrote:
> On Tue, Mar 24, 2009 at 10:36:32PM +0000, Alan Cox wrote:
> > On Tue, 24 Mar 2009 22:29:34 +0000
> > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > I'd prefer not to go with this approach unless we've got a convincing 
> > > number of bugs filed. It's guaranteed to reduce hardware support in 
> > > favour of fixing an unknown number of machines.
> > 
> > I get a regular stream of complaints. But as I said Red Hat is the patch
> > originator, Red Hat has the distro bugzilla so perhaps Red Hat folks can
> > comment ?
> 
> I've had a dig through Bugzilla but couldn't find it, and it doesn't 
> seem to be in anything we're shipping right now. Clark, do you have a 
> pointer to a bug that this patch came from?

This patch is a major problem for ia64.  ia64 doesn't have any legacy
serial port probing, so if we turn off SERIAL_8250_PNP, we won't find
any of the non-PCI built-in ports.  Many of these machines have only
serial consoles, so turning off either SERIAL_8250_PNP or SERIAL_8250_CONSOLE
is a problem.

Red Hat has been shipping with ia64 kernels with CONFIG_SERIAL_8250_CONSOLE=y
and CONFIG_SERIAL_8250_PNP=y (or its predecessor CONFIG_SERIAL_8250_ACPI=y)
since at least RHEL4.

Bjorn
