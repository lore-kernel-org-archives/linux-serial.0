From: Russell Coker <russell@coker.com.au>
Subject: Re: sredird fork: sercd
Date: Mon, 2 Aug 2004 00:23:55 +1000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408020023.55246.russell@coker.com.au>
References: <Pine.LNX.4.44.0312191428390.8980-100000@maggie.lkpg.cendio.se>
Reply-To: russell@coker.com.au
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.sws.net.au ([61.95.69.6]:5025 "EHLO smtp.sws.net.au")
	by vger.kernel.org with ESMTP id S265981AbUHAOX7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Aug 2004 10:23:59 -0400
In-Reply-To: <Pine.LNX.4.44.0312191428390.8980-100000@maggie.lkpg.cendio.se>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: Peter Astrand <peter@cendio.se>
Cc: Denis Sbragion <d.sbragion@infotecna.it>, jaltman@columbia.edu, mario@viara.info, linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>

On Sat, 20 Dec 2003 00:39, Peter Astrand <peter@cendio.se> wrote:
> I've created a new project for a RFC2217 serial redirection daemon:
> "sercd" (Serial Communications Daemon). This is basically a fork of
> sredird. Compared to sredird, this project includes:

I've just had a look at the sercd project.  It seems like nothing has happened 
since December last year.  The only apparent differences between sercd.c and 
sredird.c are comments and code style.

Which is the most live of these projects?  As there have been security bugs 
reported against sredird I want to put a replacement in Debian which has the 
bugs fixed.  I would prefer to avoid any serious coding on this myself due to 
lack of time.  If one of the two projects could issue a new release to fix 
the security issues (in a separate message) then I'll put it in Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page
