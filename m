From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch 1/6]drivers/usb/serial/ftdi_sio.c: Basic icount
 infrastructure for ftdi_sio
Date: Tue, 18 Oct 2011 13:44:12 -0700
Message-ID: <20111018204412.GA10910@kroah.com>
References: <20115.3608.745590.271161@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20115.3608.745590.271161-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 10, 2011 at 05:24:08PM +0200, Uwe Bonnes wrote:
> 
> -- 
> Uwe Bonnes                bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org
> 
> Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
> --------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
> >From ea100c30d21374caa4fef77d78272497751703ce Mon Sep 17 00:00:00 2001
> From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
> Date: Sun, 9 Oct 2011 16:48:51 +0200
> Subject: Basic icount infrastructure for ftdi_sio

Why did you send these patches this way?  I'll fix these up this time,
but note that I have to edit every one of your patches, which is a pain.
Please just use git send-email next time.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
