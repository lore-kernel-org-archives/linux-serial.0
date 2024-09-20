Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7017C22A;
	Fri, 20 Sep 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846957; cv=none; b=koZXQmmlMcLX8VEvmJT/0EplVqrIWeN3lbM/VpY2HXVvDOPC6pZF3b2oe+dNC5uXhXktLFTZ4loYWwM0SwQ4f/POojDnvQGCsvYr2xLeSmVx8WEB9UCTBvGTYQKTNQ0ZpBKZzTxKkp+e8ZinmRrfCsfoRHRe5lTevovu0K5jvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846957; c=relaxed/simple;
	bh=zqbgwVXpbMPvYrQsl/a0qrGNFKRQDovGg1giUHWDWWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGjYBVNboLOKt9cwPKxBw+u3FnZRLqL9Cnf1TfkMdVPUKTpb3XJqN17UAYaup1BLSFujkxdKEwBLxBuioBK5eRAPsPlRGaMK3Y3jswApSP7NXUh2UAE2kx8c+2fzLY+PEBqwPYrhAH1HOZl6T68cyksoPV/8WMST/1SDL1d0418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=hvMa9e0j; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="hvMa9e0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726846943; x=1727451743; i=parker@finest.io;
	bh=fR3TYlDsldKR0tpKtjPBomIY4TsBJgyHhgAKFrXN0g0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hvMa9e0jRmum8ol7EKASzNpJMMIviAEdWboabdiFKbeO42mZl9eZDUk9TtvfAGAv
	 RWf6hX2PDnEFbXSVmcE0EeDnduj4prHF0g6l4I4++FU53QggRdBpDliSohbPI5Skz
	 IBi57iWABCQkmdl5HAr4unhHc7Bm9Jtx9hdALoJ+KTDbKLUvf6VtF+4Ts95glgKCe
	 7qNMIkYokLSLXTkmh47erKIknWjMzQ0P6b6L8s+Tz2phrxKo4N1cqV4IY1n9xqGRe
	 Ew0/mYkAk+gf4FaJWi4fK68DiSmQDGL+5evkLXT5kDc9/BZ3mY3VKxJZeTBlqlIox
	 W0ST+/tlb+KgjCRnKQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M8ftl-1s5SdI12zD-018NTb; Fri, 20 Sep 2024 17:42:23 +0200
Date: Fri, 20 Sep 2024 11:42:21 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/4] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <20240920114221.57da8890@SWDEV2.connecttech.local>
In-Reply-To: <Zu2UEAY1jweup6tS@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
	<87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
	<Zu2UEAY1jweup6tS@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:PchVmbOsjwe+x2yNnpNK4LhSErSaCy1VSCQTVP+pHztbCgbIJ77
 HEGNlgKIaBNM58s+CU7RAI6nHeTiHPj3QMDggbKgjaz2EFMkYwIGOEmi4tnLt5Lb7w/nWH4
 k6lFFRConb2redu47o3258d3t5iEurbRa4OefaNYA6Bde4t01ECBdMQs7XF2HXGvJnFj1lx
 GDCIzlDhinVYLxQKQcpsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5iQ+5LVwve4=;Iz1cYbNYIIswE563tMtzYhK6v85
 +uq4CAVRBdH9OBs5P/sUxwH8Avs6GOBOfNCLOO42JPemkT7BcuD09K8D8zUscOJ4PcWKF6g+b
 BPpeRJzaGGtcR4LcWFMRElcrvTsblv2INFqvGlGM8Acs4FWFH///ITM/N+j832H1iHmGOJ1h0
 hdV7gSSNmbnFTf9a1dTnbySyDB2eto5bhcTFWWi+9miDWx5Jh1fjJnw0mqhyf3GE0EuQFVeAR
 42qkAlUgZh6JxAko7YCAho1dLzuy4Y36frl1wb6lHtM1letQIxNEORXxexkXIxr/lkgpgDnBJ
 9ZRfxZmAzbSxiVLdcyUFqLdry2HodfGqRVNRDKqDwwnpZEE0VkjN1WA7ckFgghJuNugeyk37a
 8gOccVmjAtsmFm/zbaqeTTRZs1rsBt/yOR71d64vd2nOfvyvmhdaSm1F1/2Sq+nIVu76048wm
 Kb3/PqyjPpCNcwbmoUdcPo9EaP7BIBAgfSZieTsnWYvQQACODkeI4XeWhuEd51wu0NkX5QcuJ
 w7tqAh8IqgHi4EsH1pUvuD37K3mGO8LOfWlvc8TbOpc4Ia9rUNZete8REvcjRr7yxTiaovLI9
 +7qiy2N7sh2ACtozfuYBgcXV9uENJna208qM1rgvmRuGbeGRGQpYCvZAgeAofCqt5BevPFYZ8
 85OOZ+HLJyXYor77WbrH8Khmw6PbpSeUtrQ5FuHMovuckl2Cde6n/K2KedC2mMEJL8Rzu9X9w
 LBYVUqbdZCY4bJwha9hsadXXUMSYGKzcw==

On Fri, 20 Sep 2024 18:26:08 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 20, 2024 at 10:03:23AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
>
> ...
>
> > +	osc_freq =3D le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) <<=
 16);
> > +	if (osc_freq =3D=3D GENMASK(31, 0))
> >  		return -EIO;
>
> Just noticed that you have
> #define CTI_EE_MASK_OSC_FREQ_LOWER      GENMASK(15, 0)
> #define CTI_EE_MASK_OSC_FREQ_UPPER      GENMASK(31, 16)
>
> So, please modify them and the above check using these.
> Something like
>

Good catch, I debated using them again with FIELD_PREP() like the
old code but it looked pretty ugly. I guess I missed removing them.

I will fix in v3. In this case should I drop your Reviewed-by tag?
Or is this change small enough to keep it?

> #define CTI_EE_MASK_OSC_FREQ		GENMASK(31, 0)
>
> 	osc_freq =3D le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) << 16=
);
> 	if (osc_freq =3D=3D CTI_EE_MASK_OSC_FREQ)
> 		return -EIO;
>
> P.S> If I am not mistaken the definitions were only used in this functio=
n.
>

