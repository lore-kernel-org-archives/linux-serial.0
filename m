From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: update entry for atmel_serial driver
Date: Thu, 29 Sep 2016 08:31:48 +0200
Message-ID: <20160929063148.GA418@kroah.com>
References: <20160928154735.25265-1-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160928154735.25265-1-nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, richard.genoud@gmail.com, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 28, 2016 at 05:47:35PM +0200, Nicolas Ferre wrote:
> Change maintainer for the serial driver found on most of the
> Microchip / Atmel MPUs and take advantage of the move to rename
> and reorder the entry.
> I'm happy that Richard is taking over the maintenance of this
> driver.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  MAINTAINERS | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

This doesn't apply to my tty-next tree at all, what did you make it
against?

thanks,

greg k-h
