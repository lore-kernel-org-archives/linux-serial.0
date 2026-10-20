Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460483;
	b=H4tsuyqPp5Vu9keKPF4DKYrTOMh60uP0m2O28d9i2j5IRSa/LcGrSUK4NddLr1Z+wKuM
	 QFybxwGda+8EM92UNakK3eqCHtdYRoL14wn9YW6WoepEQ0J2qEnttETMa1QUPmkvChiE/
	 ax3vciYja7sH/EVnNfIATdP2ksS/3LLPJQIEKQpb50RB9OoslJeXQX6xaXQhI3+OSEjgU
	 m9A7NKLlmDhh7h1XhCRbmcKT5YY1GgWbRuj83/Jlmgu8P/UONVli7B/GimTRVb+wUdhOY
	 RxCUT8xmK2HpHu95wJ1eft8GunNxXiNwj7og3GxtAWOpmvAPKVO1btXVDE5gKGD1N5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fr0TV53Zh4gczCXYrk8qJ7Y+cVmeHFe014wAKV8qTsI=;
	b=3lQOAeEbAJW7BPApM5yRLbKNrcw8KkGX104m6kul7+f+bTkpl+GWM99KqNQNkVm5ssAW
	 L6ZfCqbXibK5pNrUPpXUm5J5MAqRbX6vu7YTy6YuxieIecb8NIx5Y0oSjAJmofagg1rKr
	 C/1cRvFBeVg3ocr7+0Hwkx4WcyH5STmA/BWfXZaXdej+sYIAE4CpNlYYjPOM/GAqRTgER
	 Esg6oPKhIZ54/Van7FuT8cS3D3cLZOXnloQVp2x1NlDPuHynuvMqy7FTK0Rmxp9cPn8Vl
	 sl4r2RBOPwMzMab72+eEZTim9rbUcq7cG4sDoxB8ztCp5hX9aLH4fG/YI6kFZjEwgYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QczcF95R;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E31606A31F
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 01:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E31606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QczcF95R
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-17bc533fda3so3192438c88.1
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460482; x=1793065282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fr0TV53Zh4gczCXYrk8qJ7Y+cVmeHFe014wAKV8qTsI=;
        b=QczcF95RLqhKlbaXAMGeaN1AxXkPoihUjRzwJVbthf4GI55+lJ/tDi12lth6tKOKgS
         cTy0iOv691TwhqWhbFHkeMyngO05h40ol7fVkPUdDShmb/rxRNfuCGVl2BfSZK0Mttn5
         5MixBOFNKTY/fMstidcQZ3LVYufFQ3YWrTq9F4AVmrDg46vLcoHy8iKXwR0XM6Y7sGKp
         1IDs+Qj8URbMRiTauduB8UaIxqMiKMsUanldJd5gaRaB/+PvGIjPk6j+FFOenOkaeN+D
         eU9fsubgP6AxXusE7HElU6ZprcnCC676R3EJf2L6aT2bUSjW/DlIBnLUfV3aBygH8Bfa
         DeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460482; x=1793065282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr0TV53Zh4gczCXYrk8qJ7Y+cVmeHFe014wAKV8qTsI=;
        b=xETMEMBeFRmbnftsQ+ij8GhgCy6fVYc0hRnMP36X8fFx+sJ+Z3E14TZs4sjDdPJtfR
         PBFl2UHSFf07f4K2EZs11Jh7M5az9x7w9U6+UMevEOaCs3n0EhgcZYzEWTmsXt4/a75n
         vQJr8wwE7E4GRbMIVz4kQvQpAImnIILQ6BuoxCf58OqIQKVqlaUH2fnHvy5n56HtpOv6
         2RWHp+wanqJQPt3JFgF5zRrr/pVqiwib1MiXU7k+4MkeUwzsAXdAPYdw36rDSSg7tiDC
         6Xpajfy0Tqz+Nsg4e9XSj0QHzCLK+1ZSRzYe2lJyA4DLUYedYNRKg7ohjK5mESwkmANf
         7ajg==
X-Forwarded-Encrypted: i=1; AKwUvBzSKbDlAk1Cga5nHi08H/KFZpvGBDGAvWBcVOidTkWhgJpvseajvhvHX3wCbqV7T3fvRHPciS8ZKTYpcGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKw2qlINbveE9LwD4IC6D02AifvnaYLkg635JLlAAxEsEFZ4eLk
	Oaz2d+0fG5FvZw9R0i7kf4d1Hv55GWvz2k/2MylglnIyDN4iFlnTKJVs
X-Gm-Gg: AYBFou1nXaEuNTij4opbiA323QDil4MMrZD8lDW/1fbCFQ9CILQJr2ibBoBAneDp/eL
	Yj2ELO2EeaF32wwAFBc0NzzpaZhB7/rVu+UpHrtWRMFy4lxXSvOXxy/CyhUMS+YUKkz2GIq0yIn
	6PLw6umGzXNedMkRAw9SSSqAIKSY2+QhMjHBayOcPiVCX2FwiLx0H+hyh5/mMBN9AGd0n8gCHsI
	+uGHP6ffoshGsWx/ua6nf+YSyy2EnL6Q3/ED6RQgt10YYGMgy5Gxz2au85FxfaCG3o1MsI+VVsT
	seYcip9VX3YjqK9ArSRAU7FI3xpxwXG0DkOtFT1NNvoRzvThwu6EOcM23UZaZYeRaCgK1HNKfOr
	9KDx0nXr7jSuCvvMVeoAphz9okY2ZW2K4dDr2yLGIVV0iAdMDB7trVov4shbLBZV1bJk6aFHzU3
	OvMZ0YRi83/mWBgE+hSEE2ZW0Igl2eNMD5+rgQ2QUMMQbVEgpyuZEodEM7wooIebMB9yLPagJ3/
	Bl32W3MG3VBIoCqM7kRjV3biS6USslSeYvzEt1aMTMqsqqoL+jwaipQ97EtEf5sGsYgCg==
X-Received: by 2002:a05:7022:ea50:b0:143:2968:564c with SMTP id a92af1059eb24-18512f1e993mr12640931c88.26.1792460482105;
        Mon, 19 Oct 2026 18:41:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm28816461c88.20.2026.10.19.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:41:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:41:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Grisdale <bengris32@protonmail.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 6/8] watchdog: mediatek: Add support for MT8163 TOPRGU/WDT
Message-ID: <589d0ab4-46cf-4b8d-b4b3-5519dbf030ea@roeck-us.net>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>
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
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:40:02AM +0100, Ben Grisdale wrote:
> From: Ben Grisdale <bengris32@protonmail.ch>
> 
> Add support for the Top Reset Generation Unit (TOPRGU) and watchdog
> timer on the MediaTek MT8163 SoC, which provides 15 software resets.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Applied.

Thanks,
Guenter
