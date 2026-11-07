Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.74.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057811;
	b=gWPI0e9fUpfofM3e0LLzthFfmtzz1lsByPOTpFCABSFxrKDPTEARzXLQfLvtNALu2BqI
	 HZljdj13lpHifQKn6XAAGtGjKAzab4Lz3iMNBOf+Bs3etCMf7vec1xIezAJ5vxivYNUba
	 04VKZgMQhMrXhOeQIW6Vqk9DaquPI6awdwK3zPmKjM4STuoStpUueWdRkf3Dts/mqvEb6
	 vrR7Bq6XA049epG3rcB3WsiP+y9ze+90BIww3IEQ1cF6QcslyT9xn9c5CdX4oDnfoAffi
	 IiYLdSiqrDseMyPl2KkxpsfTGZ85DJu3L7TmEU4GqoTFx9WOdWXE7JRfMPIjmh8ZFZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057811;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-Proofpoint-ORIG-GUID:X-Authority-Info-Out:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-JNJ;
	bh=XkH+vWqZucV2P2/xeZrqT3HKbZQaLRyiqkAW1d5j9jQ=;
	b=IcCOulqK5tnfe/S8PzxW0t1BDprbNQ3be1FgjFxVz1wVPICfuOnPkgNFXkGm7C2hQkOl
	 WyYiS7vBH6pZGZO46QB0rW2ybqfXJMFsBt8EQqY5OMH9K5rVYzMGzNjppv9HCtmJrnZ/d
	 9cXTAlxiphS4WPFUm1nOTwb2um26onjP5N4Ml49skaUtBymFzR1ITkkKPycbQOmaOk36l
	 UlVp9yCuFV2HB9OEmArJ0Wd+5uov7O68zytnth9TR0I6JpNVohSc1g4Rw1t7l0CGkwDB3
	 xCq+Q+d8xn62A7r6cr96SIc41D0obcwahAgAB2TOqN4bZx5reosTybKZ1bmJnyUJhbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=udp0.com;
	spf=pass smtp.mailfrom=udp0.com;
	dkim=pass header.d=udp0.com header.i=@udp0.com header.a=rsa-sha256 header.s=sig1 header.b=Q67QI6z6;
	arc=none smtp.remote-ip=57.103.74.214
Received: from outbound.ms.icloud.com (ms-2004k-snip4-3.eps.apple.com [57.103.74.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA87606A32D
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 13:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA87606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=udp0.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=udp0.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=udp0.com header.i=@udp0.com header.a=rsa-sha256 header.s=sig1 header.b=Q67QI6z6
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPS id F1DB81800F73;
	Sat, 07 Nov 2026 13:23:26 +0000 (UTC)
X-ICL-RepId: 01a1b62d-a406-7ee0-92a7-aa3fdd673dcc
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtKAEMGWwZeCEEHQwVaC1BcHA4Edx5WAAlWUAJaS1QUBA1XHQdFUR9UWEEOCloFUFEdXwIKBEcEWxdGA1NFXwMXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PBV0IA0NUBF9QVBFXUAtbAEYBQAZVckYHRAhPHlkHWQtdAEp2XBopCzEOTgopBFgEM384RglHWxwTVhUNTUMSQhUEG0YeQwRfL10XXgxeBQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=udp0.com; s=sig1; t=1794057809; x=1825593809; bh=XkH+vWqZucV2P2/xeZrqT3HKbZQaLRyiqkAW1d5j9jQ=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=Q67QI6z699y4Il3JSoGzy9/3agUy+eFvfdcNU5kmsd1agU3tKJcYqejCOrZXhRcp6NaTqBTzalpa2ACczGTyVlgZ4ysmoPZqJzBaTx2kJrZ6SDXvObPUKL582NMxy3Yf4q5ufLiDAvZK7kePK2vUa0V0RsCvmkStN/0rONdpABDRafF5oYunofXzKNMyUqWobOFs7zn59AyEodaG2Y+7lt4vV0au/FGxeIKTp/Y77DmjBTcvMVNBt6XYuQPz9AMuBj7EEzWkWLTdxQA9pBZw0vwvj0jL6C5IKB+8jF2TUaBDjPf/L4d4C/UkInea1cHzlJ1zr01jiVxOQ4XXQ+HqAQ==
mail-alias-created-date: 1755760572767
Received: from smtpclient.apple (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPSA id 5273618000BE;
	Sat, 07 Nov 2026 13:23:19 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 2/4] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
From: i@udp0.com
In-Reply-To: <NHTtBa55FlZroePPfTapZ39Pvy1b4wyqCCdSD04TWCQXFLmLQy2sA6FNcAybpbZP5XAT42Ze_JPK1F8mA3c49Wk7dm8_Uir4anxYntb_CNI=@protonmail.com>
Date: Sat, 7 Nov 2026 21:23:06 +0800
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org,
 linux-serial@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0268858E-5417-4029-92E1-B9A769D336CF@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
 <NHTtBa55FlZroePPfTapZ39Pvy1b4wyqCCdSD04TWCQXFLmLQy2sA6FNcAybpbZP5XAT42Ze_JPK1F8mA3c49Wk7dm8_Uir4anxYntb_CNI=@protonmail.com>
To: Roman Vivchar <rva333@protonmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Proofpoint-ORIG-GUID: 95eXpZTJhLMQL2DA2HK0aiuKYkqwkhMZ
X-Authority-Info-Out: v=2.4 cv=JcWxbEKV c=1 sm=1 tr=0 ts=6aef2650
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VihV-RlftAohqbJ1NDcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MyBTYWx0ZWRfX4q5Zr7QYhpp/
 PijRaXHDjgtCoIUFHOzLSWz0IjqKqdGrXY0156XKKKtYnM79/iKqlLd3Cww7UF1AlrgAIogNSoc
 RxkaG6f7QJVHnVyFp2zikNGFXP+/NqEm3adM4X0q+7Rerq2nhlmUjkbNB2TMqyILMXAVs2byt0C
 re+evaIkMmo+AOOCjL54QGyXAlS2kfoQCYGMi77omjCXA4QgTbPRCSpEZo0n0QxAQM+vYGU5546
 LH7DYXSQUbhsl4QOMarBwR8aynppmn2R1c3cBIk9WgKVOWu5uQ792Df1FM/w3Dsv7sbvADcNkjF
 pZ+Uii6U8P1TkRe9RBB6SabMi0h+wILpD+ShLSOKl9DDuuy0vtb6A/ISpSB5G0=
X-Proofpoint-GUID: 95eXpZTJhLMQL2DA2HK0aiuKYkqwkhMZ
X-JNJ: AAAAAAABhz3Oh/EPhCGAyIy6KvmkLp7t7H18Lp9MeSUEuUYuOLaDxL0B7oLDYsDhsmWO2q
 6F42SgfSUyu6PBKz0FwBsZVi+kbcmRcqsbSn3lhSM6m9MoI8RRSnyNQXfDSZ11Wd4rZ+eI
 qppeNSauUXS4WyrvDGBoOaH0dwBHc/FUrzxIFuaXkfO66j/B563ndOGebhqOkaM9+WAj3v
 WAnuqTLWJVnN71jpS/ThuXybbmyMTqGx7OGgGk48m67gS6TfPe66vSCIK+0VCkDf32L0Yx
 CzO+MG+KhK5WzYjslbn4W/tOXjdYNfafplXcgsJBP3FVHs1WbI5tKbiS0v879uJfd1aSYA
 P6zFjyvE+1aPlUzUr/6FINWvT8FPbtzU7DAkjf0cVYMQzAW2UXbE2gK6+MtRv1tWWhWa6M
 6uXXz3s3dosVJ/zbkxayIXOHevMrdSzmsUjDh1hIcoAu+JUxZgq0yrKUu0vYP9bfg2SgKM
 AVQxD7HhlCz7hChGkxs1RH76DkhBb8bna96/TxRDCubco1/o8hNUy6ApXCpdB5T9noFSzk
 DqKJm6b4u+uGsn7fpJpwnXkoz4l8v699dn4EGl078BYz0dIwu9xAgmgY8/+G9PzjTdSTKQ
 c2JwlNpQouvzsiYyGoTPlJOC2b5KGqmZhzVKaMJyLIukkonng/vDAM5PBuUyzFFNycemiG
 IDr5adFI9+J/4FyidrTw0n5M+ysPjPkoO4UCXMwjAf2YHYMlx0Pgq/9r61jTC0oVQX5UgU
 vFpvfueAHn4q41PrkiMhwGCWBTmLXYdJ8pfrjVYpYCPRwMdY5R25Ch5fPwm5DuVfE/4mOe
 tja1itNC5QdG29/7+IUtuECogI+u16wodX3UsJBogdWYEY4C6LPa6/RTTeZ+b5j5o7MQfi
 xXCrrkcgHiqLwG2SBqNBejAJs8r+d6Uxv3qjZFKh3/usjJICtUt2qYoNY87G6+yaqTTTXX
 pR7HgWFHns+gA9ScipZqvEdaXFZFTGvmyFzByLonJGp4dZvsFi86U8etrTyYOx47hoVw7T
 teQZADgQd18gEcefXK8/DVErtlzIrIhKBvqdTaIiyDnlCKkxMxrJxvLjQfx0tySIvpHmRj
 6TYErlvnMwoZ+OG2UiDXAqk4GeJ09Ct8ho4b0WbFRPYKlQN4c0ZyRAo2OJ7aUXzuvFFE+5
 i4RS+pm/oJ4lL1D8ZjHKrjxkaioFHES/smdb0B7Wc6imhcFFHis19EuhYiSAeT4rGYYVeT
 D+lR0pRJM6boTjhDp9K/q4tKRWHrwP5oV1VOl/yCJm5+BcaC9ZtpVnFfGf6X/U9gS2DAYh
 86l3zkl50nRXMPG3E7NGB3LQ1rgDnjMM6WYYgQ8Xp4L0UopdA687X5nLeVI6TQKe2pgrjY
 71xnwBNt8xGFbZdAgS4zzNAVYobgbenR80bdnRmcjPhpV/1ziwTNMQYse4bt09ZbfLC668
 GgoBI=

Hi Roman,

On Saturday, November 7th, 2026, Roman Vivchar wrote:
> Does mt6833 watchdog have the same resets as mt6589? Please take a look
> at mt6895 series [1].

Thanks, I had missed that the mt6589 entry now registers a TOPRGU reset
controller. MT6833's resets don't match it: MediaTek's kernel for this
phone resets the connectivity CPU through bit 12 of WDT_SWSYSRST, past
MT6589's twelve lines. That kernel has no full reset table for MT6833,
though, and nothing in this series uses the resets.

So, as in the MT6895 thread, I'll make mediatek,mt6833-wdt a standalone
compatible in v2, with a match entry in mtk_wdt.c that has no reset
data; the resets can follow once their layout is known. I'll wait for
comments on the rest of the series before sending it.

Best regards,
Rui

