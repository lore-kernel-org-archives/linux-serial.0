From: Julio Guerra <julio-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Subject: cdc_acm bug? read buffer bytes shifted
Date: Sat, 20 Aug 2016 05:40:51 +0200
Message-ID: <2c59e268-9fd6-172b-1803-074aa4e11f27@farjump.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,

I have noticed a problem using a usb device managed by the cdc_acm
driver. The data received from the device and copied to userspace ends
up being shifted by one byte again and again after some amount of calls
to read() and most importantly with previously read data. usbmon shows
the usb data payload is correct.

A small shell script is enough to make it happen fastly:
https://gist.github.com/Julio-Guerra/b6529994f814771c825649bdb8d927c2

It prints the buffer read with my device (a relay) and gives me things like:
> 00 01 01 01 00 01 00 01
...
> 01 00 01 01 01 00 01 00
...
> 00 01 00 01 01 01 00 01
after a random number of times, while usbmon shows the usb payload
"00 01 01 01 00 01 00 01"


Another example:
> 00 00 00 00 00 00 00 01
...
> 01 00 00 00 00 00 00 00
...
> 00 01 00 00 00 00 00 00
...
> 00 00 01 00 00 00 00 00
after a random number of times, while usbmon shows the usb payload
"00 00 00 00 00 00 00 01".

Any idea?

I currently use versions 4.5.0 and 4.7.1 to execute this script.

Thanks you

-- 
Julio Guerra
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
