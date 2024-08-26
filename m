Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE32C1AC;
	Mon, 26 Aug 2024 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652055; cv=none; b=Q9u7rfkjJSc5rK5igAE4jMA8GvIXKVLcOa13O4nty2Sd8GZR9QlsovVHJvQnCZcdMWAmxSaVGl154u5Cmp+XNt3bgzEknSr4ych0Jgotcf28fsq08MCyGGr6I8nc5bL5ntHRjZM+b5wfLeJ6wvgLWnqZr9ID5fGdDJf4npKwxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652055; c=relaxed/simple;
	bh=M8PzmzGsKxoxe7APmdLlrOMwSJDjNeWLTNO/ZLQaq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrICi3F19hSWy7DkvIklXwYWu6ubpFVqIHTjfoRuozNgKGDeM4BlX8LJ2tQq2cF1W8if/b8+anpeD0eba+Gtn+h6i9uX/dST4Dqiy7gilFHq05+HPMawYl9W0PBmd1Yw3DPi4UcDmozXDvsGDarRmNNkEWyUionZM01UtxaKfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2MOgqYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2MOgqYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0944EC4DE00;
	Mon, 26 Aug 2024 06:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724652055;
	bh=M8PzmzGsKxoxe7APmdLlrOMwSJDjNeWLTNO/ZLQaq+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2MOgqYB1+c+B3HmKWJNdFq5pWC0ZdwT7maoaxpQAzOQvYnFbW3xTjmtCGrC7fgmj
	 KsXHARBtpgxhB2hPDZ92VZoL8Dr3Ltd+aYGceYD/69W3P9Zl6W9tkOiSZxjH4AhmVF
	 D0e3M/gnWktJ723Lk9NyFky8Fur/Y4Hi/KJWQxM271rVAO30/mKQciK4qjBaXy4cUw
	 JC48WSZC1Jg+RvBuX/D2Ihgh6I4wd+aG9nsdfnt3czoWMKonKyK24VvebTwOGAzqda
	 aIURyC1PSYrreXtmQyU8VudnW0i4GIfI8Otvtq5E8Uu3nMHDA5wxjK6LmtNey/X7my
	 68kIPA0WqQt0g==
Date: Mon, 26 Aug 2024 08:00:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: zhenghaowei@loongson.cn
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	p.zabel@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 3/3] LoongArch: Update dts to support Loongson UART
 driver.
Message-ID: <gtbaqcnk4g3f4achlyiixu2bbb2rxoxoitbltqxavexjoyqxlf@furbr4zsirkz>
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
 <20240826024705.55474-4-zhenghaowei@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826024705.55474-4-zhenghaowei@loongson.cn>

On Mon, Aug 26, 2024 at 10:47:05AM +0800, zhenghaowei@loongson.cn wrote:
> From: Haowei Zheng <zhenghaowei@loongson.cn>
> 
> Change to use the Loongson UART driver for Loongson-2K2000,
> Loongson-2K1000 and Loongson-2K0500.

Why?

That's what commit msg should explain.  This is not bisectable and
breaks users without any reasonable need/explanation.

Best regards,
Krzysztof

