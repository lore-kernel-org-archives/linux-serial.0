From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serdev: ttyport: enforce tty-driver open()
 requirement
Date: Fri, 20 Oct 2017 14:21:44 +0200
Message-ID: <20171020122144.GA30326@kroah.com>
References: <20171016130620.5404-1-johan@kernel.org>
 <CAL_JsqKhCue-vMzM2ip3NoGTKb9T_EexG3G2-SekfVZOTKdHOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKhCue-vMzM2ip3NoGTKb9T_EexG3G2-SekfVZOTKdHOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 17, 2017 at 11:07:20AM -0500, Rob Herring wrote:
> On Mon, Oct 16, 2017 at 8:06 AM, Johan Hovold <johan@kernel.org> wrote:
> > The tty-driver open routine is mandatory, but the serdev
> > tty-port-controller implementation did not treat it as such and would
> > instead fall back to calling tty_port_open() directly.
> 
> The idea was to eventually get rid of the tty_struct dependency and
> only depend on tty_port. That's very invasive though and needs various
> pieces of tty_struct to move into tty_port.
> 
> Of course, tty_port_open itself would have to change as well, so this
> change doesn't really matter.

So are you acking these patches?

confused,

greg k-h
