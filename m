From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Sat, 7 Oct 2017 08:42:56 +0200
Message-ID: <20171007064256.GA19701@kroah.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507107090-15992-2-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 04, 2017 at 10:51:29AM +0200, Frédéric Danis wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
> 
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
