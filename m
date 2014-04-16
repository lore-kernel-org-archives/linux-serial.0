From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: Question regarding serial_core.h port type
Date: Wed, 16 Apr 2014 15:26:37 +0200
Message-ID: <20140416132637.GA9237@jtlinux>
References: <20140415140956.GA25718@jtlinux>
 <20140415152231.GB7311@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.163]:11226 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161040AbaDPNdD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Apr 2014 09:33:03 -0400
Content-Disposition: inline
In-Reply-To: <20140415152231.GB7311@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>, linux-serial@vger.kernel.org

On Tue, Apr 15, 2014 at 08:22:31AM -0700, Greg KH wrote:
> On Tue, Apr 15, 2014 at 04:09:56PM +0200, Johannes Thumshirn wrote:
> > Hi,
> >
> > I have a question regarding the port type constants in serial_core.h. Is there
> > any "official" assignment scheme, or is it ok to just grab/append an unused
> > number?
>
> You can get a new number when you submit a patch with your driver.
>

I'll then add it with my driver patch.

> > Or is it even possible/allowed to reuse an existing number from the list?
>
> No, please don't do that.

OK, I expected this answer. Just wanted to be sure.

Thanks,
	Johannes
