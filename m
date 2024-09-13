Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BA82D70;
	Fri, 13 Sep 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253463; cv=none; b=PKGKDjtzcBCnrQU6gfCbEGz001lpbxz4f2YsGXsVtt6SrrzKVtWxKUllbSw0VydBOsS4cSGu/49HQQ5DPenBz2yF88+y9y8TexYIzzQr14iSRCdy03REIvX2LyNScVMNoAW+VeHdjXfDOjJr/zliC8c0FSF4ccfHYYMher7IAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253463; c=relaxed/simple;
	bh=jRSiZboWWwNqI3fzr+wltOm9Xr75AofUf2tdZLQMYlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crN4s3Ck/xJAdt1idlQBg7eadgRZ4JZXrlyOIowXJJSvv4xZOEXE7dKygJcyIlZ6u8aOHCBeHZ50t0sLYE/mvVA9JTCmwyKYKl/wxgjYwRikVdvqCdDuoviP9K5dpNOoORSBHDNcsJmSkco//uQnNERNAbU0b9rnyP4RI4rVowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=sPK0DUih; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="sPK0DUih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726253450; x=1726858250; i=parker@finest.io;
	bh=jRSiZboWWwNqI3fzr+wltOm9Xr75AofUf2tdZLQMYlE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sPK0DUihSR8Cf2cBrRE61dUxW7gt4llMizphwNThye+4f1c0l1j1k/gpz9zC6+YB
	 nUDPJS/ckvoMjra7Lxn0nI7pN0LuhOevWeeVX0b0FELWvyv02yWsjIcCgRGQ5qIU0
	 tM0NM5TwRsDPDNPNzAL6SyobDBDqOkOsfqkRZj+xh1KkXZHCGngmU+jkWb1Vb7hY5
	 SsAJm1rVXT3p8ZEpKV5/zOj58WXfBLngfVfzmzNXTonv7Xl/WVGMKPnizE5ucIZE5
	 OcWlMIEto1IA3cYO0rxToPg3hYfBVYB+glOA9nLjcQYjl8857X+eIskdKIY+cHw4+
	 S9HT7I/09XjuNCf07A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LwsP8-1rw9zd3IeO-00qnjy; Fri, 13 Sep 2024 20:50:49 +0200
Date: Fri, 13 Sep 2024 14:50:48 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v1 0/6] serial: 8250_exar: Replace custom EEPROM code
 with eeprom_93cx6
Message-ID: <20240913145048.1f5d4141@SWDEV2.connecttech.local>
In-Reply-To: <ZuR_-cV5zy1mwel3@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
	<ZuR_-cV5zy1mwel3@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:+0MUIOtggsbR/T1fH1riCcFCl9l335qeqEDC8bHXRQKvSS0kRFJ
 T0Upr61X2VG0gP35/VU+flzScSRDlgH5fwFnIolnsmmOEHyXnfdctRgbuuejHgUcJ7Plvd3
 R2AfoLYVidCwhDtDPeA7oFeUOSShBmDtgZ63yDVSjbXPGcopp8grvCFwZwZapZ8Ab1U0zyt
 RLjQYuqqA6PEAKcivUOMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BR0tYh5aNk0=;s+D2d+KBW0JEmaawC4e5OhGfwm6
 ggvrFi3P14CK4pCo0lboKRyVu7QVNM80pViyvnDZDodnZXqjIcDUiN9DnK1IJq3KhPY5RSymI
 LdvhWLfIcibk9QsvWoGAxyM++7Mdo206a3WYdozGWEznpytL1GCP6OXbZ/JHo/utwP+u4rHXH
 UUGMhC1/OyyL4/w39i08V2RWtCoSmHPNGNxBpTGRZVheVxuv0Bv7fs1yB73OH30evYc0H+3S1
 3LaofTjz8ZV+XxtogO0Q9DIITzYJJPfSraTU7xyI1hktcmtAhS82ZnsZIB4GK0aeqphcnOSNI
 SzbQ6n5iO94ndthYCcVaB/BenmTx4UjiCZIqg2CddauZ8GHDgP6pR+0+QEzhucr/hJuiYGHgM
 oqAxLhDlS2oi/ks2DlLw6FAXQaacwlEBTxZIxqCH1fZ7KBRJaPibngRusTaI+zUBn4SiHda/l
 d0q0od48/om21l7Q2O0BYa2Vor1q7lYSbkZvRKRRfFf15mjGrtUhPDLjHsqb5AN1CDaC/DqUb
 3Bq3KkABWhJ2k/uozmVBcUgi6zgSBIKVvVIbb507SwmAVbZBdubTkNEEytYbCpvq11t/dpHL7
 th+AbHXFhAO8SjXiRz6IgI8IMiM+uTgvB+/9rUfkzHup/MKJxyF14DpiJJtAD5Nqmmqs+vKwu
 apHDSrdtRKMWVX+U64kAkvslWnetdK3oUBz1ua2Qvnl2qWIonZbXUYI32idluWTgs0LO3GWtY
 YlOla8y4sFN1mQRRJ9Bcw51XhnLgOUv7g==

On Fri, 13 Sep 2024 21:10:01 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 13, 2024 at 10:55:37AM -0400, Parker Newman wrote:
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
> >
> > More details in associated patch and mailing list discussion with
> > Andy Shevchenko about these changes:
> > Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.i=
ntel.com/
>
> Thanks for the prompt update!
>
> However we are close to the merge window, I think Greg won't accept this=
 until
> v6.12-rc1 is out. So, we have a two or three weeks of time.
>
> Meanwhile I have some (small) comments, I just sent in individual replie=
s.
> Overall, LGTM.
>

Thanks for the review! I will create a v2 with your feedback some time nex=
t week.
Parker
