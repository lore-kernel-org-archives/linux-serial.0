From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Serial custom speed deprecated?
Date: Sat, 26 Aug 2006 14:16:50 +0200
Message-ID: <m3irkf66a5.fsf@defiant.localdomain>
References: <1156459387.3007.218.camel@localhost.localdomain> 	<043501c6c85a$1eb09a60$294b82ce@stuartm> 	<20060825193203.GB725@flint.arm.linux.org.uk> 	<20060825203929.GB25595@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <libc-alpha-return-19331-glibc-alpha=m.gmane.org@sourceware.org>
In-Reply-To: <20060825203929.GB25595@thunk.org> (Theodore Tso's message of "Fri, 25 Aug 2006 16:39:29 -0400")
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
To: Theodore Tso <tytso@mit.edu>
Cc: Stuart MacDonald <stuartm@connecttech.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
List-Id: linux-serial@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> What would scare me though about doing something like would be
> potential for the ABI changes.  Not only do you have to worry about a
> consistent set of ioctl's, structure definitions, and B* defines, but
> you also have to worry about userspace libraries that use B* as part
> of their interface, and expect user programs to pass B* constants to
> the userspace library.  (Say, some kind of conveience dialout library,
> for example.)

Right, there is a potential problem here. I don't know | think
if anything like that exists, though. If there is no such software
the issue can be ignored, and if something turns out then it just
have to be compiled with the same glibc headers (both parts).
That probably means even for binary software it's a non-issue.
-- 
Krzysztof Halasa
