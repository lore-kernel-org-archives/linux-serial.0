From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch 2.6.25-rc9] serial: fix platform driver hotplug/coldplug
Date: Sun, 13 Apr 2008 20:39:57 +0200
Message-ID: <8763ulzjia.fsf@macbook.be.48ers.dk>
References: <200804131115.26592.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:35343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYDMSkD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 13 Apr 2008 14:40:03 -0400
Received: by ug-out-1314.google.com with SMTP id z38so322877ugc.16
        for <linux-serial@vger.kernel.org>; Sun, 13 Apr 2008 11:39:59 -0700 (PDT)
In-Reply-To: <200804131115.26592.david-b@pacbell.net> (David Brownell's message of "Sun\, 13 Apr 2008 11\:15\:26 -0700")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, kay@ascent

>>>>> "David" == David Brownell <david-b@pacbell.net> writes:

Hi,

 David>  MODULE_LICENSE("GPL");
 David> +MODULE_ALIAS("platform:sh-sci");
 David> --- g26.orig/drivers/serial/uartlite.c	2008-04-13 10:48:05.000000000 -0700
 David> +++ g26/drivers/serial/uartlite.c	2008-04-13 10:59:04.000000000 -0700
 David> @@ -561,6 +561,9 @@ static int __devexit ulite_remove(struct
 David>  	return ulite_release(&pdev->dev);
 David>  }
 
 David> +/* work with hotplug and coldplug */
 David> +MODULE_ALIAS("platform:uartlite");
 David> +

Why not stick this next to the other MODULE_ lines, like the other
drivers?

Other than that ..

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
