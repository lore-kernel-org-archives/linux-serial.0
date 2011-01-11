From: Greg KH <greg@kroah.com>
Subject: Re: Mainpine IQ Express Rev3 problems beginning 2.6.36
Date: Tue, 11 Jan 2011 15:03:27 -0800
Message-ID: <20110111230327.GA2268@kroah.com>
References: <4D001AF1.80902@mainpine.com>
 <20101209064259.GA10714@kroah.com>
 <9BEA64D1D71A4BCFA22E0ECE7A4B3A01@callisto>
 <20101212165201.GB14184@kroah.com>
 <E2D1FFBE046E485284F82CC8135FD901@callisto>
 <64E919E148714BFCB46D62A05E9EF13D@callisto>
 <20110111000231.GA30424@kroah.com>
 <687E92CB36AA40FC9ABC8B0E23843D36@callisto>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:40589 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab1AKXDg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jan 2011 18:03:36 -0500
Content-Disposition: inline
In-Reply-To: <687E92CB36AA40FC9ABC8B0E23843D36@callisto>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <lee.howard@mainpine.com>
Cc: linux-serial@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2011 at 11:16:06AM -0800, Lee Howard wrote:
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com] 
> > Sent: Monday, January 10, 2011 4:03 PM
> > To: Lee Howard
> > Cc: linux-serial@vger.kernel.org
> > Subject: Re: Mainpine IQ Express Rev3 problems beginning 2.6.36
> > 
> > On Fri, Dec 17, 2010 at 05:25:19AM -0800, Lee Howard wrote:
> > > > -----Original Message-----
> > > > From: linux-serial-owner@vger.kernel.org
> > > > [mailto:linux-serial-owner@vger.kernel.org] On Behalf Of 
> > Lee Howard
> > > > Sent: Tuesday, December 14, 2010 11:50 AM
> > > > To: 'Greg KH'
> > > > Cc: linux-serial@vger.kernel.org
> > > > Subject: RE: Mainpine IQ Express Rev3 problems beginning 2.6.36
> > > > 
> > > > > -----Original Message-----
> > > > > From: Greg KH [mailto:greg@kroah.com]
> > > > > Sent: Sunday, December 12, 2010 8:52 AM
> > > > 
> > > > > As for build issues, try to make a minimal working 
> > config for your 
> > > > > system, using 'make localmodconfig'.  That will speed up your 
> > > > > build time immensely as well as reduce your chances of 
> > build and 
> > > > > runtime problems with the intermediate kernels.
> > > > 
> > > > Thank-you, that did help immensely.
> > > > 
> > > > Here's the 'git bisect' result...
> > > > 
> > > > --------------
> > > > 7a56aa45982bb87bfca98a2832b5ae782c03364a is the first bad commit 
> > > > commit 7a56aa45982bb87bfca98a2832b5ae782c03364a
> > > > Author: Yegor Yefremov <yegor_sub1@visionsystems.de>
> > > > Date:   Wed Jun 16 16:29:55 2010 +0200
> > > > 
> > > >     serial: add UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950 
> > > > UARTs definition
> > > >     
> > > >     Adding UART_CAP_EFR and UART_CAP_SLEEP flags will 
> > enable sleep 
> > > > mode
> > > >     and automatic CTS flow control for 16C950 UARTs. It will also 
> > > > avoid
> > > >     capabilities detection warning like this:
> > > >     
> > > >     "ttyS0: detected caps 00000700 should be 00000100"
> > > >     
> > > >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > > 
> > > > :040000 040000 1776ca8d5c653834363c0778b5b404ee52bd2d69
> > > > b81cfe4f302a674935181bd248641873820517e5 M      drivers
> > > > --------------
> > > > 
> > > > Indeed, if I remove the UART_CAP_EFR flag from later kernel 
> > > > revisions there is no problem.
> > > 
> > > Greg,
> > > 
> > > What's to be done?
> > 
> > Sorry for the delay, I think Pavel's posted patch will solve 
> > this issue for you, right?
> 
> I've looked in the linux-serial archives for posts by Pavel for the last
> month, but I don't see a patch.  Please tell me where I can find this patch.

I've attached it below.

thanks,

greg k-h

--3V7upXqbjpZ4EhLz
Content-Type: text/x-pascal; charset=us-ascii
Content-Disposition: attachment; filename=p

>From pavel@ucw.cz Sat Jan  8 23:38:58 2011
Return-Path: <pavel@ucw.cz>
X-OfflineIMAP-873005426-6772656752656d6f7465-746f646f: 1294595209-0154868123845-v6.2.0
Delivered-To: unknown
Received: from imap.suse.de ([unix socket])
	 by imap-int (Cyrus v2.2.12) with LMTPA;
	 Sun, 09 Jan 2011 08:38:58 +0100
X-Sieve: CMU Sieve 2.2
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by imap.suse.de (Postfix) with ESMTPS id 7CCF63C539A9
	for <gregkh@imap.suse.de>; Sun,  9 Jan 2011 08:38:58 +0100 (CET)
Received: by relay1.suse.de (Postfix)
	id 6E027344BA65; Sun,  9 Jan 2011 08:38:58 +0100 (CET)
Received: from relay1.suse.de (localhost [127.0.0.1])
	by relay1.suse.de (Postfix) with ESMTP id 644B9344BA64
	for <gregkh@suse.de>; Sun,  9 Jan 2011 08:38:58 +0100 (CET)
Received: from relay1.suse.de ([127.0.0.1])
 by relay1.suse.de (relay1.suse.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 01359-10 for <gregkh@suse.de>;
 Sun,  9 Jan 2011 08:38:58 +0100 (CET)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by relay1.suse.de (Postfix) with ESMTP id 18EB4344BA61
	for <gregkh@suse.de>; Sun,  9 Jan 2011 08:38:58 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by mx2.suse.de (Postfix) with ESMTP id 0F1ED4844E
	for <gregkh@suse.de>; Sun,  9 Jan 2011 08:38:57 +0100 (CET)
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 7B4B8F01C3; Sun,  9 Jan 2011 08:38:57 +0100 (CET)
Date: Sun, 9 Jan 2011 08:38:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	stable-review@kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Subject: unbreak billionton CF card (was Re: [000/152] 2.6.36.3-stable
 review)
Message-ID: <20110109073848.GA1553@ucw.cz>
References: <20110106002500.GA3172@kroah.com>
 <20110106134254.68fa27ac@lxorguk.ukuu.org.uk>
 <20110106215705.GA30799@suse.de>
 <20110107150724.GA29082@atrey.karlin.mff.cuni.cz>
 <20110107183716.GA14895@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110107183716.GA14895@suse.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by amavisd-new at relay1.suse.de
X-Spam-Status: No, score=-3.599 tagged_above=-20 required=5
 tests=[BAYES_00=-2.599, MY_LINUX=-1]
X-Spam-Score: -3.599
X-Spam-Level: 
Status: RO
Content-Length: 1129

Unbreak Billionton CF bluetooth card. This actually fixes a regression
on zaurus.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

> > Flow control flag seems to be responsible.
> > 
> > But... it hits me and then... me. So I'd like to see it resolved in
> > devel tree, but it may not 100% vital for stable.
> 
> Ok, care to make up a patch I can apply for Linus's tree first that
> works for you?

./drivers/serial - ./drivers/serial.ofic
diff -X /usr/src/linux/.gitignore -ur ./drivers/serial.ofic/8250.c ./drivers/serial/8250.c
--- ./drivers/serial.ofic/8250.c	2011-01-02 21:25:29.000000000 +0100
+++ ./drivers/serial/8250.c	2011-01-09 08:10:39.000000000 +0100
@@ -236,7 +236,8 @@
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
+		/* UART_CAP_EFR breaks billionon CF bluetooth card. */
+		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
 	},
 	[PORT_16654] = {
 		.name		= "ST16654",

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


--3V7upXqbjpZ4EhLz--
