Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110248;
	b=bEWUzfKntKklwZyxms/E4ytvovGM6N1UCm0J6I5988NyAulcdMb8UgujgJ7t+T+q/8zw
	 zZnqqcvDuqQH9ISJxmrTYfz7b9wX0WXaVWXHCeAoXa2SNDhNdHuVLVtggZXRetzjYJ/iV
	 rY5y3ESR18t/9Tdq4BCUhVdisgG1MscHO+IcbBALkLW1xTqZxbBE1xwHCxNCb7VWo0KU7
	 PH58g1oBc68DgJbOWEgpoI6PRO0YUOczU1tYgKd6ClTi2bQ/VBJjchPV7TvHWEVlasuCg
	 vyBuCUUuydlWaR41cDJoYUByio7VLffaypY6TaDQhwEoIEO9UF5qIsR+amQIWtM8oQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110248;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=zC6XbGBId3wda6WVmjXiMcV23RWx/CU4K8LR5LpFX9E=;
	b=428F6u2ofLQeXy2PaSuVbytokg+s/dDEBt45GkVijm0Zy9WvLP/WPShgSaokA2qvsPiU
	 VagNoOF3kVb2rtpGePYRvten96fVetFDpO6N9AfKntSrknIWHMIuJeV/xRlZsVIe2rIiq
	 OB5vM2MqjrxP50QE/ftSIE23QF2iSiEnmXhBhNW3ujE+m8hMii/kphUAdXFx8aQ64xxHW
	 h4ACC45wRWeyiq8c2/ybex3nf8649W+HNvGkzF2pFcc6oLpuboqb/YEn+d2ms/zGgvL8G
	 nYxpTSL21/7vbmZtitek3Tdp9ypGTImyhri/mN+wZp6QE2T/cQa4geo8I5Xaqr/9NeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lFLM7vo2;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AC606A330
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 17:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lFLM7vo2
DKIM2-Signature:  i=1; m=1; t=1795110246;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:QvhgmCQIHOPKqEZvn2hDsF4ktdNS
   /36yfZs/8U6eSAwGoR26DspnxbMwlBoAybQtlq+tYQw1gnjvA5h9fCaI1BVkJ54iabgqiaGoZtA
   GviB0Eg/VfN0U5lASLZPvLba9i0BIS7twc6zo98chcxmG/T7nqO54f8oTsEt/0GTPFmQqgBsl+g
   giNk9gkOBv3Taz2a/1d5XlQxWWpVi+ffYx6xw7Iq+9z/v6TYfkEuCSx/J/OP6ZFS49h88e4TVvA
   9rZAx/5Mq5z4BUB4pTTkjLDaPCOH9J5XnZiEe5Bv/ci3MavOVx2XJ8ezsAH163jHKweSKtfU0sT
   i23tz5uv2TnlMw==;
Message-Instance:  m=1;
 h=sha256:
   qADDsuhmGJMNZb+rzPR5n+VlabxPonESZhq+Wu3Uo+o=:
   zC6XbGBId3wda6WVmjXiMcV23RWx/CU4K8LR5LpFX9E=,
  sha512:
   RvxUqIR/lhgUkOoXq7kCPypoHjzxOiyvIhirNAhmEDDkEGscuyG7zMWQx1suSHOE1E12OnUZQjQ6/30ZqYdrKg==:
   lDFWdGee65dPA1tNCCnbv9wTSoaaJcIb9A7NX6xVJjRmt6uq/evvpdXGjgrHL+yXNspxMI7wZ0r0oDGfHIB+Mw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795110229; x=1795715029; i=markus.elfring@web.de;
	bh=zC6XbGBId3wda6WVmjXiMcV23RWx/CU4K8LR5LpFX9E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lFLM7vo2YjvcxJhPdUb6/ISZdpePKN88VYPcgO7G+xpEIOOScA4zJ8omLi68hXiM
	 ucPKhnAzw/324SCfGdlaGsulIGVQbC3F0dFcJWGG8DhTvQ3RnW/Q0FfxP+TVJtbqS
	 OSl/piPOxibdxUShfsvHGgIHcEV8EQubM457tBNZutD9/rh5+La8a63O2XCzyNxWb
	 BgDsJcirVXgaAFaPIEfkgu7GjD4L0+MNZqXynqXU6XIORFq/Y0DZQSr+iNQpZ0Avt
	 BODlgEcvFpWfHC0JckypDc2PkcnlzJWv9g3TohUu+ElA+7SENQnlU3JkZEGS7SMko
	 7R8QmHh8Aa6cXS910A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpL4-1wf36t2sOY-00pshL; Thu, 19
 Nov 2026 18:43:49 +0100
Message-ID: <aa4b162b-39eb-4867-9882-dd4a447fc11b@web.de>
Date: Thu, 19 Nov 2026 18:43:42 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: serial: sc16is7xx: Use devm_clk_get_optional_enabled() in
 sc16is7xx_probe()
To: Hugo Villeneuve <hugo@hugovil.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Jiri Slaby
 <jirislaby@kernel.org>, Joachim Knorr <joachim.knorr@ziehl-abegg.de>,
 Luca Fresi <luca.fresi@bithiatec.com>,
 Martin Fuzzey <martin.fuzzey@flowbird.group>,
 Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1333a82f-d074-487b-b3ad-c1a3496b312b@web.de>
 <20261119123624.500417c134528c090661efe1@hugovil.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261119123624.500417c134528c090661efe1@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q7V4zxVc8IvWWrNvpWVPqMEJxEATIBRzTVlk1QvMSxuwP/8s07q
 GzbfsG/HgtKGNe1M0SA0xBGCYHu+87ybWCOagF1WP6XAXcLeICzACK39+dZWBjuHJHDiizB
 IVT/lLqBwil6jRgGdV3bCUvxCcHcnUdFYEBihvlxVFR7VPqyvGhGiLHnVqKYq9SGR8ajnzw
 lURrqnGfgvzHcbb0wuEfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yBpjE9XQHZI=;HvJCN4Hcmfy2D8mCYrS7tjLLUcZ
 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
 TNAUI1hVdzA==

> Nak, your patch is incomplete and in fact just duplicates, in part,
> what Xiangwu's patch does:
>=20
> https://lore.kernel.org/all/20261113103855.2144-1-laixiangwu@cmss.chinam=
obile.com/
Thanks that you point another contribution out.
[PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock frequency

Regards,
Markus
