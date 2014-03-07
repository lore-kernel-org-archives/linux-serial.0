From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RFC: WIP: sc16is7xx.c
Date: Thu, 6 Mar 2014 21:52:31 -0800
Message-ID: <20140307055231.GA32019@kroah.com>
References: <1394159746-1729-1-git-send-email-jon@ringle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38623 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaCGFwC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 00:52:02 -0500
Content-Disposition: inline
In-Reply-To: <1394159746-1729-1-git-send-email-jon@ringle.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jon@ringle.org
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>

On Thu, Mar 06, 2014 at 09:35:46PM -0500, jon@ringle.org wrote:
> From: Jon Ringle <jringle@gridpoint.com>
> 
> I am requesting comments on this serial driver.
> I am currently having some latency issues with it where I experience
> packet loss at speed of 19200.
> 
> I welcome any and all comments.

The basic coding style problems make it hard to read to be able to help
review it, sorry.

Yes, brains have patterns, you want to follow the same patterns as
others, it matters.

thanks,

greg k-h
