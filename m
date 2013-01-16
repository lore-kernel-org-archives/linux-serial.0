From: Ilya Zykov <ilya@ilyx.ru>
Subject: Re: [PATCH] tty: Fix ptmx open without closed slave.
Date: Wed, 16 Jan 2013 11:48:38 +0400
Message-ID: <50F65B56.8090001@ilyx.ru>
References: <50D20EB5.30900@ilyx.ru> <20130116070402.GA2527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:56325 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752652Ab3APHsl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:48:41 -0500
In-Reply-To: <20130116070402.GA2527@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org


> 
> Ok, I have a ton of patches from you, lots of different threads, patches
> with the same subject, and I don't know what one Alan agreed to.
> 
> So, can you please resend what Alan and you agree should be applied to
> the tree?
> 


I think only two important:
[PATCH v4] tty: Add driver unthrottle in ioctl(...,TCFLSH,..).

[PATCH] tty: Correct tty buffer flush.
With Alan's ACK from 04.12.2012 for kernel <= 3.7

But for kernel 3.8 I resent this 05.12.2012
[PATCH -next 0/2] tty: Correct tty buffer flush.
[PATCH -next 1/2] tty: Correct tty buffer flush.
[PATCH -next 2/2] tty: Correct tty buffer flush.
The last I resent with new description after Jiri's remark.

If need I can resent.




