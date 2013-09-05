From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Linux Serial Code Problems
Date: Wed, 4 Sep 2013 19:43:59 -0700
Message-ID: <20130905024359.GA19832@kroah.com>
References: <30148664.203459.1378337936840.JavaMail.root@vznit170080>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44980 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935534Ab3IEClT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Sep 2013 22:41:19 -0400
Content-Disposition: inline
In-Reply-To: <30148664.203459.1378337936840.JavaMail.root@vznit170080>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roger Davis <rogerdavis@verizon.net>
Cc: linux-serial@vger.kernel.org

On Wed, Sep 04, 2013 at 06:38:56PM -0500, Roger Davis wrote:
>  On Mon, Sep 02, 2013 at 06:14:30PM -0500, Roger Davis wrote:
> I have been pursuing a serial port problem for over a year, using Ubuntu 12.04.
> I reported it on 2012-12-07, and the bug was confirmed soon after that. I'm not
> sure if the root cause is in the basic Linux kernel, or if it is only in Ubuntu.
> Others are having problems with similar modems.

As this used to work on older kernels, and not on newer ones, is there
any way you can:
  - first ensure this is still a problem on 3.11
  - if that fails, use 'git bisect' to find the offending patch?

thanks,

greg k-h
