From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: introduce up_to_u8250p() macro
Date: Mon, 14 Jul 2014 11:56:31 +0300
Message-ID: <1405328191.5102.131.camel@smile.fi.intel.com>
References: <1405327299-25649-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <53C39908.6070707@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9817 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbaGNI4e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jul 2014 04:56:34 -0400
In-Reply-To: <53C39908.6070707@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org

On Mon, 2014-07-14 at 10:47 +0200, Jiri Slaby wrote:
> On 07/14/2014 10:41 AM, Andy Shevchenko wrote:
> > It helps to convert struct uart_port to struct uart_8250_port.
> 
> Hi, I don't know what conversion you mean (yet),

Dynamic object casting if you like.

>  but could that be a
> static inline instead of the macro?

Yes, I could. Would like me to do so?

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

