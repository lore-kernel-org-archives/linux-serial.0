Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958527991C
	for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259159; cv=none; b=ICts4cfCQasdrA5CtfkVCK8XwanG5XyII3nz50IoACOhu/NZeQyClF3wHGiHIJUP0OcFuw/tx0Jb8RBzUyretrZRBMwKTKCcWNlIVYb11omq8+4ScrdKVTNR8U7InhErocQtN8yozdckGRTzR3NUTs5Wr+ZuRFJKDSWX8SJaCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259159; c=relaxed/simple;
	bh=vLCNSJ4DxVZDJPQ7cVNRDySeLw0NidDKviv2DX8YsFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgEUWdFciIG80CRhAjvu5znWlEVO42Ji/HzIu5aQbMvhOYz0OIXOJ8Mnjb1WQdfKfL7eaJqxDGXUOVbbqKAEAh7++9D17MKTk8KEIZ77NxY8NL6wEVJXE0nZoTOWLvZLqCLxfl16EJBiT6WFJsqK0mSmzFTu4W78SGmIPqf+wDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WF2Xc2ES; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WF2Xc2ES"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso5159332a12.3
        for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2025 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753259158; x=1753863958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLCNSJ4DxVZDJPQ7cVNRDySeLw0NidDKviv2DX8YsFo=;
        b=WF2Xc2ESZUXC3I4997szY/O/Q2b8sQFJDwGqigrANiJNjwrQgnWk/KgiUjPftfzFf2
         YUADAbu9eIdyFhPrkqBiefiC1jjzmUhXODL5cM5E4M+gVRXQLQJNJCAbF5LQAI0FEefj
         q8MxMVO9ld3BbUf/aaJqD6gt8F++fbHQ/OBNzs7YGg4l1EmRhzW/YAVxoXGzw4MRoUre
         7p+327nZRUY2hjKCflgCpBZrPK8JaJWKKILr/859g7GVsWIzAzbdinzhOLaP/UOkmAp4
         W3o0M+K6QAVSrxdF8uS6CNj2+NiV7wNwVJnNH7YJrUx58XVYBith9M8CmJspWHHkuxPW
         E44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259158; x=1753863958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLCNSJ4DxVZDJPQ7cVNRDySeLw0NidDKviv2DX8YsFo=;
        b=ssMi859yfSpihzyZKhDQvZUdMIvyT3b74AETCkhKtlidBvUZIvFXQAPEqXnA+89kRo
         L3UFa2qQL5mznHHuX8+6Ze3XaO2+U9/6xsk5HpAcMNnawyS3Nnyjz4+cVdTdkaby1eXX
         A81umyIRTvGjbKFRX+i9sduJURJwduL+aQWnc38uGW9fKEU2X2xUOFg6q5vb8FbgEgIa
         X+6WlhX6M+0hfmmHkluQaQMJoHUyW4DLKFvfxvcaFDzqZj2qnPi9HTpmNOaxUmmGbPHn
         0IoqaF5nKXHnja0MZrNiaEhbf7+58GT5PrRRcq3INK7p87uaizfSY1MvISMw6ncYeTAP
         k1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe+CJF9SrSjzlbRRLXvSsnB2ps2VvLlw0H+8AUksjRs+h2VreYNglghppL3ni4JJ+ZnDFfclzRTRvrtCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlhD5g/85SBzQHWTHIqFkhKPDXpAvkhzjSAs0ENvBH/K2a3Vuj
	0CA4alFjmhgPNCad0PifjAHrNn2LRSNbeNt7KJfNp/C61HSYMyt0+Jy0fvMaZhG/mx1hc/mjCAQ
	NyrIkabmHKRz2JFZeG10uUeEghWE9/Baa+NW9Th5nkQ==
X-Gm-Gg: ASbGncuCbrLAguPjHYkahB7q748jmg1WQCGwguupsByA8yxbGdsSs4wCx6Q+aYfuDvc
	2a6XBf66jZh9nzjH04UWkJkOkuSUjaShDDsSQJANuE7TpKP7+jRVDy0jZqtnb4lSJi6rOJcdh6+
	WtPzHRxwAaoh7CJRSTycPLn1jriW789vfiZd2dQalpZfcj8FZGZftFXG0E2RvzqV4pfPAPW6HcC
	4c8dRIpWrj8WGijA5OA7ivJADoR5GWGRBdqlSXX2q5KCh0g
X-Google-Smtp-Source: AGHT+IFzwCafFosCdx131zbcEFY3D64m+7mo0loj5vAsYVkMFUgy5UAHuuRGjg5yAkxctR2cI5zO8+e+kqhHgdsFxCw=
X-Received: by 2002:a17:90b:53d0:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-31e507dc7b4mr4498294a91.24.1753259157929; Wed, 23 Jul 2025
 01:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-axiado-ax3000-soc-and-evaluation-board-support-v6-0-543979a60ccf@axiado.com>
In-Reply-To: <20250722-axiado-ax3000-soc-and-evaluation-board-support-v6-0-543979a60ccf@axiado.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Jul 2025 10:25:43 +0200
X-Gm-Features: Ac12FXyLbBDcOzrp8fBxUqR9jIu-gUOTaGAF4LxjwERQBqGacqdoGbliH_T9iv8
Message-ID: <CAMRc=MdFoAa2omJgL__4mRqX5CYyhZ3VU_Uy-Tf1oPSuZdV93g@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Axiado AX3000 SoC and Evaluation Board Support
To: Harshit Shah <hshah@axiado.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, soc@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	Jan Kotas <jank@cadence.com>, linux-serial@vger.kernel.org, 
	linux-i3c@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:16=E2=80=AFPM Harshit Shah <hshah@axiado.com> wr=
ote:
>
> -------------------------------
> Hello SoC maintainers,
>
> This patch series adds initial support for the Axiado AX3000 SoC and its
> evaluation board.
>
> Change from v6
> - Ran "b4 trailer -u" and add reviewed by Krzysztof
>
> Add soc@lists.linux.dev in the to list and send this series again as per
> suggestion by Krzysztof and Arnd. Thank you.
>
> Checked locally and able to apply these patchset to soc git.
> (git/soc/soc.git, for-next, checked commit: 7dfbf3176d886ff9a0c7786942d3a=
89809d0641e)
>
> Sorry for late request, please consider this series for the 6.17.
>

I can't speak for the rest but do you want me to take the GPIO
dt-bindings patches through the GPIO tree for v6.17 separately?

Bartosz
