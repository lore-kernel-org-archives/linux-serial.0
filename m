From: Ilya Zykov <ilya@ilyx.ru>
Subject: Re: [PATCH v4] tty: Add driver unthrottle in ioctl(...,TCFLSH,..).
Date: Tue, 27 Nov 2012 22:46:56 +0400
Message-ID: <50B50AA0.7070603@ilyx.ru>
References: <50B45A49.2040104@ilyx.ru> <20121127172406.GE24592@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:49870 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751247Ab2K0SrL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 13:47:11 -0500
In-Reply-To: <20121127172406.GE24592@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ilya@ilyx.ru

On 27.11.2012 21:24, Greg Kroah-Hartman wrote:
> On Tue, Nov 27, 2012 at 10:14:33AM +0400, Ilya Zykov wrote:
>> Sorry. More correct.
> 
> In what way?  Should I wait for the 6th version?  :)
> 
> thanks,
> 
> greg k-h
> 

No, if only you will accept:
[PATCH]tty: Incorrect use tty_ldisc_flush() in TTY drivers.

It can be done another way, simple revert:
'tty: fix "IRQ45: nobody cared"'
commit 7b292b4bf9a9d6098440d85616d6ca4c608b8304

