From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Fri, 22 Mar 2013 11:11:55 +0100
Message-ID: <87boabpwus.fsf@dell.be.48ers.dk>
References: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
	<kifr4e$kc5$1@ger.gmane.org> <1363904564.4488.47.camel@thor.lan>
	<DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F537@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:52847 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633Ab3CVKMA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Mar 2013 06:12:00 -0400
Received: by mail-we0-f180.google.com with SMTP id r5so515615wey.39
        for <linux-serial@vger.kernel.org>; Fri, 22 Mar 2013 03:11:58 -0700 (PDT)
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F537@SINPRD0211MB405.apcprd02.prod.outlook.com>
	(Craig McQueen's message of "Thu, 21 Mar 2013 23:32:10 +0000")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: 'Peter Hurley' <peter@hurleysoftware.com>, Grant Edwards <grant.b.edwards@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

>>>>> "Craig" == Craig McQueen <craig.mcqueen@beamcommunications.com> writes:

Hi,

 Craig> * interceptty could be enhanced if the pseudo-tty could handle
 Craig> hardware handshaking as well as setting port speed etc.  *
 Craig> Serial-over-Ethernet (RFC-2217) client drivers could use a
 Craig> pseudo-tty to implement the virtual tty device, including
 Craig> hardware handshaking and setting port speed etc.

Indeed, getting RFC2217 stuff to work transparently without a custom
kernel driver would be very nice.

-- 
Bye, Peter Korsgaard
