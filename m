Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F91940A1
	for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001153; cv=none; b=NJZ1xBIBpQNl+13rNxblFoYhi7wV4uVdAeWo3Srk5KeK0wkY0LkKYNrspZxBSPrbZbE33McwHXGs8IFhPUjtOD3pU7/PA35YiV4BxPSwYWpRalss9alC49drwOngabqV+HZTrVcWibanTFy/yOPb45hifUGB0W6nXIjiQrQUz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001153; c=relaxed/simple;
	bh=s3e2+5ErfhqMPd2m9183lfzRZ3SAL+PNdFL42U93T6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEXApYm/sCiCwGLacA0RGyNz2h5AAxppJH03aV5tyNx8O5rI0GmCKCTBgpf4DRfo5k2jhWQBWqr43SBiLXl+ALRagf2SRsJPv95o/p8p804UEH+g3QVotaDp1+xOtq+zhOfiGnL+ciSjsw1PwpMOe/HEZ8TdUyOhkIdX3KJl1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OsLJtb0L; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OsLJtb0L"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5957753e0efso4673111e87.1
        for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764001149; x=1764605949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3e2+5ErfhqMPd2m9183lfzRZ3SAL+PNdFL42U93T6o=;
        b=OsLJtb0Lr1Oi2tj6r9UDMJu7KR9zOMZSpDZ0q8aonFlufY0IP8Fhzn5iFaXBBo+m5s
         TGLzAmWzIl8zCrLQCDAMKceApG3QwbKHs66VlYxIKD6VHEkNA5WR9WDBrW0z0AmzORba
         +U+ZqanIusvwN55SW13xEtHFmgXncbKshoxiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001149; x=1764605949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3e2+5ErfhqMPd2m9183lfzRZ3SAL+PNdFL42U93T6o=;
        b=K/x+xJgXMVBZzlavYhWG+RPd9QW7NTc1/QgetQuORPJwUl0iplSL9++WDq2Ipb4SYy
         K3OwH9c+MMc0XY6r1AMobZ7uPiWZlGlD3Fx8Zp3ZmlTdsAC8osrmV3FMg75NIhGuwMt0
         FNg8gA1nIc8m+y0eTCbdJhx1Flki+pmYQjg80j/YHtJJ/Zx2G3rBmGBKqN1cUi5E3VeN
         jnXa3CcL3NGiOJi7k18eXSCf2ZYfyX9nGOds2WWIZd4V6Qq2aU81nmjQPXonjLYY+Dcl
         GPGsHDE2amBQp0ArXPs/EcqR/Zy6zN754hKnO5cOBbyfUUMyDUE2LL8OIpgl12VVRR53
         /ZNg==
X-Forwarded-Encrypted: i=1; AJvYcCXlKsiyOBNJFwB1Z9svlFMV7wfLB84ICytIYNEuDsA4eExbk0cM80GrbgT4B/jjbl4IRI+OMh+A6aoXTGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhz2TcuybGXLrR5V+KYA5E+YF4LCZHI4Xwn1seBHHBzWcPZT6R
	voX4oPFqAHJJe6UfnVmrDoFrhvYq/f+eC+LsxwfIxGXqOQhcLG/jDnt4hF6TNG8wVZ7xMOUaPLL
	xW9vO6iiG
X-Gm-Gg: ASbGnctvHH+4NRD7hUH+vZ9KCVBwAYvy54YL+kJihKGhcbLvPw4dodx9ndmOe+Tp0js
	fq9xYiG5ui/WBbwzJQRp+GgGwI3Qh3tIZBbPyZgw9fS3Wy4PU7nBY/fMHhfV7EkUXe0TyNQPAtj
	B+U8YScDTnd8KeoiSXWylnBKW/S4I2NGp4ekbwV231mhZ9AWBgwPPj78NuPPQ0RA2UsJ+hfQ9kP
	oye51uC7IHtxsapLGzLFvxwhqZWgS0Xo1kykmpfFjMVsS5rI/3JR3afDe43P1TdU/54eITjBQ62
	AmV0z9tSwdRijk8JBaiTyldS/e7gaobM6uNJICBT3XbzhplKlRctodgFOmFjdiOmK677pt5geXn
	5fZgBB/jqMDEeUOxx3ISxqy0MozXnn8XzByKUIh65f+2j2PifN6mdo1MhRiYftkO0NGvIB9DOsQ
	Ls7i/SSL/1paq9znwHrtqsZ72Amg8Yo4XZzMwJ0FXWBr/YUrkYUQ==
X-Google-Smtp-Source: AGHT+IEVODOQaD0OKRpfjZfm6ELm099Vr1bfQLGyY3BJTL5EnJc019JkA0nhoUbNNdah51LtfkqG2A==
X-Received: by 2002:a05:6512:118d:b0:583:903e:b5a4 with SMTP id 2adb3069b0e04-596a3eebb7dmr4141626e87.46.1764001148557;
        Mon, 24 Nov 2025 08:19:08 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db86ab3sm4267245e87.28.2025.11.24.08.19.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 08:19:08 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957f617ff0so4807349e87.2
        for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 08:19:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeJ1Xg514NHZ5gKjRzlOgdCiBWLWuD7dpm4cUOnJYxDCHPMoicxGmZcB8A9Bs9730/xY9GRkyhGucmofI=@vger.kernel.org
X-Received: by 2002:a05:6000:2504:b0:42b:5448:7ae8 with SMTP id
 ffacd0b85a97d-42cc1d2d6fcmr12194643f8f.29.1764000799689; Mon, 24 Nov 2025
 08:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111192422.4180216-1-dianders@chromium.org> <aSOKS35/huSWd/RW@duo.ucw.cz>
In-Reply-To: <aSOKS35/huSWd/RW@duo.ucw.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Nov 2025 08:13:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WVeiGa6YkRmce4McnePEV9X_n79YA0bywPdNZcZCV=ZQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnTIIDYlcAzuiT7QR2OuZm4XUUvQ7JBRQh8rXJBFJr7sqsbbpHBMlqok64
Message-ID: <CAD=FV=WVeiGa6YkRmce4McnePEV9X_n79YA0bywPdNZcZCV=ZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: google: Introduce frankel, blazer, and mustang boards
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	Roy Luo <royluo@google.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
	Julius Werner <jwerner@chromium.org>, William McVicker <willmcvicker@google.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Drew Fustini <fustini@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 23, 2025 at 2:27=E2=80=AFPM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > This series adds barebones device trees for Pixel 10 (frankel), Pixel
> > 10 Pro (blazer), and Pixel 10 Pro XL (mustang). With a yet-unreleased
> > bootloader these can boot to a UART command prompt from an initramfs.
>
> Well, booting to full system with working cameras would be nicer,

For sure!


> but
> this is good start. Do you plan / do you have resources for full
> support in some reasonable timeframe?

As you can probably guess, I can't really make any promises. :-) Of
course, "full support" of Pixel 10 by an upstream kernel in a
"reasonable" timeframe could arguably be impossible no matter how many
resources were thrown at it. There are just some drivers / subsystems
where getting upstream working as well as downstream is working
doesn't feel likely as a short term goal.

That all being said, interest / support from the community helps.
Knowing that people are interested in this work helps motivate folks
at Google and (hopefully) upstream maintainers.


> Please cc phone-devel@vger with phone related patches.

I will try to remember.


> And... thanks! :-).

Of course! Hopefully many people find the work interesting / helpful.

-Doug
