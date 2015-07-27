From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Mon, 27 Jul 2015 12:00:55 +0200
Message-ID: <20150727100055.19696.qmail@stuge.se>
References: <55AC1883.4050605@svenbrauch.de> <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de> <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de> <55AED708.903@hurleysoftware.com> <55AEE805.9050204@svenbrauch.de> <55B01554.90201@hurleysoftware.com> <55B01EDE.3050503@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B01EDE.3050503@svenbrauch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Brauch <mail@svenbrauch.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Oliver Neukum <oneukum@suse.com>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Sven Brauch wrote:
> I don't make any other changes to the default settings. To be honest,
> I'm not sure in which mode it is operating then (I was assuming raw, but
> I might be wrong?).

You should explicitly set a mode if you need a particular mode,
otherwise the port might be in another mode. This sets raw. Add
error checking.

struct termios t;

tcgetattr(fd, &t);
cfmakeraw(&t);
cfsetspeed(&t, B115200);
tcsetattr(fd, 0, &t);


//Peter
