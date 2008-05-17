From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: 2.6.25.3: serial problem (minicom)
Date: Sat, 17 May 2008 13:29:31 +0100 (BST)
Message-ID: <762763.57234.qm@web52903.mail.re2.yahoo.com>
References: <20080516123321.5674952c@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web52903.mail.re2.yahoo.com ([206.190.49.13]:31439 "HELO
	web52903.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753157AbYEQM3g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 May 2008 08:29:36 -0400
In-Reply-To: <20080516123321.5674952c@osprey.hogchain.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

--- Jay Cliburn <jacliburn@bellsouth.net> wrote:
> Serial console using minicom works fine for me under 2.6.25 and
> 2.6.25.4.  Keystrokes are accepted normally.

I have just replicated this problem between two Fedora 8 boxes; minicom reads the remote serial
console fine, provided it is running on a 2.6.24.x kernel. (The serial console is from a 2.6.25.4
machine.)

My serial console is defined using the kernel parameters "console=ttyS0,115200n8", and my minicom
session as:

pr port             /dev/ttyS1
pu baudrate         115200
pu bits             8
pu parity           N
pu stopbits         1
#pu minit            ^M

Cheers,
Chris



      __________________________________________________________
Sent from Yahoo! Mail.
A Smarter Email http://uk.docs.yahoo.com/nowyoucan.html
