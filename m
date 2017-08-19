From: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Subject: Re: [PATCH] USB: serial: ti_usb_3410_5052: Port uart_mode from io_ti.
Date: Sun, 20 Aug 2017 06:47:25 +1000
Message-ID: <a03681e4-70e2-c8a1-ba8a-4ab334b1f06f@vrt.com.au>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170818025659.4402-1-stuartl@vrt.com.au>
 <20170819234056.37c7d339@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170819234056.37c7d339-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maksim Salau <maksim.salau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alborchers-2TsfIrYsZRL7O9PZeWXHPg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Maksim,
On 20/08/17 06:40, Maksim Salau wrote:
>> This introduces the `uart_mode` sysfs attribute as seen in the `io_ti`
>> USB serial driver, allowing this USB serial interface to be switched
>> between RS-232, 2-wire RS-485 and 4-wire RS-485.
> 
> Recently I've discovered a blog post by Greg Kroah-Hartman on sysfs files [1].
> I believe this information will help you to create the new file in a better way.
> 
> [1] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

I'll definitely look into that… however I think the long-term plan in
this case is to expand the RS-485 IOCTL once some research is done into
what settings it should include.

I personally would like to see a sysfs interface in addition to enable
the possibility of udev rules configuring a port prior to its use,
however others have indicated that may result in a race condition.  A
dual-interface (ioctl + sysfs) would give us the best of both worlds,
and that link sounds like an ideal way of doing the sysfs part.
-- 
Stuart Longland
Systems Engineer
     _ ___
\  /|_) |                           T: +61 7 3535 9619
 \/ | \ |     38b Douglas Street    F: +61 7 3535 9699
   SYSTEMS    Milton QLD 4064       http://www.vrt.com.au
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
