From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] [RFC] Alsa mixer over serial port
Date: Sun, 5 Jul 2009 22:55:21 +0200
Message-ID: <200907052255.22846.jkrzyszt@tis.icnet.pl>
References: <4A4CB5CF.2020703@tis.icnet.pl> <20090702133220.GA22321@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:44260 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbZGEUzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Jul 2009 16:55:49 -0400
In-Reply-To: <20090702133220.GA22321@sirena.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-serial@vger.kernel.org

Thursday 02 July 2009 15:32:21 Mark Brown napisa=C5=82(a):
> On Thu, Jul 02, 2009 at 03:27:43PM +0200, Janusz Krzysztofik wrote:
> > I can see two ways of getting this working:
> > 1) add a new line discipline that would take control over the seria=
l
> > line and convert it to an alsa mixer,
> > 2) create a low level driver that would replace standard serial stu=
ff
> > completely (like snd-serial-u16550 does, for example).
> >
> > Please advise which one is better.
>
> ASoC doesn't really care for itself - it just needs the upper layer
> interface, how exactly the driver ineteracts with the device is not
> important to ASoC.

Mark, thanks.

As there are no other votes, I choose line discipline. Generic form of=20
required userspace support is already provided with util-linux-ng and i=
t=20
seems much better to use established low level driver code than reinven=
t a=20
new one ;).

I hope there will be no problem getting a new line discipline registere=
d with=20
include/linux/tty.h, even if it turns out that the code using it is ded=
icated=20
to a specific device not found on any other board than my Amstrad E3.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
