Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183361B3F20;
	Wed, 11 Sep 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076355; cv=none; b=n+t5dajZZOFvF40rZb0lZD8BBaNArHu/bQWlZOI+tR5FfFqKODeGHiwKq8ELpN7O7mIAtMEVkS4jcKuhebCBEx4R3GAYJrD780AykKJGqUPx0UO7oQsBikxVNrttA16FbuQkXFMwy3r2N/IdDIT2Wg+/8EYBE17+vYt1ORKcK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076355; c=relaxed/simple;
	bh=Scii2Yzkx59cHnmvGP/H9UyzpKy5qG1xLT5aa12Bj4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDYuujU5PWrV75cmL83ksVrnqJKNVQBenjkJtJuG+NNd9dX3YJO1rdMEX8/WGJ3kRRFIWcNsvYgmFulLIdz9HmH9tbJEPvgdEgZZkD20GWS47MQqFylHXyM4u2EOjOJOaYmpHcekXBeo0sxZbxBrDzTiy/RNe2UOvlINIHdzjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=g3KE8wEe; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="g3KE8wEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726076331; x=1726681131; i=parker@finest.io;
	bh=JAqi3FAEelUovWOJbiJfCJ5PxAvtAyLyW/hgk034KZ0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g3KE8wEeWxBisDPEX690zEbYZz87BGrCGHXyPGcuD2LcVmcOddUoIRygfr4eVkvV
	 TXWT5bZPS1QkyeZQM4N0VYNzZ0A7evGnBJT236IsbyyYLHk1Px4+1lIWYD1PFZ8V0
	 ulv8Jzn24IutJ/FUk/onruDTslw2klMPo+lIxvT7z0mcG3as9FpSIZhQU0LO77Axv
	 Z90rrDHaUzvKYcw3Qwsf/B9gzooWXHF2hc58jU3CxJyJ1+BOIGk5atvcF26mN++YK
	 XoCjtD0mY7fx74tt7dkFhYMczOgeeW9YFs/le0p+S/ZMkxn5CG3fCHRdu77plqjp8
	 9itAazs090jxeaNHvA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MBEUl-1sgUfu14fl-008DER; Wed, 11 Sep 2024 19:38:51 +0200
Date: Wed, 11 Sep 2024 13:38:48 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240911133848.2cbb1834@SWDEV2.connecttech.local>
In-Reply-To: <Zt7IonZIYgBqjvy7@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
	<20240503143303.15bf82bc@SWDEV2.connecttech.local>
	<Ztr5u2wEt8VF1IdI@black.fi.intel.com>
	<20240906095141.021318c8@SWDEV2.connecttech.local>
	<ZtsQrFgH86AkKgPp@smile.fi.intel.com>
	<20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
	<ZtsU0nfAFssevmmz@smile.fi.intel.com>
	<20240906143851.21c97ef9@SWDEV2.connecttech.local>
	<Zt7IonZIYgBqjvy7@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U6SRYEOUmb/3u1J0Ceq63VSbOIo5wZzwJIxBSMRwfxKl2mFaaTv
 zMyd7kORUmgQRwhF09fP3lzh7VuGnlVR0alZ7m0nvnQbvhK88ZMxYZN5mlNFufS5AqeTSh/
 QzJor/Pb/n3LtElG85mUX5ORa0nFyaHQRR43a63yfVaHtMJFUmCcH4B8hG58PF/h0hRTDjz
 4nz/lL3GgHx1jOmk3SAHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1MzBG57hndE=;JTQUd8g0VFi5bY/wzB8aPru5QLB
 xR1e30FlvbHNOSvNPwU1IzA8TMUeKQ+DkRH2/jjiIC6lMnI/5i3y6HSQv7f53WoQmoQK2fLxo
 jlGj0kcndifT2L/4XZCf9dp9yaRa2piIu3KoncDdHgZg2skiX7PKfEseEUHgfu3BEV+sDouGw
 biqmFnHBJlw1j7K7lotGMSzz457HOHx1euXLIwWBnfx0OXc47SaRlXagGZrh6wqluvqq+4WXM
 9RAms4EYAWD5LHDEFZI2Qm3ARiesrR5/iYwngIQX6dfmt6SeLSSz0ZtbeATUiiGLT/1SXDAph
 euLlNB2bKodylnZqlBv5Lt6PDS2eu8SFLdMIcIyYOKEbx95zHdZwdn/Ja/cpbVq/c07+ywGIS
 pQLuaRFYfe9dPM4wHk5ah4uAKlxVKKTv3kgY0HvxQ+oT1CCEty9SfbrTlPkLsSrwPnZ4SgCt/
 U6opYx+1qgqO6Cu2QWqz6kb+JeaT8Myduw5hvnHwiODUZ3fdAXmdXPQSmug0Uh8/cYIdJ4wRk
 hflHFuGBo869Uo/hTso8aV6bteNBbhCvGE/eep8o7ylN1g0UjabzxqmtEfZfujwqW7S028KCo
 WD/WS2sCUq3a/AOYMwrGS/sNsPRCXKtqQ2js4Bv8tozYuwhyF8WErPGnshr/GTeoEpvZ9pWfy
 3Jpg7JigLVJ8OZXRbq24To03gohaDb8FnJpsq3FcfI2KNpFbPS5ymVNvQ8AloYyTWR+WR6OaW
 2s2taSaIsbpme4ePuQwG8m/e6GS/xNebQ==

On Mon, 9 Sep 2024 13:06:26 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 06, 2024 at 02:38:51PM -0400, Parker Newman wrote:
> > On Fri, 6 Sep 2024 17:42:26 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> > > > On Fri, 6 Sep 2024 17:24:44 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > > > > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrot=
e:
>
> ...
>
> > > > > > > Sorry for blast from the past, but I have some instersting i=
nformation
> > > > > > > for you. We now have spi-gpio and 93c46 eeprom drivers avail=
able to be
> > > > > > > used from others via software nodes, can you consider updati=
ng your code
> > > > > > > to replace custom bitbanging along with r/w ops by the insta=
ntiating the
> > > > > > > respective drivers?
> > > > > >
> > > > > > Hi Andy,
> > > > > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > > > > > They have a dedicated "EEPROM interface" which is accessed by =
the
> > > > > > REGB (0x8E) register. It is a very simple bit-bang interface t=
hough,
> > > > > > one bit per signal.
> > > > > >
> > > > > > I guess in theory I could either add  GPIO wrapper to toggle t=
hese bits
> > > > > > and use the spi-gpio driver but I am not sure if that really i=
mproves things?
> > > > > > Maybe using the spi-bitbang driver directly is more appropriat=
e?
> > > > > > What do you think?
> > > > >
> > > > > Yes, spi-bitbang seems better in this case.
> > > >
> > > > I will try to make some time to implement this... Or if someone el=
se from the
> > > > community wants to take this on in the mean time I am certainly ha=
ppy to test
> > > > and help out!
> > >
> > > Sure, I shared this thought due to having lack of time to look mysel=
f,
> > > but I prepared the above mentioned drivers to make them work in this=
 case.
> > > (If you are curios, see the Git history for the last few releases wi=
th
> > >  --author=3D"Andy Shevchenko")
> > >
> >
> > Looking into it a bit more I think we could just use the eeprom_93cx6
> > driver without any SPI layer. Just need to add simple register_read()
> > and register_write() functions to read/write the REB register.
> >
> > That should be a pretty easy change to make, I can try to make that
> > change soon unless anyone has any objections to that method?
>
> Thank you, this is pretty wonderful news!
>

I have this mostly working however there is one issue. The eeprom_93cx6
driver doesn't seem to discard the "dummy bit" the 93C46 EEPROM outputs
between the writing of the op-code/address to the EEPROM and the reading
of the data from the EEPROM.

More info can be found on page 6 of the AT93C46 datasheet. I see similar
notes in other 93C46/93C56/93C66 datasheets.
Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-=
AT93C46D-Datasheet.pdf

In summary the read operation for the AT93C46 EEPROM is:
Write to EEPROM :	110[A5-A0]	(9 bits)
Read from EEPROM: 	0[D15-D0]	(17 bits)

Where 110 is the READ OpCode, [A5-A0] is the address to read from,
0 is a "dummy bit" and then [D15-D0] is the actual data.

I am seeing the "correct" values being read from the EEPROM when using the
eeprom_93cx6 driver but they are all shifted right by one because the
dummy 0 bit is not being discarded.

The confusing part is the eeprom_93cx6 driver has behaved the same since
at least 2009 and half a dozen or so other drivers use it. I am not sure
if they just work around and/or live with this bug or if they have
different HW that handles the extra dummy bit?

I am hesitant to "fix" the eeprom_93cx6 driver and potentially break the
other users of it. I could add a flag to the eeprom_93cx6 struct to work
around this issue... Unless anyone else has some ideas or input?

Thanks,
Parker


