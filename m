From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Serial custom speed deprecated?
Date: Thu, 24 Aug 2006 23:43:07 +0100
Message-ID: <1156459387.3007.218.camel@localhost.localdomain>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm> 	 <1156411101.3012.15.camel@pmac.infradead.org> 	 <m3bqqap09a.fsf@defiant.localdomain> 	 <1156441293.3007.184.camel@localhost.localdomain> 	 <m31wr6otlr.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-19322-glibc-alpha=m.gmane.org@sourceware.org>
In-Reply-To: <m31wr6otlr.fsf@defiant.localdomain>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
List-Id: linux-serial@vger.kernel.org

Ar Iau, 2006-08-24 am 20:51 +0200, ysgrifennodd Krzysztof Halasa:
> Hmm... I'm not sure if I understand this correctly. Can't we just
> create the 3 new ioctls in the kernel and teach glibc to use it?

We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW which used
different B* values so B9600 was 9600 etc and the data was stored in
c_ospeed/c_ispeed type separate fields and we'd support arbitary speeds
for input and output once and for all, shoot all the multiplier hacks
etc. As it happens the kernel code for this is easy owing to some
fortuitous good design long ago in the tty layer.

We could also implement a Linux "improved" TCSET* new set of ioctls that
had sensible speed fields, utf-8 characters for the _cc[] array and new
flags for all the utf-8 handling and the like. That would be less
compatible though.

Or we could just add a standardised extra set of speed ioctls, but then
we need to decide what occurs if I set the speed and then issue a
termios call - does it override or not.

> The old ioctls would be optional in the kernel (and perhaps in glibc,
> sometime).

The kernel side translation is thankfully really trivial.

> Not sure if we want int, uint, or long long for speed values :-)

You want speed_t according to POSIX.

I've no idea what the glibc impact of this kind of thing would be
(consider new glibc, old kernel etc).  I've cc'd the libc folks but I am
not sure it is practical to do.

Alan
