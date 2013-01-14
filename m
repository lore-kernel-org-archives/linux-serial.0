From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RS485 serial communication on ColdFire
Date: Mon, 14 Jan 2013 06:28:15 -0800
Message-ID: <20130114142815.GA20384@kroah.com>
References: <CAODWn4qouGj+JGZzGrJD6b1Larc7v0rWE5t=_p5xW7SnVm3ErA@mail.gmail.com>
 <20130114033314.GB21784@kroah.com>
 <CAODWn4q=O6DrjxEpPU-eRrWRLRzFPzAe5XMJL1Oayeok79kyEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38677 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692Ab3ANO10 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 09:27:26 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so2249139pad.40
        for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2013 06:27:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAODWn4q=O6DrjxEpPU-eRrWRLRzFPzAe5XMJL1Oayeok79kyEA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Nguyen <afelion@gmail.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jan 14, 2013 at 06:12:34PM +1000, Kevin Nguyen wrote:
> Hi Greg,
> 
> The RS485 mode can be switched on/off from userspace by using the flag
> SER_RS485_ENABLED, therefore I've removed those #ifdefs in the patch.

Much better, thanks.

Can you also remove the debugging printk() messages you added?  Or,
convert them to dev_dbg() calls instead?  If you run your patch through
the scripts/checkpatch.pl tool, it should tell you things like this.

thanks,

greg k-h
