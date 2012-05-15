From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 08:58:33 -0700
Message-ID: <20120515155833.GA24878@kroah.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
 <20120515165339.6b142cd2@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60575 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073Ab2EOP6h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 11:58:37 -0400
Received: by pbbrp8 with SMTP id rp8so7698598pbb.19
        for <linux-serial@vger.kernel.org>; Tue, 15 May 2012 08:58:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120515165339.6b142cd2@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Corbin Atkinson <corbinat@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

On Tue, May 15, 2012 at 04:53:39PM +0100, Alan Cox wrote:
> On Fri,  4 May 2012 12:35:10 -0500
> Corbin Atkinson <corbinat@gmail.com> wrote:
> 
> > Currently, serial drivers don't report buffer overruns. When a buffer overrun
> > occurs, tty_insert_flip_char returns 0, and no attempt is made to insert that
> > same character again (i.e. it is lost). This patch reports buffer overruns via
> > the buf_overrun field in the port's icount structure.
> 
> I think this is mostly a misunderstanding - it's always been interpreted
> as logging hardware reported overrruns. The case of the software layer
> losing bytes is a "doesn't happen in normal circumstances" situation. At
> least it should be.

Hm, I applied this already, should I revert it?

thanks,

greg k-h
