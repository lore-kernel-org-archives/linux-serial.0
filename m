From: Thomas J Pinkl <tom@hbsrx.com>
Subject: Re: sredird fork: sercd
Date: Wed, 4 Aug 2004 14:02:25 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040804140225.A6598@shire.hbsrx.com>
References: <20040804110755.A17278@shire.hbsrx.com> <Pine.LNX.4.44.0408041809001.6038-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from firewall.hbsrx.com ([207.87.39.194]:51182 "EHLO shire.hbsrx.com")
	by vger.kernel.org with ESMTP id S267366AbUHDSC3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Aug 2004 14:02:29 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408041809001.6038-100000@maggie.lkpg.cendio.se>; from peter@cendio.se on Wed, Aug 04, 2004 at 06:17:11PM +0200
List-Id: linux-serial@vger.kernel.org
To: Peter Astrand <peter@cendio.se>
Cc: Jeffrey Altman <jaltman@columbia.edu>, linux-serial@vger.kernel.org

> On Wed, Aug 04, 2004, Thomas J Pinkl wrote:
>> Unfortuneately, sredird 1.1.8 had some bugs that prevented it from 
>> working with C-Kermit.  It also had some design limitations, such as 
>> supporting one modem per server/port, that I couldn't live with.

On Wed, Aug 04, 2004 at 06:17:11PM +0200, Peter Astrand wrote:
> This sounds interesting. How is it possible to support multiple modems? Is 
> this supported per-se in RFC2217?

I can't think of anything in RFC2217 that dictates how many modems 
a server can support.  It is my understanding that Cisco access 
servers, for example, provide a pool of modems behind a single 
TCP/IP server port.  Note, however, that I've never seen or used a 
Cisco access server.  :-)

At any rate, that is the model that I implemented in telnetcpcd: a 
single TCP/IP listener that fork()'s a child process to handle the 
client.  The child process allocates a modem from the pool by 
selecting one at random and trying to UUCP lock it.  It repeats that
process until it either locks a modem or determines that there is 
no modem available.

>> year.  I expect that to change, soon.  One of the things on the TODO 
>> list is to autoconf-ize the build process.  Pointers to a resource 
>> that could help with that process would be most welcome.

> seul.org/docs/autotut is recommended in ESRs TAOUP, but there are many 
> more. 

Thanks for the pointer.

>> Peter, you mention that there are 4 open source RFC2217 servers for 
>> UNIX.  I know of sredird and telnetcpcd.  Can you tell me about sercd
>> and the fourth one?

> When thinking about it, there are at least five:
> 
> 1. sredird
> 2. msredird
> 3. telnetcpcd
> 4. ser2net
> 5. sercd

>> Why was sredird forked to create sercd?

> I've explained this recently on this list: Is there an archive somewhere, 
> perhaps? 

By "this list" I assume that you're referring to linux-serial.  I 
wasn't aware of the list's existence until now.  I'll look for the 
list archives.  Thank you.

-- 
Thomas J. Pinkl                         738 Louis Drive
Unix Systems Programmer                 Warminster, Pa 18974
Health Business Systems, Inc.           (215) 442-9300 x9260
