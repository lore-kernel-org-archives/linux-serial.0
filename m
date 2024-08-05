Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9D165F1B;
	Mon,  5 Aug 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885242; cv=none; b=XT48N2kgijA8wvCRjid7ZL6oW3CsiaoZOxt/Sbi1G2GAKf/2CnhZjdifxmfme9r61KJSAkIwebzZY7DC2hyjSYdNzEnROdpKEO/XDlEGnHSvKurc5SAFlE7gzOF5xMGvJuUGG4NGdUcNv0BPyEHpNoLwJI5xmzv6+VGzdbTNgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885242; c=relaxed/simple;
	bh=Ex12VzpdyrO0NdrXHGiu5qb9yZoLRCuHFVC7doR1q6A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=q9fZyYZZtOb3pjeqLxej2aSNUlJ5QYndZE7xe6CgkBS6BvNx4iR+ludeoovBcu+aD8VBJPk47/W1epbkF8OAewZz9LJkN/2N7fd+mNcKkCbqp4qICtyR+AW2dOnmU+SaS4ONyGJOXefpqQPaInsWjqfw4/PQzVbPG7DGKybNxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VwYd2R8Q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VwYd2R8Q"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722885236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtk5dG3EnMjfhWRTuibDKCkK/kKGRGj1UhF5G7S1ARA=;
	b=VwYd2R8Q579hnEEWI6Tq589C2vlwN4VYNLiC0PcWaImyY2FszadxQtKzN0maGSHTV3JfaN
	gIjIDVGsZY5QDpPMqRU6uHhduha4T8g03a5cZJJDIlOoZIqYyb7O2XYzdSSZ4lOE/eV9R0
	OUnFd3cfGCh/tATD+QHfo1sY2q5H396b7mrGdzNDcfdahJzIXx+q51tTY6B4v4rt4X2Hcq
	8hVasH96My11mkUjXPIOIuMForyQZJw38IK2Ohp9yvUDmSUtm35sU2hsFzwwYtxMMZxoeF
	mCnYUPJA5mpSO3u+UzcDbQupl/raVQbTwClA+29Y5q1U6s0NvkqgIztx35C/JQ==
Date: Mon, 05 Aug 2024 21:13:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Yao Zi <ziyao@disroot.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tim Lunn
 <tim@feathertop.org>, Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin
 <efectn@protonmail.com>, Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman
 <megi@xff.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
In-Reply-To: <ZrD8N7_tYAiKCg-C@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
 <82e7e3a78f784b3ad63094c8a0ab1932@manjaro.org> <7941737.iedYuu7f5S@diego>
 <ZrD8N7_tYAiKCg-C@ziyaolaptop.my.domain>
Message-ID: <303a27ab5681e13467f01de9bfe94b45@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Yao,

On 2024-08-05 18:22, Yao Zi wrote:
> On Mon, Aug 05, 2024 at 01:47:45PM +0200, Heiko Stübner wrote:
>> Am Montag, 5. August 2024, 13:37:11 CEST schrieb Dragan Simic:
>> > On 2024-08-05 12:59, Yao Zi wrote:
>> > > On Sun, Aug 04, 2024 at 04:05:24PM +0200, Krzysztof Kozlowski wrote:
>> > >> On 04/08/2024 15:20, Yao Zi wrote:
>> > >> >>
>> > >> >>> +		compatible = "fixed-clock";
>> > >> >>> +		#clock-cells = <0>;
>> > >> >>> +		clock-frequency = <24000000>;
>> > >> >>> +		clock-output-names = "xin24m";
>> > >> >>> +	};
>> > >> >>> +
>> > >> >>> +	gic: interrupt-controller@fed01000 {
>> > >> >>
>> > >> >> Why this all is outside of SoC?
>> > >> >
>> > >> > Just as Heiko says, device tree for all other Rockchip SoCs don't have
>> > >> > a "soc" node. I didn't know why before but just follow the style.
>> > >> >
>> > >> > If you prefer add a soc node, I am willing to.
>> > >>
>> > >> Surprising as usually we expect MMIO nodes being part of SoC to be
>> > >> under
>> > >> soc@, but if that's Rockchip preference then fine.
>> > >>
>> > >
>> > > Okay, then I would leave it as is.
>> > >
>> > > For the fixed-clock node, I think "xin24m: clock-24m { }" is okay and
>> > > follows the new rule?
>> >
>> > I find "xin24m: clock-xin24m { }" better, because keeping the "xin24m"
>> > part in /sys listing(s), for example, can only be helpful.
>> 
>> I would second that :-) . Like on a number of boards we have for 
>> example
>> 125MHz gmac clock generators ... with 2 gmacs, there are 2 of them.
>> 
>> I'm not sure the preferred name accounts for that?
>> 
>> Similarly we also keep the naming in the regulator node,
>> it's regulator-vcc3v3-somename {} instead of just regulator-3v3 {}.
> 
> "clock-xin24m" wouldn't be more descriptive than "clock-24m" and there
> are usually only a few fixed clocks in dt, thus finding corresponding
> definition isn't a problem I think.

Well, using "clock-xin24m" comes with another benefit, which is using
the same "xin24m" as in the actual clock name.  That way, the same clock
name gets used in various /sys listings and in the debug clock summary
in /sys.  Having that kind of consistency can only be beneficial.

> For the gmac case, Krzysztof, do you think something like
> "clock-125m-gmac1" is acceptable, just like what has been done for
> regulators?
