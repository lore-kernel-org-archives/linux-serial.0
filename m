Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1520B22;
	Thu, 31 Jul 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995526; cv=none; b=HblBDYHB5Ko0uWC4fuWwdDIyJtIErIoxfTE0pegK3q6gtoSxEJ+xW7I5MLK7m3dmC8WMmoW0wtMz8SPaR1PCtYtQ9i9enZiYPI8kI9FbJ6grEataGJYsLJkeZch/xRStHtH668840lRkGqsHkZdGmsBOl6PnGxZ+BccFK0Fj+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995526; c=relaxed/simple;
	bh=m5Pk7tD9kshGeH2kKLtqxUq0aTwTrAsMUWcqrGWhXsQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ec7TwJpFEDK5KNDwycgl3EK+S8Vbk3/mlkYARu44lwFuC+c/Q/8Hg+w7RXP7QkPt+HY3pLQkwmB0RDtZPshjTkc23Wdl0WzxMtxPRNHp6SX8du1FQMAHmrpeUbyyagHC4oWcgLF3N25P5tBvuURem4eoQkuerAL6mYQu6vi6AgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=N1iwWIB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVoYy6WP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="N1iwWIB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVoYy6WP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BA1C140038A;
	Thu, 31 Jul 2025 16:58:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 31 Jul 2025 16:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753995523; x=1754081923; bh=x7iC7gDXSI
	uhAR/CbJkRs5xaFqZ4b43Gf0COwq8XDGg=; b=N1iwWIB5Lw6L4iY2s6Sx7dIA97
	1KijnzmGKtr2bnI1Vd5SLJITG6X6t/lEwtNeVTljgyW5QDsxwT46N0GTwPNc+LCF
	XtPSG0Uoji/RyERhGCibQQnRI8OQqJdGsYyrhcdN37bcMgQh92HhsptOvjE8b+RG
	YUrfA+Vk1q8PeJGL8bd3cLXzQ9KBr03kD8nbyJrU/dmrfijkx27oat+Et8SNPe91
	+LzES9c76ZeP2zx0uq7xRmM/imAwCd7x3hXF1vN4WJY5ZdlCCgBDvj0zwWy/ia68
	B6DCEWpzANvrx/zgBUjZlgMPE0TtznvdGelUZxZcYlI7CM+P4rY/e1jOY4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753995523; x=1754081923; bh=x7iC7gDXSIuhAR/CbJkRs5xaFqZ4b43Gf0C
	Owq8XDGg=; b=GVoYy6WPrzmtFx2QApnqzKkGikvJ/4iPCVLW7FNNy+QUOQJX5Lc
	IV7jH7jnIRT9IBmMz8gIF9lMpuwbNwWD4CY78xs/TdebvbmVeG3vTXiMoTIpcmJb
	y5bcGZKUvTDfV7lsplJFZGm7rb05nYtdYopLH3Y845vU07BMRrrrJk7I/vEkRoZL
	3fvjg4+BqjpIozIg+2JN3yWFj3WsSw7pluyR2cy6/AfyT+O5ZptZHHfWkHiDSuYd
	6XQQkhoC+R9ZjHPD5WdNZt6mj+cxBxLKE+UtRmh/xz8+xWgEWyqKggzohpUZ4eW0
	J5b76wFlBX15i2TlhwmyVAhBac5ZOuGRbxA==
X-ME-Sender: <xms:AtmLaCv82KKiSfk7WWNsmIBC2MW17lnqjlpjLKittmE7oZ41gkns6A>
    <xme:AtmLaPFbcH7Vl6zEwCZNmfxDUng8nP5DX0nUyeIDXfuU5pAcpaHQbJpMsnyOOFb9W
    jMV-59Ckov2aTw16PM>
X-ME-Received: <xmr:AtmLaLamBhfpjNHZfz0qi7xA1G5UzKGBDAIhrM1FiUaBqV1kSpX5xDnzD2MI755QRUuNMHYFFBGA7mzxCYLp4o4ffhM67uxZuRNwYQ2W5GPGbMZiKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddukeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpeekveeftdfgkeejhfejleeigeffueehieetvdeifedvhfeluedtkedvgeeuieejgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprd
    gvuhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhiihighhothiikhihseigvghnohhsohhfthdruggv
X-ME-Proxy: <xmx:AtmLaHU98d6aKfp9t9TCJ-44-pc_4eIdb-_4GIeEDjve8vJqXgDOeQ>
    <xmx:AtmLaJlmszz26_TbUfrOEzNshqilN2ONQOc_sOxOENo44lgcFbSHLw>
    <xmx:AtmLaKCz2nFl7Amv4rnrft4yjqsSy8JIRAaXbSxSbzTvCoexyuF8Wg>
    <xmx:AtmLaAg5uC_zs-m6CKZtcV1VIMtpgtsmmNLyuAtWBP-ipw_eVRMe_g>
    <xmx:A9mLaHzo_9hrHFNuup7uho4CytO5X1lVscNyAjjz2QkY35UMGlbhk-_a>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 16:58:41 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 31B4612949CA;
	Thu, 31 Jul 2025 16:58:41 -0400 (EDT)
Date: Thu, 31 Jul 2025 16:58:41 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org, 
    Christian Zigotzky <chzigotzky@xenosoft.de>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
In-Reply-To: <3ac7427b-4f17-480e-99ae-f00e5c00e678@csgroup.eu>
Message-ID: <9811012p-4q9q-284q-n2qr-7597s16p8sq5@syhkavp.arg>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-8-jirislaby@kernel.org> <97ec2636-915a-498c-903b-d66957420d21@csgroup.eu> <3ac7427b-4f17-480e-99ae-f00e5c00e678@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-1419361712-1753995521=:3602219"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-1419361712-1753995521=:3602219
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 31 Jul 2025, Christophe Leroy wrote:

> 
> 
> Le 31/07/2025 à 16:35, Christophe Leroy a écrit :
> > Hi Jiri,
> > 
> > Le 11/06/2025 à 12:02, Jiri Slaby (SUSE) a écrit :
> >> _IO*() is the proper way of defining ioctl numbers. All these vt numbers
> >> were synthetically built up the same way the _IO() macro does.
> >>
> >> So instead of implicit hex numbers, use _IO() properly.
> >>
> >> To not change the pre-existing numbers, use only _IO() (and not _IOR()
> >> or _IOW()). The latter would change the numbers indeed.
> > 
> > On powerpc your assumption is wrong, because _IOC_NONE is not 0:
> > 
> > $ git grep _IOC_NONE arch/powerpc/
> > arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE 1U
> > 
> > Therefore the value changes even with _IO(), leading to failure of Xorg as
> > reported by Christian.
> > 
> 
> And is likely an issue on the 4 following architectures:
> 
> $ git grep _IOC_NONE arch/ | grep 1U
> arch/alpha/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
> arch/mips/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
> arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
> arch/sparc/include/uapi/asm/ioctl.h:#define _IOC_NONE        1U

IMHO this one patch could simply be reverted and the "old" code let be.


Nicolas
---1463781375-1419361712-1753995521=:3602219--
