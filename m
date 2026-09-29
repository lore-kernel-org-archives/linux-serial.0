Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3024492E53
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672222; cv=pass; b=I9j74FkR4z5mnohpuYkxzYjFB7Umb1SKqJ9aQrs+FFHBSorEy2fC/S5BEie9fTbqcq1iOCfg/qdkV9iiKTw3tdLbnlvWOPnNShRbk48wowqb1fmmLaWV0z40INzwwZ3L8cdggwSFJSGdUvvTn736izYPLBwCV2s61SDJZ8Rn2WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672222; c=relaxed/simple;
	bh=bTzNqAl7bOHEFXynD4y2LmlWSn2p5vLqLneAHc7FfuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvuvKeIDl/8miTKaIeByorjJ/7UmEX3U7nIGmN/hev4yC4Pc0yX0VOxwffizXj6a51z7qG6tL0Th1dI7EZrJ+jd2c8AP8t8/mF0tf+xrVmPgFhh1dYOT7w2WIDPjktuzpuT1NBRmWYebyKkaJUJEqnYosPeUtoX1+NgcgB9GIqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=egkX0bpL; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egkX0bpL"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb6b726b5so544169a12.0
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 01:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790672218; cv=none;
        d=google.com; s=arc-20260327;
        b=EGAHbQYmZrZ0PHfZVEPMZn+Se0zWkKwSG49hNdr7xeyNElippx/Ip0u1wd8nUCFBDX
         hqLiywG/KUXY5+QpEu/3zGmaWFIzX+KTeDzbBaCYsK4WO6dJoUBCDU7BZCbmmQMz/iTT
         uY/FeRssili3FrIuXo/6VX43HjyCTewGL2GnJ9mGgDgxEYBM0qytk8RtQIky1VqdQTc+
         GDsbqrD9NN7ZuLvNHhqfgCjHC6uexpliCt7j055iJDgtOhwW94s7JVwlZ694dzChjdR+
         PA6WeYxAT7tlKRXA+4Kr7A/g4O1V5vd4mgq3UT0ADQ4a9t0syKC1L+8E8uDioXWZxAXi
         hxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bTzNqAl7bOHEFXynD4y2LmlWSn2p5vLqLneAHc7FfuA=;
        fh=Y/IyvMk+hek0ArUpdhgg85bHC5egiTv2U3+hv2D2ZRg=;
        b=am2EJxAQmc1T8Jtgz3QfHECMLCkuVkIpwKx/8WDys9JEywWHEeN+hQN8VwRlsQLIxD
         790DIJx/PCgsWlAooHxAxvTz86r3UWdLZedUa1Epfq2Uncifh/Pz0f3HtlHfeVeCy1W3
         yfnDR3jiuXn66c6s8c1fab0EK76SQIAsaPx6bRv8NaL710ibOLx8R2J7o9jkVEJsHGxa
         BIZny4QalWVJNwyC5JfDBxObjcH1GDgsEQINhCRtsYRFjQMrjIC2PHLdoiCKdiwJe8kg
         CU+3Xazt4I4sRwqt4BshEwe3gy55nMJFn2zOipaQ8Ix5Pl1y7T4Gc2sxBv00t3vwIYGb
         h7LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790672218; x=1791277018; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTzNqAl7bOHEFXynD4y2LmlWSn2p5vLqLneAHc7FfuA=;
        b=egkX0bpL6rutl34raL6Zr2+yA6+NRhsfdwGss+M1PG3PmWtN5xcj7wyQzmXZM8tOpE
         k3YPGc4I0soEljUWJp/bjCcfLCFwHPHk2tDNe8OI+B6RiY+zCl+94iHDaEtdMq7pOjq1
         FA8AWwOZmBiEGsGzDNSpdggISx9rHbM1/OUdkm2fbzMb6hy4baA0vcmxCboLJrha9BhX
         tbHLJ+AHEr+mPjt3RVqTWMxSKWJoYlz6SpnhUn34zJZFb/XjNTtVk5KfA7ky8NSrWWFx
         rEbcckJMr7quxmO1VpZon0Lx2Q4p8mq2yGPe/E0pVtpsHe7VgUrQsSjXous/G+/5V2b7
         f3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672218; x=1791277018;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bTzNqAl7bOHEFXynD4y2LmlWSn2p5vLqLneAHc7FfuA=;
        b=eDD/EFQem5qwIKQo5N/DGp20dpXr0Fn+w7xjdRi7ejoBWD9qIq2Db/dHf/itP85AUA
         IZI6C+dLkVYjwHxwqDNus0I+4SmNyssEtCtHKydQJmWhFbD2dPrcjcOpe7kqM8gZ5Xnn
         qCZ9nw2RSf/EFK8Uur15TEknfvIlk42x9bccK0F/0q5LPf79OU9gq4LLqVhqtSd5kbak
         FKOxRcW7ji66U0tOfyB9RWD7LnMa7yx8L9z2Rvqryrjc1WlipAvSRDp67lU3HSKGiD3X
         OHTgd6TJ9M0dQWK/GAgQ1Qw+gR4YbtLA9rxxcrrux9UracqVlPHF4d9uTio6Jk+C9QcD
         i30g==
X-Forwarded-Encrypted: i=1; AKwUvBwlI5tJstHJUC+PFrBrbe7tjs0RiN38IF6ok4yEBoNosxXdfs6s7rSdGv2jI3ezQ9x1FZSqikuo6hnuUio=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiQrJTv2hZl2mq7OoaPuA0mfv3SEY7CkA3hfJWX5bFfvoj8iFz
	4tJ1RVm4ag/nIzaAVsCHBhTCeiZVLMsinrLsZW+Dc9xoyh/M6I1fV6k3Xq+jF0oiS3PcfzzFPC6
	iC6BQIW/RSjvLSsVGoHh1h/VqPhcrku5Q4I6wmqnu7g==
X-Gm-Gg: AYBFou277a0AzEPDEoej1V8E2wiLd8zsEbsgBkti8z/CKseTgKxmyTLzWDGNCChqcx2
	mmKxCjW0QSz4y59fKnKV/dReiasmTY+zjCNB4hVcxho5n6z67udsl+ZVfeMoi7RKq843Vz+BIyN
	j4XlgGbHbWVk2SpTrz8C+5UIUa3H/ZS3rOqNZAA0rsiHZjSRWmLD3qi2eGjdpm32GFx1sfsiK4p
	UNun9cVsUxcIa5/VfsSNj1T7hMPFG5DbNr3T6YHJJeMbEa237JARsW9GCocmw/xSowXW17swrBD
	i57DwZmOD0wxrykYjfUKQ9s1dTJKW3whpTtTBneeW50bqnHOB7ShW+SNh9ohtUkTYBem6eS7RrK
	BoJLO+YadwEOK
X-Received: by 2002:a05:6402:1951:b0:6aa:f14f:556f with SMTP id
 4fb4d7f45d1cf-6aaf14f5874mr8695635a12.43.1790672217943; Tue, 29 Sep 2026
 01:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-3-745eaca28b1a@linaro.org> <7553dff6-004a-46a7-88c2-728651366113@kernel.org>
In-Reply-To: <7553dff6-004a-46a7-88c2-728651366113@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 29 Sep 2026 09:56:46 +0100
X-Gm-Features: AclHuK-S5lTQAo2phJ3ee1A6qOipGEmCVgzdBHBpPtrnraavkUJzNtrZ-i9YXbY
Message-ID: <CADrjBPrUr4+oa2jFJw8PkFbO__Ov91Do7A-h8xp3zdePGQcMKg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev, 
	Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
	RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
	William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-serial@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzystof,

On Sun, 20 Sept 2026 at 16:16, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 18/09/2026 21:05, Peter Griffin wrote:
> > From: Douglas Anderson <dianders@chromium.org>
> >
> > Add initial device trees for frankel (Pixel 10), blazer (Pixel 10
> > Pro) and mustang (Pixel 10 Pro XL). These device trees are enough to
> > boot to a serial prompt using an initramfs.
> >
> > Currently only Laguna B0 silicon found in mass production phones is
> > officially supported. Further revisions such as A0 silicon and EVT
> > devices maybe added in the future if they are useful. As of today,
> > these device trees boot fine on EVT devices with A0 silicon.
> >
> > A few things can be noted about these device trees:
>
>
> I actually forgot if you intend me to pick it up. I assume it's not for
> me to pick up, but nevertheless let me know if something is needed from me.

Thanks Krzysztof. If you could take this via your tree for this cycle
that would be much appreciated. I will then look to set up my own SoC
tree moving forward.

Thanks,

Peter
