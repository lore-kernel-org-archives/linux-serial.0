Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC9414A1C
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128139; cv=none; b=K81BWEc96rw634aBMPSJKmCTfd36nEQLYG+4xaey9jeCxgSh0Wpn9m02/r+gZ/5Hv3A7oyqm+3nm+ZFlSEt/nbz2PuYI5ATYaNpN+xK/9CE06JfDVhEBQaBwcT0vFnqQgTI2PD+XqZsPKSmgquAvMw4p8X7rh4cYenLm8ObQ15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128139; c=relaxed/simple;
	bh=cwJVuh2Zw3Qt8AXUUok0G3WmGrLxUvlvv8s7D0px7Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP46tSxcu9Rmc9kstzgtl9kjF9Zvo5/AFqVT0TNuLH0/4LwLji+OH8kt0v1/MCrQ3ZsSqRnkSTbXraAHunY6hlv8dzNVVDljZJJPiHqv89imiBND8WIh6xeZBJt8gjwrMjb0kHkK/HChB0Nd2MwyVsSQO+vruDXRA1sKB3FSF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD5Dsuw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD5Dsuw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C223D1F01558
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787128137;
	bh=cwJVuh2Zw3Qt8AXUUok0G3WmGrLxUvlvv8s7D0px7Nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YD5Dsuw3BZvBKFtfmW8bkDPQpa0BWqLAY4z28YzLE/INPClagphYH4yg734Xw5Ko6
	 det6frZZqWBOjKJ4/iAbL+/1wQ1arTcvWOIAj8N735C5q1XfuMnTklpeJTGHxeVASr
	 5GiIfFdLyHLr7Hm6zlh2kF3hytn4aooz5RgQi/M/ml9DnIdWMG/r7m7jZCCLy+BmjY
	 Ij8fWK9+1kTbdEvaYSF2MHFmCgbCaKQ+4nmlwKwwZHQPa5XR3EYtFyg4kFul92WsMG
	 QlTnnKjGno4t6zFhX8ZDmbLDL8PkIeqw5W4bah/IvKxXjNTU9Abhc3lSWgwDoe4OEM
	 cENYZ4KLAksdA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so720295e87.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 01:28:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp/+9UePDsXDlCb6h9+7HWNaeondn2fKNmDXE/8Cg527jJGdnYvJRIHXMlZM6hESIFBOL9TWyKSFb1iWQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKbX5XaYUToIa2IRdJX6dcCQ/tpGRnonncHy/HPGaT4GTH1sG
	/D8qv/EE9FSYFKGyzUvkkhHpeDIiMgyb8iW2m/TNuw/kJkl7cFvikPw2ddYfFn4AiD5+DErv/A6
	wlAix/VHCFIh/sHtvzWeYupmO3JowuSs=
X-Received: by 2002:a05:6512:39c4:b0:5b0:1551:d85c with SMTP id
 2adb3069b0e04-5b478bcbc81mr873936e87.20.1787128136557; Wed, 19 Aug 2026
 01:28:56 -0700 (PDT)
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
In-Reply-To: <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:28:42 +0200
X-Gmail-Original-Message-ID: <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com>
X-Gm-Features: AcwNN1Vl05fdJa2xPsl7u4sGvJzUiZZr27GigbzGcGgDC8MP57szGl3gF9DhpKY
Message-ID: <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com>
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

Hi Doug,

note: I know what it is like to be in active product development
with a product organization with one finger constantly on the
fast forward button to get products out the door. This creates
unacceptable stress for engineers trying to at the same time
establish standards and pass formal and slow reviews.

On Wed, Aug 19, 2026 at 12:13=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:

> Is there some other documentation saying "aliases =3D=3D evil" that I
> missed? Maybe some email thread we're all supposed to have read?

Yes, kind of, it was 10 years ago and about MMC aliases for
selecting a primary device for boot:
https://lore.kernel.org/lkml/CAD=3DFV=3DXLuPWKjQBMLApRQxk0K30p_TPcztB7g_1DB=
7iRA9BGRQ@mail.gmail.com/T/
and you were in the thread, it's not pretty, leaves a bad aftertaste.
For, I think, reasons stated in my initial paragraph.

The takeway is something like "the device enumeration is policy,
not hardware information, so it should not be encoded into
the device tree", and that is not an argument about aliases
per se.

As a result (as I think, I may be wrong) MMC gained a few
properties such as:
non-removable;
no-sd;
no-mmc;
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/mmc/mmc-controller-common.yaml

These provide a heuristic for which devices to inspect for boot.
Then on top of that I think people use schemes like EFI for finding
boot devices. (Or they still live with their quirks...)

Now this ufs0 node seems to be about calibration of some sort,
which is a more hardware adjacent subject. Is there a way to
add the entity that needs this calibration to the device tree and
reference the UFS device with a phandle along the lines of:

calibration-storage =3D <&ufs_node>;

?

Even say adding a synthetic modem node if the calibration is
for a modem is probably going to be more acceptable than an
alias.

Yours,
Linus Walleij
