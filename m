Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1071E521;
	Fri, 20 Sep 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844640; cv=none; b=bdtie4aqx1LtkQjdcD5LYaH3kbp1iJ3OmG8UeFTuQqEOHnigQnfRO20TgvYdXxR33XduD+RPBW3LCQ4jhXgyZwcDltxC21XHZkzSzBh0FQI3GJZCHZGmDL2DgJzwNvhcJ9L4k8udVhTWJo/AyHDeSqg+P6isvfRmw62VphB1CF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844640; c=relaxed/simple;
	bh=X9esZzGOTeQF3OB43MS7uS6NdgofMUQTaJ3qZMAytUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP9JasFwFdDMOWCS6wMXA8ZcoyOuwZva/jXok1nYuaKhc/uHNkBzyL/RHqjb2xx8iIKT5FiboiS0P5ncVDpBwJ4FFF7pHy7ilxKZGnUWAQ9bbUHIi25Hwnci0sKS5CwUqTqoZm+0DCC5UGzO+Zthf61qNe+4gPq//p1ESTY32u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=KSPtWyPX; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="KSPtWyPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726844627; x=1727449427; i=parker@finest.io;
	bh=BiGXGzW7sTDkHBHRU98fhBYgG2xqKnyjbSiNuAi7zBs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KSPtWyPXrhKC5q5NGqGa+2IvDAWnwaRXSXdCvL0QsTruhmrP76qCgYkJVT60pyA7
	 LsKyTufc16WZAbcWakH+q3jTOBLxEQ0Uc1tahYIyyaLZ+9tajLl3Qp0nW+L3GmZLw
	 Y2SJkAMdvVqjp6RqUM57kzupQEXMFjyq6ZOAf5N4g8diSn08tDS4Y0T2v0Jx7cU1E
	 0PCmD6RCGsyhNoLRwd82pgsIWaZYGrUoXosp26aXpM5f2eS42Q2MlOa+q1KR0eqBV
	 ZeNrBdhSElVvBpXGMl61p2CuD18wWpCoo5CPi1ZIDXN+H/Eq/0vK0I+1ZxDtpjkw6
	 PGSBFoScWOHr8xczKg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MY95y-1sVmhn1nZw-00KC5q; Fri, 20 Sep 2024 17:03:47 +0200
Date: Fri, 20 Sep 2024 11:03:33 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v2 1/4] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <20240920110333.290caae6@SWDEV2.connecttech.local>
In-Reply-To: <Zu2Ke5ttvrqXICDB@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
	<b92bd58e016a14ae95e259ffbdcfc5e5da6a7aca.1726838531.git.pnewman@connecttech.com>
	<Zu2Ke5ttvrqXICDB@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PBiEFXUH4mF/+GdY+ewzpPsIUKL+hnfiHok9vbItpDYl4pBstM2
 2GDT55gdnE+VsuVOOqkyvNie9iEKsNJ7X9K8cx3D1wj7w1iKfUGnc1yID8JC+PmcTjwKRcn
 bpsxFjINexfovq0WW/wRH3ISrtsajbCM+VVbWJd5JqroymrP5LTFUI4tGkaqrYq7BiK4EQL
 CcTD/bY7ZkOZSG3VmWDmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a8455BJiI6o=;sBGNT1X9cjrPOkpnBrVKYSbORz+
 lNUbod1Pu/4LZrh8oMdhG7mj4aeALXWV/Sra3u2alL5TnHoqRb3xKYPBAH5/JcmP/LNDx4pm5
 zo4Azz+i75+XVkiDWMb8FR4qzwoh4b162jypvJflYJIekxklScBzZWt0g072l2w6hpnUUuw9I
 uqCOzMEtHJe9Z4VdV5Uc57SQllFuDA9FqaqPu+phoG8kYdtiA1r291iYuPn43S/A8n5bDs62C
 UKgOhflxj0wLTXEa8TvQEvLrJoaaCRKqmsWMp4SIjVQtgYXXk7GgIZ0bVKzucSmIdQjJj8U8i
 X6nsPmNbvuKGiXUb5MsSLqzz9rKvP5kB3f5gtB3654nocSWzSlE62qY8VQn0P5YegmNY5/8LF
 Zr/6CUHB/a7XI21CpWJ4YW8yM1FtlrOGzGtmw5CLe94RgTSF5PxOVtARsE4tHHohYR4o2fhIN
 7pDAMWvv1SOzU9Yxv+DYwsHsQniz7wbuIMjZ7WZc4Mv/Eq4yN5jUwjAHOPftPIFS+FlbVap8c
 Fe1qEkzshF2g/s1s2wy7lbtwvHJ91aBlWTd7uByZfFinDDEt9NxCiHLCZFC5hchJccHjMjalY
 jZTm3L4KxgvFAWeKoBjbLmq/K3KIPjvk+LeFcKrNYJ+5Ay3muCtzmNg4iiMNvm21JYu87rocD
 tTR5PQPAmfjTxp3jye+EVt5TNuavJz/eXWGqeNonbwgNzWOQL1Z4s8F8uZQFBFpeuGJbF5PQY
 8mK5EbH2VZFWEneWHL7OKWAKkmsuvtFLw==

On Fri, 20 Sep 2024 17:45:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 20, 2024 at 10:03:21AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >=20
> > This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
> > cycle before reading data from the EEPROM.
> >=20
> > The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
> > of the op-code/address from the host to the EEPROM and the reading of
> > the actual data from the EEPROM.
> >=20
> > More info can be found on page 6 of the AT93C46 datasheet (linked below=
).
> > Similar notes are found in other 93xx6 datasheets.
> >=20
> > In summary the read operation for a 93Cx6 EEPROM is:
> > Write to EEPROM:	110[A5-A0]	(9 bits)
> > Read from EEPROM:	0[D15-D0]	(17 bits)
> >=20
> > Where:
> > 	110 is the start bit and READ OpCode
> > 	[A5-A0] is the address to read from
> > 	0 is a "dummy bit" preceding the actual data
> > 	[D15-D0] is the actual data.
> >=20
> > Looking at the READ timing diagrams in the 93Cx6 datasheets the dummy
> > bit should be clocked out on the last address bit clock cycle meaning it
> > should be discarded naturally.
> >=20
> > However, depending on the hardware configuration sometimes this dummy
> > bit is not discarded. This is the case with Exar PCI UARTs which require
> > an extra clock cycle between sending the address and reading the data.
> >=20
> > Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPR=
OM-AT93C46D-Datasheet.pdf =20
>=20
> JFYI: You may also convert this to Datasheet: tag (we have a history of it
> mostly in IIO subsystem), basically replacing word Link by Datasheet in t=
he
> above line.
>=20

Sounds good, I will change in v3.

> > Signed-off-by: Parker Newman <pnewman@connecttech.com> =20
>=20
> Code wise LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> (Do not forget to embed this tag into a new version. With this the `b4` t=
ool
>  is quite helpful, so the workflow is to checkout a new branch in your lo=
cal
>  Git tree, like `git checkout -b exar-93xx46 v6.12-rc1` then taking a mes=
sage
>  ID from email of this thread =E2=80=94 any should succeed, but cover let=
ter's one
>  for sure =E2=80=94 run the following `b4 am $<message ID>`. It will prin=
t the hints
>  what to do next, something like `git am $<patch_title>.mbx`. Then you can
>  continue with `git rebase --interactive v6.12-rc1` if the code or other
>  stuff in the commit message needs to be updated.)
>=20

Thanks! This is very helpful. =20
