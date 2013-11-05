From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: pl2303: fixed handling of CS5 setting
Date: Tue, 5 Nov 2013 10:08:31 -0800
Message-ID: <20131105180831.GD25633@kroah.com>
References: <5277EA2B.1020806@gmail.com>
 <20131104191355.GB15921@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57067 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3KESGU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Nov 2013 13:06:20 -0500
Content-Disposition: inline
In-Reply-To: <20131104191355.GB15921@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Colin Leitner <colin.leitner@googlemail.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Nov 04, 2013 at 08:13:55PM +0100, Johan Hovold wrote:
> On Mon, Nov 04, 2013 at 07:40:43PM +0100, Colin Leitner wrote:
> > This patch fixes the CS5 setting on the PL2303 USB-to-serial devices. CS5 has a
> > value of 0 and the CSIZE setting has been skipped altogether by the enclosing
> > if. Tested on 3.11.6 and the scope shows the correct output after the fix has
> > been applied.
> > 
> > Tagged to be added to stable, because it fixes a user visible driver bug and is
> > simple enough to backport easily.
> 
> Thanks! Now it applies cleanly to v3.12.
> 
> Greg, can you pick this one up for v3.13-rc? The fix could be backported
> to all stable trees as the bug has been there since pre-git times.
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Colin Leitner <colin.leitner@gmail.com>
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Thanks, I'll pick this up after 3.13-rc1 is out and get it into the
stable kernels as well.

greg k-h
