From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 1/2] serial: New serial driver SCCNXP
Date: Mon, 24 Sep 2012 20:50:47 +0400
Message-ID: <20120924205047.da73876b.shc_work@mail.ru>
References: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
	<20120905202433.GA23267@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp9.mail.ru ([94.100.176.54]:60828 "EHLO smtp9.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888Ab2IXRGr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 13:06:47 -0400
In-Reply-To: <20120905202433.GA23267@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, 5 Sep 2012 13:24:33 -0700
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
...
> > +config SERIAL_SCCNXP
> > +	bool "SCCNXP serial port support"
> > +	depends on !SERIAL_SC26XX
> > +	select SERIAL_CORE
> > +	default n
> > +	help
> > +	  This selects support for an advanced UART from NXP (Philips).
> > +	  Supported ICs are SCC2681, SCC2691, SCC2692, SC28L91, SC28L92,
> > +	  SC28L202, SCC68681 and SCC68692.
> > +	  Positioned as a replacement for the driver SC26XX.
> 
> This driver can be built as a module, right?  If so, please change this
> to a tristate variable, not a "bool".  I don't feel like always building
> it into my kernels :)
> Care to send a follow-on patch fixing this up?

I'm not sure whether the driver works as a module, as in the case of the
module, we can not setup at least IO-address and IRQ parameters. Or, we are
need to create module_param variables.

-- 
Alexander Shiyan <shc_work@mail.ru>
