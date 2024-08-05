Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2113634B;
	Mon,  5 Aug 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857845; cv=none; b=Kkwtjd06XOXdu5+6aGpOyaca/o1D+3vw0EEzuf3PvTkoDWYBsIYKTEsZFYnsis/WpkNz5m0J7Jbtx2RVnPVuuGtiGIBbarDkBiS+TTd0g3QqdGT5ckRII5/ODtriKsw8kaMPePQmLnEBluP2VhBEkWovZHu4IMoJPvKlnkagaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857845; c=relaxed/simple;
	bh=avZPHcmD5jG94fg14soRlNHA8bVHgs5gjw7IdSPWQ3c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fpkGaxYK3pSMLilo1R5jBITcs1jcgijYHAO4VkRKaISzRxhXZRl2zpiW4Qis9VdlTVTxQSSngCZXjPVmbR3ct6wplhXrEcVF4DCHvpWs6C+WvnsH/nuXiwB2Rl3LJRd8CzxGuFv6GKRWhWRv0iFo2O7cCLMtlPtHsibhfKyO1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qUUlxRPT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qUUlxRPT"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722857833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXUv4vhwwDrlK6OrMkKD/adJ3fBSeeUSyzbCZQ61tL0=;
	b=qUUlxRPT1IMSC952YYeidmM0KBYMvEOIsbrWjX5Wcam1Tqn5KVnFKpwl8kQOgxOCNf+9fx
	9WLIi3gt00vx7CwV0DbX2hhKD2/5mp3ir3ZOmOHaJ4c58zU5kLXPWjNpnyxsRtlnvi4u/7
	WOrr4TD7UFyOEH3loM4VszSqwDGpAVOAwdgwD6fWnzOv1sRs+Dru7PRIW9byugYmu5pgVG
	3I09LAldrwTsabdPnpYCVcgJ+eLOWKhToSd0N94QN/YwU39dCX5wjobRLuloLLMtT1vOFY
	7Pp89kj2kr/0co2oV38y7Di/ruP30FVWjRab2fOwVxzjFQQRK4qtsK99Hdl4vg==
Date: Mon, 05 Aug 2024 13:37:11 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tim Lunn
 <tim@feathertop.org>, Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin
 <efectn@protonmail.com>, Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman
 <megi@xff.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
In-Reply-To: <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-5-ziyao@disroot.org>
 <56bd1478-ce8c-4c1d-ab16-afe4ad462bf5@kernel.org>
 <Zq-AFWYaqu7zGuz-@ziyaolaptop.my.domain>
 <b967ab05-dd0e-4fc5-bee6-ad7639e47bfb@kernel.org>
 <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
Message-ID: <82e7e3a78f784b3ad63094c8a0ab1932@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-05 12:59, Yao Zi wrote:
> On Sun, Aug 04, 2024 at 04:05:24PM +0200, Krzysztof Kozlowski wrote:
>> On 04/08/2024 15:20, Yao Zi wrote:
>> >>
>> >>> +		compatible = "fixed-clock";
>> >>> +		#clock-cells = <0>;
>> >>> +		clock-frequency = <24000000>;
>> >>> +		clock-output-names = "xin24m";
>> >>> +	};
>> >>> +
>> >>> +	gic: interrupt-controller@fed01000 {
>> >>
>> >> Why this all is outside of SoC?
>> >
>> > Just as Heiko says, device tree for all other Rockchip SoCs don't have
>> > a "soc" node. I didn't know why before but just follow the style.
>> >
>> > If you prefer add a soc node, I am willing to.
>> 
>> Surprising as usually we expect MMIO nodes being part of SoC to be 
>> under
>> soc@, but if that's Rockchip preference then fine.
>> 
> 
> Okay, then I would leave it as is.
> 
> For the fixed-clock node, I think "xin24m: clock-24m { }" is okay and
> follows the new rule?

I find "xin24m: clock-xin24m { }" better, because keeping the "xin24m"
part in /sys listing(s), for example, can only be helpful.
