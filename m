From: Greg KH <greg@kroah.com>
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Date: Sun, 27 Feb 2005 22:39:54 -0800
Message-ID: <20050228063954.GB23595@kroah.com>
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mail.kroah.org ([69.55.234.183]:18588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261512AbVB1G6J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Feb 2005 01:58:09 -0500
Content-Disposition: inline
In-Reply-To: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, Feb 27, 2005 at 06:39:51PM -0500, Wen Xiong wrote:
> This patch is for jsm_proc.c and includes the functions relating to 
> /proc/jsm entry.

No, don't add new /proc stuff.  Use sysfs, and if you want to spit out
more data, use debugfs.

What is the need for these files?

thanks,

greg k-h 
