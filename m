From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] pch_uart: Use uartclk instead of base_baud
Date: Thu, 8 Mar 2012 10:58:07 -0800
Message-ID: <20120308185807.GA19040@kroah.com>
References: <cover.1330539597.git.dvhart@linux.intel.com>
 <8b7e59a1f360a5f1ca9382ff53d9be941ef07f7b.1330539597.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55381 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab2CHS6M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 13:58:12 -0500
Received: by yhmm54 with SMTP id m54so437831yhm.19
        for <linux-serial@vger.kernel.org>; Thu, 08 Mar 2012 10:58:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8b7e59a1f360a5f1ca9382ff53d9be941ef07f7b.1330539597.git.dvhart@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Wed, Feb 29, 2012 at 10:24:44AM -0800, Darren Hart wrote:
> The term "base baud" refers to the fastest baud rate the device can communicate
> at. This is clock/16. pch_uart is using base_baud as the clock itself. Rename
> the variables to be semantically correct.

This patch doesn't apply to my tree, what did you make it against?

Care to refresh these against the linux-next tree and resend them so
that I can apply them?

thanks,

greg k-h
