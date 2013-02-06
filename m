From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] ACPI / serial: Add UART change_pm support with ACPI
 power domain
Date: Wed, 6 Feb 2013 13:38:39 -0800
Message-ID: <20130206213839.GB31339@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <69483f548e2d5476b8e1ce530e6910bfbf770d3d.1360131884.git.lv.zheng@intel.com>
 <20130206190728.GA32275@kroah.com>
 <14333377.SHpFl2uDhh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45288 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539Ab3BFVim (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 16:38:42 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so2602787iea.33
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 13:38:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <14333377.SHpFl2uDhh@vostro.rjw.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lv Zheng <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Krogerus Heikki <heikki.krogerus@intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Feb 06, 2013 at 10:39:09PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 06, 2013 11:07:28 AM Greg Kroah-Hartman wrote:
> > On Wed, Feb 06, 2013 at 02:26:26PM +0800, Lv Zheng wrote:
> > > This patch enables ACPI power domain on UART user devices. With this
> > > patch, Linux can achieve open/close based ACPI power manageability for
> > > UART tty ports.
> > 
> > So you are going to be sticking acpi_* calls into common core places all
> > over the kernel for stuff like this?
> > 
> > What's wrong with using the existing pm callbacks that are there for all
> > platforms to use?
> 
> I think that this just hasn't been thought through sufficiently (again).

Ugh.  Ok, I now am going to just quietly drop all intel.com patches to
the tty/serial layer unless they have at least 2 signed-off-by: lines,
one of which is by someone who is "well known" to me as being sane.

greg k-h
