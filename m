From: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 5/5] HACK: serial: move pl011 initcall to device_initcall
Date: Tue, 8 Sep 2015 17:55:24 +0100
Message-ID: <20150908165524.GO10728@bivouac.eciton.net>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-6-git-send-email-leif.lindholm@linaro.org>
 <20150908125608.GD20562@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150908125608.GD20562@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 08, 2015 at 01:56:08PM +0100, Mark Rutland wrote:
> On Tue, Sep 08, 2015 at 01:43:37PM +0100, Leif Lindholm wrote:
> > ---
> >  drivers/tty/serial/amba-pl011.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 452dbba..31cf985 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2806,7 +2806,7 @@ static void __exit pl011_exit(void)
> >   * While this can be a module, if builtin it's most likely the console
> >   * So let's leave module_exit but move module_init to an earlier place
> >   */
> > -arch_initcall(pl011_init);
> > +device_initcall(pl011_init);
> >  module_exit(pl011_exit);
> 
> What's the ordering constraint that you're trying to solve with this?

Basically that _CRS is not available until the ACPI subsystem is up -
so when uart_add_one_port() calls acpi_console_check(), that function
looks for a match against variables that have not been set yet.

> The cover didn't mention anything, and there's no commit message.

That's because I really don't want it committed :)
 
> Mark.
> 
> >  
> >  MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
> > -- 
> > 2.1.4
> > 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
