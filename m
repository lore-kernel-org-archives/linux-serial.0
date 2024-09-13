Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1412D1EA;
	Fri, 13 Sep 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251873; cv=none; b=ojN+ljRURm0UNoY7J0gYLbMzZhOie9F9GtA10Jzqlxem7tBky8RPuymD0adkrNBVpLdXMGiiBekhvlhjzkeigiAKgQF50rTk1Mh4FUy57dQxesruEvdGnXRMERKppK8k4PjOP9gNAUE7hvXvNAZMn8kigNhEjiYj3tiqRkz0ldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251873; c=relaxed/simple;
	bh=Z+w+8oycgqaK4tqY4poB5CUC/js9DJbBU8KFfLHiDu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8MrfnCf2NBNUWi0lirh4bXJg0fG1+MzJH1o5GvbMZY3h4X2AvlKunffYxegy0jO2ggGT/tEuGaMX6Gm/UK6RcnuqFj50KIo2/nXoYLHMAosokQKygaaWp67xe2Zz8yqZCV1m97Dunjv6dLIMd2glahZa80MHNL1o5oMTuFPjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=mkPMN57z; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="mkPMN57z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726251862; x=1726856662; i=parker@finest.io;
	bh=xCQB6HrOuc6yoWPGEb2hOmynqm1KeHWsyghC2ukGrsg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mkPMN57zuAxUqAhVgikuCtlDmM2Li/kLUkg3RtAPrUsmlrlc4cJHdE7A6gfyxPkU
	 noegdJY1RA0OzAmB3W8u5CERQ0HsgeR1JG4OEUiH0yIJlNxXCi9b2UUS7ymrWMn6K
	 7QqmSlViVbGWRpRaa4F2/4LxBpbdLaONE4dnA+rXfXQiVHVBI5Fyvh4RVcRZORLbD
	 btEMXT7/NnqgoeZXfkDk0rJMsT74ZT+HJgbkQXyjXTYuurE8FiHSjq2/WqUMBJmb+
	 PCBxYsFDCqAHr8Qeo1l+DvkXuwbqe4thd+qADFYz1AIcdIDvUz1hp3gNk3grlzVOT
	 P55K6Yne7yvvKEvViA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LbL7E-1s9pgC1zFS-00eEx3; Fri, 13 Sep 2024 20:24:22 +0200
Date: Fri, 13 Sep 2024 14:24:20 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/6] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <20240913142420.675faf80@SWDEV2.connecttech.local>
In-Reply-To: <ZuR600QgWi6oQcau@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
	<d0818651c4a58d0162a898c3ba3dd8abf9f95272.1726237379.git.pnewman@connecttech.com>
	<ZuR600QgWi6oQcau@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:nti8a+qShA6s3dzsfN5LJNKhmfK/6pa57HifSQI7Y1SckL14RrB
 P52RyZhd9xTTPuT0y0yPzY0y5qOHIJkA5B9ILT5IWmYMM6KiFPATkIP0LTiG3P1V6c0WHvv
 PgIQ15al+LTQLKP4PREfKQafq3NbATvfqik7FtZjHUuWyoLSgKvYDOhqcIcfu/75YXqpakH
 fLqZUrlWwSkTQSLSwLipg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wx8JGLuwzm0=;nGZr5lOM9+rDnItSmVHzBsjg9OP
 LEdcdR9I//n3CzmISOFSrHjg+XfGu7SmOD1jBLKnIWReiv3Mkw3E9M5HhiSVldJq6+e+/s6eq
 GJKUdADiIoxHK1712JThiEvr9Hb12XDJfCZQKjrx5F7F9OTQMmcRVfDA9XO6YeosrZiZ7Tl/U
 5ewQofKb3XvRfarXWMwvt3lbfpz1jRUR9O7UVdVpeaKILgoIt3tAijBYgjgdcrneNDJMkt2gI
 jGImg/0Kdz59ARsEgGDwCTBradXJcsYwHEUwAdvFCliKcOIiYXznidiGJF2Y5jWQz9zXOxiaP
 olf+/InzTO883HWG6APk9LO676u6Kbiaj1w81azc4Jd9GCzTlN3wF0/NP/Y/64K965DkLArx+
 J88ZacAdmGWgKZsDck+b7EIWvEYaIX+2ZjWlhdUvblhJQkLFT+7oCthm9d+eQjtdJ0/TuFO+2
 +jjv6Ei3IugFepdVUnyaADpLDkhqyrUFeGHBy9iP7QeN4diFLNlMJ5BhRr80COHawuqFq2gXu
 4ww5f90YO4QdjM4F3abSJSa1l56GLY3Iu58tkvc4h7M1dzNar+WWQRkj2pE8PE4GePY6niknl
 6oab4sFT8t00yz2RpwB/NUA9mx8Ewcf+ffEm9Dh3m01NE6WYN9Eo7Eyj62j+Y73NfSC1O7O9y
 LyKey0zHLPll9djSMHzolC4SzQkN4Q1ep6ZmQVrfcBMuZu61wWZsJKwReGv+lagSRmav2RqBN
 xs310bNbQaXhK0mHhBjZTiuPtYz94vmuQ==

On Fri, 13 Sep 2024 20:48:03 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 13, 2024 at 10:55:38AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
> > cycle before reading data from the EEPROM.
> >
> > The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
> > of the op-code/address from the host to the EEPROM and the reading of
> > the actual data from the EEPROM.
> >
> > More info can be found on page 6 of the AT93C46 datasheet. Similar not=
es
> > are found in other 93xx6 datasheets.
>
> > Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEP=
ROM-AT93C46D-Datasheet.pdf
>
> Make it a tag (i.e. locate just above your SoB tag)
>

Sorry, not 100% sure what you mean by tag? Do I just need to move the Link=
: entry
to be above my Sign-off? Or is there something else? Thanks!

> > In summary the read operation for a 93Cx6 EEPROM is:
> > Write to EEPROM :	110[A5-A0]	(9 bits)
>
> > Read from EEPROM: 	0[D15-D0]	(17 bits)
>
> The mixed TABs/space here (one extra space after :)
>
> > Where:
> >  	110 is the start bit and READ OpCode
> > 	[A5-A0] is the address to read from
> > 	0 is a "dummy bit" preceding the actual data
> > 	[D15-D0] is the actual data.
>
> Also leading spaces, please remove them and use TAB, or use spaces only.
>

Ugh, copy/paste is hard! I will fix :).

> > Looking at the READ timing diagrams in the 93Cx6 datasheets the dummy
> > bit should be clocked out on the last address bit clock cycle meaning =
it
> > should be discarded naturally.
> >
> > However, depending on the hardware configuration sometimes this dummy
> > bit is not discarded. This is the case with Exar PCI UARTs which requi=
re
> > an extra clock cycle between sending the address and reading the data.
>
> ...
>
> > +static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *ee=
prom)
> > +{
> > +	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
> > +}
>
> So, this makes sense to be in a header since everything else related to =
that
> also in the header already.

Makes sense, will do.

> ...
>
> > +	if (has_quirk_extra_read_cycle(eeprom)) {
> > +		eeprom_93cx6_pulse_high(eeprom);
>
> No additional delay is needed?
>

Should not need any extra delay as both pulse high/low functions have the =
worst case
450ns delay after the register write. It was working well on my test cards=
.

> > +		eeprom_93cx6_pulse_low(eeprom);
> > +	}
>
> > +	if (has_quirk_extra_read_cycle(eeprom)) {
> > +		eeprom_93cx6_pulse_high(eeprom);
>
> Ditto.
>
> > +		eeprom_93cx6_pulse_low(eeprom);
> > +	}
>
> ...
>
> > +/* Some EEPROMs require an extra clock cycle before reading */
> > +#define PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE	BIT(0)
>
> I would move it directly into the structure definitions, just after quir=
k
> field (the same way it's done in the other driver)...
>

Will do, thanks!

> ...
>
> >  	int width;
> > +	unsigned int quirks;
>
> ...somewhere here.
>
> >  	char drive_data;
> >  	char reg_data_in;
>

