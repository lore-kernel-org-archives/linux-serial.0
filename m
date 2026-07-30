Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674347A870
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454496; cv=none; b=aVC4rnoba22+Pa+nY0oppPejIb9NSWp9yNFstLpv9fr/G8kKn4gGa9zIYYmagfP6maA9Piw5Q7wMHHn5SS0O1XTZ0btfYv7hQigR0RCMXL49VQWUU5lQWlVpePyDy3+SZsIcAjnwOeCXWh+8F+t4HCoMhTwyTKD3K+GidhWOXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454496; c=relaxed/simple;
	bh=utT5GH8JwJmVzB+0txH3Mifzm/70gcqs7ugOLa5BO/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4jelYFU6TR2LuBhL8lx70vWd2poEVnzRPzE2J/Yhi9Cw0G2DRUkPTDNvnqYwUb8a6rzH1tcb7qAhjndrm8KZu8FOvQOrClubJtZEY0jf/ZzlhlyZgHDEjs53z7VGq5t81/ixZZdMISLxYh6rXHizKkAlUZOe9hcqjN2lW/mu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jOAxZEwJ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOAxZEwJ"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-74d55dac06dso108781137.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785454494; x=1786059294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7GFN5YpwDEZAtAP3vleYwkuNsvwAGPeTkmkPSkEkzs=;
        b=jOAxZEwJLw5Me8TAT5p3HD3jl3cTf00u3naxMR48xdOQ+vBnYdESrbfBoBo2iav3vC
         jwCcPmcNjJUHWvySnfW5+rQ0MNP0nq9GVvNa1OJA9W9CamMlqxkzzKPTcyZK5dyjef0w
         RiNWvzY/YH3orUCDi09CCByQ/HdsXdq8/dpRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454494; x=1786059294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7GFN5YpwDEZAtAP3vleYwkuNsvwAGPeTkmkPSkEkzs=;
        b=UYHbk2r0MmJhGzpsAg1Wbx8adSzAk2XXcDnenkpjTLz40GC6L3NJ2zLljKRQT9P58u
         M94LsZJlckQs0DSGELMFeUO+uo2GVSlKI+MEG6N6ie9yveRSn4VMdMChCb4oI0LgH8x/
         gFM4hP9OfI01YGxZ6sG5+7RVyyqfrpggXHZVzrBwtYoRS4/EmQUU5u4eAYKj/ujAXVF/
         JVUyZYFwDzBQaeZIwF3cDQ7RkjT+BelT+mSzQdDL7TdLhgYfe9fHLM/5X6IQawEpL6Y0
         QKRHhK7UIhzAwonzM+Y8HIgsyYOSYiAmtxyUamF7/m0qaCizoTvEDvswcf8tMAw6Gyxv
         gB8g==
X-Forwarded-Encrypted: i=1; AHgh+RoAYSbJx6yUDPXRXy8JuS9YtiI2qiwhUIJ/poPV26YmVnmY1PCLAcOvSJ3/YasIvtj0wxI21vpp8c1plxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztobP1RnKF/GVtua0VL3DheyLTekYe56V2Ua4u8k1WeWkMO8We
	kkAO8CJlqBARd+UWKwq+Pl/9NnFWrH0uquraxdf7n59mypcGbyYUtppMpjJ8jBtz1dtZuGNbHTd
	1Jrw=
X-Gm-Gg: AR+sD130d6N46TVMMyYuFUGeh6Qv6EQjTxZBig16nq7/a0zb8ag0LCfyqHzkM6FGOt7
	A37HTN+mADrHpULcvYRP6uLXHUUjmBhMTMQWfZ15/tZbIVcfY3q3vbZWI9JoGXyLM1KrDoFwgtx
	7f9LgnV0Xh/e86vPeDBBFwSXfox/MX1iCOJs/bLA+Il0l801BDLdMQybmUEfANJwX4FxH6HadOw
	qkbsZRyL9l1Z8k5cqRWgFYuJd2RLXBXrZGZZKVBo9r4AVvMWzSWSd63+5QAEMbBYNum85PWuSFC
	tfGPumhn7OjfoDznX3H1Vjf1iaJHBMLJ68CHbYIB5bgRkJhtb+LVCHCzCe5vyhIZ2D4Al7YRhje
	wU3XZ6CD6oMtgNEo+k63De4aEYQMc8YjTHy8L3/CZRVErrR1kBeX90cCWNGnAx7GxRU4LQroO+t
	oFVlcqD0i/hXJAiOrEozBVoUEn2Y16U1dt+g2sZn+mw3dF+yHgBxLlwaliFjQW/704L4292hpLT
	FSpgsy194zP8gZK/nx2xMsnKSg=
X-Received: by 2002:a05:6102:5e88:b0:631:28c1:154c with SMTP id ada2fe7eead31-7574e4dd42emr1604266137.9.1785454494107;
        Thu, 30 Jul 2026 16:34:54 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-977cdb237a0sm2281397241.6.2026.07.30.16.34.53
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 16:34:53 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74d55dac06dso108778137.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:34:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr16PrX24T5w+OiFytg3K5Xx1LbH2lyMgtUj9ArR9ezpjk3A5ZfPkvu/fnZb7i6UXNWuCCww2sIJOhDx5w=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:745:78d4:4856 with SMTP id
 ada2fe7eead31-7574e1d5298mr1438306137.7.1785454492526; Thu, 30 Jul 2026
 16:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-5-3abae9717feb@linaro.org>
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-5-3abae9717feb@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 16:34:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWpswZ0LbZzpj6RcyRxYps1Ht8+w2TYTviTw4bo80KZg@mail.gmail.com>
X-Gm-Features: AUfX_mxnuq3KCnn0XeSL1ZB4QNLigMdFRjElx75voPzjUsE6soU8Kl1B5ccPok8
Message-ID: <CAD=FV=WWpswZ0LbZzpj6RcyRxYps1Ht8+w2TYTviTw4bo80KZg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: defconfig: enable Tensor G5 SoC family
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 22, 2026 at 2:56=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> Enable the Google Tensor G5 (Laguna) SoC family in the arm64
> defconfig. This SoC family is found in Pixel 10 and later phones.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

In case having a tag helps:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
