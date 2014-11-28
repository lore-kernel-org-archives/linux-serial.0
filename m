From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Making our own device work under Linux
Date: Fri, 28 Nov 2014 11:08:42 -0800
Message-ID: <20141128190842.GA21239@kroah.com>
References: <37235F81-C73A-4CBB-A4ED-C1B9B8D8182D@radier.ca>
 <20141128184845.GA30162@kroah.com>
 <47A1438A-BFBE-4B3E-836E-D4A418DB3CC5@radier.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53284 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaK1TKD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2014 14:10:03 -0500
Content-Disposition: inline
In-Reply-To: <47A1438A-BFBE-4B3E-836E-D4A418DB3CC5@radier.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitriy Fitisov <dmitriy@radier.ca>
Cc: linux-serial@vger.kernel.org

On Fri, Nov 28, 2014 at 02:05:55PM -0500, Dmitriy Fitisov wrote:
> Thank you.
> I registered on a forum, awaited activation.
> Raspberry mailing list is virtually dead, producing a few kilobytes montly.
> But anyway, it is pretty much Debian I would think.

If it is Debian, then try asking on one of the Debian developer mailing
lists.  Either way, it's probably still ModemManager doing this type of
thing, try removing it from your system image and see if that helps.

greg k-h
