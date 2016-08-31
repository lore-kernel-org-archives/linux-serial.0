From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Allowing UART DMA to be configured on i.MX53
Date: Wed, 31 Aug 2016 15:53:07 +0200
Message-ID: <20160831135307.GA5394@kroah.com>
References: <CAOMZO5DAAU0jUpd2xwgTwL9Y1Bhido35fxvhQ9HGZRXbRnB2Gg@mail.gmail.com>
 <1470648566-11698-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470648566-11698-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: festevam@gmail.com, Martyn Welch <martyn.welch@collabora.co.uk>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 08, 2016 at 11:29:25AM +0200, Fabien Lahoudere wrote:
> From: Martyn Welch <martyn.welch@collabora.co.uk>
> 
> The UART DMA was only being configured on i.MX6Q compatible devices. We
> know that the DMA also works for i.MX53 devices, so allow DMA to be
> configured on those devices too.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

You sent 3 copies of this?  Which do I apply?

Please resend your whole series, linked together, so that I know what
ones to apply, I've dropped all of your patches from my queue.

thanks,

greg k-h
