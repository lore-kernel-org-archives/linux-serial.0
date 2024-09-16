Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC088155CBA;
	Mon, 16 Sep 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488276; cv=none; b=Zj99WtuhjdeuAIYOfpEKzEb/eFx3yxBBeACrG93fY7Yedq64iwvK8nuc3wbRox5NvthNV8twLIEZrEX700XbtwWaveyHIBMLfNL2Z+/8jpNIv5jYURoZmg5ixEToPVuThuQYD7Z7dU5OOFej7g3b76tUpZCpZSMBib1fYlLfYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488276; c=relaxed/simple;
	bh=7S18rPoiPzvusuGS+kyFYp8/T/kXDOTuobzJSRRHYKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDDoh+Z0mz32rgBjtIxV26wVpjdAGIVnTqOFlnmtFi/6I5xO1XVnCG14DMf4mxCYMph51PguvNCRCznt7B482KuAMAF9UR3Ek4Of09rapnC+7nrxJbEphjTsGfs2CpHeZN4tfT6oQ3pPaOocMv3PXB+qVoAY1dTtneWWkd54QG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=a39UXvGC; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="a39UXvGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726488253; x=1727093053; i=parker@finest.io;
	bh=ALJDs8SGNjtmUFTDPZD0bOpnICbMntRY7CN0EI99nFM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a39UXvGCqJNxsIwacRvGI9/PYjaIhxl6SuXR41MLW+t8NHCijxwud74YL9yCNb5J
	 jvznNVnyCuIk/OThNATEn6MBRdNSy5i4eMEitpOkpe7LPxU73LRcczoLT+48g6BWl
	 +atzVVGn4FNHmT14HUhj9xMcrwxz0BW3wCD/uKN8vjTSmupRH0PvGC0wqCWc5F9av
	 t44BQfbcy8KMjU+4PiGmdJQGlj+oN3knyboYC/PKQNABDxpGsBB8UA4FAOcDhE4lS
	 lqxP3QVhh6YhdjufhdF6XS5upMIqgyG4+VUzswic0SB5/Pi6R6YOeF0EGGZgXe7dk
	 HuCXFE56+s9PUigu4g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MCKxT-1shg8T3UFV-006dOE; Mon, 16 Sep 2024 14:04:12 +0200
Date: Mon, 16 Sep 2024 08:04:10 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <20240916080410.464c2b5f@SWDEV2.connecttech.local>
In-Reply-To: <ZugJT4nl1l04biJd@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
	<127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
	<2024091438-charity-borough-54b3@gregkh>
	<ZugAeVWeMZGtjYme@smile.fi.intel.com>
	<2024091632-oboe-subfloor-afc8@gregkh>
	<ZugJT4nl1l04biJd@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:DuWs3EKfDrQtfvu6F+LpRP/HGSHQxGtwQBS9GkF5FMxlIG61Mw2
 ONRmfSYx+otrPfHOVNZ37/1vb1vAwtfJBbIn4PIMtoJkC0zjPleRX/ed4F511dNQYpJmV80
 ua030qVBa9LeB3CzDPfJoOUAASY+An4KkhXHVhK7trezYqfd8M8MKlSyU07aRweuYfUUWkf
 qhC82mYZrPnpH64FLWUPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BfvrrlymyrU=;WNS6KeBH1Kylzip7C/ijKSR+rJO
 7YNSAytIiZ2UbLd524u+TCDXPROiurE8mK3DbRiClvQU6nYycp65f1Q1e3YLv/Nz/vxZBDE/O
 YzC0SN7gkn4P049wCD8rFmm/xPoofUFCsNu9UN9M1UKiuzc4/VpBIGFQEO95Olna1xuMIKHqB
 CBfiNctgfu9dtPbtwjvPNvPePa4zLaZcggNlsqnXAy6aBiA/siPBzomBVqqC6yjXhkIrAhxTP
 yI8RLrpgEr+Vho8NDWN6dTWlJFQ5H2LnxYJ+bgCjpx7L7xBWANA75ZkyMgCAxJ5cE0y+ogMnj
 liI/vTFXqXtlFywXR5FYH7QWU4uvuxX4LUcB84xeqZFkXgNbh/JECjhXzVyQGFwjJb6eu811o
 yi3oLfbB+tt+nDHcwZMxBMn45bSDG1reutqdwd2tW4tB2VVmwl+mOBxwT1WI0YWjTF2nnrPBz
 hMWNN1oME6l9wpaUKdnHPeQPWZu1IYnQFv4lHWevkXEuZMJR8o96CuFul6rr7eX/i5nW2oKyI
 NKxOQCxEUo0vCdbANt+A2NGmfGJFcdCF0QDgb0PqRHBq0PAtP3S0nBpxCOciT/ga9YjhTOJtX
 T0Q4nE3Yw4lDYaIFRe57FUlEoNB4qa+83Hd/tGvLvDAp0ze8062EwFeeHlvXJtHDNqY9cer5k
 vYW7cpiHscuK1Q6sgbfwpvArUaKpkZ6vypVcOg1Cksj/dvQDgJAbagtiw7dXmEFbncgOPMvTA
 MDMBqsl1hBMXJJtZO6uE+g30t3Mt1CD1Q==

On Mon, 16 Sep 2024 13:32:47 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Sep 16, 2024 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 16, 2024 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > > On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:
>
> ...
>
> > > > > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > > > > +			pr_err("%s: timeout\n", __func__);
> > > >
> > > > It's a device, please use dev_err().
> > >
> > > The problem is that this library doesn't know about this fact. I.e. =
it would
> > > need a new member just for this message. Instead, maybe drop the mes=
sage as we
> > > anyway get a unique enough error code?
> >
> > Fair enough, although adding real device pointers would be good to do =
in
> > the future...
>
> Let's then do it when it will be the real need? Because I don't think th=
is
> message is _so_ important. I believe one of the upper layers (whichever =
calls
> this function) should propagate the error code up to the user space. If =
it's
> not the case _that_ has to be fixed.
>
> TL;DR: Let's remove the message for now.
>

I can remove the message or leave it as is and drop this patch from the se=
ries.
One could make the argument that any error indication it is better than no=
ne
in this case.
