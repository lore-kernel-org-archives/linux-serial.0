From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 00/15] tty: serial: 8250: Fix checkpatch warnings
Date: Wed, 3 Feb 2016 09:54:44 -0800
Message-ID: <20160203175444.GA24491@kroah.com>
References: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
 <ff62e385d45ea8755ffaa8495e4d5443.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff62e385d45ea8755ffaa8495e4d5443.squirrel@faumail.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 03, 2016 at 03:40:09PM +0100, Anton Wuerfel wrote:
> Hello,
> 
> we noticed the patch series has not been merged yet to 4.5. Are there
> still problems we have to address?

I don't know, they are in my queue to be processed "soon"...

And they will not go into 4.5, that merge window is long closed, coding
style fixes like this are on the bottom of my list of things to be
reviewed, and are not "bug fixes" that affect people so they sometimes
take a long time to get merged.

thanks,

greg k-h
