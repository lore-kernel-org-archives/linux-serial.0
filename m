From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] synclink fix ldisc buffer argument
Date: Sun, 2 Dec 2012 15:13:32 +0000
Message-ID: <20121202151332.3b6a6504@pyramind.ukuu.org.uk>
References: <50B6E751.9000000@asianux.com>
	<20121129051335.GA4375@kroah.com>
	<50B6F967.3050000@asianux.com>
	<20121129183207.GA4688@kroah.com>
	<50B81F76.8020508@asianux.com>
	<50B8DDAC.8070901@microgate.com>
	<50B90D0D.9040401@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49304 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab2LBPIk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Dec 2012 10:08:40 -0500
In-Reply-To: <50B90D0D.9040401@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Chen Gang <gang.chen@asianux.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

> +				 * If a different line discipline is selected by mistake it
> +				 * will have valid memory for both arguments.
> +				 */
> +				ldisc_receive_buf(tty, buf->data, buf->data, framesize);

But not valid content it seems 
