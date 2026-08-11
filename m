Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18A3BFAEE
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464663; cv=none; b=mqpYISL9FjnicrYZ3UgT6ahEdUfyeONA8gm6/wnGr9obIVdRfyxNK4MZRPA+9PAszKgxYMpBoHPxdSe9gzv3sYviasMAAoctFGY65YjI90QTei7/syL0wJ5ngWz2Kn2FC/ouw0h83a0HutOHFdXK+ispmeGdDQhk9ewzBR63vOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464663; c=relaxed/simple;
	bh=s5aYQFH5/TsJrfgH3Hmm3Z5/dP+xYZg4aYmTqt5N98Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Klk0z7OD54oamdA92P0BgMWzNtdo6MNxBUar/FPg6CUcYGZtqM406u7Knrq4UWn6/xIp7rzARrvYqWJTs1bbDtxy6HACNabn07C2m66A3rWncOQF3V+DeQvLBWh+2AbdDFbu4+5f5Fz9Dhgc9Qg9amwrpLFCwEMDM2ZLbDcokl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTxVVdhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTxVVdhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3436C1F00A3F
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786464661;
	bh=s5aYQFH5/TsJrfgH3Hmm3Z5/dP+xYZg4aYmTqt5N98Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OTxVVdhZRmaj9tkDRGlrzrtpdSexA49s47RLI8Twy4X2WCBf/g6bn8k/1d9JPgFpL
	 y2GfduWi+ZR2W8AtNJ9UUWy0Jzlt8uVWTADljZX6LKKQGowZ1O0DA1++7yUSUqYfDz
	 xnWwwtP0KKRTajZsIx3bFfJDthsQ422gzilaNI+jKfGTXv9zd8+5AgQY0/dKRdhXYS
	 QwboSbp6U+VhfW9Nbv3/bE8sNBu3eyksQBNDp2KxA2kffHOk6uRtwaHx0uhnzVPfAW
	 8PqlY/j+Yxvhi2iP6MxW+SkT2z0UT56qMQcg+PDuGgNUoQpsPbwr0W8foY1KZST59P
	 GMhX9Wv+0tTEA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f5208b38dso628466b.0
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 09:11:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpwC/GptVZD8m9sxF2/uhE4XxBTIWWVkfhSvuxKlsS43yRHhDzFr3FKaskNZNTXgPfs+WlF247hvjqJFL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfY5Gxqi7iz5FQ3NZ/j0gKgulRLq5Ymo5K9yxm8J+3qn+v0QKI
	jiI8tGNe0750SyJiU7X1wDrHZfOCn/tAdp1giFhl842jr2XV2Lv+6pgqF0GOWPjaa0n6qVLzF6n
	Icm3It3gskIbM3N56rvngX2P9h13djw==
X-Received: by 2002:a17:907:9344:b0:c19:49ee:19b9 with SMTP id
 a640c23a62f3a-c20ecb40d59mr83318066b.15.1786464659836; Tue, 11 Aug 2026
 09:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-7-6b09707c5fe9@ambarella.com>
 <CAD++jLk0LoOJk=TXin42AL3_z_7eVVkvMnYr1S8090C6A_B+dQ@mail.gmail.com>
 <DS0PR19MB7925690FD29D578D8AC5D10EDADE2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <CAD++jLkUPU0eujvWc5Hn1tEu4n451LvkuGGT=j6OfirJENpRgg@mail.gmail.com>
In-Reply-To: <CAD++jLkUPU0eujvWc5Hn1tEu4n451LvkuGGT=j6OfirJENpRgg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Aug 2026 11:10:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJprX0oC3Gdj=RNNYtPiQ-0NkEPvn-MyQ9ZtFakKcj1ew@mail.gmail.com>
X-Gm-Features: AUfX_mzXtvkrshAlkiMteNJj8gvRU9rIYBk-lG0usv9XUDyxXzzHJorja6k1J7w
Message-ID: <CAL_JsqJprX0oC3Gdj=RNNYtPiQ-0NkEPvn-MyQ9ZtFakKcj1ew@mail.gmail.com>
Subject: Re: Re: [PATCH v2 07/10] pinctrl: ambarella: add Ambarella pin controller
To: Linus Walleij <linusw@kernel.org>
Cc: Long Zhao <longzhao@ambarella.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 2:42=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Mon, Aug 10, 2026 at 6:02=E2=80=AFAM Long Zhao <longzhao@ambarella.com=
> wrote:
>
> > Thanks for the review. I will rework this to reuse the PL061 driver wit=
h
> > per-variant register offsets, and evaluate modeling each GPIO bank as a
> > separate DT entity. The duplicated GPIO implementation will be removed.
>
> Thanks Long, I think it will be easier if you break out the pin control
> bindings and driver from the patch series and work on it separately,
> the same with the serial driver at least.
>
> I understand this can be hard to test on the hardware, I usually
> put a few patches "underneath" the b4 cover letter, and then the
> b4 send-email will only send the cover letter and the patches
> on top.

The problem with that advice is then 'base-commit' is useless.

Maybe b4 could learn an 'ignore the top N commits" or "only track the
first N commits".

Rob
