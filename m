From: chri <chripell@gmail.com>
Subject: Re: [PATCH] max3100 driver
Date: Sat, 20 Sep 2008 12:35:26 +0200
Message-ID: <cabda6420809200335x3409d31eo47e7aa5fc809cfa4@mail.gmail.com>
References: <1221895208650-git-send-email-chripell@gmail.com>
	 <20080920012454.e40f03cc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:20561 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbYITKf1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 06:35:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so815380rvb.1
        for <linux-serial@vger.kernel.org>; Sat, 20 Sep 2008 03:35:26 -0700 (PDT)
In-Reply-To: <20080920012454.e40f03cc.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Sorry, sent HTML mail by mistake, so resending :-/


On Sat, Sep 20, 2008 at 10:24 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:

> > +#define MAX3100_MAJOR 204
>
> Allocating a new major is a Big Deal.  It involves getting the major
> registered by contacting device@lanana.org.
>
> It's better to dynamically allocate it - let udev handle it.
>


I looked at other serial driver as an example and checked devices.txt:
if I don't get it wrong major 204 should be already reserved for
serial port. Anyway I choose a minor number already allocated by
mistake (did not see the "...") and will correct that. Is this ok or I
*have to* move to dynamic major (it's a bit a nuisance since max3100
is used in embedded system where udev is not always used)?


> `struct max3100_port' is sufficient, and would be more typical.
>
> > +     struct uart_port port;
> > +     struct spi_device *spi;
> > +
> > +     int cts:1;              /* last CTS received for flow ctrl */
> > +     int tx_empty:1;         /* last TX empty bit */
>
> These two bits will share a word and hence locking is needed to prevent
> modifications to one from trashing modifications to the other on SMP.
>
> That's OK, but it would be best to document that locking right here, and
> to check that it is adhered to.
>


I did not realize this until you explained me. I'm not sure if actual
packing of bit-fields is implementation dependent but I think so. If
this is right I guess it's better to avoid bit-fields in structs that
can be accessed concurrently (or otherwise I have to lock the entire
struct). So, should I avoid bit-fields altogether?

I will correct the patch and resend.

Thanks,

--
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
