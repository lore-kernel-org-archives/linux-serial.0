From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sun, 24 Jan 2016 17:10:53 +0000
Message-ID: <20160124171053.5f15b92c@lxorguk.ukuu.org.uk>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
	<20160116233157.GA7774@rob-hp-laptop>
	<3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com>
	<20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
	<1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com>
	<20160117193849.69d00c28@lxorguk.ukuu.org.uk>
	<37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com>
	<20160118111926.0882b422@lxorguk.ukuu.org.uk>
	<07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com>
	<20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
	<C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com>
	<9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com>
	<20160120174610.1c64239a@lxorguk.ukuu.org.uk>
	<39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com>
	<CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5EwA@mail.gmail.com>
	<20160122201229.5df0bb2d@lxorguk.ukuu.org.uk>
	<DF404071-9FD0-4B33-B1B5-EC14192655E7@goldelico.com>
	<20160123172830.51933d2d@lxorguk.ukuu.org.uk>
	<68E21655-A8A1-431B-BBB9-3B43AFC0B03A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68E21655-A8A1-431B-BBB9-3B43AFC0B03A@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>, Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

> > but by having only the
> > minimum necessary in the kernel. Unix  
> 
> I think you are confusing it with the goals of microkernels (e.g. Mach or Hurd).

No and the quote below is from Doug McIlroy - who amongst other thing
invented pipes.

> > 
> > "We used to sit around in the Unix Room saying, 'What can we throw out?
> > Why is there this option?" - Doug McIlroy  

> Most GPS receivers I came across are modules which spit out NMEA
> records with serial 9600 bit/s. Either through RS232 or Bluetooth SPP. There
> may be others, but I don't want to have all problems of the world solved
> at once.

The kernel lives in the big world, not your personal fiefdom

*PLONK*
