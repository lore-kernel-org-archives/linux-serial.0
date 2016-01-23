From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sat, 23 Jan 2016 17:28:30 +0000
Message-ID: <20160123172830.51933d2d@lxorguk.ukuu.org.uk>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
	<744620565.20160116103445@cogentembedded.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DF404071-9FD0-4B33-B1B5-EC14192655E7-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Tomeu Vizoso <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> > There is lots of stuff we probe and bind via user space - most things
> > these days in fact. That's much of why we have notifiers and udev. It's
> > frequently a win in flexibility, security and configurability to do stuff
> > via user daemons. We do it for example with all the volume management,
> > raid and disk encryption.  
> 
> Because volumes are something users really want to configure. They
> can change their hardware configuration every now and then. And
> there are removable media to be considered.

Like USB bluetooth dongles, like systems with external SPI ports, or plug
in SPI devices, or plug in gps devices on other interfaces ?

> In our UART cases the underlaying hardware can't be reconfigured. So
> there is no need to load this burden of config to the user.

Plenty of uarts it can be or the BT can be muxed with other device
endpoints.

> For BT or GPS I just want it to work the same on all devices (independently
> on how the specific chip is connected). Kernel should unify such things.
> Or it would not be a Un(iplexed)ix.

I think you are confusing Unix and Multics.

Unix is nothing to do with Linux and Unix was about creating a beautiful
system not by having a huge crap filled kernel, but by having only the
minimum necessary in the kernel. Unix was not about what was put in but
what was left out.

"We used to sit around in the Unix Room saying, 'What can we throw out?
Why is there this option?" - Doug McIlroy

GPS is a train wreck for commonality. Most GPS requires custom binary
only user space code often obfuscated in order to meet the regulations
governing GPS technology to stop third parties using it for missile
guidance.


Alan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
