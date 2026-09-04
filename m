Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79D5013A7
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561797; cv=none; b=BF6hJtIRsTnRlT1wkzqQGkERZDPeMK4qFW4H6Em2IBhdSSqJly6bjKh2WRqptxJnQju298tQB9P8jFmw9K78NiPqUrdCGuD//RcggD8VFmjVZ+k1Hto8KXkSqRPMX1pS51V/Z+Qxz9LQy0svkv+K9g643feir2fwewFjZP2mKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561797; c=relaxed/simple;
	bh=yQlciG4UeR6ZpI5LegjbxAmEArAFXIkWdyeVsAKF9t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IasZVCO32PCFBnlEdWG9ld/FbklwK/kKfy8xcLjZCPvFlzy+B9INLaVSihm+70PQOSVss44FmZ5iDk+fCC+BPKiV1INcNJDAybkaDL2qTeFboUafAkNObI3Dysnn3+asN6/3EJHkP5db2Wy21AuSWegUb29tBSGgtiIAl52AjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvZK3m73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvZK3m73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683DB1F01562
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561795;
	bh=yQlciG4UeR6ZpI5LegjbxAmEArAFXIkWdyeVsAKF9t8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lvZK3m739I1TAyBKURTF7/Kb+X2ZvvFj247sZaVM2Y7KEEHO6/yynk1kz7XaKQ59Q
	 ZvCVbI8+x0VTCsi57uE8TkCQukaD+TlAzX49WyMaWQcYOhfEG2nAeOldmX4fLJsqtv
	 4zERRJoM6irlSNSACUu0tj579xmg5sRMUxAWsCiUA4RiNAWBBKAmekItSw4plubse5
	 MnDvkDeFzl3+Q9bcQdKqRsJXwNy3j9e5KJklRJnrpQFdJTvBflUWTrXi2Ufll0eoz4
	 1brvORcXUrICOhRZAtNUhvHABaZTaeMOoBl6pZbSio5rADb2A6ErZ5fIkIdiwmmzDi
	 t23Pc83ITvzPw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b5607bd3b5so1362702e87.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 15:43:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByxwIOCRKIV4/IGqh++NxyLDZmDqWOrOq6VMaB+E0LFW6hynuudGIw6q2XxfGMKxyS4dn7mSaceK5Msjc0=@vger.kernel.org
X-Gm-Message-State: AFuF++mMwdFz/CTMkCCaymeF9qhBN6K4iSS5rBXCkBUXLgmuprpJUIBu
	hj/Rbd6exSxvGL7oK716uRZUtrj3FT/cUB5gYsECBViF5BUDNZkv3G8UdFVgqzVUFVpvRTa5uq7
	5UP2U2+OMNyIb9uZjLgmWi3xzspPQd3E=
X-Received: by 2002:a05:6512:114c:b0:5b6:184c:7d9b with SMTP id
 2adb3069b0e04-5b6184c7efbmr1171058e87.36.1788561794026; Fri, 04 Sep 2026
 15:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com> <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:43:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLnxmDmDQn=gYkKMvT1GCYz50kodMTfuxEL2=7H9mKU4kA@mail.gmail.com>
X-Gm-Features: AcwNN1Vycc-Z0L8Av9C-2Ir33TDG5kELHbymgbWMx-Yh-6kR1ncYYEZ285jVOQM
Message-ID: <CAD++jLnxmDmDQn=gYkKMvT1GCYz50kodMTfuxEL2=7H9mKU4kA@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:39=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
>
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

This is really nice. Compare the size of this to what was initially
submitted!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
