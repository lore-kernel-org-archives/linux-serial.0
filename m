Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5838FA1;
	Tue, 17 Sep 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726614846; cv=none; b=hdJGmrJyNhekNRAsn95XhpCfqbZHY96ZLOOFpvi+pv00I5jGCJcjB14QtqdI9a2pRAM3i2xiLw/1MBhKFo0al2MHqS0zjl4eyJh3rOfLF3e7t4dglw4UGebYBo3AmStN85JDKTPzcFeijZdIMqyKaHoQEijdGWzHcrKRuo9ep4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726614846; c=relaxed/simple;
	bh=9uuB5ejb+qvV8e3P+mzsDCQqb+5wYFLw06IFjWGrVuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCVy+ox5bsafP4MokvasMiw1iNtbsFxLg8o+OvlPzOwqTtk8gbKBAUUaetk129Fr4XXPXN4jlUljQ3tXYJn9zcl9k53/TaCfIR7OzknlhguAuq9xREIn0P1KuTwekxI1CIoItowQoMFhsrmXHX+EF0Ed6dQOwxDyulENxce/ajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=v1pf5bMa; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="v1pf5bMa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O0f4fMiSZzhyqnmcGQxhgWk91t8Qt5UtvlepWEOO714=; b=v1pf5bMaWt60Y9OWAVsnZCkuR2
	PTJaC+UN2QUDYr6VI69SdTOUUS0N3+zc6z6bm2fJb6cW6iPGVPZ5CpqEZCvwSyTQzNQFePdMQ5STb
	TV/EG+S96nL4HDnb2m7f70YOM/LfUJsJsBKdPqHDpFTaju4V3gDILPAsuew/qb/eav0BEacukcR5I
	VCDMVdVRx6kTx4GKZO2ISx4B4gBSHeJwzHxiUIuzkilNy8NoEQBSMYsSQuL/tYAxut+kDNabGEMt8
	Cobh3I6p91J3+alOs/8208rgyw2369ATNccsFy21Nh4ucODLS59pFZqAY9EA+ZcI82mhIUb8uJQo1
	axXYtJSg==;
Received: from [213.164.25.30] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sqhNu-000126-HM; Wed, 18 Sep 2024 01:13:26 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
 Ondrej Jirman <megi@xff.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH v4 0/4] Add initial support for Rockchip RK3528 SoC
Date: Wed, 18 Sep 2024 01:13:25 +0200
Message-ID: <23655990.6Emhk5qWAg@phil>
In-Reply-To: <ZunjLMQGEcES2zIV@pineapple>
References:
 <20240829092705.6241-1-ziyao@disroot.org> <ZunjLMQGEcES2zIV@pineapple>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey,

Am Dienstag, 17. September 2024, 22:14:36 CEST schrieb Yao Zi:
> On Thu, Aug 29, 2024 at 09:27:01AM +0000, Yao Zi wrote:
> > Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> > multimedia application. This series add a basic device tree with CPU,
> > interrupts and UART nodes for it and is able to boot into a kernel with
> > only UART console.
> > 
> > Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> > booted into initramfs with this log[2].

> Ping on this thread. Is it possible to get this merged in v6.12? Or
> anything else I need to do?

sadly nope. From a timeline point of view things should ideally be in the
Rockchip tree by -rc6 . Which then move to the soc tree and from there
to Linus' tree.

There is this rule that all new development for a -rc1 kernel should be
present in linux-next _before_ the merge-window opens.

The thing we need to figure out for your series is the uart binding,
because that _should_ go through the tree handling serial drivers.
Greg is in your cc list but with the amount of mail he gets, I don't
think he has single-parts of patch series on his radar.

So I guess the easiest way would be to send the uart-binding from patch 1
as a completely separate patch with adapted Cc list, so that it's obvious
this should go through the serial tree.

From talking with Collabora people today at the Open Source Summit, it
seems that's also their plan for the rk3576 that is stuck at a similar
state.


Hope that helps a bit to explain
Heiko


