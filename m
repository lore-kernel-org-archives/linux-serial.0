From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] serdev: bus-code clean ups
Date: Tue, 9 Jan 2018 16:48:36 +0100
Message-ID: <20180109154836.GB10213@kroah.com>
References: <20180108124233.26729-1-johan@kernel.org>
 <20180108135014.GA27201@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108135014.GA27201@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 08, 2018 at 02:50:14PM +0100, Johan Hovold wrote:
> On Mon, Jan 08, 2018 at 01:42:31PM +0100, Johan Hovold wrote:
> > As noted by Hans, we currently fail to generate uevents for ACPI serdev
> > controller as they do not have any ACPI companions from which ACPI
> > modaliases are constructed.
> > 
> > In fact, we should not have been generating modaliases for controllers
> > in the first place as controllers are not bound to drivers.
> > 
> > This series applies on top of Hans's minimal fix which suppresses the
> > uevent errors for ACPI controllers (even though it could replace it
> > entirely if preferred).
> 
> I somehow forgot to CC Hans. Sorry about that. This series can be found
> here:
> 
> 	https://lkml.kernel.org/r/20180108124233.26729-1-johan@kernel.org

Minor issue found with patch 1, can you fix that up and resend and cc:
him this time?  :)

thanks,

greg k-h
