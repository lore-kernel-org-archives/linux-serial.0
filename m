From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: plug a use-after-free in TIOCGETD ioctl
Date: Thu, 7 Jan 2016 10:21:38 -0800
Message-ID: <20160107182138.GA5115@kroah.com>
References: <1452178680-30284-1-git-send-email-mguzik@redhat.com>
 <20160107161418.GA28297@kroah.com>
 <568E946C.60703@hurleysoftware.com>
 <20160107170853.GA28780@kroah.com>
 <568EA2B0.3010407@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568EA2B0.3010407@hurleysoftware.com>
Sender: stable-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Mateusz Guzik <mguzik@redhat.com>, Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, milos@redhat.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 07, 2016 at 09:38:56AM -0800, Peter Hurley wrote:
> On 01/07/2016 09:08 AM, Greg Kroah-Hartman wrote:
> > On Thu, Jan 07, 2016 at 08:38:04AM -0800, Peter Hurley wrote:
> >> On 01/07/2016 08:14 AM, Greg Kroah-Hartman wrote:
> >>> Adding Peter and linux-serial to the list here, as Peter has been doing
> >>> a ton of work in this area...
> >>>
> >>> Peter, does this seem sane with the tty locking rules?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> No.
> >>
> >> Fix for this is right here:
> >> http://lkml.iu.edu/hypermail/linux/kernel/1511.3/03045.html
> > 
> > Ah, I thought I had seen this before, thanks for the reminder :)
> > 
> > But, I didn't apply that series for some reason, was it waiting on
> > something before that?  Or did I just miss it with the holliday break?
> 
> That series is good to go, and in fact fixes a rash of crash
> reports which occur on kernels since 3.10, but just started showing
> up now (triggered by some interaction between consoles over terminal servers
> and systemd).
> 
> I didn't bother you about it because it seemed like you were busy.
> Do you need me to resend this series (and the other 6 series' plus
> misc fixes)?

Sure, a resend would be good to have, if you can do that.

thanks,

greg k-h
