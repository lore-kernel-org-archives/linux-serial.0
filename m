From: Thomas J Pinkl <tom@hbsrx.com>
Subject: Re: sredird fork: sercd
Date: Wed, 4 Aug 2004 11:07:55 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040804110755.A17278@shire.hbsrx.com>
References: <Pine.LNX.4.44.0408011907440.14207-100000@maggie.lkpg.cendio.se> <410D27A7.9080704@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from firewall.hbsrx.com ([207.87.39.194]:24558 "EHLO shire.hbsrx.com")
	by vger.kernel.org with ESMTP id S266304AbUHDPIG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Aug 2004 11:08:06 -0400
Content-Disposition: inline
In-Reply-To: <410D27A7.9080704@columbia.edu>; from jaltman@columbia.edu on Sun, Aug 01, 2004 at 10:25:59AM -0700
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>, Peter Astrand <peter@cendio.se>
Cc: linux-serial@vger.kernel.org

>>Jeffrey Altman wrote:
>>>A much better implementation of Telnet CPC, "telnetcpcd", was put
>>>together by Thomas Pinkl <tom@hbsrx.com>. He has open sourced it and the
>>>code quality is quite high.  

> Peter Astrand wrote:
>>What does "better" mean? This software looks much younger than
>>sredird/sercd, which probably means more bugs. I cannot find a home page,
>>CVS repository, mailing list, freshmeat entry or documentation. The build
>>system is not Autoconfized. The tarball unpacks all the files in the
>>current directory...
>>
>>Tell me, in what way was sredird so fundamentally broken that a complete
>>rewrite was necessary?
>>
>>Now we have *four* Open Source RFC2217 servers for UNIX...

On Sun, Aug 01, 2004 at 10:25:59AM -0700, Jeffrey Altman wrote:
> Actually, telnetcpcd is not young.  It is much more robust and just as 
> old as sredird.
> It was only recently open sourced due to the sluggishness of corporate 
> lawyers.  My hope
> is to one day find the time to implement TELNET START-TLS and TELNET AUTH
> for telnetcpcd.   My time is rather restricted these days.

sredird does pre-date my telnetcpcd.  At the time that I needed an 
RFC2217 server, in October 2001, just after C-Kermit 8.x was released 
with RFC2217 client support, I searched the net for open source 
projects and found only sredird (version 1.1.8 of November 9, 2000).

Unfortuneately, sredird 1.1.8 had some bugs that prevented it from 
working with C-Kermit.  It also had some design limitations, such as 
supporting one modem per server/port, that I couldn't live with.

Jeff quickly fixed the bugs in sredird.  But I had already decided 
to write my own server.  By February 2002, I had a version working 
(mostly) in-house.  By December 2002, nearly all of the wrinkles had 
been ironed out of C-Kermit and telnetcpcd.  In August 2003, I 
received offical permission from HBS management to release telnetcpcd 
under an open source license.

For the past 30 months or so, telnetcpcd has been managing a pool of 
48 modems here at HBS.  The modem pool sits on an old Pentium II 
400MHz box running Red Hat Linux 6.1.  The modems are attached to 3 
Digi Xem devices.  We're using C-Kermit 8.0.207 as the client.  This 
combination has been very stable.

I've registered telnetcpcd as a project at Sourceforge, but there's 
nothing there right now, except for a description.  I've also obtained 
a port assignment for "Telnet Com Port Control" from IANA, port 3696.

Unfortunately I haven't had time to work on telnetcpcd during the past 
year.  I expect that to change, soon.  One of the things on the TODO 
list is to autoconf-ize the build process.  Pointers to a resource 
that could help with that process would be most welcome.

Peter, you mention that there are 4 open source RFC2217 servers for 
UNIX.  I know of sredird and telnetcpcd.  Can you tell me about sercd
and the fourth one?

Why was sredird forked to create sercd?

-- 
Thomas J. Pinkl                         738 Louis Drive
Unix Systems Programmer                 Warminster, Pa 18974
Health Business Systems, Inc.           (215) 442-9300 x9260
