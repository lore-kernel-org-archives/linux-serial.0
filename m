Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78431DD97;
	Fri, 24 Jul 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875574; cv=none; b=RFCrcUcy7iHq7tseZNxg2wvmFzOd4jMArtVvrpawzSDmBBqV0scwavYSYFt9fkkSnMM9HLUx9dV9L/KbChDVVclnSMko4wem+8mlfGRDE00g51yGCai26DravgoUIK2EwZpeLKgsl8VKezlbvG5AiM9QLlRSywIJ45HqLvh5dqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875574; c=relaxed/simple;
	bh=hlD8/cUKG+I0EWOOvCr44jhXNOo65cxBF40fW+R3lkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfu0IZEVuXVKuCia4VbJ/SQn1agi9Sm8wF+gsw9XYF9ikO/K09I1mns4NAnWtJTaiuFCdK80pKrcBNyPTJ/VrTIXlg2oWwoYiS/zdBSewsYpPEDJhG6+XFxqU8gbbtfFQTTQ3IbTJaQ8O1HW9BVdFKa1Zh4MzuhcRgeWpnP7T5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKgAwGFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKgAwGFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C61F000E9;
	Fri, 24 Jul 2026 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784875572;
	bh=b2vJ+M9F1JLYCArJOe+bb3FjbJIxromizLHWPeuzgew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HKgAwGFOvOviAZUJinOxYdfg0wAx2QbSqVbqMnW1JJvoze7ts8+Ds109tCjdxxQPk
	 0rai1An1f7xfB/30JNFJu8L+Wnhch+4k+gY+R24jQ9ORWLNgZZnVENr8IR3QWrbtdr
	 uPqRxKc0XwWHkAP2ut71VMg1a23QETq0SXphP5gvW4gw18RVKe6AE0/ewyHgnJRuJh
	 PI9y6/k5h86eahNgB+G3oQGnL4/32yES+Y+KmL4VwWqMY2i7hmw88Xf8za53k1HovT
	 k/hi5B91WSoR92Bqaz4l4A/9AewffiDWU3xXqoN/ONU5EuL5SbmdWbosF5w7+XkDgj
	 GuEW9pwd0HA6g==
Date: Fri, 24 Jul 2026 08:46:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Subject: Re: [PATCH v2 3/5] arm64: dts: google: Add dts directory for
 Google-designed silicon
Message-ID: <20260724-sly-grinning-pig-86900e@quoll>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-3-3abae9717feb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-3-3abae9717feb@linaro.org>

On Wed, Jul 22, 2026 at 10:55:54AM +0100, Peter Griffin wrote:
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
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  MAINTAINERS                         | 1 +
>  arch/arm64/Kconfig.platforms        | 8 ++++++++
>  arch/arm64/boot/dts/Makefile        | 1 +
>  arch/arm64/boot/dts/google/Makefile | 1 +
>  4 files changed, 11 insertions(+)
> 

This is not Samsung derivative, but new top-level SoC platform, thus
usual way is that you send it after review to soc@ (see maintainer-soc
profile).

OTOH, the maintainers entry is the same as Google Tensor GS, thus maybe
you want me to pick this up via Samsung SoC tree?

Both will work, up to you.

Patch looks good.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

