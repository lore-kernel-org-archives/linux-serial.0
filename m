From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2 v2] serial/8250: Add support for RS485 IOCTLs
Date: Tue, 5 Aug 2014 10:58:15 +0100
Message-ID: <20140805105815.52926e67@alan.etchedpixels.co.uk>
References: <1407231959-18696-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:48413 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933078AbaHEJ7V (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2014 05:59:21 -0400
In-Reply-To: <1407231959-18696-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jg1.han@samsung.com>, Michael Welling <mwelling@ieee.org>, Peter Hurley <peter@hurleysoftware.com>, Joe Schultz <jschultz@xes-inc.com>, Ingo Molnar <mingo@elte.hu>, Doug Anderson <dianders@chromium.org>, linux-serial@vger.kernel.org

On Tue,  5 Aug 2014 11:45:59 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> This patch allow the users of the 8250 infrastructure to define a
> handler for RS485 configration.
> 
> If no handler is defined the 8250 driver will work as usual.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
