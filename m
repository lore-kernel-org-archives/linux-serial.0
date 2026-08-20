Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939B313546
	for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269278; cv=none; b=iQDFhZpSNVJTJ6mZN1S12URfnSMNTjkSDgh5hc7zHrKtcLvYQU+n6teNxtymfchq7Hi7/WjzijIlaEzDRGrBiJFhAXi4bmbqkUnX5z3xiKF8S6ubYVKjuB2pF69FWSykWPgPrl8HuYHvj2L17EEMLdR94wKGTT5ecUlFQBzKu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269278; c=relaxed/simple;
	bh=faVdfbMyKRC0yZz7duQHLz6OqzYJS783yM+QPhqaBsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrswW0cqvgCQLT8+EXc6eHHUQfh2TGn39LuFXjrNmkCvacl3/7ocEnoSR/JPF9DJqPt2sN+bCx9Cd4xUu4z2a+8vpqFMJ4a8rHuClyksYnGbY0hH1lu+viOL/8Q4ydjzCJaScrQ9K3SUOcphZ3qDguQ++blPqv9jyOL+F3Ry6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RrKTVhF7; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrKTVhF7"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7564b7a9490so1148961137.1
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787269275; x=1787874075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=faVdfbMyKRC0yZz7duQHLz6OqzYJS783yM+QPhqaBsQ=;
        b=RrKTVhF74UR6WYzw8yKAEZ/aDmF5PHE4CQy+pcOLW1N2/iViY1JEAfSY0YAhKEwZ0j
         ifuvHcTnW0XnPyR23hHCl78fAIXM+PjYrSkV9WugwpGnu/cGqH1En52cyL6N52q0KDoG
         6YwyfArKRMPll85ibeodfB8RA1pFUZ58L1OBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269275; x=1787874075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faVdfbMyKRC0yZz7duQHLz6OqzYJS783yM+QPhqaBsQ=;
        b=lRVdDuuIjUZzPmsHojj4UVfmEfE87sJsiaMUMZFblF5DdCRkCNyfqglQfdZT/99vas
         NeGCZ0R8NtCX3FoiLjiVqZZ59Gd243QNdV7mGclt3cyhOUGc4eqqdBfDnpLD6DmMl248
         ciWLjlkU3A11mjezUsANNQrAxw0WT2Zwf0s04OfEfZjlQOGtkubTwY+Ulx5etv1JC0Gl
         YxlIx5GdNGWsNkv/sx/lR67kFgJxeMzo3Hm+ICjgua43CS2iTUOkQbdaqWkCI+3ekI8n
         9cpZQV+2epEPKCaD1vKn/DY831XazO5M7VPqCxpTwh+s82dAftUc2lK2aGJWByjP1Jyd
         yUPg==
X-Forwarded-Encrypted: i=1; AHgh+RqqebKnAoZ/NIVVoIIuNpVqdJp1cd/AuQJUS2Z67gV+SlThMdsXoSmZmjfZe3SKVVjtACqsfmafqqfv2+o=@vger.kernel.org
X-Gm-Message-State: AFuF++ndGYCPanYpRljAIOStNtI9oM+jT+7dow+YHViXT1c1O8YfBiFA
	xmGb7A0FHnCXz2Mr4jmhuvy6KY5jIynbw48DxNykRcgyrYyJs732At7xE/NUD4o0mHNd7k1tylK
	jQ2I=
X-Gm-Gg: AR+sD12kLYYCK7OyxeCvOd1r6mD4fqjboyYNLM0wqa+LalooNI2S3BYgOELY+jS4KJh
	c59qN2xaHUH7toO2jkQm9yHXoj2FFHKhai1zMSzQxmj6acTDIL2VecCB+pgILqzz7siflcd49MV
	6OjqTkkiLocRSF6miWiEESKliQ7bLuYMqSBcXco5G73wVuipXIR7AksEogrIJbBQPuSkv1L2s1t
	H45brW97xEY22o0Bk7Q4YCU15LvQSePWfOcwiYz9J11M7pp990lbbAVjDpkX4ittwJcYVLbsadh
	nhuflbOs6KjgYZqfLwHg12f8jFqqVN13vhG+6ST3QSUU/vf4B8xqPCGt4hBZgAO5+hpgPDfqVzg
	kMdYQ5eOwKlFRKUEi0VB5/bqXUiKD/fUZBXvQqVdGlbTOd0yzBfj1IaicQwL8tHZIdzUkacPE2g
	t95GtShA4RN9BYsuMV7HIihdArflEM6Bz8vJ6FNk2GDQHELJShqcRn54UXAHmtU+MO76BPbA7TR
	+NBCwNnGe51ddgtANaPTG+HarI=
X-Received: by 2002:a05:6102:2c15:b0:779:328:8a2e with SMTP id ada2fe7eead31-77a87280e85mr322271137.5.1787269275536;
        Thu, 20 Aug 2026 16:41:15 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777d823dbe4sm7811232137.0.2026.08.20.16.41.13
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 16:41:13 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7737a1f65c0so312260137.1
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 16:41:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr55bXZ92HSTjRD5MoknK2A272IINgUZbPFzx4PvJBs3S12E4TvJ2n/J4+F12KufrPD6I/cRyDQk3tGSOE=@vger.kernel.org
X-Received: by 2002:a05:6102:3032:b0:747:560c:e7e0 with SMTP id
 ada2fe7eead31-778f05babd5mr1953525137.1.1787269272014; Thu, 20 Aug 2026
 16:41:12 -0700 (PDT)
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
 <56db332f-a18e-4a9e-be9d-67d2e25c3666@kernel.org>
In-Reply-To: <56db332f-a18e-4a9e-be9d-67d2e25c3666@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Aug 2026 16:40:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUMKGRUbAyd7XFFc-NGoJEKRwu4MaUnEQUDB9Mq6YYXA@mail.gmail.com>
X-Gm-Features: AcwNN1XRfcu1Y9Mu4rBPOaQuheZikf-15PdNleMMKujFPqm2AwjeBRozlHD45_0
Message-ID: <CAD=FV=WUMKGRUbAyd7XFFc-NGoJEKRwu4MaUnEQUDB9Mq6YYXA@mail.gmail.com>
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

On Wed, Aug 19, 2026 at 11:03=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> > I'm happy to document. Can you please point to how / where I would
>
> Description of:
> Documentation/devicetree/bindings/ufs/ufs-common.yaml

Got it.

If you tell me that the patch won't be instantly NAKed I'd be happy to
post an addition to this file saying:

If this UFS controller has a well-known ID <N>, a "ufsN" alias may be
created in the "aliases" node. If this UFS controller is a singleton
(no other UFS controllers in the system), a "ufs0" alias may be
created in the "aliases" node.


> And obviously, as with every binding/ABI, you also need open-source,
> upstream user of this.

As I understand it, this isn't truly policy. I know DT folks often
want to look at an open-source driver to ensure the hardware is
described correctly. I also know that a badly written but
"open-source" driver doesn't justify landing your bindings. ...but in
this case, it doesn't feel like there is any complexity understanding
what's going on.


> > document this? As far as I can tell, no aliases are documented today,
>
> git grep disagrees with you, e.g. second paragraph of serial.yaml.

Ah, I see! I was looking for something more formal. Something like a
list of allowed aliases or something that would automatically validate
which aliases are permitted. You're just saying to document this in
prose.

Thank you for clarifying. I didn't understand this based on your
previous emails.


> > I think I've presened my problem fairly concretely [1]. If you hate
>
> There is no description of the problem at [1], except "bootloader adds
> the same type of calibration data".
>
> So I repeat my questions: to every UFS node? To every node? To one UFS
> node (but how do you guarantee that?)?

I'm sure it's not what you want to hear, but I guess my answer would
be "for these boards".

In my opinion, this would be fine as an ABI contract between the
device trees intended to run on Pixel 10 phones and the Pixel 10
bootloader. While I'm still of the opinion that people should be
allowed to include UFS aliases in general and it would be handy if
that affected the "dev/ufsN" node created in Linux, I know that's not
a popular opinion among DT maintainers. If upstream would allow a less
"generic" sounding alias "google,ufs =3D <&xyz>" I could do that, but I
doubt that would make you any happier.


> I gave you two solutions, depending on actual upstream need of this. If
> you have the second case - so not the boot device - then you basically
> want to re-implement overlays which you cannot. Use overlays, which
> gives you nice stable and build-time verifiable label/phandle.

I'm not quite clear on the "overlay" suggestion here. You're saying
that we should require the base device tree to be compiled with "-@"?
...and not because we necessarily have any overlays upstream, but
because the bootloader will generate an overlay dynamically? Compiling
with "-@" would mean we could give a "ufs:" label to the UFS node and
with "-@" that would be preserved. The bootloader could then use the
"ufs:" label to find the node. When compiling with "-@", the exposed
labels are essentially ABI. Did I get that right?

That's a pretty neat idea. If you confirm that's what you mean, I can
see about implementing it. It would also be nice if you could confirm
that this was an OK thing to do even though the bootloader is
closed-source.

We'd obviously want a comment in the device tree itself indicating
that the "ufs:" label is consumed by the bootloader so it doesn't get
removed.


-Doug
