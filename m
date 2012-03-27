From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] atmel-serial: fix RS485 half-duplex problem
Date: Tue, 27 Mar 2012 13:26:28 -0700
Message-ID: <20120327202628.GB15798@kroah.com>
References: <6FF0F449D45DEE479E93D93A0C07A8BD025E8F0631@USROCEX01>
 <20120327175433.GA6623@kroah.com>
 <6FF0F449D45DEE479E93D93A0C07A8BD025E9F8D47@USROCEX01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35856 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab2C0U0c (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Mar 2012 16:26:32 -0400
Received: by ghrr11 with SMTP id r11so318496ghr.19
        for <linux-serial@vger.kernel.org>; Tue, 27 Mar 2012 13:26:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6FF0F449D45DEE479E93D93A0C07A8BD025E9F8D47@USROCEX01>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Siftar, Gabe" <Gabe.Siftar@getingeusa.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Claudio Scordino <claudio@evidence.eu.com>, Bernhard Roth <br@pwrnet.de>

On Tue, Mar 27, 2012 at 04:20:51PM -0400, Siftar, Gabe wrote:
> >From: Greg KH [mailto:gregkh@linuxfoundation.org]
> >Sent: Tuesday, March 27, 2012 1:55 PM
> >Care to resend this without the footer so I can accept it?
> 
> Sorry.  It turns out that the footer was added by our 3rd party email 
> filtering service - I hope that it's no longer being included.

Looks good, thanks, I'll queue this up once 3.4-rc1 is out.

thanks,

greg k-h
