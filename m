From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/12] gpio-sch: Fix leak of resource
Date: Wed, 27 Jun 2012 12:32:51 -0700
Message-ID: <20120627193251.GA2358@kroah.com>
References: <20120627112102.5678.4141.stgit@localhost.localdomain>
 <20120627112140.5678.79917.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64660 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab2F0Tc4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 15:32:56 -0400
Received: by pbbrp8 with SMTP id rp8so1976432pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 27 Jun 2012 12:32:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120627112140.5678.79917.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Wed, Jun 27, 2012 at 12:21:42PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/gpio/gpio-sch.c |    3 ++-

Again, I can't take this patch, it should go to the GPIO maintainer.

greg k-h
