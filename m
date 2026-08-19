Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9B3E7141
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787182157; cv=none; b=iZNcAX2cFFcW1+kLPGWUJDM5MsuGfv/ZJQJYqVkdxywbKtQ4Z+W7KDcUboBaLqEN0qh2xWAZyQlDUMIpZcHLKf47zLkpRbYrpYYDxyhKxb06oQk3ACRnJDUitLoGYo4JcDQCwGMwz4nHlZ32Wm3iQElNuLUknu+D+axPE0Pg+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787182157; c=relaxed/simple;
	bh=+t/GRCAwSF42wJi2sjOuZkdNg6YgI/3zwyHdc7PNqS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHKXoQ0GagT81RwhH03qw/WUtWPkZZOfBDUUmG3hQf7zEZtrMp3MvAlg6yueSNlNpHnLD6UKmoFGyVoBsd0gRLEDhYA1CHlCBQQibAvrMPR/VlVCX+k6ds/cc5RsD3Gxyte4a1wWRGEnuwlUVfqtOpzUBMnCLqYQzzmw6QG7ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2RJ7MpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2RJ7MpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3A31F0155E
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787182155;
	bh=+t/GRCAwSF42wJi2sjOuZkdNg6YgI/3zwyHdc7PNqS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O2RJ7MpQHiwPRjeoq6uCNd1ZYkdycmUDt/r3oaXlPxPl/y9QrvDFG2OKTKrYFkQE9
	 6N6y/v+eLfB0F+BHKrOQqNtov7pO06xadDBgOCZIXXXHPVQf3sOY8Uf1Ckq/bvAZV4
	 NGVLSMr7uGJnlMYHCiQhbnqliJDpXMxkIw7wp51MjCgcgehmTSXjTpNg/Vjs/j2SKb
	 QTD+xabPpKUsLzHGSUFMyr6bV4TWxR9dWP/f0RVXBxAD3FUQcga1yFrFKgHGZewznd
	 6vR6JTsY938gdCizfpqUaeQKrc6KFO753v84vNxG5J8viNXgyT12RIjh5sNCyrlOq9
	 clo5+HTuvQHuw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso2093865e87.2
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 16:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RphDQhAv0+jwpeMGX06iZmMjcv24R/4VVuQGbdpgR4HiQPyhB10VjzDvmFXmLt597DwkiJQu/fIqLFkESQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ldNuqf0NYHKlaDdD/J29k+JHTODGTA1qeHSoBsxx4N6ns/hZ
	L+ShmeeeWfgyyhiKa7ErWwrQF98yRcWduwGoYdkilGgqfPuEAB25uVIxtAp58X96kL8yYmi7dEo
	EJuYqlFKIlhd9iySV4Ch2FzHBc9nX7yg=
X-Received: by 2002:a05:6512:3ca0:b0:5b0:c95:cdb9 with SMTP id
 2adb3069b0e04-5b478d01111mr3368058e87.23.1787182154248; Wed, 19 Aug 2026
 16:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
 <20260724-dancing-skunk-of-novelty-72c1b8@quoll> <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
 <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com>
 <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com> <CAD=FV=VuVdq_=TQmONJZak84S2c2-2yQ8DS0k_odYsUfg0C+rQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VuVdq_=TQmONJZak84S2c2-2yQ8DS0k_odYsUfg0C+rQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 20 Aug 2026 01:29:02 +0200
X-Gmail-Original-Message-ID: <CAD++jL=VLzW-4eB=izJwaTJ+6xObk9+AQGTDK6ABdrGX4K3vAg@mail.gmail.com>
X-Gm-Features: AcwNN1Ur7ujm3RlAIw_lPfCX_YRoigqa7hb3ISujkLyge01WaVNeGdcwWIhysPw
Message-ID: <CAD++jL=VLzW-4eB=izJwaTJ+6xObk9+AQGTDK6ABdrGX4K3vAg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Doug Anderson <dianders@chromium.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:03=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:

> I appreciate your suggestion of having a separate node for calibration
> storage. This feels more awkward to me than just giving up and having
> the bootloader hardcode all known device-tree paths that the UFS node
> might be found at. That being said, if everyone says that this would
> be a great solution, I could try prototyping it. The trick would now
> be that the Linux UFS driver would need to be able to find this
> calibration data, so the Linux UFS driver would either need to be able
> to find it at a specific hardcoded device tree path or the Linux UFS
> driver would need to search the device tree for a specific
> ufs-calibration compatible string.

Can't you just put the calibration data as a custom property inside
the UFS DT node? Just a long byte array or whatever it is.
The driver would certainly know where to find it that way.
I don't know who or how it has to be put there during manufacturing
or inserted by the boot loader into the node from wherever
manufacturing stores it though. (Assuming it's some calibration
added at manufacturing, I don't exactly know what it is...)
If the actual storage place is in something the OS can read
then we could probably use the nvmem to fetch it live?

The calibration business and what it is and where it is stored
evades me a bit...

Yours,
Linus Walleij
