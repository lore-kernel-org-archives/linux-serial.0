From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:21:21 -0400
Message-ID: <043501c6c85a$1eb09a60$294b82ce@stuartm>
References: <1156459387.3007.218.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; 	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-19325-glibc-alpha=m.gmane.org@sourceware.org>
In-Reply-To: <1156459387.3007.218.camel@localhost.localdomain>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, 'Krzysztof Halasa' <khc@pm.waw.pl>
Cc: linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
List-Id: linux-serial@vger.kernel.org

From: On Behalf Of Alan Cox
> We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW 
> which used
> different B* values so B9600 was 9600 etc and the data was stored in

I think if a numeric baud rate is going to be supported, getting away
from the B* cruft is important. Just use a number.

> Or we could just add a standardised extra set of speed 
> ioctls, but then
> we need to decide what occurs if I set the speed and then issue a
> termios call - does it override or not.

I'd say yes.

..Stu
