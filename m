From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Tty: serial - Fix possible NULL derefrence.
Date: Sat, 18 Feb 2017 14:06:50 +0100
Message-ID: <20170218130650.GB24938@kroah.com>
References: <CGME20170127111619epcas4p44c21059f85b7aa091016019c98d42939@epcas4p4.samsung.com>
 <1485515773-3542-1-git-send-email-shailendra.v@samsung.com>
 <20170130193743.GB27138@kroah.com>
 <c5f241d637c1c7208e95683eb50e7aa9@vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c5f241d637c1c7208e95683eb50e7aa9@vanmierlo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>
Cc: Shailendra Verma <shailendra.v@samsung.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>, linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Feb 18, 2017 at 11:25:19AM +0100, Maarten Brock wrote:
> Hello Greg,
> 
> Does that also mean that this isn't possible in the sc16is7xx.c driver in
> sc16is7xx_spi_probe() line 1358 and sc16is7xx_i2c_probe() line 1419 ?
> 
> If so, should these checks be removed?

Probably.
