From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial: 8250: introduce up_to_u8250p() macro
Date: Mon, 14 Jul 2014 12:32:57 +0200
Message-ID: <53C3B1D9.5020403@suse.cz>
References: <1405327299-25649-1-git-send-email-andriy.shevchenko@linux.intel.com>	 <53C39908.6070707@suse.cz> <1405328191.5102.131.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58138 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbaGNKdC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jul 2014 06:33:02 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so2196899wiv.4
        for <linux-serial@vger.kernel.org>; Mon, 14 Jul 2014 03:33:00 -0700 (PDT)
In-Reply-To: <1405328191.5102.131.camel@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org

On 07/14/2014 10:56 AM, Andy Shevchenko wrote:
> On Mon, 2014-07-14 at 10:47 +0200, Jiri Slaby wrote:
>> On 07/14/2014 10:41 AM, Andy Shevchenko wrote:
>>> It helps to convert struct uart_port to struct uart_8250_port.
>>
>> Hi, I don't know what conversion you mean (yet),
> 
> Dynamic object casting if you like.
> 
>>  but could that be a
>> static inline instead of the macro?
> 
> Yes, I could. Would like me to do so?

Yes, please.


-- 
js
suse labs
