Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D7346E7E
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160741; cv=none; b=nHlemkXP3pYr+A8yp/hDrTq3QjJ+B8wqLQtmtFgJT73ffel3lKpR4Ijp+O3UJ0842gYwnDWh7AcZQppWqnjQZkc8pUnvmtHvONg5CsbgqVNR84tKz44555yveWg2/lVgxDrm4/f/dLotYvejXk8FBEQKEeImkWJT5TfPB9eUX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160741; c=relaxed/simple;
	bh=R+X1+pJjWvWvVDlg36MzfNwzU5dUF/DCSQzZsCpt9jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2TwJw9G8aaabrbm4+8I3ccPUCQ8yIMJrlL2+Gt2sv4OExKMaK3R12CyZTO1hdgGusj5q1y+ZYeFyGWzAfM4Jnivro4mP2e7DQ7WFVF1+ALQMDX13efUlDQ9klKVtwkwqsZkD7dkcNIiBkT0Joe9m7y3MF2zpXeB4sIvJmTmBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAWpoMQu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAWpoMQu"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2dcede83so1564218b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787160739; x=1787765539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oOL0sGbjRAF6LYH92WM9uY0MD9+Nj1oBAHQxCb/Np7E=;
        b=CAWpoMQubwNAvFH9FCLt2K6+oUiGW5iwZRVf1Pr7TDewOVM86GMY6QzVveb2XwaqrQ
         wRUwh1w1Njrr+BB8AKBNbUPwwoiU2HhT1TxbNcuijHMmw9Kd463O3tWDWL1HFaa19JVV
         TE+6wDnQcINF4Me49Piq004KIOz3M7v1Ka/HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160739; x=1787765539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOL0sGbjRAF6LYH92WM9uY0MD9+Nj1oBAHQxCb/Np7E=;
        b=mF1iL6ofty+2LZ6LCHUqy76kTII86lvO6z/xeFtgnmnsOMURWKyvrR2QgADXyaOfqz
         ZB+4yGMudmKo0OG92/uzipMSZr6jvhqNxJ8jHsdqgU078hp9p2PSzXvRiysLrHDa0fDg
         rOxdFuDzbMclewyEicXj+/idxWxAi8TezSK4z6OXlcC047ILadvYahNDWvtZopGWh7m2
         UXgXtrk70E4nh/mq+7c0JlZ6hseLGUQkQWTZIYLAr0VgRlZMZ60XqtM468IEs9cAFyh0
         lgkmOFxKrjrmXvBKp4nmr1wFxto8G2f4vspOZm4QHSTu8AAq8w5D3xMSBJq8tkUXOHZw
         0BNA==
X-Forwarded-Encrypted: i=1; AHgh+RrVX8InBt2dcpZ2c1MELCpS1BYyIdnOa5aQ7QMH9d7jWwFfLnqRdfVpzMRYeUdfGxkUWSn03uVoQZqb+kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKO58ipyRgCEy7I8vsKX/L66cVIbPCNrbTPzVWoTNEMhIKfBe
	o/W4mbnz1yTHWZLndL185UBPVVpgfnSnPlzfrPlPgzi9H1U+dKJnwMADsb+6ci8u/L5wdsNlQzT
	TOq0=
X-Gm-Gg: AR+sD12GoZ7k3xAylJd67iE1+tNuhbvLYueAIM31LpUw7UzvIUN5j3IbBGUulWpjNqV
	swmGnnBsL80V1dOgPdWxj0AKdffYMA+YPt2sNrGgcznsfGa5XLGuk+D6p0tebHZ3K6ECutNNufh
	NS9ORBXxvBb4qNWiHbIlzmVqstt4ePGv1Gtxn4wLK7JbMJ58MNwACvCz0+ep4CdPwupBWCk/RCq
	4E4uzxozTk28CX0EJ71l4CSbnHITc2O9nWNreOBMpBK5P/RZYSEqePd8adrm6QgWJVHaGNb83ao
	qlEXphJMAwPuQavpIgnu8BpE5H+OTB8OFy0gOapDXjp+TXqTgwhIJjyakzmwynnXwBnFJjJYp1b
	VC7jFcMGYV82Y/F2OLF3l6x+TvFr6s1n08prklCyLz3ayIMUIIt5J/6yA83nCPrkcKWwL9cxreP
	J+jELZ+Td6tJNGCM76PPXbhH8UOAeqlXce9TuaB0X7C3rVQeYlUxaZc2wBZ+U4HgyGWqPMln7Pa
	lbMeuQcdtZg28TtRaP6IGLQaq6PSwc=
X-Received: by 2002:a05:6a00:807:b0:84e:7ec:aa42 with SMTP id d2e1a72fcca58-851d3929f58mr9009236b3a.10.1787160738994;
        Wed, 19 Aug 2026 10:32:18 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3618744sm889786b3a.33.2026.08.19.10.32.18
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:32:18 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbee846deecso1318664a12.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpfr55z4SGsGbKeyiYpOXwhypUzHMcVzeNpmQ4IZ69OI5XajFFOuHl8z7/fZY2L79YLSlLkZO7Gr1/9wvY=@vger.kernel.org
X-Received: by 2002:a05:6102:191a:b0:778:5579:c662 with SMTP id
 ada2fe7eead31-7785579c755mr1067469137.9.1787159074606; Wed, 19 Aug 2026
 10:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
 <20260724-dancing-skunk-of-novelty-72c1b8@quoll> <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
 <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com> <c0657108-1958-4c4c-b5f5-0eb24e81b2b4@kernel.org>
In-Reply-To: <c0657108-1958-4c4c-b5f5-0eb24e81b2b4@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Aug 2026 10:04:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VY4AeAf=TMZfJYRo6C0iSqmL-P0GzxRvZHfnNsf+GnYQ@mail.gmail.com>
X-Gm-Features: AcwNN1VC5Sr-hmHls4qje9y_sLrQ3mcRyp6W877ec39iaS3jdP4hd--uL8qQ3VU
Message-ID: <CAD=FV=VY4AeAf=TMZfJYRo6C0iSqmL-P0GzxRvZHfnNsf+GnYQ@mail.gmail.com>
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

On Wed, Aug 19, 2026 at 2:02=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> > Is there some other documentation saying "aliases =3D=3D evil" that I
> > missed? Maybe some email thread we're all supposed to have read?
>
> A lot of rules are implied by other rules and this one, how Linus stated
> in other thread, might be implied by no-Linuxisms as you want ordering
> or stable naming of Linux /dev entries.
>
> I understand your reason is actually different than above, but your code
> does not suggest that.
>
> Anyway, if you wanted to have aliases as ABI, it would have to be
> documented. You cannot send post-factum DTS and say "we already use it".
> Every ABI must be documented before usage.

I'm happy to document. Can you please point to how / where I would
document this? As far as I can tell, no aliases are documented today,
so this would be the first. If you could give me a hint of where you'd
expect it, that would probably be better than me guessing.


> And this is what my comment was about: "they MUST talk
> with upstream open source maintainers before they ship such ABI."
>
> And no, sending such DTS in your v1 is not documenting ABI. Does not coun=
t.

Sure, sending a DTS isn't documenting, but it _is_ talking. Discussion
in responses to patches is where we figure things out. For that to
work, reviewers need to point out problems and then we need to have a
continued discussion until we can figure out a solution. When that
discussion just stops, it's incredibly hard to make progress.


> > thus implicitly provides an "instance ID"?  Would it be OK if I
> > changed my alias name to "ufs-primary" or "ufs-internal" or "ufs-boot"
> > or just "ufs"? We're not using the alias to get an instance ID, but
> > when I added the alias I followed the pattern of all the other aliases
> > and put an number at the end.
> >
> > I'm happy to attempt to fix our bootloader using whatever scheme
> > upstream suggests. I'm trying to "talk to upstream" as requested, but
> > for it to work I need upstream to talk back. :-)
>
> Make your case - what is the purpose of it? Boot device? Then you have
> "chosen" node for stuff between firmware and OS. There is even a
> property called "bootsource". If this is not boot device, but some
> calibration data for ONE given instance of IP, regardless whether you
> boot from it or not, then I find such case as border-base and not worth
> implementing, because basically one can come one month later with "I
> need 1000 aliases because my bootloader is patching up every device
> node".

I think I've presened my problem fairly concretely [1]. If you hate
aliases as a solution, I'd love for you to tell me which solution you
prefer so the firmware can add calibration data to the DT. To quickly
summarize options:

a) Hardcode the DT path to the UFS node in the bootloader.

b) Use some variant of aliases to find the UFS node.

c) Firmware finds the UFS node by searching the whole device-tree for
the right "compatible" string.

d) A separate "UFS calibration" node stored somewhere in the DT
(where?), as proposed by Linus W.

e) Something else?


[1] https://lore.kernel.org/all/CAD=3DFV=3DU0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr3=
8p+YwRnC_G6w@mail.gmail.com/
