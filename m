From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from OF
Date: Fri, 25 Jan 2013 04:40:30 -0800
Message-ID: <20130125124030.GA14952@kroah.com>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
 <1359111008-9998-2-git-send-email-blogic@openwrt.org>
 <51027021.8010802@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36765 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485Ab3AYMi6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 07:38:58 -0500
Content-Disposition: inline
In-Reply-To: <51027021.8010802@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: John Crispin <blogic@openwrt.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Fri, Jan 25, 2013 at 03:44:33PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-01-2013 14:50, John Crispin wrote:
> 
> >In order to make serial_8250 loadable via OF on Au1x00 and Ralink WiSoC we need
> >to default the iotype to UPIO_AU.
> 
>    Alan Cox no longer works on Linux, Greg KH looks after the serial
> drivers snow.

It's ok, I'm on the mailing list and pick this stuff up, no need to
resend.

greg k-h
