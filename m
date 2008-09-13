From: Marcel Holtmann <holtmann@linux.intel.com>
Subject: Re: [NONSERIOUS PATCH]: Change Sun serial major/minor numbers...
Date: Sat, 13 Sep 2008 19:13:01 +0200
Message-ID: <1221325981.6695.49.camel@californication>
References: <20080912.212013.205659677.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37504 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYIMRM0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Sep 2008 13:12:26 -0400
In-Reply-To: <20080912.212013.205659677.davem@davemloft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, joy@entuzijast.net

Hi Dave,

> This is the non-serious patch I mentioned in my first posting
> which changes all of the major/minor numbers used by the Sun
> serial drivers in order to get out of the way of 8250's
> major/minor namespace.
> 
> Again, this patch isn't meant to be taken seriously at all.
> I'm not even willing to sign off on it :-)

as long as you are using udev, it wouldn't that big of a problem :)

Regards

Marcel


