From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] tty/serial: jsm: Added spaces in if sentences and
 around binary operators
Date: Mon, 3 Aug 2015 16:33:32 -0700
Message-ID: <20150803233332.GA6205@kroah.com>
References: <1438241765-3094-1-git-send-email-abuinjm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438241765-3094-1-git-send-email-abuinjm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Manuel Abuin Mosquera <abuinjm@gmail.com>
Cc: cascardo@linux.vnet.ibm.com, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 30, 2015 at 09:36:05AM +0200, Jose Manuel Abuin Mosquera wrote:
> From: "Jose M. Abuin" <abuinjm@gmail.com>
> 
> Added a blank line between variable declaration and code.
> Changed printk(KERN_INFO by pr_info( in some lines.
> Fixed space separations in if - else sentences.
> Added spaces between binary operators and variables.
> Variable assignation outside if in line 766.

A patch should only do one thing.  You are doing multiple things here in
this patch so please break it out into multiple patches.

thanks,

greg k-h
