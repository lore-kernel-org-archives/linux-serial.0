From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc9] serial: fix platform driver hotplug/coldplug
Date: Sun, 13 Apr 2008 12:07:25 -0700
Message-ID: <200804131207.25982.david-b@pacbell.net>
References: <200804131115.26592.david-b@pacbell.net> <8763ulzjia.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:25869 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751792AbYDMTH2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 13 Apr 2008 15:07:28 -0400
In-Reply-To: <8763ulzjia.fsf@macbook.be.48ers.dk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, kay@ascent.dsl.pltn13.pacbell.net

On Sunday 13 April 2008, Peter Korsgaard wrote:
>  David> +/* work with hotplug and coldplug */
>  David> +MODULE_ALIAS("platform:uartlite");
>  David> +
> 
> Why not stick this next to the other MODULE_ lines, like the other
> drivers?

Conceptually that's part of the driver struct ... it's not
metadata like who wrote it, its version, and so on.  So I
prefer to keep it with that driver.

For example if the driver name changes that alias must change
too.  And when the platform bus glue gets configured out -- with
PPC_MERGE, where OpenFirmware bus glue aranges for any hotplug
and coldplug suppoort, or in some other cases -- that alias must
be made to vanish.

So when I fix omissions in Kay's original patch, or otherwise
write the code myself, that's how I do it.

- Dave


> Other than that ..
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> -- 
> Bye, Peter Korsgaard
> 


