Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839130;
	b=YO/dzLljLnyB72xf9YqeVfgosCQXhTT4Ja4qahyNptT3sWXcV6xMczg/Sygup64sryYY
	 arwbZLEU4qhTmQPoOutBnK16ABTNt1zycYE/8szrlHC6Qtseo7ANcxKaQgIU9KSYCvbyb
	 b4/oYBEtKKqfUB7n9ye5W3A4jay6yMWgYU7spQWrt4luJqFZdS3OgQU6vjFV1p7bmPtbB
	 FLbafpNcJ7yoUofvpbt/XrDiGIC/Nzrz4fuT/DF4ivifsXcvwLTqOIwy8xbTk0+wINcpG
	 kWo5Xp6T+Q8g/MfB7Hec/nT71bAtYEF9Qo6tTNAqEz9L4ZWDjr97w1oNbpQc32E17Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839130;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=bnKc3IJSrt3IePIy9TsoCqbRk4dzHod7cZj0q0eSHH8=;
	b=NBiw13NpFgzIdNc046iUW8NMCxvThy7YQ+dl4b0rLLhnuge/7DmIiV5AyKhnbXl6VrDX
	 3F8T1RMmUP73YLeyJ2QZKS6eRktNBJOjxH2jdS0FY755oH2p/UbUWBMK3w4Hpp7mNr8mL
	 aviYx55mYw2UnZsEIp55SKyHnZDL75wIs1WGdUjzRZ+3kEWXKWgGHYmnC/KAt1O1k6FaF
	 xyYb9iWC8/JfnDB0iQ0SVrVqD6ddPuiZSs9hbAHMK2iA5S/xL9DBx0PIocKEXMb2cCR/y
	 Ls7mLyAONkpgWJKWWDal9bi9ETvp31wb+5mgaabLkpMFs2pJdyzvA1Ef+ZjpDp+2d5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0sk6mFXH;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D323606A332
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 14:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D323606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0sk6mFXH
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id SnsxxvT0BAR1iSxeDxZTDs; Mon, 16 Nov 2026 14:25:30 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SxeBxAvdvSeuLSxeBx37JO; Mon, 16 Nov 2026 14:25:27 +0000
X-Authority-Analysis: v=2.4 cv=NYvm13D4 c=1 sm=1 tr=0 ts=6afb1259
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gUJwKisUJcuna-pPN7wA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bnKc3IJSrt3IePIy9TsoCqbRk4dzHod7cZj0q0eSHH8=; b=0sk6mFXHdazpnAR1pwYEQWKC6I
	X1E8ekQhO0z3VayxRm1NfHDKZPYKtSjVyBbOQ6BXgsKnbsaQijZg9Njwvi72ApNtUv8cSMNdGc4Vd
	QyBkQyIPDzLAZFyuqMD232Y8huOEnhHlwlN1r/1BLq79zhy1fepUalqTHRZt7AQpgRJ/hNNVCJ4/W
	+wjozLlctGicx/oK/1NIvMu3BrlohLbRxPWhx6Kl99HdJQN9Ph/a5KSW52HJ5bvDy+eWL6YxSlBW3
	Pv6/DkmHUpcXaGr7B2cKNOjA017mfcKr12cerSqK+iWNmuAk3le8gG/O8AgxGgOr0CZNuR51nIbhz
	RUC4xEhA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54554 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSxe8-00000003nQw-0sPf;
	Mon, 16 Nov 2026 19:55:24 +0530
Date: Mon, 16 Nov 2026 06:25:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
Message-ID: <20ace44c-2385-4561-9e69-c6c7bd3a3fb6@roeck-us.net>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSxe8-00000003nQw-0sPf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:54554
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 28
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG5/vHyeUFey2WipVMmsIBbIwxMRo/vU3yLC9/SO5ayug6++zjU3Be7wIN7NpLAH0fA+mkbCmqBCILQAMpYnn8wvv+5WhRkDSmXqSTVgLpZOZXVBEWMF
 ADxE6BHBIPtGbNAjGLUsrQIISwzkTQoQvi6m+/2zV8FRKpWXMIWExGrcViJSc4e6/336TrXomBW3ZiIUPV9opSIMIsDECBTV/z3/pK57eDb700MDJmM5ibDj

On Fri, Nov 13, 2026 at 10:04:59PM +0300, Alexander Letuchiy wrote:
> Add a compatible string for the watchdog of the MediaTek MT6895
> (Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
> which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
> known yet.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
