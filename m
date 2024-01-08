Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89E51C46
	for <linux-serial@vger.kernel.org>; Mon,  8 Jan 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lY+6josP"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783234dd689so81614585a.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jan 2024 07:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704727812; x=1705332612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzw/cgm0NqSiQjobJ8Qq3PX7WH99Q7opW3VxmOxNOVc=;
        b=lY+6josP6BMPTp4bR4tvGbsOd6mdEgpAadcly5LWlQadAqv6cgoWlDr1tW6WjcSzx4
         8LJjvz5HGluFQ0FN41mX1Yp5TllNoVBMfmkk8vVk1uRD0eFdE1CRQlLww8khbgECZT/M
         ZUe0pUl94wXOhjV3ZRpGVvXnQRpAHuflMTF+doZODKjId3G5F+kngjf/2VEnqb+LSsw2
         qdXpPL+y5mI+XhilGbmtg1lBd5A8ZM39V6Y8F52TAmkTAnU88dA4fHiukhCxpZ/wBo4O
         pXzLM6jfTQnIXtur4UnVsr/B0980TDais4VYwzfJJ7LH/7gT10mysYfvkpYKTS6oQWv7
         3Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727812; x=1705332612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzw/cgm0NqSiQjobJ8Qq3PX7WH99Q7opW3VxmOxNOVc=;
        b=h8pQGz8QceJbekfkzi+IW1TqYeUsyIc3EPDE2uMeju2BIZFllhRycbWER14psqRnlE
         gDzVcnacpjUdYyVLsWGqMv6MDchNqc2MDa/AJ4NvQGo8Nh7Cux7B2MRkAapGV3cMpbGq
         Yh9XLNiH470oApQ7N85C1WX7g8A67rSsMLh3mr8aiCCCV6sgv+45f98SWD0QHt5zwJsJ
         1U8UUl7zvW3Zs8GqTKZ6dRbnU+gg+jXeWZgfAXAPWyf+mfcDPB7GE69Ve0wK1/NchNs/
         DwarNTr8u0iclzZDmki9ZdDzsAUu6BMPEE/4qwDkEXcXPWGkBibO8c914muNiy7qqQms
         CgCw==
X-Gm-Message-State: AOJu0Yx3kenbCrrkH5C2l5deHtYejQ+Xpe4ugIIcuQBVfWwozZB0FD5B
	7z9AYJ5qc/IIbihTIaYSR57C720KmX38gYI5ffNMsQNmz+dhCQ==
X-Google-Smtp-Source: AGHT+IFYKrhFgbRYAiEyPYoqEve1qSR2GT6wdqvLM/UdItQ5yRGST7HVQm+lQQheC7taXe1ZY76iPAlFAoLAEnpj6vY=
X-Received: by 2002:a05:6214:1302:b0:67a:96c7:4c90 with SMTP id
 pn2-20020a056214130200b0067a96c74c90mr4913500qvb.38.1704727812403; Mon, 08
 Jan 2024 07:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125805.661725-1-tudor.ambarus@linaro.org> <20231228125805.661725-9-tudor.ambarus@linaro.org>
In-Reply-To: <20231228125805.661725-9-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 8 Jan 2024 15:30:00 +0000
Message-ID: <CADrjBPoBPrQh+73eqk_oc0VXFqJrLhY+BH4m9dFN=65QnpB4DA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] arm64: dts: exynos: gs101: remove reg-io-width
 from serial
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, 
	andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Thu, 28 Dec 2023 at 12:58, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Remove the reg-io-width property in order to comply with the bindings.
>
> The entire bus (PERIC) on which the GS101 serial resides only allows
> 32-bit register accesses. The reg-io-width dt property is disallowed
> for the "google,gs101-uart" compatible and instead the iotype is
> inferred from the compatible.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
