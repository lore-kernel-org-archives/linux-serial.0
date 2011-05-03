From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [lm-sensors] [RFC 5/5] hwmon: add support for Technologic
 Systems TS-5500 A-D converter
Date: Tue, 3 May 2011 10:33:06 -0700
Message-ID: <1304443986.31666.359.camel@groeck-laptop>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <1304115712-5299-6-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <20110430033938.GA14397@ericsson.com>  <1304434162-sup-3877@sfl>
Reply-To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1304434162-sup-3877@sfl>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonas Fonseca <jonas.fonseca-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>, "platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2011-05-03 at 11:55 -0400, Vivien Didelot wrote:
> Hi Guenter,
> 
> Excerpts from Guenter Roeck's message of 2011-04-29 23:39:38 -0400:
> > Hi Vivien,
> > 
> > The headline and file name are a bit misleading, since the driver is really
> > for MAX197 on a TS-5500 board.
> > 
> > You should split the driver into two parts, a generic driver
> > for the MAX197 and a platform driver (residing somewhere in arch/
> > or possibly drivers/platform/) to instantiate it.
> > 
> > There should be a platform data include file, probably in
> > include/linux/platform_data/.
> > 
> > .ioaddr in platform data should not be necessary. The driver's probe
> > function should get the values using platform_get_resource().
> > 
> > Having said that, from reading the code it looks like the chip is not really
> > used for hardware monitoring, but for generic ADC functionality. A quick look
> > into the TS-5500 user manual confirms this. So this should not be a hwmon
> > driver in the first place, but a generic ADC driver. Given the ADC conversion rate
> > of the MAX197, the hwmon ABI is not optimal anyway. You should move this driver
> > into the iio subsystem, probably to drivers/staging/iio/adc. Copying the iio
> > mailing list for input.
> > 
> > Thanks,
> > Guenter
> 
> I've took a closer look to the manual and that's right, in fact the
> driver doesn't talk to the MAX197 directly. The board uses a CPLD to
> abstract the interface to the MAX197. So all the MAX197 logic is hidden
> by the CPLD.  Therefore, the driver files should probably not have
> function and structure names with a "max197_" prefix. I'll make the code
> a bit clearer. What do you think?
> 
The original driver for the chip on http://mcrapet.free.fr/ has a
platform dependent and a platform independent part. Other than coding
style issues, that approach seems to be cleaner to me.

Thanks,
Guenter
