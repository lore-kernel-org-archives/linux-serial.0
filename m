From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] serdev: ttyport: add missing open() error handling
Date: Wed, 18 Oct 2017 09:01:57 +0200
Message-ID: <20171018070157.GC5638@localhost>
References: <20171016130620.5404-1-johan@kernel.org>
 <20171016130620.5404-2-johan@kernel.org>
 <CAL_JsqKe_yLODOuUXaivFC3VMoy9EmgUhb+3LRmw5C3DvtdVKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKe_yLODOuUXaivFC3VMoy9EmgUhb+3LRmw5C3DvtdVKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 17, 2017 at 11:08:53AM -0500, Rob Herring wrote:
> On Mon, Oct 16, 2017 at 8:06 AM, Johan Hovold <johan@kernel.org> wrote:
> > Add missing error handling for tty-driver open() which may fail (e.g. if
> > resource allocation fails or if a port is being disconnected).
> >
> > Note that close() must be called also in case of failed open() and that
> > the operation sanity check is amended to catch buggy drivers.
> 
> That's a very odd pattern. Wouldn't a must_check annotation be enough?

An odd pattern indeed, but that's how the TTY drivers are implemented
and the interface documented (i.e. that close() will be called also
after failed open()).

Not sure how a must_check could help here. 

Johan
