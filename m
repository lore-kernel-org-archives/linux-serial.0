From: Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Sat, 7 Oct 2017 08:42:34 +0200
Message-ID: <20171007064234.GB19450@kroah.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com>
 <BF8AC3FB-72FE-41C3-BE8D-27A32B84F6CB@holtmann.org>
 <CAJZ5v0gLhnisMn9o00ndnB6fjHt5V7KCy_57UScF=ZfZVF=dxA@mail.gmail.com>
 <E5446B94-9914-44B5-A734-050F7457746D@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E5446B94-9914-44B5-A734-050F7457746D-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Oct 07, 2017 at 02:31:05AM +0200, Marcel Holtmann wrote:
> Hi Rafael,
> 
> >>>> This patch allows SerDev module to manage serial devices declared as
> >>>> attached to an UART in ACPI table.
> >>>> 
> >>>> acpi_serdev_add_device() callback will only take into account entries
> >>>> without enumerated flag set. This flags is set for all entries during
> >>>> ACPI scan, except for SPI and I2C serial devices, and for UART with
> >>>> 2nd patch in the series.
> >>>> 
> >>>> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>> ---
> >>>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
> >>>> 1 file changed, 94 insertions(+), 5 deletions(-)
> >>> 
> >>> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> 
> >> so how do we get these changes upstream? If the serdev changes alone do not cause any harm, I am almost proposing taking them through bluetooth-next tree and only leave only the ACPI change to the ACPI maintainers.
> > 
> > That would be fine by me.  I can take the serdev patch too, though.
> 
> having both patches go via ACPI tree might be simplest. Greg, any objections from you?

None from me, let me go ack the serdev patch...

thanks,

greg k-h
