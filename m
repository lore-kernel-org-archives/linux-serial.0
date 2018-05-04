From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: serial: custom baud rate
Date: Fri, 4 May 2018 09:59:04 -0400
Message-ID: <20180504135904.GJ29205@thunk.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
 <20180503175401.GD29205@thunk.org>
 <CAHhAz+iiv+h+RAPXACQuJRiEQmE1jxeS7+qaz-8fu30Fm9tNaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+iiv+h+RAPXACQuJRiEQmE1jxeS7+qaz-8fu30Fm9tNaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, May 04, 2018 at 02:34:51PM +0530, Muni Sekhar wrote:
> > See the setserial man page:t
> >
> >         https://linux.die.net/man/8/setserial
> >
> > Not all serial devices support the spd_cust and divisor, however.  In
> > general, only devices where the kernel directly programs the
> > 8250/16450/16550 UART directly will support this feature.
> >
> So custom baud's can be set via TIOCSSERIAL IOCtl in kernel mode?

ioctl's are in general designed for use in userspace.  So are the
termios interface.

					- Ted
