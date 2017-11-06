From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] tty: fix tty_ldisc_receive_buf() documentation
Date: Mon, 6 Nov 2017 14:57:58 +0100
Message-ID: <20171106135758.GE11226@localhost>
References: <20171103141805.20292-1-johan@kernel.org>
 <20171106133944.2vkbbpl2tokhsabq@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171106133944.2vkbbpl2tokhsabq@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 06, 2017 at 02:39:44PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 03, 2017 at 03:18:05PM +0100, Johan Hovold wrote:
> > The tty_ldisc_receive_buf() helper returns the number of bytes
> > processed so drop the bogus "not" from the kernel doc comment.
> > 
> > Fixes: 8d082cd300ab ("tty: Unify receive_buf() code paths")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Thanks for the review. Greg already picked this one up for next though.

Johan
