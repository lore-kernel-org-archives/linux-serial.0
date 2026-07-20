Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA037A822;
	Mon, 20 Jul 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566862; cv=none; b=syD3wsThRuGo6sqoBz4pEtmMXqdE4ebgOTWuE+uOZyb7M1Jhi/DMn07HprkYrGFyL2u0F8L/qB4jhRIpmD7/fPes+1x4AkPx2rvdXt1zV9E9GkpjwIxAi2wUgSw/hHEDQT5nUg0hUkmGHVmiRkMBtHEpNflzt1/NaSrw9azQptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566862; c=relaxed/simple;
	bh=ZnocIwDopiqqJVtg7Vh0BtT5txebzTbq20nDoe2yfWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMy00UmDirxA6Q5Wkh/z2/fKj2ntX3QvlaDFJS7sMNVNh1nVJcQD5Mkij5CyhSsm+bczgPL4Zrl9C95FwPb/HykreFrby5oOgDTtIDTT1lp8/zSXcHKV/VjFFAz8fSA0whhTCrzoj5dYi5RZZorGSIn+m9vtBOCVN+aIJMVdMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NO3JayVd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NO3JayVd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B260D4E40E81;
	Mon, 20 Jul 2026 17:00:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C80260360;
	Mon, 20 Jul 2026 17:00:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CC2111BD0382;
	Mon, 20 Jul 2026 19:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784566857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mZZOF6F/+6qbNKDZNrs6o2rZDEXs+kob5JewkcsaTMI=;
	b=NO3JayVdQ3CLT/6I5bhNFXPmsyyk3gjtLO74861rznSjjAiL0jbKD4m/9c7UTOuXhyAZIE
	hK/5x73D6QSBO6KzbYGfA8N2DK7QfB3w0lUQaN293kooZPGiZwXbqtSsOuOm0b/2gdyxe5
	uoIfaTD8Y7wFX5SCHtuKQrQjcTq+1VykLD3I+wGic9mG0oGlfuOiV4pgz2WvJJABCwuE7i
	fiRRx9Mq54xB5lnICoVgjRkZ+SYxwhArSIUOW8i5Hx2K2DiXxVsaKuEx+80N3eA+Yb8DZz
	9FlCpISUFqqIZ+0NJrAH3crNikvFUwc3QiLr1vU1wpoqTvn1YUpNxlpOMtKdaw==
Date: Mon, 20 Jul 2026 19:00:52 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Frank Li <Frank.Li@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Swark Yang <syang@axiado.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v3 4/8] dt-bindings: i3c: cdns: add Axiado
 AX3005 I3C variant
Message-ID: <178456684519.97914.11616437803490580349.b4-ty@b4>
References: <20260716-upstream-axiado-ax3005-upstream-v3-4-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-4-c429095143ec@axiado.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 16 Jul 2026 20:51:11 -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 I3C master. So far, no changes
> are known, so it can fall back to the cdns,i3c-master compatible.

Applied, thanks!

[4/8] dt-bindings: i3c: cdns: add Axiado AX3005 I3C variant
      https://git.kernel.org/i3c/c/0dbcbd4c0b7a

Best regards,
