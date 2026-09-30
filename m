Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED24078E5
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804856; cv=none; b=BKJn2zvO1LAgVJtz4cZbbhcDFvVGxWXuaTyYDE4+gGHXV7bN5n3ne6db1BQnKmuFYgk8aOXgIz1o9cWpjNvKevNaIdr1ZvQLbOFPW+tI97KXsC/8+7Io037Yx1t+YK3LjmCyA21ng+f7ILkQ8VqkOoivErpIrLD7oFH2pErr4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804856; c=relaxed/simple;
	bh=m+T593NoH9LHM4nyge2qVy8iIDHmmBHMv1mbnGq3CSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2pDBK77KcrG8uXlglJWWrh7cFUbtTc21gMSPCK+GAfqYCa4I6YBpSaUlMq4fbRRCuIBBSaDYugxGeqiRT+u/TIDJpvuisu+XPMVZk//eq/c8yjm4Qmz8lTgj6R7sR+mvHrAZLQ/2l5PFFw2JHWl1UOlGgv1wEKGv+W/+GjJhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UioBh4V9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UioBh4V9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA1F1F008A0
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 21:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804854;
	bh=MfzXiat9H5DF2PiTWs4O9ojHJwLpSTSb+XBwmSF47uA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UioBh4V9PQcDGpw9Unc/Da5NbMY7NE901fFzRagTGXiAlkHHTtMmv1OqBE/22sWOa
	 ngwmBVUj4zgjk9SlH7sYU4Nv1ZzJIwb4Zq1x40gAI9cvvsjpikYfYtDp+lgEnyYGXg
	 qScvN3edrMuJeR6BOwCCpC2Y+KnFw+L6rdq7ow0vWuIZqo0zXRVILaeDOaFVSQKNw8
	 LmaJ9GFc2x/aAm8iXx244y0PS3EdDOee0MNGKX7OzSxfi32rRN9FAnQh4Kp9dMnp4I
	 7p/6JJ3P9u0fBzDoVhvRo4kvrX0Rx95HHSgX7GHkA4gtPhA21ZGGayF7McLMZ5BG+m
	 Q5MEMnDNsf5Qw==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a75ff20a6eso28474711fa.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 14:47:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwmz12TLRHnpp70V+uB1m3lY6Ui/bhTVxt3pLPFWeUcOKWYQIedukBA8EnbkODQav7ny/wGbdIygG0oWgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQFtfZyG310amip2hV6oOFhJ9eLXd5w5FEDRZp310L229rz2O3
	e4a4gHp3ecn/EeKJxTyu02Ej71VPYoTFfxa+Z6lvu8kOFzJ4F7uo3hh37oyWqfM1OPfLqnDj9eq
	KrBpOCnx3IGwUKD0ADXjNSm85AOS1HB0=
X-Received: by 2002:a05:651c:1990:b0:3a7:7ddb:aab3 with SMTP id
 38308e7fff4ca-3a77ddbad7emr6934201fa.16.1790804853193; Wed, 30 Sep 2026
 14:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-2-745eaca28b1a@linaro.org>
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-2-745eaca28b1a@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 23:47:20 +0200
X-Gmail-Original-Message-ID: <CAD++jLntPtJVosWrmO4Hh_kuAPyC2G8MRB9BAwwR0wx1OUzLiw@mail.gmail.com>
X-Gm-Features: AclHuK9JASmZ3mAuwTzXMDc2vQ_yXfdUx9hC2uGUMFRzKST4nRDXC-j2uJr4VPc
Message-ID: <CAD++jLntPtJVosWrmO4Hh_kuAPyC2G8MRB9BAwwR0wx1OUzLiw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: google: Add dts directory for
 Google-designed silicon
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev, 
	Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
	RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
	William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-serial@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:05=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:

> From: Douglas Anderson <dianders@chromium.org>
>
> The first four Google Tensor SoCs were offshoots of Samsung Exynos
> SoCs and their device trees were organized under the "exynos/google"
> directory. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
> Google Tensor SoCs are now of Google's own design. Add a location in
> the tree to store these device tree files.
>
> Changes by Peter Griffin
>  * update config symbol help with at least 4 lines to avoid checkpatch
>    warning
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
