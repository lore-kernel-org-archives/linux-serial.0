From: Morten Helgesen <morten@sourcepoet.org>
Subject: Re: [PATCH] genericserial: Remove bogus optimisation check and dead
 code paths
Date: Tue, 03 Jul 2007 16:39:05 +0200
Message-ID: <468A5F89.70900@sourcepoet.org>
References: <20070703152021.6eb8013d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.webon.net ([213.188.24.21]:47100 "EHLO smtp.webon.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756175AbXGCOyE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 10:54:04 -0400
In-Reply-To: <20070703152021.6eb8013d@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Alan Cox wrote:

[...snip...]
> @@ -75,11 +64,11 @@
>  	if (! (port->flags & ASYNC_INITIALIZED)) return;
>  
>  	/* Take a lock on the serial tranmit buffer! */
> -	LOCKIT;
> +	mutex_lock(& port->port_write_mutex);
>   

^ Contains additional whitespace.

>  	if (port->xmit_cnt >= SERIAL_XMIT_SIZE - 1) {
>  		/* Sorry, buffer is full, drop character. Update statistics???? -- REW */
> -		RELEASEIT;
> +		mutex_unlock(&port->port_write_mutex);
>  		return;
>  	}
>  
> @@ -87,13 +76,11 @@
>   
[...snip...]

== Morten
