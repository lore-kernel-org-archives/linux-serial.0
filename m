Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B826AFA;
	Tue, 21 Jan 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459318; cv=none; b=cB1cEljBpouWsinq+Vo+fzRqPxgYSuJ7EA4Td55BCQfasaZYInlC2aj32ttTC8ZLxfzsqvP62M84LvxYHFKih0RVXA88FxZ6KCTjtsLOJx9t0mbiR25WfYavoIyupTyfKvXkQqr9xR0wwenPp6CntGufPNtr6TBoHnZkLtn2yE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459318; c=relaxed/simple;
	bh=kAipTy+8FddX1uIJ7V80DD/M+1JnUHzua06fRqQAdgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBCMMyBSFN9S4Tvyat6URQxxemIW/vA1699DofVcpv6iuVBhy4fp5AXeowybQkw/gxmcQ0TSPjEkXSi+wOR1EEEbTF1UIMGQmaS8w+wq026lMyIeAjLPmmqi9CG265OkDfDsolvuclcOQWGsPi/3Bynoyz4eK7uhgCmQ6ZzeAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW2XDlMV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW2XDlMV"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2166f1e589cso131697905ad.3;
        Tue, 21 Jan 2025 03:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737459316; x=1738064116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGLkX+J1Jlxf1URXI5Jk4oBm02w4k+T980MVqvE2nhA=;
        b=hW2XDlMV3syR3cWK3SdESs+1ErtqCVjCKhw9lmNKVoHHD9KSJKQALessJcXWuapr5s
         1U5gUDgBk52nRgAvFUaF4eP9yEwOdw7QUKsV9Wba2bRcG8Baa5hUggVEInTtYxyvKNre
         lC7X/pd7nClpx1aHp9j4yvEWsv1thDHj1kTxqySOsvOpJy62iXi/zv+z3SnVtEZiUmOT
         Y6VmS2h+J9ANbmrmHteTM0pDP2OxtIlwzDkB9ZVmzougHXpMhCMUmdE+1bv/P9xQ/Jpo
         oOeRBzLTURwzaSVOQUt8Tv6FnXmEDS4+HNGSS8BTT4Y4tdIzUKJkQ1/JyTKaX7DzxPXB
         cYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737459316; x=1738064116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGLkX+J1Jlxf1URXI5Jk4oBm02w4k+T980MVqvE2nhA=;
        b=DsOjKuj7ibJUSeUjenvILmaRMYIfMVyaX8Xo728MEvRU+ltbEvYP8h3WFDla/zPLl9
         p4BT2j9Nd4hw2yG8KHweNN4bb+j+LL2I2nqObCMlkCFLUnB6qMXOHCzmwoGl+KckI0+Q
         oEquHkknXGSd5bFIF2cArclx3SGNMsb1PCLppkcKSEts3Ttu+/jXl1nrhjt4HhfBN765
         UcAsx45quG3gL0zWInoaHYOLFEkUkcJZ2LpWsu33RNPLXEQKd6rxNf4hJL17uQGS3WnX
         9h5CfUOWsLLcbDyzol2lnjSPecXX0l527piHhgtDZWuUi4MOYzkaxx94s6TwBYbToVXi
         xzhg==
X-Forwarded-Encrypted: i=1; AJvYcCUbqqemL+tH9oZWp2HRFcglKU6kD7BVPWzo3sAsXe5RnSjt/aYD9SvVGIGfVX5YpM/7FqfHFTX9xOysgyK9@vger.kernel.org, AJvYcCV1Zx4cAUe7jFrYdRZtZPC6P1+UagouJyZqm0Wsm7uCgMWXxp56OEo3IYQ5SJLBhyuFdAxyCwZpE6LVQ8H0@vger.kernel.org, AJvYcCW2gSnp6ADZdTaGKbyCwUXOjlkSMSn1iC4l0PuRnMv/125h2wcbdyGt1FyDcFBl/rTaQh2vcWE62uU0@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzChtkfek36pjngUVhikQ/aK72ednEQmPKg3Cp9Cwn37ebu+c
	yS0m6xk9iAUWjrt8Hm/2tovsY+YsvTaMmY68kmDDRCZZLlMhcwlu8EHl/Z6KW7fXecEWX4mauPq
	ZY++UQB5/uhF/DtFDB4gf0jRu8cY=
X-Gm-Gg: ASbGncuL+0Mjqn8SNFB3mZnrqP/gbzdqYzIWQhGRNAnHdf6dArVS9KG9pzy27zpR8cd
	KXPSy/phwTWrHD0iRjsb77j5sKgRLW9DDrn9yR3A/WL+lvX6lLWY2
X-Google-Smtp-Source: AGHT+IHCd8of8d500DJCLyn0QNmigh6e4Mp6+DiDF4V3UwwZh+zePgc4APmTo04fumB0lBzTXgd/H5xNDX5LXGU/cOk=
X-Received: by 2002:a05:6a20:9149:b0:1e6:5323:58d1 with SMTP id
 adf61e73a8af0-1eb2159018bmr25259926637.26.1737459316158; Tue, 21 Jan 2025
 03:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120032212.3579184-1-Wenhua.Lin@unisoc.com> <20250120-talented-octopus-of-serendipity-aa8a58@krzk-bin>
In-Reply-To: <20250120-talented-octopus-of-serendipity-aa8a58@krzk-bin>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 21 Jan 2025 19:35:04 +0800
X-Gm-Features: AbW1kvZZo2-OIjZzTV11iCycQGKzEWbrDVJmWFy8J3an7-wGQ87-POankXsm3Uk
Message-ID: <CAB9BWhcGdDADkHtX+YTCQekzUghaW_cN6s=-BkuxwWnNN-5-Fg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: serial: Add a new compatible string for UMS9632
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 3:48=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Jan 20, 2025 at 11:22:12AM +0800, Wenhua Lin wrote:
> > The sc9632-uart is incompatible
> > with sc9836-uart, Add sc9632-uart dedicated compatible
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597
>
> Missing full stop.
>
> Your commit msg should explain briefly why sc9632-uart is incompatible
> with sc9836-uart.
>
> > for representing uart of the new project UMS9632 SoC.
> >
> > Change in V2:
> > -Change commit message in PATCH 2/2.
> > -Modify the compatible string of enum in PATCH 2/2.
>
> Changelog goes to changelog place, under ---.
>
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/=
Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > index a2a5056eba04..83582aa6c750 100644
> > --- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > @@ -17,13 +17,17 @@ properties:
> >      oneOf:
> >        - items:
> >            - enum:
> > -              - sprd,sc9632-uart
> >                - sprd,sc9860-uart
> >                - sprd,sc9863a-uart
> >                - sprd,ums512-uart
> >                - sprd,ums9620-uart
> >            - const: sprd,sc9836-uart
> >        - const: sprd,sc9836-uart
> > +      - items:
> > +          - enum:
> > +              - sprd,ums9632-uart
> > +          - const: sprd,sc9632-uart
>
> Lists are ordered by fallback, so this goes before list ending
> sprd,sc9836-uart. Do not break orders by putting everything always at
> the end.
>
> > +      - const: sprd,sc9632-uart
>
> Combine two such const items into enum:
>   - enum
>       - sprd,sc9632-uart
>       - sprd,sc9836-uart
>

Hi Krzysztof:
   Thank you very much for your review, we will correct it in patch v3.
Thanks

> Best regards,
> Krzysztof
>
