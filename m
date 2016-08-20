From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: cdc_acm bug? read buffer bytes shifted
Date: Sat, 20 Aug 2016 13:32:38 +0200
Message-ID: <1471692758.29854.0.camel@suse.com>
References: <2c59e268-9fd6-172b-1803-074aa4e11f27@farjump.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2c59e268-9fd6-172b-1803-074aa4e11f27-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julio Guerra <julio-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sat, 2016-08-20 at 05:40 +0200, Julio Guerra wrote:

> Another example:
> > 00 00 00 00 00 00 00 01
> ...
> > 01 00 00 00 00 00 00 00
> ...
> > 00 01 00 00 00 00 00 00
> ...
> > 00 00 01 00 00 00 00 00
> after a random number of times, while usbmon shows the usb payload
> "00 00 00 00 00 00 00 01".

Hi, how many bytes does read() return?

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
