From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 20:32:03 +0100
Message-ID: <20060825193203.GB725@flint.arm.linux.org.uk>
References: <1156459387.3007.218.camel@localhost.localdomain> <043501c6c85a$1eb09a60$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <libc-alpha-return-19326-glibc-alpha=m.gmane.org@sourceware.org>
Content-Disposition: inline
In-Reply-To: <043501c6c85a$1eb09a60$294b82ce@stuartm>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, 'Krzysztof Halasa' <khc@pm.waw.pl>, linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 25, 2006 at 11:21:21AM -0400, Stuart MacDonald wrote:
> From: On Behalf Of Alan Cox
> > We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW 
> > which used
> > different B* values so B9600 was 9600 etc and the data was stored in
> 
> I think if a numeric baud rate is going to be supported, getting away
> from the B* cruft is important. Just use a number.

The "B* cruft" is part of POSIX so needs to be retained.  These are
used in conjunction with with cfgetispeed(), cfgetospeed(), cfsetispeed()
and cfsetospeed() to alter the baud rate settings in the termios
structure in an implementation defined manner.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
