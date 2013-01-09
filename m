From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCHv2 0/5] serial: 8250: 8250_dw changes and dynamic
 capabilities
Date: Wed, 9 Jan 2013 11:22:46 +0200
Message-ID: <20130109092246.GA7912@as23.pp.htv.fi>
References: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:37719 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420Ab3AIJWt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2013 04:22:49 -0500
Content-Disposition: inline
In-Reply-To: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On Mon, Dec 03, 2012 at 01:17:54PM +0200, Heikki Krogerus wrote:
> Changes since v1:
> - rebased on top of Greg's tty-next
> 
> These are mainly small 8250_dw.c changes. The interesting patch is
> probable the first one that changes 8250.c so the drivers are able to
> deliver their UART's capabilities when they are registering ports.

I will make one more version of this set. I'll add ACPI support for
8250_dw.c, and also introduce dmaengine support for 8250.c.

-- 
heikki
