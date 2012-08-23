From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCHv4 3/9] serial: vt8500: Add devicetree support for
 vt8500-serial
Date: Thu, 23 Aug 2012 11:53:00 +0100
Message-ID: <20120823115300.5fdb5cd1@bob.linux.org.uk>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
	<1345707346-9035-4-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40250 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932718Ab2HWKf3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Aug 2012 06:35:29 -0400
In-Reply-To: <1345707346-9035-4-git-send-email-linux@prisktech.co.nz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: vt8500-wm8505-linux-kernel@googlegroups.com, Russell King <linux@arm.linux.org.uk>, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Linus Walleij <linus.walleij@stericsson.com>, Mike Turquette <mturquette@ti.com>, Stephen Warren <swarren@nvidia.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, rtc-linux@googlegroups.com, devicetree-discuss@lists.ozlabs.org

On Thu, 23 Aug 2012 19:35:39 +1200
Tony Prisk <linux@prisktech.co.nz> wrote:

> Increase vt8500_max_ports to 6 as the WM8505 as 6 available uarts.
> Use devicetree port id as primary addressing for ports but allow
> auto-allocation if id not specified.

Acked-by: Alan Cox <alan@linux.intel.com>

for the serial bits
