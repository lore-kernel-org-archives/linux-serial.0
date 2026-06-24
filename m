Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E872DC350
	for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308675; cv=pass; b=YHx69XRB9j2gwndKeKMJwv+1H8NVl3fqVxpWWFFcY4gZa2JlfJjcsithZiMBrG8W/OfKv2Vjnk3/pLCDQO0Ex7giwuA1ZZoJTQ3IYSdyA1uuRiCqlsOZbHbbAY131VSixhRGtvReATeHSsczm8WHZkOkw5vu0oziGk4rk2mmVfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308675; c=relaxed/simple;
	bh=4hmQpzJT1LFiuBCedVTY1IO9MEPmTIQMCZ1zdVhoFzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0HLDkUvEacz05Ozh6jHl/gtJsiYkME4JuXsCY6kPL0SV1OQLqqRDjs8JGyXIXtsMDD/hakQWWS8zrUNRQZ4gLDkqtyWmaxZXuzyIQoju3eC+iMl0jOFDjKQj5KE49S57hM7BKNWK7yd2OCLRT9txKdQr4w9hTR6amelSi+5eoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=KfwDRbJv; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="KfwDRbJv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so6872575e9.1
        for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 06:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782308672; cv=none;
        d=google.com; s=arc-20240605;
        b=AjFlu8DMGp3c95FWHgA4muIKvarPMxTscyBIn6nk5cvDppZDByXyQuIujY1hFrk14M
         ItT9SRTarkQvBeTYD0gyjAob+kOU1OEAy1LYtdpxLX6ne3CjfbcYzri7xT/EoxCk4lIq
         Pmji/CwERs+FjJk+vExc759fH96q25GjY2uDEBsfVsEaN+4VCswOYlBG3qr9REe+RGZj
         8AxHlXfbDiB2/J1/h07wyE9ag0QdT4wwdIwPGtGkzM/qRGW6geZ0/WGYXFrproKpnFT3
         IoFImNJerjaxdY1mKhvJdNj7qayxGG7PBUnAtD6OVqBUvCfiZBucpTEU7seoZQVlSQ9V
         kZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4hmQpzJT1LFiuBCedVTY1IO9MEPmTIQMCZ1zdVhoFzY=;
        fh=F4sKedzsKFWvsfpxHZ29j1Sqw2k7Ysmwq4yL1pBmbHg=;
        b=DZe7Rfm5qg1cIEFzF/l4ch5+1Dy8eh+/PopFHqsHLUixnjhsv3jygs2ntv9VAB86fn
         bwUWct7YYFqjHzf8LymyuVeBR0+3EmmiKdl59vjL+NwNCv5RPFl9im8d1+6Pc8PfuPNI
         kJy4DGr1HqUJFQ5CfaLpLPTb36Kk6ffIQyXbLFkaAd+QrOxqLAg4SgQLidWMpTr95M2V
         /Kr0uXLPJmot2MvkyWBQ/yZeZLA30nQ7dUDfJ0b6ZXxNvm56PLh25K9YGeBbOaGqJPvM
         WaZc3M6zbsT88tObUkFa55RVhWBIV0zQXnxBKcGd1aeNzLCM0Siu2czfCZGp1CUmcj4X
         AbmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782308672; x=1782913472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hmQpzJT1LFiuBCedVTY1IO9MEPmTIQMCZ1zdVhoFzY=;
        b=KfwDRbJvBcKDt8Nlt5QHcOVyoaVnG7lSwpzYlHgsaZwctTnuNk/8j0CQhyW21n6IFF
         Yhh4GTksLUQsWqdSFlXQolbrWZ4HZ5a8RBQ0cQcQDHwu75Gflp/PL7BUGLf8TQMXNV62
         Eem7xW0K3yqxzUCj28M+ZuR7mkIAj4xfIH7BUyp+qIxKqFejcXEGl2yQO2LbTgNaVEMW
         odeTnjBr56GUPj/Tp0ragreDlKAgHPO17UmTmrSj8Ua0mFkVxSd01wxAp0799eYAq8C6
         RU9zosab0eCngr/aTgVdy6ulrJMgPq7pj2Cb1oXs/SD7Wc2ZMCY/i3aiTh6apP3Uhveb
         f88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308672; x=1782913472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hmQpzJT1LFiuBCedVTY1IO9MEPmTIQMCZ1zdVhoFzY=;
        b=ZkyklY40Ftbf+Jd5G70SoSBCyZM7y47d2gXJjeSzoGkgmYDbUXTdW3QGN1LTKJRpqK
         a+3DivT/VckNk6vtvcxiKo3W6g7z2BGoBUSrxv8sH9itHn8b+w5594Fc2bjbJyJtbExi
         BACRE0dtRiwvBmB+kre/r7XPgL5Zw7XCPUKMocTtjX8GQo5VWiBd3Z/9Mygyo6r/Kw1P
         GRByQJMjhHeIHtb2bZVU1vNw1T7MOoPB4CEobAG4w0VliDBeJJAvta+XFtUFjaeV788R
         1fA2i9UHSnqwlZWtnU5qErq5vT3hznZBmzwapO0Y/2Mn+MNrIVG+kVD98ocUMgcvqSzR
         2HjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CiaDT0niBOZkJ6OsQ++b+F5TLJHlhVx0HiCcNyWQtorz69kqkSSPYaAlY0aC1cFMiHj68ZwqteLJl9qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YrORBNfJezlfj/C7kGiPmQIAgeNXg+G1gRFJtwvyJpBIzlz/
	M4OlfYtmXgMykpqF0MRs2X7bFqDIfehNkeuRCs0qAvk0fJjSQY6mXhN5BLIUMmnEuMwQtT7TAGz
	ddL82Lgax6sq/T9EZy3q20jogLF/G0On/YGNyvLmSpA==
X-Gm-Gg: AfdE7ck3NW8EJ6NypRiGtosnzmWyLEURuchmmjKwWRVxWzWhJcKLMsxwAERay31Vaei
	zietmT30hPY4YRqhnD3tB++Bck7vkvplVOLN+EYCHqnDqgU6HZ6noXnBKIruQA4M8cFIhW/NYW/
	48P4FuoqA/C0lxn7bgXhy0Ukzdyb70u9V3YGxBc1eoAbdhKAE2leTfaPNQDQNkXHf4rK9XvwHE5
	OGYlSZ/SMJLEBIGL9zFonzzceGXy9n2mM9Zj334r4W2Aw5TISeNZoHz4LlG0lhLmo96vy8l/nR3
	9Ai8JZdZQc/pGstOxsQrOAXoNKYDkldWn7e/FKtXXyjbzLT4R9C6ZyC8QA==
X-Received: by 2002:a05:600c:4ecb:b0:492:37b7:607a with SMTP id
 5b1f17b1804b1-492608796bemr50951345e9.31.1782308671484; Wed, 24 Jun 2026
 06:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <30aedaa9ffd5ba2d763d8802a07b77ef2d5bfcf0.1782224060.git.gregoire.layet@9elements.com>
 <20260624-copper-albatross-of-youth-6abae8@quoll>
In-Reply-To: <20260624-copper-albatross-of-youth-6abae8@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 24 Jun 2026 15:44:19 +0200
X-Gm-Features: AVVi8CevgRC28tg2RrmLdkUxp5ymSnVB-xqiyZURryTvD9U9Bz7rA-Yxg2vjrr0
Message-ID: <CAFi2wKY+JZZV5vKnKKO91Bk-903+HVKm2a6NF+fufri0r3EjCA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> Please start testing your patches. This for sure fails tests.
>
> It does not look like you tested the DTS against bindings. Please run
> 'make dtbs_check W=3D1' (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.

You are right, I had tested my patches but wrongly. It is indeed failling.
I'm very sorry for that. Thank's for taking the time to explain.

Best regards,
Gr=C3=A9goire
