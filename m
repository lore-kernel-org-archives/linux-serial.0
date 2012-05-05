From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Sat, 5 May 2012 07:57:32 -0700
Message-ID: <20120505145732.GA27577@kroah.com>
References: <1335817637-2862-1-git-send-email-preston.fick@silabs.com>
 <20120503213456.77c55c51@pyramind.ukuu.org.uk>
 <20120505003208.GA30718@kroah.com>
 <20120505120137.11a45c86@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50879 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab2EEO5f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 5 May 2012 10:57:35 -0400
Received: by pbbrp8 with SMTP id rp8so4971090pbb.19
        for <linux-serial@vger.kernel.org>; Sat, 05 May 2012 07:57:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120505120137.11a45c86@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Preston Fick <pffick@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, preston.fick@silabs.com, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Sat, May 05, 2012 at 12:01:37PM +0100, Alan Cox wrote:
> > Will the new ldisc mess with the tty stuff to prevent "normal" serial
> > data and line settings from being handled properly?  If not, that all
> > looks very good to me, thanks for working this out.
> 
> It'll have no effect on that. What it will do is provide a way for things
> like ISO7816 ldiscs to use the extra pins (as they can call from the
> ldisc into the gpio layer) and to know the mapping of the extra control
> wires, which varies by device.

Ok, that sounds good to me.
