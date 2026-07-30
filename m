Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB484219E7
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454751; cv=none; b=C4h8clBS40R+vRbe5rIsVbcwADqsrRY4Sy/3tiHpB85XxkL51J+XOX+/63bcYps9x3rla6VLBof7EfWN7IyejSTpcdhsGFkgDhTVhmvfCXIksu8omLtVb4XIqFZj2xICBbzoGoT7eLx+z/uKZpF3aNQC5YeLJvHufsa5dKpusBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454751; c=relaxed/simple;
	bh=O0SjzN/C0aO3qHhb3UBjmXFOhQPDFTOsNKhcZLytoNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzhWR7ENgFgh7DbOCy/EM00A/fEIei9oiG5uqSq2ryiTRmjM2D9/TqiSsRVQuce6VvgC8Kc4kdsZKsytEmln5Q+mtjmkbb0f2MV1LMB4zkxrNEtB5bk2PEmX3Zj5Y79TIZOaJbMO7+oNTD3DLOzoIY47JPSaIoIftgNttbTn1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PlC+edWQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlC+edWQ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80c5cb9a888so4075177b3.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785454749; x=1786059549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b2iUYeLjQUxHnF+XDQe2fiV8PKRsDwqLHqM0lXiq4GU=;
        b=PlC+edWQkL1rwnx+ZtUKskhvd99FIIuM+30uL84w3KKidCmWKYuamYjiNDWlGfAYH0
         ADtx8TsTw7tK+k4DFvxNIjldJPTnCN49xMc0QiHKd78EiPzSaQc9jo0W/9kt8nB3Lhid
         7o84G7YxhHJlLIxQvl9fqI2duJ6R9SzDZ1P/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454749; x=1786059549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2iUYeLjQUxHnF+XDQe2fiV8PKRsDwqLHqM0lXiq4GU=;
        b=PDwIox8tEWCMMsQar/NQxaY7RaRsh5jT8RjHYB1GzNUkmojDivetUs5Fiw57l9yor6
         ttqJZ+PqeZsPvIW2nOpxGKI/KUpVFU1MSPepIVD/n1e3/7dzip4t43jZ+P919r08FfS3
         tF2CEtIAN2/fea3rx7n8kmCMIvgk6WvGzdC/hbBtcQQfdLXv/QyCRuc48dlStsAEOztA
         04D45ID0jPoJuYEUAY0d895fIxjqXFtNdWilpnLaKH3RCXO7/6CLXPL/cknzeukkth9t
         wFh2uaeGbSH4VfO7PSiEayM372F0TtpleBze5G7u6TEqwC18IGZlH79W1jO4ZVJCwILw
         CVEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9aWvu5RKYDe/DO9Nh8PMR6ABjxpu7Sldppq8n0hw1YQ9EiYDp2mmN69aLHN9e/neDc6TIWEkjy+b6rgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd34dl5yFNI9PZ7QVOBRKpolgyFELcE+OALrQhxwM6iZl7DfwM
	NaZn3hcGnfFcvKJ2KZiX0bQrIKiWdDRFJhXfer0QSOI2ZylNazlk9zD0LbGfEwI/kx1QnjM/CBi
	9dJk=
X-Gm-Gg: AR+sD11rIk2mYOgpvWcgavgmJd83ZObroi1ZJYYF10anx9NYEXYSKFIfXdZjvHlS8t/
	76zSWKU3KfO3UsQssxc3xHMIn9RXatTJ780un2n/v3SRCJUoD+pGbeKnqwkD3ISRhfhIiZA8/rV
	k70RS9v7IKn3m+xcMCkm9qc7QoBtMsgVdhSlwdmNhbFuVdpBgf5DSSmEctml8w7cIKD9d1IeXfc
	/e1OMBRhqqGcuNJ9IEm9+wWrUJQ31uM64z8Np1HcLy39BOX89saoeLxVW0QddW+OgfLskherPcB
	mJeZ2H7Kxp8sVECGbMwxmpA7Nedzic9yEoK2KrTpwWFHPmRzWnBcoURJ1XJ6FnqHyZhUexDO02c
	hOBPADjNt8oRl/JE1EfeaX8xU6p+qEIrTSWYYWlufYzfk/pJXkJXjmwY1zmgjb4zVQZFT9qJZbz
	BsLP+AwAb6GxuBRSPKj1i3ZiON8guOQKKl1IgS1phhsWLSax0s0LjwMuwcgUTj7VN1G6XH9hnip
	P4Z+T9lwCRPEQxDu3F24SodnJXHXVk=
X-Received: by 2002:a05:690c:909:b0:81e:d656:9909 with SMTP id 00721157ae682-81fb89449abmr32831217b3.1.1785454748827;
        Thu, 30 Jul 2026 16:39:08 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8aec6f4sm20608637b3.41.2026.07.30.16.39.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 16:39:08 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81f64e8dfbcso5306107b3.2
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr5nV63sVY5uX3Vl2X+DwbbSjJeDMxQeW5PEkGlDxG0zcMyQSrX3EobusfLFxF8NyNF6vWouaCHjfjYI0s=@vger.kernel.org
X-Received: by 2002:a05:6102:14aa:b0:739:97bf:9189 with SMTP id
 ada2fe7eead31-7574f93a65fmr1607449137.19.1785454369736; Thu, 30 Jul 2026
 16:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org> <20260724-dancing-skunk-of-novelty-72c1b8@quoll>
In-Reply-To: <20260724-dancing-skunk-of-novelty-72c1b8@quoll>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 16:32:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
X-Gm-Features: AUfX_mwnyu4WjATq-AQcVkDVhFUfk_uPBliwju6dkYwZZ_ZMH3FiPhsyMK3Tdpo
Message-ID: <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
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

On Fri, Jul 24, 2026 at 12:00=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> > +                     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LE=
VEL_LOW) 0>,
> > +                     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LE=
VEL_LOW) 0>,
> > +                     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LE=
VEL_LOW) 0>;
> > +     };
> > +
> > +     /*
> > +      * The Pixel bootloader considers it a fatal error if it doesn't =
find
> > +      * a `ufs0` alias so it can add calibration data to the node. Unt=
il
>
> Fake node is ok, but alias won't fly because aliases are not allowed for
> ufs. Well, would work 10 years ago, but this is a device from ~2025 (so
> SoC maybe a bit earlier), thus Google already knew that they MUST talk
> with upstream open source maintainers before they ship such ABI.
>
> They did not talk, so you reap what you sow.
>
> There is no more excuse for a vendor to ignore open source and push
> whatever-ABI-they-wish into their product, if they ever want to upstream
> that product.
>
> I know it is not your fault, obviously. And I know that not much you can
> do, so that is not rant towards you nor towards Doug.
>
> You will have to keep this part of patch out of tree or fix the Pixel
> bootloader.

FWIW, it actually _is_ a rant towards me, since I added the "ufs0" alias. :=
-P

When I was originally bringing up Pixel 10 with upstream, the
bootloader had a hardcoded path to the UFS node. It looked for it at
"/ufs@3c400000". That certainly wasn't going to work. Downstream
_still_ hasn't transitioned to having a "soc@0" node to put all the
MMIO peripherals under, so the equivalent upstream path would be
"/soc@0/ufs@3c400000"

Now, I certainly could have made the bootloader search both paths, but
that seemed bad to me because:

1. As I understand it, DT paths aren't ABI. While it feels unlikely
upstream would change "/soc@0/ufs@3c400000" to something else, I
believe upstream would feel free to and not consider it a "breaking"
change. This makes it feel unwise to hardcode the path in the
bootloader. In the past, upstream has renamed nodes to clean them up
and it wasn't considered a violation of the sanctity of the
device-tree ABI.

2. If #1 is untrue and we consider DT paths as ABI, it's still a bit
awkward. We have one bootloader base that supports multiple SoCs. The
unit address differs across SoCs, even though the IP block is nearly
the same (bootloader still adds the same type of calibration data to
the node). The code I started with had a bunch of #if statements for
the paths in various SoC variants, and that went away with the alias.
I suppose the bootloader needs to know the UFS base address anyway so
I could have probably constructed the node name based on other
#defines, but it still was a bit awkward.

3. I certainly could have searched the whole device tree for the UFS
node by "compatible" string, but the Pixel 10 (and future) UFS
controllers aren't upstream yet. We wouldn't be able to land the Pixel
10 device tree without the UFS bindings landed yet and I think we're a
bit far away from getting the Pixel 10 UFS bindings landed...

With all that, the "aliases" seemed like a pretty clean way for the
bootloader to find the UFS node. It also matched my understanding of
an appropriate use of an "alias".

Any suggestions for how to resolve this? Do we go back to hardcoding a
path in the bootloader and cross our fingers that upstream never
cleans up anything that changes the path to the UFS node? Would it
really be terrible to allow a "ufs0" alias for this case?

As a side note, I did "talk" to upstream shortly after adding the
"ufs0" node by sending the Pixel 10 patches upstream, but I guess we
were so focused on the overlay topic that nobody thought to comment on
the "ufs0" node? At the time, I'm fairly certain my resulting device
tree files passed schema validation at the time, too...


-Doug
