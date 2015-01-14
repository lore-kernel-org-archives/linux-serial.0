From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] char: Added support for u-blox 6 i2c gps driver
Date: Wed, 14 Jan 2015 12:43:30 -0800
Message-ID: <20150114204330.GB31119@kroah.com>
References: <1421198202-4042-1-git-send-email-eu@felipetonello.com>
 <20150114154816.58b0f9c7@lxorguk.ukuu.org.uk>
 <CAGrhNMysmq==Y0naNki0z5usmMwUErj-FOTy=8KH0V=R7=VFwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGrhNMysmq==Y0naNki0z5usmMwUErj-FOTy=8KH0V=R7=VFwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Tonello <eu@felipetonello.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 14, 2015 at 10:39:04AM -0800, Felipe Tonello wrote:
> The thing is that: I wrote this driver to work with only one gps
> module, because that's my configuration here. I cannot really test
> multiple i2c gps at the same time. If you guys really want a driver
> that works for multiple gps drivers, I cannot test it.
> 
> So my question is, can I leave the driver working for one gps only and
> then improve what needs to be improved?

No, write it to handle any number of devices, the logic is the same for
one, or one thousand, there should not be any issues in the driver that
make this any different.

thanks,

greg k-h
