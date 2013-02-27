From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v3 1/3] serial: sh-sci: Add OF support
Date: Wed, 27 Feb 2013 17:19:55 +0900
Message-ID: <20130227081954.GA30395@linux-sh.org>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <20130227080742.GB21690@linux-sh.org>
 <CANqRtoSDqm1VMZxxuPgnpNScfSVsozeS=_m0-1t6Z1w0vny7FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:45619 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab3B0IUA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Feb 2013 03:20:00 -0500
Content-Disposition: inline
In-Reply-To: <CANqRtoSDqm1VMZxxuPgnpNScfSVsozeS=_m0-1t6Z1w0vny7FA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Feb 27, 2013 at 05:11:34PM +0900, Magnus Damm wrote:
> On Wed, Feb 27, 2013 at 5:07 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, Feb 26, 2013 at 11:03:26AM -0600, Bastian Hecht wrote:
> >> We add the capabilty to probe Renesas SCI devices using Device Tree setup.
> >>
> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >> ---
> >> v3:
> >> - add remaining register layouts to bindings
> >> - remove register set mapping sci_regtype_modes[]
> >> - adapt renesas,regtype probing
> >>
> >> - add enums SCBRR_ALGO_INVALID and SCBRR_NR_ALGOS
> >> - check renesas,scbrr-algo-id boundaries using new enums
> >>
> >>  .../bindings/tty/serial/renesas,sci-serial.txt     |   53 ++++++++
> >>  drivers/tty/serial/sh-sci.c                        |  126 +++++++++++++++++++-
> >>  include/linux/serial_sci.h                         |    4 +
> >>  3 files changed, 179 insertions(+), 4 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> >>
> > Looks good to me.
> >
> > Reviewed-by: Paul Mundt <lethal@linux-sh.org>
> 
> Thanks. Do you intend to merge this yourself at some point, or do you
> have some other preferred way to deal with this?
> 
I can merge it if you like, but then obviously the ARM patches will have
to wait until that part is upstream. I assumed you would want them all
grouped together, at which point I don't mind if it goes through some
other tree.
