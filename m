From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/tty/tty_io.c: fix a potential memleak at
 do_tty_write()
Date: Mon, 18 Jun 2012 08:26:42 -0700
Message-ID: <20120618152642.GB15267@kroah.com>
References: <4FDF1DDA.3030704@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57105 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2FRP0q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 11:26:46 -0400
Received: by dady13 with SMTP id y13so7092232dad.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 08:26:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FDF1DDA.3030704@oracle.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jeff Liu <jeff.liu@oracle.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jun 18, 2012 at 08:23:54PM +0800, Jeff Liu wrote:
> Hello,
> 
> Looks there is a potential memory leak at drivers/tty/tty_io.c: do_tty_write().
> It did allocate a buf_chunk if tty->write_cnt < chunk, however, buf_chunk was not
> freed after the writing is done.  Below tiny patch could fix it.
> 
> Thanks,
> -Jeff
> 

Thanks for the patch, but can you resend it with a signed-off-by: line
as described in Documentation/SubmittingPatches so that we can properly
apply the patch?

thanks,

greg k-h
