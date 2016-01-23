From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sat, 23 Jan 2016 23:04:09 +0100
Message-ID: <68E21655-A8A1-431B-BBB9-3B43AFC0B03A@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop> <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk> <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk> <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <20160118111926.0882b422@lxorguk.ukuu.org.uk> <07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com> <20160118220319.051c9cc0@lxorguk.ukuu.org.uk> <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com> <9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com> <20160120174610.1c64239a@lxorguk.ukuu.org.uk> <39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com> <CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5E
 wA@mail.gmail.com> <20160122201229.5df0bb2d@lxorguk.ukuu.org.uk> <DF404071-9FD0-4B33-B1B5-EC14192655E7@goldelico.com> <20160123172830.51933d2d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160123172830.51933d2d@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>, Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org


Am 23.01.2016 um 18:28 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:

>>> There is lots of stuff we probe and bind via user space - most things
>>> these days in fact. That's much of why we have notifiers and udev. It's
>>> frequently a win in flexibility, security and configurability to do stuff
>>> via user daemons. We do it for example with all the volume management,
>>> raid and disk encryption.  
>> 
>> Because volumes are something users really want to configure. They
>> can change their hardware configuration every now and then. And
>> there are removable media to be considered.
> 
> Like USB bluetooth dongles, like systems with external SPI ports, or plug
> in SPI devices, or plug in gps devices on other interfaces ?
> 
>> In our UART cases the underlaying hardware can't be reconfigured. So
>> there is no need to load this burden of config to the user.
> 
> Plenty of uarts it can be or the BT can be muxed with other device
> endpoints.

Please give examples where the user can configure such a chip that is
soldered on the same PCB as the SoC.

> 
>> For BT or GPS I just want it to work the same on all devices (independently
>> on how the specific chip is connected). Kernel should unify such things.
>> Or it would not be a Un(iplexed)ix.
> 
> I think you are confusing Unix and Multics.

No, If I write Unix I mean Unix. The "Un" stands for "Uniplexed" which is
a pun of course. But it alludes to "Unification" giving the impression of
"Simplification".

> 
> Unix is nothing to do with Linux and Unix was about creating a beautiful
> system not by having a huge crap filled kernel,

and no crap filled user space.

> but by having only the
> minimum necessary in the kernel. Unix

I think you are confusing it with the goals of microkernels (e.g. Mach or Hurd).

> was not about what was put in but
> what was left out.

Exactly. It left out complexity. E.g. everything is a file. You can use devices
like files. Just open some /dev/tty and get GPS NMEA records...

> 
> "We used to sit around in the Unix Room saying, 'What can we throw out?
> Why is there this option?" - Doug McIlroy

Fine. Let's throw out the idea to configure power on/off a GPS or BT device
by user space daemons for hard wired chips.

> 
> GPS is a train wreck for commonality. Most GPS requires custom binary
> only user space code often obfuscated in order to meet the regulations
> governing GPS technology to stop third parties using it for missile
> guidance.

Most GPS receivers I came across are modules which spit out NMEA
records with serial 9600 bit/s. Either through RS232 or Bluetooth SPP. There
may be others, but I don't want to have all problems of the world solved
at once.

-- hns
