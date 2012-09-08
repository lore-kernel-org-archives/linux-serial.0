From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug in USB FTDI SIO driver
Date: Sat, 8 Sep 2012 18:30:15 +0100
Message-ID: <20120908183015.2ca02043@pyramind.ukuu.org.uk>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
	<20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
	<20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49721 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2IHRZY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 13:25:24 -0400
In-Reply-To: <20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: peter.sheeren@axiris.be
Cc: linux-serial@vger.kernel.org

> The existence of /dev/ttyUSB0 depends on the system:
> * RPi with Raspbian: /dev/ttyUSB0 never goes away after step 4.
> * RPi with Debian6, BBXM: /dev/ttyUSB0 goes away after step 4 and  
> comes back after step 6.

Thats dependant upon your user space and really nothing to do with this

> Are there any commands I can run to provide you with more information?

As I said...

> > If you think that if check is the problem can you replace it with an
> > unconditional call to change_speed(tty, port) and the re-test. That will
> > confirm if it is the cause.

Alan
