Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26681A303C;
	Thu, 12 Sep 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144925; cv=none; b=UoeiuKDr75uiPzNo+Bg5lDAMAE+BUyQeSMrOZfGs40QCO3U+75IP8QQa8XZVJ++L31Vjcqcn8WG7vLhkvcFv9j9Qlx0X/ZIt1rdnxd4egwL+4PavABsb5j+GQnUKHslNdgtD2OAhfZwCR0OpI24+0ezTjDtCGXDVmlP+ulgmrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144925; c=relaxed/simple;
	bh=D1uDsvTbaqu1HrfHJ2Vd8lkZ3tUN2jkcWKugSRK1ikM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1i95HNOnam/1xjcvWbMD9lNsWAx0MP3WJ7iwXwxqnpF3pHIa9R9MP60l1QyEWJchAQ6WdF9/EgtmdhOV199FlkZANdqdMsuesVuQDrrdkHo+kO20OF7th2D39Cd0eN486FlecJxcLRpDzEClhDJFi9TLEr3HrySEB8VotER3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=ViX02ETU; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="ViX02ETU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726144909; x=1726749709; i=parker@finest.io;
	bh=fBbkcOl0VMdsHvC9YylJScXU+R8oqCgwbE9yHAKhiVg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ViX02ETUlEqaWkwtrBelv/RrhRbr3u6gqzbzSjkvAiA47eLMqOZESybaJtAt82xY
	 lZJnwjvr/jcaSmNNY2exuTS2c9SiZ1Kr/PoURyzgxrJEBBu9tTQQqUcsn0B4v0yp6
	 TOcO8BGGlRzFjs0FPsfWHh59IjQiWkj8e9bbd9nO3s+2OZMruW2ZijrT+NIXXhaim
	 eTwJq0OTpaTkGnV7zcOhhOVik2uBHP1ZGY9S5fBHtGcvaUWhNdGocFdV+giEfN7NG
	 L/xelWKpBaWfROdUcyV+M72whH8+SBJkBd5rJ4pwL6YA6KAGGibOXMXUlF68yen7O
	 wm5sgiQoTPdCb6kebw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N7yr1-1rt28E0VEJ-0101Zs; Thu, 12 Sep 2024 14:41:49 +0200
Date: Thu, 12 Sep 2024 08:41:47 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240912084147.6af5ac12@SWDEV2.connecttech.local>
In-Reply-To: <ZuICvRjM4TqozL_X@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
	<20240503143303.15bf82bc@SWDEV2.connecttech.local>
	<Ztr5u2wEt8VF1IdI@black.fi.intel.com>
	<20240906095141.021318c8@SWDEV2.connecttech.local>
	<ZtsQrFgH86AkKgPp@smile.fi.intel.com>
	<20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
	<ZtsU0nfAFssevmmz@smile.fi.intel.com>
	<20240906143851.21c97ef9@SWDEV2.connecttech.local>
	<Zt7IonZIYgBqjvy7@smile.fi.intel.com>
	<20240911133848.2cbb1834@SWDEV2.connecttech.local>
	<ZuICvRjM4TqozL_X@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:O+X3c3mUes4o50eMtLFzGJcNgPinrqwicO1KsP1DsYP7OAXJFJe
 yuUrkhKnyXT04BLbLcJ0GICS+5l28ougLK+V9G0TU9irUUZw8M/qqHuuSSmPdXEdSEJY2YL
 eLYE1ywhySMob0F6+I4FZaEu6eXsbS6X/rVv6U9tR0bbT0EpEL/2vPvaC8AX5I8rUEipk+M
 EexBiJ8kkGIuLCnPE6dlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aShr8j0d03k=;U/gcWrVSCjzHlunSSPJlLx9pW1b
 XZQb6+jgZGUy8q3XH13HUhK9sY6CvwfTNGYUsntqys2PIYrZoMkxaL8QyUpy5bJYUesprdiWw
 QnT50ASSmE5KknylEIUTOkRzBPlh8CD8xQvXxj4xyiuIfzY/t6qwDfIUrrDOucA/a0s+wax8q
 sDZLSqsZuzBq4Pabzw694CLZS9nopBfiJ4neLbMMZmypL5PKeUQwWmw49qAs/Tn6UyoTBgrVA
 YEqdTG7aY6Hx+htCJNZo8x9J8n5sb9jDCdpidYWG8isZpQ31JzdAQfIRMCBa/5J3JP09l/XXo
 4fxP4Ql6zeZSlopqFp4QvwwFDPq92OuUK+95kRYnxbizpuQQygY7HMfdxINCBc9A4FSDOTj+m
 26PUNsSfSpWAWa+v6fshjeQ63HKeQER3/B2qH1dY59K3IYEtNYIXkS6Z1QXlrngf54BAmJQT1
 FLVJ5llOAPRGRbDFY7pSun0MroFGH613Pzi1J3t2ZZhxO1k4wFKwB7tEdY9R+3Y7CN71VZWc7
 Xe0hzXTTFEXHp5cOZ65cGJ9UnTqLm8TqQ+MhUji0uGfvhKERMp90uU2ZdZAONvD+uS/6oEkLu
 nqLZ2foK+uom4A2/LNuUYmYBRS45keLimyTjyJAlWrTEMtMP/57ZfZz6Ug99WeCtI46a4MROL
 pzewSC6KL7X8XJehYGxlQkoX3t7ymZhScc9+PRDynUCpYGCk0z2U6keFEeMtas5rQdhDFwbJS
 tGc6PrSFQ+kdFqxeUOiAHK+rDfS60+tEA==

On Wed, 11 Sep 2024 23:51:09 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Sep 11, 2024 at 01:38:48PM -0400, Parker Newman wrote:
> > On Mon, 9 Sep 2024 13:06:26 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 06, 2024 at 02:38:51PM -0400, Parker Newman wrote:
> > > > On Fri, 6 Sep 2024 17:42:26 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> > > > > > On Fri, 6 Sep 2024 17:24:44 +0300
> > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrot=
e:
> > > > > > > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman =
wrote:
>
> ...
>
> > > > > > > > > Sorry for blast from the past, but I have some instersti=
ng information
> > > > > > > > > for you. We now have spi-gpio and 93c46 eeprom drivers a=
vailable to be
> > > > > > > > > used from others via software nodes, can you consider up=
dating your code
> > > > > > > > > to replace custom bitbanging along with r/w ops by the i=
nstantiating the
> > > > > > > > > respective drivers?
> > > > > > > >
> > > > > > > > Hi Andy,
> > > > > > > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM=
.
> > > > > > > > They have a dedicated "EEPROM interface" which is accessed=
 by the
> > > > > > > > REGB (0x8E) register. It is a very simple bit-bang interfa=
ce though,
> > > > > > > > one bit per signal.
> > > > > > > >
> > > > > > > > I guess in theory I could either add  GPIO wrapper to togg=
le these bits
> > > > > > > > and use the spi-gpio driver but I am not sure if that real=
ly improves things?
> > > > > > > > Maybe using the spi-bitbang driver directly is more approp=
riate?
> > > > > > > > What do you think?
> > > > > > >
> > > > > > > Yes, spi-bitbang seems better in this case.
> > > > > >
> > > > > > I will try to make some time to implement this... Or if someon=
e else from the
> > > > > > community wants to take this on in the mean time I am certainl=
y happy to test
> > > > > > and help out!
> > > > >
> > > > > Sure, I shared this thought due to having lack of time to look m=
yself,
> > > > > but I prepared the above mentioned drivers to make them work in =
this case.
> > > > > (If you are curios, see the Git history for the last few release=
s with
> > > > >  --author=3D"Andy Shevchenko")
> > > > >
> > > >
> > > > Looking into it a bit more I think we could just use the eeprom_93=
cx6
> > > > driver without any SPI layer. Just need to add simple register_rea=
d()
> > > > and register_write() functions to read/write the REB register.
> > > >
> > > > That should be a pretty easy change to make, I can try to make tha=
t
> > > > change soon unless anyone has any objections to that method?
> > >
> > > Thank you, this is pretty wonderful news!
> > >
> >
> > I have this mostly working however there is one issue. The eeprom_93cx=
6
> > driver doesn't seem to discard the "dummy bit" the 93C46 EEPROM output=
s
> > between the writing of the op-code/address to the EEPROM and the readi=
ng
> > of the data from the EEPROM.
> >
> > More info can be found on page 6 of the AT93C46 datasheet. I see simil=
ar
> > notes in other 93C46/93C56/93C66 datasheets.
> > Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEP=
ROM-AT93C46D-Datasheet.pdf
> >
> > In summary the read operation for the AT93C46 EEPROM is:
> > Write to EEPROM :	110[A5-A0]	(9 bits)
> > Read from EEPROM: 	0[D15-D0]	(17 bits)
> >
> > Where 110 is the READ OpCode, [A5-A0] is the address to read from,
> > 0 is a "dummy bit" and then [D15-D0] is the actual data.
> >
> > I am seeing the "correct" values being read from the EEPROM when using=
 the
> > eeprom_93cx6 driver but they are all shifted right by one because the
> > dummy 0 bit is not being discarded.
> >
> > The confusing part is the eeprom_93cx6 driver has behaved the same sin=
ce
> > at least 2009 and half a dozen or so other drivers use it. I am not su=
re
> > if they just work around and/or live with this bug or if they have
> > different HW that handles the extra dummy bit?
>
> I briefly looked at a few users and it seems to me:
> 1) either the Atmel chip has different HW protocol;
> 2) or all of them handle that in HW transparently to SW.

The 3 Exar cards I have handy actually use the ST M93C46 version but looki=
ng
through our BOMs I see AT/CAT/ST used on various cards over the years.

Looking at the READ timing diagrams in the Atmel and ST datasheets it look=
s
like the dummy bit should actually be clocked out on the last address bit
clock cycle. If this were so it would be ignored naturally.

This may just be a quirk of the Exar HW. All Exar code I have looked at
manually discards the dummy bit.

> > I am hesitant to "fix" the eeprom_93cx6 driver and potentially break t=
he
> > other users of it. I could add a flag to the eeprom_93cx6 struct to wo=
rk
> > around this issue... Unless anyone else has some ideas or input?
>
> In my opinion the 93c46 needs an additional configuration setting (in th=
e
> respective data structure) and some code to implement what you need here=
.

I see the eeprom_93xx46 driver has the QUIRK_EXTRA_READ_CYCLE quirk to sol=
ve
this issue. I could add something similar.

> But yes, let's wait a bit for other opinions...
>

