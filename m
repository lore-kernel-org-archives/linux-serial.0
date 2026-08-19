Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95523A1B5
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183200; cv=none; b=BqywNtJHDlrB5WtfGQnQrmPCshysbQCsqP+8w9LKSaCodjGJUfOiRe1hPd+E3nhzjSJzOvSlI60dZciLCqDpNdyKuEAVnByMVP4NYyJZQacMT8ZoGVzzMMT6xvgAcbyBbp43fAorMh2YFodanQbSeZ/7rkWfynqi+wBI3rgrtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183200; c=relaxed/simple;
	bh=bk8X/C1AqkDTikcqiW7Hg2XdCI/waiwQ0VemNKokSJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/uXyDQa5EyrZmZsdNuunDRi3/ywMQ1t/Ak9QaRZzvFM7of/5px2Ed3zECm6mVDrsVlHWEnvapPAr/sWfKloXV2I9/ZtD+F8Tsbe+u8OheOL2xGhoe8cHywT8WNJbfkNNv8qbgx3UbmY0tKWpcV+o8pX1R158Fi/r5kNgGgJWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QC3BpT0H; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QC3BpT0H"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c2cce930cso15566661cf.0
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787183197; x=1787787997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bk8X/C1AqkDTikcqiW7Hg2XdCI/waiwQ0VemNKokSJg=;
        b=QC3BpT0HUFIHwVYaYaR9hdht8fQl1G3Snr0cp3pb299RyWUh7lQKAxFLARh5rgTO/u
         FLQ7hixDGgVNm4yz/2i4q10I9mxVnjndq/a+wgfxr2JB1iXr2T3wZFMCdevy4mybvOmb
         G3NXV3mHE6JuV9e8aooObG7AMMFn2+QkbXpQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787183197; x=1787787997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bk8X/C1AqkDTikcqiW7Hg2XdCI/waiwQ0VemNKokSJg=;
        b=TOKJ9KsENLBO+kHOL33pPTO97Ay7ieo+uiyA3TE6K+hKjnnPRuod9ThB9WcFK6BhfS
         U3qOBOvGN/gjKMYOJHnbZ4SQqzPoC2DNEHYHRczGF4pN2If1vG0YfENTOdgEtWymMS0z
         xLMNN7orQ1dAu5kSJgPtKWWSMJ9q4TSLa5Gnp4WAp5ukFnUX5jQfS2cEA9DvI99FW2df
         wSUYTL1zAeVPBaqIBRzyaDM7psa9dTzbN3mci9ujqWy/qkhbelZ1GP7ULWy7leBM229+
         5wMP2zzNuV//Bn0lP/VVckWtzXCDKdPI9TqFDz0Y1dEzGVnVX4W13J7iQRQaQxheJvBm
         BfdA==
X-Forwarded-Encrypted: i=1; AHgh+RotZcp4yLZXVM48etytlfDeS/NnAYZ8F6TAADf92Xk5i9D5UQ+41gOsaKV96K/uaYu+DIerGi4TTYIUuAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTY+ZTjLBoCpnqSCxJMDTGtUjDGmtao29pZOW2hF8w8dzG+cM
	fSAC8Oro1OOlqUeYJ/JmLuetMi1joqLjc/f6eLCKDfMWsPkPCzufkRcPNaL0bHqRps7tvVawglf
	hTJs=
X-Gm-Gg: AR+sD12UUYIP5mcKQgWDRJvMdC5/2Bb42B7ukFaWucXgpUgHmEJce60jL+mTgCIqf0/
	VPgec0mHqnNl/52oQmIzaVeIjohLUB2lW9eNiInvQTkDjpU3f3RunVfhx4TqhjHhQS6+KAqIMX6
	0bl+zdBIsdbTPjkM29EXgrKBvv1n0beSEhBlge9J6KTx8xL4+a+sZ/A6sG6o6SlpshWlx3o1KJO
	kmiGTQDC7ZobE6xQfrR8CfmpU/35+acCIoCpe5wVvp9jzFfYcJjXqmpFfeS2ioxaruYNiyEAp1N
	gjvQ7vf91Dw9OScGqzgUMN/WUDlMLQ+8bZp3ZyH7UhJdTk9olUV0TV6nD0r5dtUMZeCjPmjjcxY
	Nufn3CDTOeXgelOUvt7sXU6L73mZYuiMrjcmw/L1xAAyUVeZEHlvnMdz9kGhPy0simrbbE05Co5
	Vl9duxnAtmZZ5+47heKhFzVgMxcmP5BtUAwmb3BFgoXCkNz3yp/KPUp0ij2TPMDAUAUCp1qiV1E
	IdlBcu9XpEAV05Qyr2dObo5xVOD6rtsKmHwUNc=
X-Received: by 2002:ac8:580a:0:b0:51c:1291:911c with SMTP id d75a77b69052e-52dd5795c20mr84938431cf.14.1787183197556;
        Wed, 19 Aug 2026 16:46:37 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd872b167sm20107201cf.21.2026.08.19.16.46.35
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 16:46:36 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90a80860d35so19053936d6.2
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 16:46:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roh6H5zrZo4f6S5UhVN187F+FhPczDzBe5mf+9kCyFKyJMYTORAJBIVb0lqAS7YUlbIdfDvQDCL5Ewy8E8=@vger.kernel.org
X-Received: by 2002:a05:6102:15ab:b0:777:4e3a:8dde with SMTP id
 ada2fe7eead31-777fab9d4a7mr3615810137.11.1787182853246; Wed, 19 Aug 2026
 16:40:53 -0700 (PDT)
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
 <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com>
 <CAD=FV=VuVdq_=TQmONJZak84S2c2-2yQ8DS0k_odYsUfg0C+rQ@mail.gmail.com> <CAD++jL=VLzW-4eB=izJwaTJ+6xObk9+AQGTDK6ABdrGX4K3vAg@mail.gmail.com>
In-Reply-To: <CAD++jL=VLzW-4eB=izJwaTJ+6xObk9+AQGTDK6ABdrGX4K3vAg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Aug 2026 16:40:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsiQfoGYHw3D2xmV=Jedu+cmqEfrCk0mkKFzsrRCQcTg@mail.gmail.com>
X-Gm-Features: AcwNN1UHCTu0dpSrOeIjoA8l2gjjfO6Nzx_OO7IAuQCNztYoKMKLEde815SfxYY
Message-ID: <CAD=FV=VsiQfoGYHw3D2xmV=Jedu+cmqEfrCk0mkKFzsrRCQcTg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Linus Walleij <linusw@kernel.org>
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

Hi,

On Wed, Aug 19, 2026 at 4:29=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Wed, Aug 19, 2026 at 7:03=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
>
> > I appreciate your suggestion of having a separate node for calibration
> > storage. This feels more awkward to me than just giving up and having
> > the bootloader hardcode all known device-tree paths that the UFS node
> > might be found at. That being said, if everyone says that this would
> > be a great solution, I could try prototyping it. The trick would now
> > be that the Linux UFS driver would need to be able to find this
> > calibration data, so the Linux UFS driver would either need to be able
> > to find it at a specific hardcoded device tree path or the Linux UFS
> > driver would need to search the device tree for a specific
> > ufs-calibration compatible string.
>
> Can't you just put the calibration data as a custom property inside
> the UFS DT node? Just a long byte array or whatever it is.
> The driver would certainly know where to find it that way.
> I don't know who or how it has to be put there during manufacturing
> or inserted by the boot loader into the node from wherever
> manufacturing stores it though. (Assuming it's some calibration
> added at manufacturing, I don't exactly know what it is...)
> If the actual storage place is in something the OS can read
> then we could probably use the nvmem to fetch it live?
>
> The calibration business and what it is and where it is stored
> evades me a bit...

The problem we're facing is _finding_ the UFS node in the bootloader.

The device tree for the board is stored / maintained outside of the
bootloader codebase. It is compiled and stored on the device. The
bootloader runs, locates the device tree and then wants to make
changes to it.

The bootloader needs to _find_ the UFS node in the device tree in
order to make changes to it.

The question is: how does the bootloader find the UFS node?

* Does it hardcode the DT path to the UFS node?

* Does it use an "alias" to find the path to the UFS node?

* Does it search the whole device tree for a certain "compatible"
string and use that to locate the node?

Hardcoding the path is the easiest thing to do here, but then the
bootloader will break if the UFS node ever changes. We also know that
this path will differ for every SoC and is currently different between
the downstream device trees and the upstream ones (because downstream
device trees don't have a "soc@0" node). I've also been told that
device tree paths are not ABI, so hardcoding paths in the bootloader
seems less ideal.

We could just hardcode the path in the bootloader. If this
conversation goes nowhere I'll just change it to do that. If paths
ever break, then I guess we'll just have to get yelled at when folks
say "Why in the world would you hardcode DT paths in the bootloader?
That's not ABI!"

-Doug
