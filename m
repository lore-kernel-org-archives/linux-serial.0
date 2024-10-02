Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BB19752C;
	Wed,  2 Oct 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879879; cv=none; b=BCy0zfQ/Tbsk2idyZzhv5efA41+yVcrgC7q1cTigjJKstlRMfnwJBiphMN9d9fkO1MGB+P/QjQEUdJEWUMugMbl9COEiOcXiu+U05dvZ6MBylWksonOYBeYzGDN4jWPkDxwTdIlzAOEfn+QCMODey/tXOSNdyLkMT3r1pQF5nHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879879; c=relaxed/simple;
	bh=zr80b20tpopt/aUf76z1RqYm2oRY33/ADAVSBY381vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgadC+y8R58aIT/E3WzoliZujG397TxaLcQHW+hnkTPNNO8sGY5J4RqE6jC5sZgrgmuU0BecROn7XGlfrJsyzAj6sekpTEXTjY3Agf5yWI05/d7MK51rnJW+Drc6NVElMuzacnlHBq7sDNOCeb45dGxy4kd+Z2YAM93uO0glvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=TFuaFm1P; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="TFuaFm1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727879867; x=1728484667; i=parker@finest.io;
	bh=zr80b20tpopt/aUf76z1RqYm2oRY33/ADAVSBY381vk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TFuaFm1PDiUOITcMjlNvCGrFp+GjbEKVrccJIM5UitIGBivibgtOvN5J681vDqRz
	 pAbOrpBXqdK0Ntzu2fTH/jS1ExiRfwBIW2BqC4wVK9hTnnCV8ewsGK/E1dqCKxu8W
	 V8VkcwRedxazBqMAANExcanGMNbuvhLp3AWPCHGkdyl2pRSJEhZuOhFdsg0fv+kC1
	 1FKkWYy2TfPQyPjSdQHtEIkHX/7JreG4wrlRyTPGOqoIx8KsiZMRyFBf1poqLh+58
	 P6NTtbTaGin3C4vU1Dxcv4FxKQ2A/UWkCTcfptLsPYNrRqcnlzz6gP8eJQULhouDi
	 HcXO/6KhIRMRGMXpnw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N3K18-1rx3rV2KJ8-00tce0; Wed, 02 Oct 2024 16:37:47 +0200
Date: Wed, 2 Oct 2024 10:37:45 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v3 0/5] serial: 8250_exar: Replace custom EEPROM code
 with eeprom_93cx6
Message-ID: <20241002103745.261e1922@SWDEV2.connecttech.local>
In-Reply-To: <Zv1ZOs1u1S8B6szs@smile.fi.intel.com>
References: <cover.1727873292.git.pnewman@connecttech.com>
	<Zv1ZOs1u1S8B6szs@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:8BBCdPssmoLT2mdzi93obNFfaEp14APLqXGjT5bdwWYvyCypL/b
 qUg2lEl8a0Fl/g5RbktDWwvLvHizmjcAdou5yccXgDlbqRmemLYRi5mzHDUSIj+jpe57mHR
 +Mz80jm91FLqbv3pw89zrC7hooSRpieMs3/USKWgX5sB8nlql0nNsFwtVrfEnb9bhKgLRb0
 BQYkikDfhPSC+QhT0XOLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JDX8LCtuhug=;twUH1eYOGEYyXemNF4Us5MY34+Y
 a4xzzwUVSaZNDTx5QcaFDOISYzPVGeRbao2CBKtb3cxaICaYrpe0Jteab9hBiLop71MvCUyyW
 lfkbRG85wU1GsF3d6m1VP+JbgnO/eH6E/+liS0hsAecKzCqWSkD7SvmXVJ+54jIsUM1qxFBSV
 sXpcNwmjLa18MxSBncpB7kIBarH1Xr+zn4uTtZH55m35b+cYTjmB6RioQwk6jaKGeg53GYG5Y
 dJvh2pOi+ImhXJWe3vwA1q3KDXiF8ZnX7NCXRspB11KdRFVfVGBsNVcIzrkl5zraeMOXVGTKl
 l0TiOedsclZXGaa5u8QIXkT0eCSELt1SQWHedMaF9df6QBNnKl/E9/4M4gd3XKTD9yCkSqEug
 AmAgQ42GEzX6VAecNirXWrPBkpSB/DkBPG/2UdBKEWdoyjXBPj97xxTi0i9d+UYx+YEMEYyNr
 Z/pydNhQJIEoatKarWltv+wxnLOZa/njUcvn3bx5pB4e8Pw+/oi0pyRqCotmxEkqWN6O41oqk
 tHGAWjqnfPaJF3D9AcHKJl15GIHHGiWM5Lc+A1Hh/2iM2mps0X8A5SadcBlxQOkvw5a98Xj3E
 gXvHBlciZM+PYA88j/w6JWcvrdwIYs9H3cSDFQdIZuy/01j6UGPEWd93d2vdnewwn+ru5g3tg
 F40NxrKiV1NVSX7u7URaSCOPxOyeA1VvSjgCTVf1VA3rJSR+B28Y0QIPWE+lGsoVovftT+AaS
 0ukq/5avjFcdupGWAflGBv+TFhKss/GoQ==

On Wed, 2 Oct 2024 17:31:22 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Oct 02, 2024 at 10:14:06AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > This series of patches replaces the custom 93cx6 EEPROM read functions=
 in
> > the 8250_exar driver with the eeprom_93cx6 driver. This removes duplic=
ate code
> > and improves code readability.
> >
> > In order to use the eeprom_93cx6 driver a quirk needed to be added to =
add an
> > extra clock cycle before reading from the EEPROM. This is similar to t=
he
> > quirk in the eeprom_93xx46 driver.
>
> Everything is fine except one minor (in patch 1) and one more serious
> (see patches 3 & 4) issue. I just commented on them. Fix and send a fina=
l
> v4, my tags are already there and you may keep them.
>
> Thank you!
>
Thank you, I will fix and resend.
