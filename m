From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 1/5] platform-drivers-x86: add support for Technologic
 Systems TS-5xxx detection
Date: Tue, 3 May 2011 10:39:19 +0100
Message-ID: <20110503103919.5b0daa5e@lxorguk.ukuu.org.uk>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com>
	<20110429233230.GB24864@kroah.com>
	<1304368433-sup-4264@sfl>
	<20110502215535.GA30373@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110502215535.GA30373@kroah.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>
List-Id: linux-serial@vger.kernel.org

> > I had a look at other drivers, and /sys/devices/platform/ts/ seems to be
> > a good place to hold those entries (one per options as you suggested).
> > Do you agree with that?
> 
> No, this is not a platform device, is it?  Only platform devices go
> there, and I really doubt you have many of them for this board.

It seems analogous to some of the laptop helpers so I don't think it is
that unreasonable to make the board config a platform device of its own -
we don't really have a general solution to the board as a device, so if
you look at equivalents on laptops and the like we have assorted platform
control interfaces that are platform devices.

Alan
