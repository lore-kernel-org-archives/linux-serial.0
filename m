Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316E3603EB
	for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330453; cv=none; b=PlgskgbealGYnCy299mlEKLUVvJ+H8NHIqaSZsiPYDnzmAUCgpAi4OfO2q+/AVDZ/hejg5CdnUSCV29OZsgr2oD/j+6WqD8KtxeQ2bW5AReqg54a27a/TZV7g+6cRyJdhAG8IM6Fgjo5xpoRFaYSQexSh2iGTQdW9PnvBAvWdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330453; c=relaxed/simple;
	bh=ZXeo8EI+t7/t3ez1NovFOGBbAko3PEvsb48iBmoNbLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRATxE8lzITb8W34gNl4NTsHSdX+5VFK+aFaxbsbgr/jhrjcuvEmh8VNVoNsZKxWl+qEO4JZ10V5e4SrGDHCxx86DnqTE6dQA37LLeSV8OCWTX5AfMDaFvBqevNaO7fijNIbCa5FBhvei5MfgAKFZCbLvRf/HSk4rD1r3IyuD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cMfr4TWX; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cMfr4TWX"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-977258a75d9so784493241.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2026 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787330451; x=1787935251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXeo8EI+t7/t3ez1NovFOGBbAko3PEvsb48iBmoNbLk=;
        b=cMfr4TWX4yB+BNoj8GPzVxL6MUEu+d9LTDAwo31HuqlDPiWieW2OkFm1WO7YbHVwlf
         eN6t/YDIP+uKsPnNGiljU4p37Wg2TEWa+u4qiIy7M8YcOILxxx6qDS+Krs84Twcs3A8y
         hzPs2sTnsmdQWUiulcO20AHbDfdd4rLyG0oSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787330451; x=1787935251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXeo8EI+t7/t3ez1NovFOGBbAko3PEvsb48iBmoNbLk=;
        b=DrdiadIOP6MXMTr2yqY+LAq3lm2EzsZmpZWKIwGmHdc0sSmHgtB/7PYlgHtaoGVy1e
         9VG7fNYhLHYmG1oGoNGlTwiaxyKs39Du7s4b2JJ5gP/EjDMmBq6u+O4f5Sabybv7LYPE
         S6lTNXcMqLpFGFVS/i8zBhUBouySQu/994501O1K0YEicPWVIlT85apEURfQl3bDF5sl
         gk4TXg6IIgEOLXn7m2W50J9jcfTQZxchWJsugsVY8Oepmf38UsS0WgAxWZNDJ3HSnOoh
         gdP/oMaWepuhHeeYDQtCeG0i5MH1llZ7/G/7VzLBWXGbYWDWtWxmmD86/T7RdFzoAkOy
         7/yw==
X-Forwarded-Encrypted: i=1; AHgh+RpnGUz1ht7AVK6cvf00+HH2UnRSr8Tqvr4cFWHg8U5nxyFt3KHDKblR8Ggqn+A2PVeC8QPhkcuu+ZMoQ1A=@vger.kernel.org
X-Gm-Message-State: AFuF++l9WZJqC4g2qVx+X8vwFieInfET4eETokJ6WZHBgD//hPzECA4t
	K3pKmPLJ+6vGMidXVE6uC3IMuhvlFBnuJTgMxhwT6w0SoykkYUbzRFCCaHUQf2LX0fK/2WiNv5J
	9hE8=
X-Gm-Gg: AR+sD12SRbaAE97MUS5wEA2NbasUsUFlo+GOisniZOj7yl/1JUvBQfvsQMNtXapj5s0
	TrxoqYpBtg8xKWBxEM/C9rVPqAA4FbMJcCpSKUczPCNJVawzpEIAFixChOpBEZZrgdBvkNr0Cvb
	CcVDFD7j5xBOvlUQn08QXsFRCMfj4Id9y0+LjK+KKmFwtk688qCgw9YQBWAgRQXW5bwQHin5uSd
	tQcZYCkNS0KKiuFDdoolGfTXJu7WLyIfreJo24gYdktbyh/M3r5i2jIGRQ/78KhP9yrJ+7fdVBT
	YBvoxFmqIiqqp4jXTpff3EGi3FK2RKmnLUeMcBomID720S2p+1TcIu/zQ/d7QXlR18x4wd/z7Og
	+ENXLzOt3hYPf/YhnGp9YvVNSaOCUQVfXW6qAzjWYcz8b5tl07NFO55JU21b0IXiUSI6ooLKRq2
	COrL6S1QroWGhjiYGs+lZzWLyYye074ADoKgdP+bIxEbrSeIlOeE+6rsyqO5dkt2fcwS+18Bk1A
	xLmW04hN04yf170mmp/Eevcv0dO66s=
X-Received: by 2002:a05:6102:162a:b0:778:64ab:9772 with SMTP id ada2fe7eead31-77a6262e608mr3192137137.11.1787330451023;
        Fri, 21 Aug 2026 09:40:51 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c4e90749fsm9441474241.8.2026.08.21.09.40.50
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 09:40:50 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso1048534e0c.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2026 09:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrt0w8yxwQpwcjUPpal3mkrfo985kayNzGCndjVXFKUzT6X7fAJmAiK1XKHHW2dFscqzNiuUaBnKTBBEHE=@vger.kernel.org
X-Received: by 2002:a67:c996:0:b0:77a:9991:5d08 with SMTP id
 ada2fe7eead31-77a9991cec1mr1941674137.9.1787330449569; Fri, 21 Aug 2026
 09:40:49 -0700 (PDT)
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
 <c0657108-1958-4c4c-b5f5-0eb24e81b2b4@kernel.org> <CAD=FV=VY4AeAf=TMZfJYRo6C0iSqmL-P0GzxRvZHfnNsf+GnYQ@mail.gmail.com>
 <56db332f-a18e-4a9e-be9d-67d2e25c3666@kernel.org> <CAD=FV=WUMKGRUbAyd7XFFc-NGoJEKRwu4MaUnEQUDB9Mq6YYXA@mail.gmail.com>
 <d6685094-b241-415e-9e56-d2fba75f3269@kernel.org>
In-Reply-To: <d6685094-b241-415e-9e56-d2fba75f3269@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Aug 2026 09:40:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPu5tuWA7MhC=48r=1uP3LK6hSqY7Egy=56V1Dqq1wRg@mail.gmail.com>
X-Gm-Features: AcwNN1WVXS8N4-UYjDXHL5iUmkkapXer1429A5JjKjwhm2wT5WS30SWZHssAmw4
Message-ID: <CAD=FV=WPu5tuWA7MhC=48r=1uP3LK6hSqY7Egy=56V1Dqq1wRg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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

On Thu, Aug 20, 2026 at 11:51=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> >>> I think I've presened my problem fairly concretely [1]. If you hate
> >>
> >> There is no description of the problem at [1], except "bootloader adds
> >> the same type of calibration data".
> >>
> >> So I repeat my questions: to every UFS node? To every node? To one UFS
> >> node (but how do you guarantee that?)?
> >
> > I'm sure it's not what you want to hear, but I guess my answer would
> > be "for these boards".
>
> No, the question is how many aliases you need. Devices might have more
> than one UFS storage, e.g. ExynosAuto.

How many UFS aliases do I need for this board? The answer is in the
patch that started this whole discussion: one UFS alias.


> And then someone might need to calibrate UFS and SPI NOR storage? And MMC=
?

Not for this board.

If you're asking about all future boards, of course they may have
other things to calibrate / tune. My point is that the contract here
is between the bootloader that will be run on these boards and the
device tree that will be run on these boards.

FWIW: the idea of a bootloader using an alias to find a node is not
something I invented. Coreboot (the upstream, open-source project)
uses "wifi" and "bluetooth" aliases to find nodes on Chromebooks. It
uses these aliases to place MAC addresses (which are stored by
manufacturing outside of DT) into the DT nodes (where bindings expect
them). Perhaps coreboot is doing it wrong, but this concept isn't new,
and I didn't invent it.


> > I'm not quite clear on the "overlay" suggestion here. You're saying
> > that we should require the base device tree to be compiled with "-@"?
> > ...and not because we necessarily have any overlays upstream, but
> > because the bootloader will generate an overlay dynamically? Compiling
> > with "-@" would mean we could give a "ufs:" label to the UFS node and
> > with "-@" that would be preserved. The bootloader could then use the
> > "ufs:" label to find the node. When compiling with "-@", the exposed
> > labels are essentially ABI. Did I get that right?
>
> I am saying that if you cannot answer my questions earlier (and you did
> not)

I'm still not quite sure which question I didn't answer, but I guess
at this point it doesn't matter.


> thus this should be treated as adding calibration to multiple
> random nodes, then essentially you are reimplementing overlays and this
> won't be accepted. Instead you should use overlays.
>
> "-@" will give you the labels in __symbols__ section, but it won't be
> treated as ABI because it is not feasible. No one would remember which
> boards have @ and which don't thus which labels are needed externally.
> Only a comment in DTS code would prevent it from being changed.
>
> Well, same for aliases honestly. There is no tool which would guard that
> ABI.

Given the above response, I'm a bit baffled how "use overlays" helps.
Each individual board will have different calibration data. It's
presumably stored in something like an EEPROM on the device. The
firmware is getting this data out of the EEPROM and putting it in the
device tree. This puts the calibration data somewhere the Linux driver
can easily find it. This means any "overlay" would need to be
dynamically constructed for each device by the firmware. In order for
this to work, there has to be _some_ guarante that the firmware can
use to find the UFS node and add the calibration data.

You are saying: "no, there isn't."

I suppose one answer here is that the UFS driver in Linux could get a
phandle to a "NVMEM" device and read it directly. ...though it might
not have permissions.

I suppose another answer here is that the UFS driver in Linux should
somehow figure out how to directly query the firmware for the info.
That seems unnecessarily convoluted, though.

...so I guess the answer is: time to hardcode the path in the
bootloader (shhh, don't tell the DT maintainers) and end this
fruitless conversation.

-Doug
