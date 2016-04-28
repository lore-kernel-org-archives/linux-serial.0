From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH 0/8] Replace kernel-defined ASYNC_ bits
Date: Thu, 28 Apr 2016 15:44:15 -0500
Message-ID: <20160428204415.GA21183@grante>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
 <20160428203643.GA13542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160428203643.GA13542@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 28, 2016 at 01:36:43PM -0700, Greg Kroah-Hartman wrote:
> On Sat, Apr 09, 2016 at 05:53:19PM -0700, Peter Hurley wrote:
> > As outlined in my January email ("RFC: out-of-tree tty driver breakage"),
> > the tty/serial core uses 5 bits in the tty_port.flags field to manage
> > state. They are:
[...]
> > The last patch of the series purposefully breaks out-of-tree driver
> > builds to ensure they update state test/change methods to the helpers
> > instead.
> > 
> > REQUIRES: "tty: Replace TTY_IO_ERROR bit tests with tty_io_error()"
> >           "tty: Replace TTY_THROTTLED bit tests with tty_throttled()"
> 
> Wonderful, thanks for doing this work.

And particular thanks from us out-of-tree driver maintainers for
making the breakage apparent.  It always sucks when a change goes in
under our radar that causes breakage without even causing a compiler
warning.  [Yea, I know if the drivers were in-tree, this wouldn't be a
problem.]

-- 
Grant
