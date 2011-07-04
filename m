From: Greg KH <greg@kroah.com>
Subject: Re: USB console broken in -next ?
Date: Mon, 4 Jul 2011 09:31:50 -0700
Message-ID: <20110704163150.GA18935@kroah.com>
References: <20110704171959.0aa2cafa@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110704171959.0aa2cafa@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 04, 2011 at 05:19:59PM +0100, Alan Cox wrote:
> I'm seeing the USB console hang part way through the boot up. It looks as
> if it hangs the box solid about the point the standard USB setup/binding
> would occur for the serial driver it is using in console mode
> 
> Any ideas - not sure how old the problem is as I've not needed USB
> console for a long time.

No ideas, sorry, but I haven't tried a USB console out in a long time
either.

greg k-h
