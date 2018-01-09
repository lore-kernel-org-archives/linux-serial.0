From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] serdev: do not generate modaliases for controllers
Date: Tue, 9 Jan 2018 16:56:02 +0100
Message-ID: <20180109155602.GU11344@localhost>
References: <20180108124233.26729-1-johan@kernel.org>
 <20180108124233.26729-2-johan@kernel.org>
 <20180109154803.GA10213@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109154803.GA10213@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 09, 2018 at 04:48:03PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 08, 2018 at 01:42:32PM +0100, Johan Hovold wrote:
> > Serdev controllers are not bound to any drivers and it therefore makes
> > no sense to generate modaliases for them.
> > 
> > This has already been fixed separately for ACPI controllers for which
> > uevent errors were also being logged during probe due to the missing
> > ACPI companions (from which ACPI modaliases are generated).
> > 
> > This patch moves the modalias handling from the bus type to the client
> > device type. Specifically, this means that only serdev devices (a.k.a.
> > clients or slaves) will have have MODALIAS fields in their uevent
> > environments and corresponding modalias sysfs attributes.
> > 
> > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/tty/serdev/core.c | 72 ++++++++++++++++++++++-------------------------
> >  1 file changed, 34 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 5dc88f61f506..61c85e49e178 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -19,6 +19,38 @@
> >  static bool is_registered;
> >  static DEFINE_IDA(ctrl_ida);
> >  
> > +static ssize_t modalias_show(struct device *dev,
> > +			     struct device_attribute *attr, char *buf)
> > +{
> > +	int len;
> > +
> > +	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> > +	if (len != -ENODEV)
> > +		return len;
> > +
> > +	return of_device_modalias(dev, buf, PAGE_SIZE);
> > +}
> > +DEVICE_ATTR_RO(modalias);
> 
> static?
> 
> Sorry, minor nit :(

Heh, no worries. I didn't notice that as I was just moving code around
here, but I'll make sure to add that missing static in a v2.

Thanks,
Johan
