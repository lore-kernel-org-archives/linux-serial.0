Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C83C3458
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159470; cv=none; b=KCFj30L8aoygco4xu2VGzHATVShYEAGUziegZldxE2DCr35QM8yN/l32PO7G3eMuPKl/uzeLKs6QS446e0n07aVuSuszniZwKf4Hdu5t8XEo8LA3HAeLcTmzyQGFUImDAG5RxN7GsyDlxD5gm/GMDhGz1mhOvxuFcMqp2iTYvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159470; c=relaxed/simple;
	bh=Fe7DkO5aRoKlOx5BdmX7YNUhZMMlLH8G7Y1MOtuX6k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3KkO+HWt0+wnvmpXLaONwtocLRe8bV9MoBQ4ck60SYP9SavP7fUBNFuxO3yzmQeBwRBQrHE8GvJcysy2QMmrzI+FXE4DwTDFRSRS6gm3RnkZjAanaV5ly4rJdRPfgMvv2WzCiej81pTGxsem4JA/jv93lEBPQXzuUmchmN2SQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O+VZo9e8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+VZo9e8"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ee125ec926so1045594a34.2
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787159467; x=1787764267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fe7DkO5aRoKlOx5BdmX7YNUhZMMlLH8G7Y1MOtuX6k4=;
        b=O+VZo9e8XHyj0uP/RH8NrdX6YMhS9tlJFuAkdUn1V8dfp7//HKorwiA+rCw1S1qKnG
         +YdBshT62sByzOyAhmFyXmEkkRAl5dKrGXc9+Ec1keGgCYw1Q42ghzHRIowndzLp9d/K
         +TJbBz7O+9X0U2LEhGLf7l+KxiPnMbBjbOcTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159467; x=1787764267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fe7DkO5aRoKlOx5BdmX7YNUhZMMlLH8G7Y1MOtuX6k4=;
        b=EUjTaWyZB0sg4OSX0XPEA/9UIXbjwfiKLY8QqufXjDiv8tSpqM5XXswzuY801h13gm
         b4yKed+cBT4lb8GbFjMrxs//1kzaq7by2bY4h8V739YyVizObnByAmA+L7u3J15o3wj2
         oeRNt3/p7FPIqPGGVQIxjUoyRcTpm56/4NRPZ5aisAa2DE7jlK1A+gFJhVSpsqL8AgAC
         kVgKtnM3Xcn7lkKCQybMOWh7xhBlU6fmv6caJCwED08G3yrE03T0YmJklOfO7uoSnrkp
         2oQwiI6w1V6W5kCyBhCFJ53du5P6XC0pWU5zFMAP6dhKd1OUQ1/KgeT25Cdlu5rncCsa
         SDpA==
X-Forwarded-Encrypted: i=1; AHgh+Roux9nd9RwRax8hFK9Wm1+uQhirN1d37phInx7yCcPj1JfRfV71m/iuZ9Zn9EJ/UsAXVoZ/o9g8h1Bolqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6mc17NfAWs02DA2qkSMNSAHKJ2S0X25WEgXJbpfLItCvRQzF
	BqnxuPeafjFvyvK5/3UsDlDkWKNsO+9u7e8yw+ChHVbeksh86Mz9KkO2zgceotOpWMccrqQMfQI
	TFtM=
X-Gm-Gg: AR+sD12e2outK6/xXc0ol35tLApg1+411d3Ght0wboRPOcVtwJPEtnleE4bU3ZGi3d3
	O/jFHTn8IwWnHG1GOJKbUuAab0Z9zopathSrcWc6qK35z3u5kBnQECiaOQs6OxVno3oVzDZXHt5
	2iSoZQ1Z3WW+b57UPyreI76NQ5ulvX2atsL2WaGb6pMqG14jiwCE3FANtVGbXmCQLMsm7Rl8HEC
	kNpHKHNvDp25pgxUhnY0DWXgPQUncKk3J/tjbRPr4eHAI6KwqHXVODsOXO7q5z0/P3olNuA5IFb
	agdRH/6WRzoedjvYTLiZyC7M+B0gXl5bht38fHV6SyKQXxRqOIWH91ftYmqK1awgKpaOWLc8rp7
	Bw4223KNdYw29b+1eYRakhtM33E+6tUIAjNcmKqDeXCe8d6Rq2Mf/QFMLOObIB9JVMyP+eCjW+w
	YqGYE6icipkIiLHL7mJXni/yAoHnDFdjGrjac7XHF7hAXVyf85qukJDDY+sGbd/ebuDSIcofztO
	PwDRqnfiGkDBKlah7eDjLfdOQY=
X-Received: by 2002:a05:6830:82e1:b0:7dc:d967:63de with SMTP id 46e09a7af769-7f43f90e40emr7647323a34.3.1787159467597;
        Wed, 19 Aug 2026 10:11:07 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4439d218dsm1743248a34.26.2026.08.19.10.11.07
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:11:07 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-451d8064238so966973fac.3
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:11:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr/GzQ5mVpI9xwfJ3hl2So/CwpTueusOWajw1m61VXxu/6SwM6lA5CJSniZ6/DmLSH8LZkgeo1XHCfuj3A=@vger.kernel.org
X-Received: by 2002:a05:6102:918:b0:778:5c2b:f836 with SMTP id
 ada2fe7eead31-7785c2bf8famr1715744137.5.1787159025695; Wed, 19 Aug 2026
 10:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
 <20260724-dancing-skunk-of-novelty-72c1b8@quoll> <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
 <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com> <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com>
In-Reply-To: <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Aug 2026 10:03:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuVdq_=TQmONJZak84S2c2-2yQ8DS0k_odYsUfg0C+rQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xq_Hs6V24rG4OhS-cjamxWAO0UpSeGmP_9xYxqjvzRBGkaMhCLOMPBOe8
Message-ID: <CAD=FV=VuVdq_=TQmONJZak84S2c2-2yQ8DS0k_odYsUfg0C+rQ@mail.gmail.com>
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

On Wed, Aug 19, 2026 at 1:29=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> > Is there some other documentation saying "aliases =3D=3D evil" that I
> > missed? Maybe some email thread we're all supposed to have read?
>
> Yes, kind of, it was 10 years ago and about MMC aliases for
> selecting a primary device for boot:
> https://lore.kernel.org/lkml/CAD=3DFV=3DXLuPWKjQBMLApRQxk0K30p_TPcztB7g_1=
DB7iRA9BGRQ@mail.gmail.com/T/
> and you were in the thread, it's not pretty, leaves a bad aftertaste.
> For, I think, reasons stated in my initial paragraph.
>
> The takeway is something like "the device enumeration is policy,
> not hardware information, so it should not be encoded into
> the device tree", and that is not an argument about aliases
> per se.
>
> As a result (as I think, I may be wrong) MMC gained a few
> properties such as:
> non-removable;
> no-sd;
> no-mmc;
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>
> These provide a heuristic for which devices to inspect for boot.
> Then on top of that I think people use schemes like EFI for finding
> boot devices. (Or they still live with their quirks...)

Yup, I was definitely involved in that conversation around mmc. ...and
yes, that was a frustrating topic. Though I guess I remember things a
bit differently / have a different takeaway. Specifically:

* The whole argument there was about people not liking the idea of
assigning "numbers" to MMC nodes. As I have said, I'm OK with not
having a number here and it's not central to my needs. Said another
way, people seemed to hate assigning a numeric ID to hardware devices,
which is not my goal here.

* The "mmc numbering" patches were (independently) sent again and
again by people because (shockingly, I know) people found it useful to
have their MMC devices enumerate with consistent numbers.

* In the end, support for "mmc aliases" was landed. See commit
fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree
alias").


> Now this ufs0 node seems to be about calibration of some sort,
> which is a more hardware adjacent subject. Is there a way to
> add the entity that needs this calibration to the device tree and
> reference the UFS device with a phandle along the lines of:
>
> calibration-storage =3D <&ufs_node>;
>
> ?
>
> Even say adding a synthetic modem node if the calibration is
> for a modem is probably going to be more acceptable than an
> alias.

The crux of the issue is that the bootloader needs to add UFS
calibration to the device tree provided to it, and later the UFS
driver in Linux needs to find this calibration data. Since the device
tree lives outside the firmware and is provided to it, the firmware
should make the fewest assumptions about the device tree possible.

Having the firmware hardcode the path to the UFS node doesn't seem
ideal, since (I believe) device tree paths aren't guaranteed to stay
consistent according to the device tree ABI. This, and the current
downstream device tree path differs from what upstream would accept.

Using an alias seems (to me) to be a reasonable solution. However,
I've tried to express that I'm open to concrete ideas.

I appreciate your suggestion of having a separate node for calibration
storage. This feels more awkward to me than just giving up and having
the bootloader hardcode all known device-tree paths that the UFS node
might be found at. That being said, if everyone says that this would
be a great solution, I could try prototyping it. The trick would now
be that the Linux UFS driver would need to be able to find this
calibration data, so the Linux UFS driver would either need to be able
to find it at a specific hardcoded device tree path or the Linux UFS
driver would need to search the device tree for a specific
ufs-calibration compatible string.


-Doug
