Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A89209686
	for <linux-serial@vger.kernel.org>; Mon,  2 Dec 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153049; cv=none; b=r4OXR/7O9sd1jn7nA0ygcLQL3krlmzkUAsNOTCzVxeuhjwAgT8/WGZcidUxrmR7QdX6BOaHnjkdrLCJ5ByMsg1uLnCUwGMj1jWx/V+Gkd6vSGNESEuWcKUWzRl2/YJdfi+X69ucnQnQvCYRD8Vgii+mE2wdfNzsoI6cV03TAONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153049; c=relaxed/simple;
	bh=+Xl8s91uz6z0166yhunqPMLThqhGtXNxm6DGP1hGyaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxOQ11jfRxdh4j+afitkYkW9ItOD/eMNOZr4v4QxXXbbwwk5AERJopoNgSj/el7t8N0501jHdMrDEvBdk/S5yFnlsagHxU+8WyzrVgSZp7L6vwsvAJ1uafbdGAticlR764Vg5YWYdkUDOCvn3rwpGpSqbFweY+nv4VPdj30xh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5Lk6NCL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5Lk6NCL"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef0ef11aafso41734517b3.2
        for <linux-serial@vger.kernel.org>; Mon, 02 Dec 2024 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153047; x=1733757847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMx9usLc+8H+1O3Ux5r/Qz56sk5GB2iRle+hBCjO6+0=;
        b=k5Lk6NCL/Q9S2n2SD7XUQy3GgjWsjcXzD2V/+giR9rhAUrOGGCsMQ/r8/8dAPLYGsW
         ulCSdELHI1aTBluKfiDycsvm82o8sgvRyGtiXYSAGP0/WxrT27xmDDDgbwE+M/CCvKEd
         0uh4t60+ULG1Ks4uJ4LNZYFklbSa+BPzal9TSB/GfYKX+XXRNKkYMor2pa3wur1kOHlS
         FwhQtAJpO5o9tSZUZtX+ynvGl4TSVftm5BgyNchSRDtjBsudY0vkHF6+9NmXWz9zclq8
         x8WgYa44Bx7oS49t0Opu8E+xUy/9ma+sg7UrILv5kSFdznhmNNCq9kHIJbfa2juCgfhX
         oyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153047; x=1733757847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMx9usLc+8H+1O3Ux5r/Qz56sk5GB2iRle+hBCjO6+0=;
        b=D2t4A5Mvtuhsdmi25itscZf1TIdRkbnfR5s80lt4M+bKL9RDaVgvPIoHHMBPinStWZ
         ZybKJvEczLPwVIym7zxw0sxhxhhXJA94GefUi2i7PzTa51zjwH7G52YoD2rqRJ9PPVVf
         tZIQ5uwmY+ajYWgv6+KEzOYcqc1nQUJyPPvDtTqgY51FbDc+ZCUoUq+L9ofrNlI0RxvT
         ez/QAZ0n9jMEb5uzRx/YGS2soqEmSQ3oUzKeOC9yXQfUyoTFMwMwykEEL/b4Apmvhtwp
         ojHxrwgfUP4HssDPdc8DYzX2RbMAn9nlxaL0KLnBEiUougjWdl5efEZZSQY9KhuIiTYb
         w17Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTFOFrAqDEqJcSnBySRM3esJ54UnOcI0ij5QSXBJss35UcXNOFWnHB6A9GxOtj4/uvCwC/VS2pg2A2kMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa1BYtTKx5na2NmigGau6Tygqhy3rCd75aINXxWGU2IuKCl8Q
	oO4r+el+d40wDoBkTcSanf1NbzCFE1jDj1DdeCqucuruoQ2FqbAMO5IkeHcpuNFhYR5yBnwxXup
	l1Pt5N3GM1PpopCjKC+A/JN8eem7HeYfO3u3ANQ==
X-Gm-Gg: ASbGnctBiIt+qs1jBSuI79+ITDxoQgXLyQ6usl0AksjseAfRJ5tStbrCNcaufxCIIZh
	5RCvCl8JGe+aYMNmdEOc1LlTLudyy0OF2
X-Google-Smtp-Source: AGHT+IEGJdd9IwF7sSUzoqqAWgtWCRY1a0UMhBwb88ErQOHU8BaxnCWHnPMW9+ru+41yFpFYGuJqHhtoLonEK76JtT0=
X-Received: by 2002:a05:6902:1895:b0:e30:c614:5c3a with SMTP id
 3f1490d57ef6-e395b869b78mr21357729276.3.1733153046692; Mon, 02 Dec 2024
 07:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732030972.git.Ryan.Wanner@microchip.com> <e9e9e4cf0753422706bdc44fe7d20ca3a686ce7a.1732030972.git.Ryan.Wanner@microchip.com>
In-Reply-To: <e9e9e4cf0753422706bdc44fe7d20ca3a686ce7a.1732030972.git.Ryan.Wanner@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:30 +0100
Message-ID: <CAPDyKFpN-2kowdi_eCtbW1WEdc5OKh7tj60GfbPPBR0Hbpyj5Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, mturquette@baylibre.com, sboyd@kernel.org, 
	arnd@arndb.de, dharma.b@microchip.com, mihai.sain@microchip.com, 
	romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 17:42, <Ryan.Wanner@microchip.com> wrote:
>
> From: Dharma Balasubiramani <dharma.b@microchip.com>
>
> Add mmc binding documentation for SAMA7D65.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> index 8c8ade88e8fe..ba75623b7778 100644
> --- a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> @@ -22,6 +22,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,sam9x7-sdhci
> +              - microchip,sama7d65-sdhci
>                - microchip,sama7g5-sdhci
>            - const: microchip,sam9x60-sdhci
>
> --
> 2.43.0
>
>
