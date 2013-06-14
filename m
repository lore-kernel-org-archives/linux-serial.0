From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Possible tty VT1 disallocate regression
Date: Fri, 14 Jun 2013 14:35:43 -0700
Message-ID: <20130614213543.GA1896@kroah.com>
References: <20130614204740.GA706@hobo.wolfson.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130614204740.GA706@hobo.wolfson.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 14, 2013 at 09:47:40PM +0100, Ross Lagerwall wrote:
> Hi,
> 
> Ever since commit 421b40a6286e ("tty/vt: Fix vc_deallocate() lock
> order"), the first VT does not clear when I log out.  AFAIK, this means
> that disallocation is not working?  The problem only affects the first
> VT, the others clear when logging out.

And if you revert that patch, does it all start working again?

thanks,

greg k-h

p.s. In the future, please cc: the people who handled the patch you are
asking about, otherwise stuff like this often gets missed in the noise
of lkml.
