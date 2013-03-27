From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: 8250serial driver causing DEADLOCK, suggestions needed
Date: Wed, 27 Mar 2013 08:11:06 -0700
Message-ID: <20130327151106.GA18686@kroah.com>
References: <CAD15agYNgq2uC0D4nGChCJyKr7F8+X-7QpG=8QSnNPs1qG=t6w@mail.gmail.com>
 <CAD15agbuTCt1YzUxCOqL=8N3KXqae0iaa=fsU2pvG2D+6HiLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51543 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3C0PLK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Mar 2013 11:11:10 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so1045422pdi.7
        for <linux-serial@vger.kernel.org>; Wed, 27 Mar 2013 08:11:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAD15agbuTCt1YzUxCOqL=8N3KXqae0iaa=fsU2pvG2D+6HiLwg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ritesh Harjani <ritesh.harjani@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, Mar 27, 2013 at 07:33:47PM +0530, Ritesh Harjani wrote:
> 
> Hi guys
> 
> I am facing following deadlock on my ARM SMP machine and thought of mailing you
> guys for any valuable suggestions on this.
> 
> [Problem]
> 1. In serial8250_handle_irq function after acquiring a spin_lock, I want to
> print some debug info. This printk will call serial8250_console_write function.
> This function too tries to acquire the same spin_lock and spins on it if
> someone else already acquired it. Assume that this scenario happened on cpu0,
> that means this situation will create a deadlock (as cpu0 will busy spin for
> acquiring a lock which it had already acquired).

Then don't do that :)

Use the tracing infrastructure if you really want to do debug stuff from
within your console irq handler.

greg k-h
