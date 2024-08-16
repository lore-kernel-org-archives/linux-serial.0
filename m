Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757E3F9D5;
	Fri, 16 Aug 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790424; cv=none; b=ecdEybAx+Jiz6DSIwwUInFT//rMzs/OgVwiOoW+JfPeFI5e7I0srykhEND6uj7sVp1MqOXM6RF9yuKSICKuc/0hMX1aaMDavKgjNAVWKAT+kNUKQRqN7M189WQn3ep6dZSy/xxf5qGVEvzKugGnQ7RXk2nKYutyPRL4gonWQ2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790424; c=relaxed/simple;
	bh=+d3XRUf7fgNNMkPhiBADu1Mygie2bfYXkkG+stkBDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa56ezdBcvODkES2am2Akl9mFZQrodNGa5ZRG6A+O2xnpJ6zwK2lKUs7ZVx4578uR19QukDzVyF5Jo5BUZ2T4Umjwp5MVJW2cNLAwd/b4npeG4vbyvxWMD+yG6LuYpDJ7YnY544OPZMicED+3ZbDVtmZAwo2zj3EJ+yQv96jGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=loK2DQeQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="loK2DQeQ"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 30FA841A4C;
	Fri, 16 Aug 2024 08:40:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FE_tVLB1Jtg9; Fri, 16 Aug 2024 08:40:12 +0200 (CEST)
Date: Fri, 16 Aug 2024 14:39:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723790412; bh=+d3XRUf7fgNNMkPhiBADu1Mygie2bfYXkkG+stkBDbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=loK2DQeQIcnGWc14T58cYt6F3lIPFvHEUxGbwKVUWvORBCWX6XEMF52h3WmB2kCUx
	 hlm8Lxh88wonxf3bvyTY+IjDfE3k5X6TMIAtTLnLkooLmwPEQvokft9EOfdcjKwZ7M
	 ZVCDQARu5buW+9uVxxFe+790ijbIy341vAk/TdTekKVr8Md0XTi/U7d7F7lzfx+Ic+
	 81LG7Jb0VL8kG7ckXVWA2sLYlzC3iU+eq0bBZPFxggE/OFna+HfMyvvCBQV3Dma7Ey
	 wrjIWEbh4P+L1ywrnrSsJDeuWMT+64mOLh6xuenU7HIPIS3W2Lco/i3hVqk4AYnHCY
	 YGNaMbU2z5LdA==
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Message-ID: <Zr7z-SOFIgcuplq-@ziyaolaptop.my.domain>
References: <20240814155014.18097-1-ziyao@disroot.org>
 <20240814155014.18097-4-ziyao@disroot.org>
 <10324095.IZOipudI63@diego>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10324095.IZOipudI63@diego>

On Thu, Aug 15, 2024 at 06:43:20PM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Mittwoch, 14. August 2024, 17:50:13 CEST schrieb Yao Zi:
> > This initial device tree describes CPU, interrupts and UART on the chip
> > and is able to boot into basic kernel with only UART. Cache information
> > is omitted for now as there is no precise documentation. Support for
> > other features will be added later.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> 
> not sure if you have seen Krzysztof's comment yesterday, that he found
> the soc node getting documented in 2019 [0].

Oops, I don't read that before sending the series.

> I guess that counts as a strong suggestion. Not sure how you're feeling
> about that, but I guess we could move to that scheme for new socs.
> 
> So would you be willing to move the mmio-devices to a soc node?
> (stuff with mmio addresses in the node name)

I'm willing to, there will be patch v4.

> 
> Thanks
> Heiko
> 
> [0] https://lore.kernel.org/all/6320e4f3-e737-4787-8a72-7bd314ba883c@kernel.org/
> 

Best regards,
Yao Zi
