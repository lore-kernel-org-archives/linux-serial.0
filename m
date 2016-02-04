From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Data corruption on serial interface under load
Date: Thu, 4 Feb 2016 23:16:14 +0000
Message-ID: <20160204231614.GJ10826@n2100.arm.linux.org.uk>
References: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
 <56B3AF54.2050609@hurleysoftware.com>
 <CAHp75VcjxYne9WN1=j+bGHF6FdGL3tHQeq8EXoiKxmj1+fXW-A@mail.gmail.com>
 <CAHp75VfFQt3ST7DrWSuR2YmfU0xdd1p2TS7RyUD0hN1_dJ-tYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfFQt3ST7DrWSuR2YmfU0xdd1p2TS7RyUD0hN1_dJ-tYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 05, 2016 at 12:27:19AM +0200, Andy Shevchenko wrote:
> Here are the calls
> 
> ret = cfsetspeed(&new_term, opts.baudrate);
> cfmakeraw(&new_term);
> new_term.c_cflag |= CREAD;
> new_term.c_cflag &= ~CRTSCTS;

So no hardware flow control...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
