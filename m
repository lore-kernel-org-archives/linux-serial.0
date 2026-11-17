Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914543;
	b=pjcx7jI7amWyfIob2kBmEOR3pjzuPcn2Uq4Wpf7yYqX2OtCoWEFqcmxFn8OC/XKHFP1T
	 FEi8OHuNIdr4qfy3N8Ivl8TSNqh4M+g+pLxlOZwjKFgi09fCEJbzaIE1oLDqAdfa5fCTh
	 L91qa1shl6NFnLTvymLC1ft2x8rjTIQLkncDXYw7qa0ZvDAsojxCpTrQc/8lXRrylPBlv
	 /Rvbo3oOP76Qf2AFw3OPl57NZkNCNQ+hKarFa9Lgz2dN5rTJ0xRbcGUjMzqxhHmYsSi7V
	 33kNQRpVRHDWPsIlegyloVWszCLcW+QZTrBjasjBuR6jhwxd6P2XVmF9Es2TOOEP8kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914543;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=oIe3p67w4/MbeGv4zncqvt3AjFKp/+ub75gyoZv00yk=;
	b=jdU1gW1hP17A7FC+k/Cyp9EWLDWbGERSvFThvCYoC7E7nmlWPSxolwNb8KMU5qdEwjj0
	 T6qKT8gZTgZXfr3hgyGJCOy6LhTv5OgJ7gbTTQKgMgY32LvFgqjuR7FGnlUKa+qiMrSxL
	 XEjYAD+WGaIxkkREvtTXmMfPK7gcmjUw1YAXQYX9udr71q28Ie80u2PvpqZBaaC+pu63U
	 BucI1eMIK/iJs5gP03OuH7vWWdXbLNTru2A+Ho0XwO1FMsuk0SWRlODcKU2E6T4S+l2HE
	 r3Ds5DS6wCb4yxiJLoNaympVxGplzgrMHO66QWnq6Wr8sjbYl2P4fUUxupZmXweytqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RCJ4jS0O;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B343606A31C;
	Tue, 17 Nov 2026 11:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B343606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RCJ4jS0O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794914541;
	bh=fA7EhNWJGQMJleB4jeAMNpc2PM2vJfFLxpgDHBdrh/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RCJ4jS0O1HgXzb6a7gu4e2T24gqN8Sq6ElCpkeEzqhKHDWzHxucj6RSxoY0gKXb6+
	 kSS1ilPDNoclzdLQzkEts/2EHXVHs3b+WsQm5VJlX4SGvlg0miHdiF+aYr5nqgTa23
	 90XS0A7GxLhacqR4ITX5hw6Z18fvBHQWJFEDsDHnTJMSToGp0PD8RyKYwVN85X2UjV
	 T47zlhaPyupNsFckWGP1f/moMioiwRkfcQQk512x+FzuKOZW8uEU+BMhzImMJd7EV1
	 At0U7fDzKFivcP8mcXX3E9gtTjTosIyz3YBraDkr3UAY+65oqKspx4LaQgLv9xG6f5
	 8hyclFiQY99kw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7924F17E0A27;
	Tue, 17 Nov 2026 12:22:20 +0100 (CET)
Message-ID: <0956ff3c-1bf9-42bd-b498-721696ce2b9e@collabora.com>
Date: Tue, 17 Nov 2026 12:22:20 +0100
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
Subject: Re: [PATCH v2 3/5] watchdog: mediatek: Add MT6833
To: i@udp0.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org,
 phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-3-058a0685c40c@udp0.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261117-mt6833-base-v2-3-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 10:11, Rui Cao via B4 Relay wrote:
> From: Rui Cao <i@udp0.com>
> 
> Match MT6833's watchdog. It works as MT6589's, but its TOPRGU reset
> layout isn't known well enough to describe, so it gets no match data
> and the driver registers no reset controller for it.
> 
> Signed-off-by: Rui Cao <i@udp0.com>

Hopefully we can get the TOPRGU reset controller layout somehow somewhere, because
it's a pity not to have it... though, I think that the only reset that would be
actually needed is the CONN one (for the modem) and nothing else.

So

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

