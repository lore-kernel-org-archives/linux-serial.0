From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] timbuart: Support for beeing probed more than
 once
Date: Tue, 29 Sep 2009 16:20:20 -0700
Message-ID: <20090929162020.e429c826.akpm@linux-foundation.org>
References: <4AB8C23B.3020309@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45400 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752855AbZI2XU1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Sep 2009 19:20:27 -0400
In-Reply-To: <4AB8C23B.3020309@mocean-labs.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@mocean-labs.com>
Cc: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Tue, 22 Sep 2009 14:25:31 +0200
Richard R__jfors <richard.rojfors@mocean-labs.com> wrote:

> There was a problem in the current implementation where a global static
> uart_driver struct was used. The same struct was reused every time the
> driver got probed. Since the struct has a state within the serial core
> it can not be reused.
> 
> A uart_driver struct is added to the timbuart_port struct which is
> allocated per platform device.
> 
> The probe and remove functions are declared __devinit and __devexit.

Are you sure?  Lots of other serial drivers appears to do it this way
and I'm ununaware of it causing any problems there.

Exactly what problem(s) are you observing?  (This should have been
described in the original changelog btw).

