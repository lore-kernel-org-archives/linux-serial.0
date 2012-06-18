From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] pch_uart: Add eg20t_port lock field, avoid recursive
 spinlocks
Date: Mon, 18 Jun 2012 15:21:04 -0700
Message-ID: <20120618222104.GA9543@kroah.com>
References: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com>
 <CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com>
 <4FC90BAD.3080606@linux.intel.com>
 <4FCE8307.3050901@linux.intel.com>
 <CANKRQnj5mxHLprMt4VMMa7sCwLZb=PAktnVVD1MZVkkUG4eLoA@mail.gmail.com>
 <4FDFA09A.4030405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61867 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab2FRWVI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 18:21:08 -0400
Received: by pbbrp8 with SMTP id rp8so8786593pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 15:21:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FDFA09A.4030405@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Mon, Jun 18, 2012 at 02:41:46PM -0700, Darren Hart wrote:
> 
> 
> On 06/05/2012 04:48 PM, Tomoya MORINAGA wrote:
> > On Wed, Jun 6, 2012 at 7:07 AM, Darren Hart <dvhart@linux.intel.com> wrote:
> >> Are there still concerns about the additional lock? I'll resend V2
> >> tomorrow with the single whitespace fix if I don't hear anything back today.
> > 
> > I understand your saying. Looks good.
> > However, I am not expert of linux-uart core system.
> > So, I'd like UART maintainer to give us your opinion.
> 
> Greg, Alan,
> 
> any concerns with the locking approach I've adopted in the patch?

Care to resend the patch, as it was a RFC one, it's no longer in my
queue.

thanks,

greg k-h
