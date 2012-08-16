From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Remove BUG_ON from n_tty_read()
Date: Thu, 16 Aug 2012 11:46:03 -0700
Message-ID: <20120816184603.GB20400@kroah.com>
References: <20120816110130.774.87642.stgit@localhost.localdomain>
 <20120816110146.774.73249.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64964 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab2HPSqI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 14:46:08 -0400
Received: by pbbrr13 with SMTP id rr13so1977647pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 16 Aug 2012 11:46:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120816110146.774.73249.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Thu, Aug 16, 2012 at 12:01:47PM +0100, Alan Cox wrote:
> From: Stanislav Kozina <skozina@redhat.com>
> 
> Change the BUG_ON to WARN_ON and return in case of tty->read_buf==NULL. We want to track a
> couple of long standing reports of this but at the same time we can avoid killing the box.
> 
> Signed-off-by: Stanislav Kozina <skozina@redhat.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Cc: Horses <stable@kernel.org>

Heh, "Horses"?  That's a first...

