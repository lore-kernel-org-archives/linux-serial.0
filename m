From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH 3/4] sc16is7xx: expose RTS inversion in RS-485 mode
Date: Tue, 17 Mar 2015 15:57:00 +0100
Message-ID: <20150317155700.71a4ad1b@north>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
	<1426548529-21738-4-git-send-email-moorray3@wp.pl>
	<alpine.DEB.2.10.1503171043400.3566@jring-w510-7m3g.gridpoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.10.1503171043400.3566-cn3jTo8IYkmeSY0hgfj7bYJKnSiCLr9B28t4la5Gatg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Ringle, Jonathan" <Jonathan.Ringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Karol =?UTF-8?B?RMSZYm9nw7Nyc2tp?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 17 Mar 2015 10:45:26 -0400 (EDT), Jon Ringle wrote:
> This makes sense. I did have to fix up my user space app to set 
> SER_RS485_RTS_ON_SEND after applying this patch.

Yes, perhaps I should have mentioned that this makes the ioctl return
-EINVAL when neither of SER_RS485_RTS_*_SEND flags is set.  This
definitely has potential to break people's apps.  Let's see if anyone
else has an opinion on this.

I am also very tempted to remove rs485.delay_rts_*_send mdelays from
this driver and return -EINVAL in a similar fashion when there are set.
Normally when the driver is responsible for wiggling the GPIO/RTS line
mdelays can indeed impact when the lines change state but in sc16is7xx
case transitions are controlled by HW and there is nothing the driver
can do about the the relation between TX/RX mode switch and state of 
RTS lines...  Do you agree?
