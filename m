From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: serial core: crash / race condition on unbind
Date: Tue, 11 Mar 2014 12:00:34 +0000
Message-ID: <20140311120034.632ff833@alan.etchedpixels.co.uk>
References: <CAMuHMdVV_NrQ3PPJwPNx7MoM9TWLdk02d+10zNipNcC7VC0HAA@mail.gmail.com>
	<CAMuHMdVwpQEWAVHA5BO2xXzaNc1DTdteDMWFHQ=MFJoo4Afm_A@mail.gmail.com>
	<531E7F81.20400@hurleysoftware.com>
	<CAMuHMdUeUjuBe0tWpYBZqwqWT=euPAn6fwzmXMYCP573Q1BDXQ@mail.gmail.com>
	<531EF864.5020104@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59812 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbaCKMAo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Mar 2014 08:00:44 -0400
In-Reply-To: <531EF864.5020104@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

> > No one unbinds serial drivers using serial_core, as all these drivers are
> > for fixed hardware?
> 
> Yep, never tested until now :)
> Do you need this to work?
> 
> > Hot-pluggable usb-serial doesn't use serial_core.
> 
> I guess none of the 8250 PCI adapters are hot-pluggable...

pcmcia 8250 certainly was and worked - but then I've not had pcmcia ports
in years 8)

