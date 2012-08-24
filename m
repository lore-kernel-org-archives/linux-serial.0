From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Added a CONFIG_TTY option to allow removal of TTY
Date: Fri, 24 Aug 2012 18:12:21 +0100
Message-ID: <20120824181221.5ed4511c@pyramind.ukuu.org.uk>
References: <1345499431-21658-1-git-send-email-jmillenbach@gmail.com>
	<20120821142047.777e4bb0@pyramind.ukuu.org.uk>
	<CADwDc1AvCvWbj8znN-1WbkZA9WYVAqaTkxi7+ENZfJ-qFNRAvw@mail.gmail.com>
	<CADwDc1BgCM9AA4T3mUxfOGNaNoYwERP-x4y2ZS4mAhfF-K_qzA@mail.gmail.com>
	<20120824141537.63274081@pyramind.ukuu.org.uk>
	<20120824170342.GA9794@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60340 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab2HXRHk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Aug 2012 13:07:40 -0400
In-Reply-To: <20120824170342.GA9794@jtriplet-mobl1>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Joe Millenbach <jmillenbach@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, team-fjord@googlegroups.com


> > The true cause I think is that serio/serport.c should depend on tty to be
> > built but the ps/2 mouse bits shouldn't.
> 
> On the other hand, most people disabling CONFIG_TTY will be building an
> extreme embedded system, and on such a system a PS/2 mouse seems highly
> unlikely.  Given that, perhaps the goal of removing dependencies on TTY
> could happen incrementally once CONFIG_TTY exists?

Fine by me
