From: David Lawyer <dave@lafn.org>
Subject: Re: Maintainer needed for Serial-Programming-HOWTO
Date: Sat, 29 Mar 2003 13:53:50 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030329215350.GC780@lafn.org>
References: <1779CCD227485B49A825718AAAA90E3E744879@tpsmail01.turbopower.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from davespc1 (mail@host-66-81-198-91.rev.o1.com [66.81.198.91])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h2TM2Vu7096855
	for <linux-serial@vger.kernel.org>; Sat, 29 Mar 2003 14:02:32 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by davespc1 with local (Exim 3.36 #1 (Debian))
	id 18zOGt-0000Eh-00
	for <linux-serial@vger.kernel.org>; Sat, 29 Mar 2003 13:53:51 -0800
Content-Disposition: inline
In-Reply-To: <1779CCD227485B49A825718AAAA90E3E744879@tpsmail01.turbopower.net>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Fri, Mar 28, 2003 at 04:00:38PM -0700, Gary Frerking wrote:
> >> However, I never saw the new 1999-stuff from Vern.
> 
> The useful and/or unique info from Vern (stuff that is tough to find
> elsewhere) is in a series of separate files called "blurbs". These
> should really be merged in as well.

No.  Vern wrote Serial-Programming-HOWTO which is not one of his blurbs.
I looked at his blurbs years ago and made sure that the most important
info in them was also in Serial-HOWTO (not to be confused
with Serial-Programming-HOWTO).  Note that Vern labeled it HOWTO-serial
in his index.  It has two parts, the first of which is the
Serial-Programming-HOWTO with the second part being a rewrite of the
termios man page.  I suggested that he submit the man page to the
appropriate man page maintainer and not to LDP.  Don't know if he did.

See Serial Suite ftp://scicom.alphacdc.com/pub/linux.  "HOWTO-serial" is
about programming the serial port and is much different than
"Serial-HOWTO".

> These blurbs, however, are somewhat unstructured/unorganized and would
> require a good bit of messaging to properly work them into the HOWTO.
> They also have no licensing information, which is why I tried to contact
> Vern to obtain permission to merge them into the HOWTO as appropriate.
> 
			David Lawyer
