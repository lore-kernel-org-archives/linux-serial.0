From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] tty: erase buffers when the kernel is done with
 it.
Date: Wed, 10 Oct 2018 20:24:21 +0200
Message-ID: <20181010182421.GA23517@kroah.com>
References: <20181004180614.25619-1-gregkh@linuxfoundation.org>
 <c54d108b-729a-5866-53d1-26f2e7d0db2b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c54d108b-729a-5866-53d1-26f2e7d0db2b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milan Broz <gmazyland@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build, torvalds@linux-foundation.org, w@1wt.eu, Daniel Zatovic <daniel.zatovic@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 10, 2018 at 08:20:06PM +0200, Milan Broz wrote:
> On 04/10/2018 20:06, Greg Kroah-Hartman wrote:
> > azlig and Milan Broz reported that when the tty layer is done with a
> > buffer, the data can hang around in it for a very long time.  That
> > sometimes can "leak" to userspace under some conditions.
> > 
> > Because of this, just zero out the data after the tty layer is finished
> > with it, for buffers that we "think" should be zeroed out.
> > 
> > v2 - addressed some review comments on the 2/2 patch.
> 
> Hello Greg,
> 
> together with our intern we re-tested both patches and it fixes the reported problem,
> so, if it helps anything, you can add
> 
> Tested-by: Milan Broz <gmazyland@gmail.com>
> Tested-by: Daniel Zatovic <daniel.zatovic@gmail.com>
> 
> Do you plan to add this to linux-next?

Yes, I'll queue it up soon, thanks for testing!

greg k-h
