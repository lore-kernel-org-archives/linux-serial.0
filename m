From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] max3100: adds console support
	for MAX3100
Date: Sun, 21 Mar 2010 09:28:48 -0700
Message-ID: <201003210928.48937.david-b@pacbell.net>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	<fa686aa41003191231w54d7489ds917c3cd2de0bea52@mail.gmail.com>
	<cabda6421003210047i1d4545aasf8969bb70d48ceb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cabda6421003210047i1d4545aasf8969bb70d48ceb9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: christian pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sunday 21 March 2010, christian pellegrin wrote:
> > Anybody know the right thing to do here?

when to register consoles is a general mess.  I've seeen some
success in having it be board-specific data, at the level of
"port 3 should be a console ... or in this case, maybe having
platform data say which chip.

After all, board docs probably assign numbers to each of the
external connetors, and say "#1 is normally the onsole" (or
maybe #0, #3, etc).


But it's still kind of chaotic trying to set things up so that
for example $3 becomes /dev/ttyS3" and so forth.  Especially if
your chip has six serial ports but several of them aren't wired
up (and so should not get published to userspace even if they do
get autodetected...  (Heck, the controller may exist, but the
unavailability may as easily be "those pins are routed to some
other peripheral" as ""those pins aren't wired up to RS232 level
shifters or a DB9/RJ45/... connector.

.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
