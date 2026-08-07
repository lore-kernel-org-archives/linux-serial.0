Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFC348463;
	Fri,  7 Aug 2026 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082502; cv=none; b=C/omhk9jm1Dpk0JvXKXFt88q9ch4AN34lZHYk5ureGQnPeKmm2oCwuQgrmJqP8JhPZl/P0fqOG9JgCb9XMcLfxckb7oT+wKVRafi4WPoA4JQt5KxKMhwa5zYKcEjpawow4ij7GhMg3Nkp7w91y+KUsnymE/+XUax1dqRKb7apDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082502; c=relaxed/simple;
	bh=i52Rz2jye2ceJWKGp8EZ7Bc7JIAIQX1PnMlHaXcQF9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG5sh2Yr1MJizNIQHzZ3vos+DsdU3aY3GYOUkYnUEHKB5S9lx07H4D1L6oaHa/y09yjYJ+AongqPXwYq4+fmxgWACsAi9w5+4heqt8oERuNyIeo7qiWrPsfL8OK1yCI0M58A/PIVFociheaVNkBuCqPV/DN1Grtl0x8O5V/XnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T497BqII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T497BqII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2511F000E9;
	Fri,  7 Aug 2026 06:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786082500;
	bh=mlpEb48WPTayGKdm4eVdxNznK3KImhnyyeVW6wCAWfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T497BqIIxWI3YaUWHpUZRfd69wbja9MhBt6qFUib0UHQQAUTcP+20Ysn2Uj5XZBIF
	 bZUlgp10L/vfXGa14VhG2Nw+pjMj3IluXbhj5fD4pTCwNkdASrSXBpxTbxXDJArhlQ
	 WIujQ1EC+Qi3OBKnCB66sUQCoBPyTyPLl9FjxiF6nW55mpNSHUOf2pGQbZ4F9VbmNv
	 I4qx3NoXA7GjN2ajbRgN0ISOYvQ1hMmA1vCzWrJrTY7U/3ObmbYt0k06sh8xpOAo47
	 B+YM/pW4NEeXj7ArLsFDOcDuAnosAm/PaxTq1Ajx2DIkJgJnWlWjYbloPI9ayzFstD
	 CCB76+SIsIYWA==
Date: Fri, 7 Aug 2026 08:01:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH v2 02/10] dt-bindings: soc: add Ambarella secure
 scratchpad
Message-ID: <20260807-raspberry-chowchow-of-endeavor-e57df8@quoll>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-2-6b09707c5fe9@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-2-6b09707c5fe9@ambarella.com>

On Thu, Aug 06, 2026 at 05:34:10PM +0800, Long Zhao wrote:
> Document the Ambarella secure scratchpad syscon used by CV75.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../ambarella/ambarella,cv75-sec-scratchpad.yaml   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml b/Documentation/devicetree/bindings/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml
> new file mode 100644
> index 000000000000..4bfeca0ac3da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml

Why do you need separate binding? What is incomplete here that it cannot
go to syscon.yaml?

Best regards,
Krzysztof

