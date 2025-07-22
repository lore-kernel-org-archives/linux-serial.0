Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729F1DF990;
	Tue, 22 Jul 2025 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169283; cv=none; b=gzCiuMjZ8hT7lNP7gx8cCuFDahVNDIs1vaznOldNXW4SIESjfZO1ccrVAVl/Ju6dOVIuoLoGjKFc+rKToF8LvT7T3EoDeIbT2VXHD5hm7HV3ngBQPwYpUGthVxoPcGVfjbi0eeZwR9wyTAqsauNAp80ssEZ+0nT64mNh69sYK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169283; c=relaxed/simple;
	bh=OS1W1F3+uicr+BJ96OdK0Fwq1c/V2PKY69jVU9c7b1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgoE44USUg0NViRzWKB14d9pRdBb6s1IjCvDlDcBt4eQauv00s/bcwDrrF2CtrYAYv99JgYnNMA/Jj6OJwlESAbN6SZmfRKUDas6mC82LpOMhJQny8y0elJwhxMJMBCdMKc0rrxrYBQyELH5Toooqly9c2+i/zITQZ9RD876ngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anb5ftzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anb5ftzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB287C4CEEB;
	Tue, 22 Jul 2025 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169282;
	bh=OS1W1F3+uicr+BJ96OdK0Fwq1c/V2PKY69jVU9c7b1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Anb5ftzHQ/yX14xJp8PsiMzrMY9MEeKaMm0E7CtepaK9fz3qD32p+mSm+VxnacIaq
	 uTed1zP9zxx+3p1YJEHuNUe2M+2hkS5okxg3hAdudS6oaDy8ZDDDvFaJqZ3dBVMJk9
	 6AVXN5T+UUdkKagrek0uBrKfyB3iEawqBiTFUT6IWFpOKD916pivrYdbwtixibiCqb
	 5Q/bQZL9I3lESdWUJVbnqQ5R6jm7y7j5ccdH9EcFfWYZ94Zy/WSHnHlMA92qH5cegE
	 lAjV1zRlqTZ6vnrkcZwbimKHVPc5F0077eA69+0EbWwRC5ikbLCrOqoO12IiyyuPuS
	 SfB1yGOVJPJyQ==
Date: Tue, 22 Jul 2025 09:27:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: vendor-prefixes: Add Anlogic,
 Milianke and Nuclei
Message-ID: <20250722-elite-topaz-parrot-9c5a5e@kuoka>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
 <20250721-dr1v90-basic-dt-v1-1-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721-dr1v90-basic-dt-v1-1-5740c5199c47@pigmoral.tech>

On Mon, Jul 21, 2025 at 11:46:07PM +0800, Junhui Liu wrote:
> Add vendor prefixes for "anlogic", "milianke" and "nuclei". These are
> required for describing the Milianke MLKPAI-FS01 board with DR1V90 SoC
> from Anlogic, which uses a processor core designed by Nuclei.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof

