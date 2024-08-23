Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6574194A4B
	for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429582; cv=none; b=fhC0JagbLyKl/apHHEh4GCYvHT39HTEen6sO+tMLHBc4h+O9qIvIeTsmowJ5AoTm/wCwQybhvZma6/Kk4n+E8ik5jH1xUWKOqsGTHNGGJlsIvcWQeUmPPKmkjkwAevIyHUfE45qUDPEcsX+clmiQNT3J6EGsLj1zA4KS/vo9OwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429582; c=relaxed/simple;
	bh=v3tl121UFcqjaRW1cQWXFFukEED+sZyQ1Hsg/FKSyTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaWoXbyoSqDJJ+AM7lAa4qWb75NbjlgIgYDum5BJWY3VCKDe4KjXfvve1btlcL5qOA4Qqp2VspB8zwI8sWQrDggtvfgvw15GWkLqVIfZWDO8ghth4PnUlDR1Ww1gj/s75h8p9kwjFoPj++kfUoVL9w+rFUJ/GbJcNVuXTEfIxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdeqLSoS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdeqLSoS"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53351642021so2253815e87.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2024 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429579; x=1725034379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3tl121UFcqjaRW1cQWXFFukEED+sZyQ1Hsg/FKSyTw=;
        b=sdeqLSoS+cceR6ApQSN6cimmYONbktn16U4f0nXIbhbinKuLz03woTI8WuAR2goGow
         QVm0m/9uiYxGwUhQHbyekpGFcwzPJhEMqrE6G8d6oHVY/a+Cl5Pfr6reG2t/3oahIjfu
         dRGTR+3velXi48dsyPAgWclGpqRbnySvY/bxdxBkZW1cyIM/lEIK9Lt+pI06uf9hrxhT
         QhpW9N6fB5+xwh5qF6P4ht86uVQmw9Snxb0Damnty9Cxhms/6Xr3nIfFtcoSHCwf2d8R
         b7rDlIskAQUJwLEwNTukRKmtyfH7Ek2tX7fi1eLyFJERo5C6uHp9NGd6pzazFnjAu2It
         IoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429579; x=1725034379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3tl121UFcqjaRW1cQWXFFukEED+sZyQ1Hsg/FKSyTw=;
        b=Ex1LWrR76DeWjTucshdNlVwA6WZguU5v7nisTbgiyn3EM7W3qX9Y8yw/l0iJf6bTkL
         oo03qaNnQ9XA360ChJoQOPXA2meJZzUMyrO5dYLhiBNnwfTYY2ZV/gLhQd5oedi7N0/o
         TSbr4ZVHqTfEFmJ3bGih55hkPXGmWxPVude9BomFP+Aj7IQI5g0mSaWE2lz9itrc4Aec
         2DFRhQNOMdd7hcRDRkNSa/EPz79DZAjwhYKOMslr4+JrHqMmmGkFthMHMLEcL8peAJnU
         xGgV3zUGYymzS3Nz1saC3wu/6aksRCaXJAHwTPawD5RvScAtgJiCmEZLApkBNpPGDt9A
         /bfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDFvAp1OVKXfoSCqUynvmcnPsVpTZ8D6yZoCAOy8iY8DNPbRQ4+htrV+S2p2uIw+GZNJjVKa8bYtADHPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbVtRpzVxLTahkYuxO+8Lz6xOni4wFt50AfpQ1mo/Z0gP0Uql
	2CHLpZLCcqNiJdevpLjRQmaOwqt/3sj6gEnBH/DimALEJ6HxmW5DbskgXJNt0HhpuI8c3LNBPZd
	FlVtZmOmv4Qw84mgyygqQiYITphOurjDh1g3EdA==
X-Google-Smtp-Source: AGHT+IH1hynyymLz1ZuEZUhvfWZZ/Hkkj2g0Tl04dlGTeLjC9tjjJISAp+o+SHgwFRjXGoZ1puRhp7iBRORVJcZyH3Q=
X-Received: by 2002:a05:6512:6cf:b0:52f:c14e:2533 with SMTP id
 2adb3069b0e04-534387be6d8mr1996904e87.48.1724429578471; Fri, 23 Aug 2024
 09:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
 <20240811-dt-bindings-serial-peripheral-props-v1-5-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-5-1dba258b7492@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:12:47 +0200
Message-ID: <CACRpkdagjGv79pJy8Ry2+OM8ShCE8sWNafQtzrPM_-2MJYNzLQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: bluetooth: reference serial-peripheral-props.yaml
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johan Hovold <johan@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Kaehn <kaehndan@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 8:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Reference common serial properties schema (for children of UART
> controllers) to bring common definition of "current-speed" and
> "max-speed" properties.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
