Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D21E515
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159521; cv=none; b=RlNQ9UqRDWL6uqPYMTRCNvvzIo1b1fwT3H9U52Tb6vFcL05IP7VeHxStktY2MfEO8t9wr1Jj/iAPbY1NCU2PIhj6GZxqvrFgHfE45kKIDf6M/aNvA3tUYamGcT0qF/PohFWj8ON+OPLNWJqUOIpjiUDtyV8UNYO2ubBgATd+Z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159521; c=relaxed/simple;
	bh=xMRZ/YioDGD5qZ+6uqVpdRktvjMuhXrPGr3NK/pQ9Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi4SJSfLIosyEiRulUAuqtCAgpMsrtPvhKyAK4Td49zTMLnluJFndUrQnTBb7gRNBaURK7rooxqliMeytThpIpKK0B3+APn363Pcsc9CT6q88+6YE8QJ+pyAzs8ADDTaKTRGOX2Ia1upeJsetcLX61sOfdJ6PHrxR+RXCS1pGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NpnavrBb; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NpnavrBb"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836f34a0ceaso2643457b3.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787159519; x=1787764319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xMRZ/YioDGD5qZ+6uqVpdRktvjMuhXrPGr3NK/pQ9Z8=;
        b=NpnavrBbYqZp6EaJg9cCMcMDzcY66qMLBSDvqGa8SQt1HbP2xgpBUqHghorK3Iwdts
         TtegwqyCZb3oESv1Q5+o/7uL99Nwk2yN76SA4D4SDr0LfbSnnLfRAgnBTMzeBt+o5I9r
         NKUA5SCqCTQidSTODZaQ4VqhQrP6w5mMuXeWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159519; x=1787764319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMRZ/YioDGD5qZ+6uqVpdRktvjMuhXrPGr3NK/pQ9Z8=;
        b=AKaGl0KNSRXuCRFJOIX5dJlHYeS2pD+Z7RJbUluQSMT2f4BbOxH2LsEJ/iDZF/H+hg
         VLQAFqOtAESmtiYUGrUIwR++t38zGQwHgYqLlM2DTz7Ahwu5C8r8x9QNkvZPv8JWVTDV
         vwFRZNxRtOxNqm4/kpUhYzWW9TaCBlZHJrAlg25vlNo3nUXEaNc3P+LQsM6ZJ+eW8ru2
         RZYWBlY85VdCFB8NtKpjcFi0jXA9tChunaI4iphYg5Ifjw8tX48D4EdvMRXRmqmC37rx
         U3jSw0869rhrt/t9WgbfwoQXV35WCtNqgFMM+B5T2l+KjNyu7q4DsSf+2RkCnGBft+zo
         PTMQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5izFT7Ozlbp51u56tAYau3ayzZLbWtNFJ9TjejZ7nJaqZWIhGfAnqi1fWKK4DKWoHzFp48OTRkB5/w1I=@vger.kernel.org
X-Gm-Message-State: AFuF++k4U9Tadf8aZalTdM0aUBFq4LPfjdAS6w/5VyI9+4Ml0/PMCMyV
	2dfP0HLTD99EzsF8Pn6rtojAX/esvTlq5Fu9g75lST7Y7+bALfMLEAczdld+UTpW5UrJRfpRKic
	m7GY=
X-Gm-Gg: AR+sD13nrUO0Pi3m+187Wkz6mADDZppwNzv1CZdpZro32nGFWdRPPoXr7KVHeMyaa/u
	72FQNWFm/aVQOMTP+iu0iUd5bmwCNvUZaqtp8cduWn9Ddl79SresV6d0zL53fr3vpkGdzMkPTWH
	QmZavPGiuYMQYFZsBXfvkgFy8S8s8DFPt1uU0nBiG63+hKqEDaDuQtdcKwf/kSfdl3bU3I3TatY
	pK3SyAZB5V38dn2ZS3UGigEncc93tsa2An+y/pich9bxgUyQsal9dD9ZwNWaLg2Lm/Ghyrm0m1Y
	x6piiwqVJeuEn+H9utO9d/ozR1j7pZWuyPCz4PbcrSVtl10e8LfSce9NLc3Usmzqkyf8Vz3AK8n
	+EfuV/5cfP7GXznhzOeDTd+T8XGM50cMfQdAKyav2v5DR6/ZlPCP2ESJL8/jH6wsnnKQNMglJTG
	Ci9T0aBPbPHjDLb+zANbhBugOjn4MCVyns2kZHGZMnKSzRK9mH+LCIWOF691pcT+ES0PjGYm7T8
	XYrU2ROrO0F1UZD4BCLQrtFxReVKm5OXgm9fg==
X-Received: by 2002:a05:690c:e3d3:b0:826:9d78:a0cf with SMTP id 00721157ae682-8470b1e9c66mr2597467b3.9.1787159519138;
        Wed, 19 Aug 2026 10:11:59 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84511abc117sm12376977b3.3.2026.08.19.10.11.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:11:58 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7737a1f65c0so117689137.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:11:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrBjjanSAKroSo/u/DF1RYTrlp4kOVHbvz6y1vFtylZo22rKQiA7B7znR0adPeJtiKAvI/ms4daYFaWfbk=@vger.kernel.org
X-Received: by 2002:a05:6102:4449:20b0:76b:2548:560a with SMTP id
 ada2fe7eead31-778f37d8a97mr140907137.16.1787159100271; Wed, 19 Aug 2026
 10:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
 <20260724-dancing-skunk-of-novelty-72c1b8@quoll> <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
 <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com> <72ec1b1f-112d-4f65-897e-e99652c5a7bf@kernel.org>
In-Reply-To: <72ec1b1f-112d-4f65-897e-e99652c5a7bf@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Aug 2026 10:04:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ViYUB6NXKVNxnPGwvkHzKnNQQSJfLRhVx7T-S8t0kqKg@mail.gmail.com>
X-Gm-Features: AcwNN1UtXmY_Pr6A3vg9yN6JPfaZdRsVgtlhCWAfgMFRKlEKan_CTSIL5IjyAS4
Message-ID: <CAD=FV=ViYUB6NXKVNxnPGwvkHzKnNQQSJfLRhVx7T-S8t0kqKg@mail.gmail.com>
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

On Wed, Aug 19, 2026 at 2:26=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 00:13, Doug Anderson wrote:
> > I did some digging. As far as I can tell:
> >
> > * Nothing in the DeviceTree specification 0.4 [1] mentions that
> > aliases are deprecated.
> >
> > * Nothing in the dt-schema repository [2] causes validation to fail
> > when you use new aliases and there is no "allowlist" of old aliases
> > that are allowed for historical reasons.
> >
> > * There is a single reference in the kernel "Documentation/devicetree"
> > about not using aliases to assign an "instance ID" [3].
>
>
> No. The rule is saying: Do not add instance index properties OR custom
> OF aliases.
>
> Logical "OR" means here that for you this sentence is equal to:
> "Do not add custom OF aliases."

That feels like a stretch. While that interpretation is correct if you
read just that sentence in isolation, in the context of the patch as a
whole it feels clear that the point was that you didn't want aliases
specifically because they were used to assign instance IDs. The
patch's subject is "Document discouraged instance IDs", not "document
that aliases are bad" or even "document a bunch of bad things". The
sentence is also in a paragraph that's all about instance IDs.

While I understand you authored the patch, it still feels hard to read
"all aliases are bad" from it.


-Doug
