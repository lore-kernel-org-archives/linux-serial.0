Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8026631;
	Mon,  5 Aug 2024 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722835366; cv=none; b=ty/i0KVWfPqA5onSAJx++95xCHPdDdM0fFQ4xexVD74UklZf/GOJPDpE7vFUzXPEdnDF0S7OC6jIPi2LqadsND8jpybc4uuCJ73Vbmb8m86I+jytOHlJSCLNwW/w0dWhtBOI8GrMRW5ea2ZsB426QOccMYEYcxXnaZAFa3DitL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722835366; c=relaxed/simple;
	bh=TW26NEDM/mH7w4nfR2+VSs8WSBePmr7ut6r0x2J9gw8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pWyaPbwiQwUP5giYHLvNUUV3ZIwlLfvnxlbp++3/41RcY5OcgFtAgaeLbgf0teFx1Fa9+PFOJbiwomMTVWH/Sy0GBDG8GnrINvX0ztrCgBtHEgCEnlam6wfPzmM9M465wtLOO3sDhJQ62PpEQaOTQ5HdeIj/+QL3DzGXg4MaH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gu6gyClf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gu6gyClf"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722835360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AOe1X1BK2T9Nhb61hULdxwB8+O9eooFF234E3lK5bc=;
	b=gu6gyClfqFB4PQ+WxAd5h9p9n4YjVkd+J9VwMd9c2CwEAg18JJ547LmzTGDdhxeKXwKUwe
	IHWdr43Kqif02h2PBhgyxI3bMsGEuv9PMOTvZLB4bBU8+ca59vRfuZht0b7iDZdEEsgGWk
	Apy+y47XAEB/JuXSsxmH+9fTjPFYaU+iRO+66bYHqBV9EIjtnwdNDuGevmKuD5r+c3pPw7
	LJHW23x+jMMn3rKEKswV6A69D2wOdvM4KvF85xQlXU7gJbGlbbzVFn2wta5Ddalv+IvoT+
	m+eSIbi3oVo/u7+YIyYdHRV3Mk3BXtjsMinyzs7WBit9ZxUIUnqDDkMrLop2rw==
Date: Mon, 05 Aug 2024 07:22:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tim Lunn
 <tim@feathertop.org>, Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin
 <efectn@protonmail.com>, Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman
 <megi@xff.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
In-Reply-To: <10256980.nnTZe4vzsl@diego>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <2408413.9XhxPE3A7Q@diego> <81147f0205c2a9555c9c64e4f7a69b6b@manjaro.org>
 <10256980.nnTZe4vzsl@diego>
Message-ID: <1da29af645d98be85b422208136e8150@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-04 17:51, Heiko Stübner wrote:
> Am Sonntag, 4. August 2024, 15:59:19 CEST schrieb Dragan Simic:
>> On 2024-08-04 15:44, Heiko Stübner wrote:
>> > Am Sonntag, 4. August 2024, 15:25:47 CEST schrieb Dragan Simic:
>> >> On 2024-08-04 15:20, Yao Zi wrote:
>> >> > On Sun, Aug 04, 2024 at 12:05:11PM +0200, Krzysztof Kozlowski wrote:
>> >> >> On 03/08/2024 14:55, Yao Zi wrote:
>> >> >> > +	xin24m: xin24m {
>> >> >>
>> >> >> Please use name for all fixed clocks which matches current format
>> >> >> recommendation: 'clock-([0-9]+|[a-z0-9-]+)+'
>> >> >
>> >> > Will be fixed in next revision.
>> >>
>> >> Hmm, why should we apply that rule to the xin24m clock, which is
>> >> named exactly like that everywhere else in Rockchip SoC dtsi files?
>> >> It's much better to remain consistent.
>> >
>> > bindings or how we write devicetrees evolve over time ... similarly the
>> > xin24m name comes from more than 10 years ago.
>> >
>> > We also name all those regulator nodes regulator-foo now, which in turn
>> > automatically does enforce a nice sorting rule to keep all the
>> > regulators
>> > around the same area ;-)
>> >
>> > So I don't see a problem of going with xin24m: clock-xin24m {}
>> 
>> I agree that using "clock-xin24m" makes more sense in general, but the
>> trouble is that we can't rename the already existing instances of
>> "xin24m",
>> because that has become part of the ABI.  Thus, I'm not sure that
>> breaking
>> away from the legacy brings benefits in this particular case.
> 
> In the regulator case, we have _new_ boards using the new _node_-names
> but I don't see any renaming of old boards and also don't think we 
> should.
> 
> But that still does not keep us from using the nicer naming convention 
> in
> new boards ;-) .
> 
> Same with xin24m. We're talking only about the node-name here. The
> phandle stays the same and also the actual clock name stays the same 
> and
> really only the actual node name you need to look for in 
> /proc/device-tree
> changes ;-) .
> 
> So I don't see the need to go about changing all the old socs, but new
> additions should use improved naming conventions.
> 
> xin24m: clock-xin24m {
> 	compatible = "fixed-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <24000000>;
> 	clock-output-names = "xin24m";
> };

Makes sense.  Though, updating the dtsi files for older SoCs to follow
the new rules, if possible, still remains an itch to me. :)
