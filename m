Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547D191496;
	Tue, 10 Sep 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972093; cv=none; b=pelwX+Vh/aysBRjYC1epC8S/3ud8IwSx7ZdXMh777Wdcs8efAszty1NJTXqoXyeYSJ+/S0ihxWyr8b9Kcs8He9RYSWkwPc364dFwWP7ThT45E34XUUtXeWdq6AQXxnjbjk+uh2Te1aRwyAW9pqcO3lTCIuNgKeSe7WtDHPXxge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972093; c=relaxed/simple;
	bh=+6YjHJf3opWEu205zGa4rrPdFmwzUleeuk+5gD46Dxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hson85fczgzC8g1OfCtwbSCrJpHNxKuTnX028UxUlJqv7dZ05ZDEwOssHpqQPpxmHwbft99iGoR3WGpONW+YVxW9IDxLQRvJImxudjrLg+DGrOOGDjp56vTWROA5B5h0z7ij9GKk7PGOTfAFQ5Vc2my3v27FCJ6LqxqEoQUwlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmrnhr8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmrnhr8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A7BC4CECD;
	Tue, 10 Sep 2024 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972091;
	bh=+6YjHJf3opWEu205zGa4rrPdFmwzUleeuk+5gD46Dxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmrnhr8TVp7AtPWIlqRWhHd6A+fvSJdtr+IbuYmxNL2Ci3BD28E15WLDouiMCRz8q
	 rPjt4bxqs67TXqsDpoDaYXzcl80w+siS0FAZWTZzJQr/aGhP+3ohaLalplrnmblY8r
	 nj5Sb+eje5/4gBTt1gnrYY2uu20IWPiwWOVPdd8vA/rLtBJXLrH8zQv8glh0vOU6Jz
	 f5FwOEL0mIJV4AcGxEV5clxM1mmY5l8hCFLV3nVkZYImve0zTp8HuXhdxsdHcnpwPZ
	 6P8sXtvzwMMefK1AxBPmMMFeV+++vdX9+lMa3YlaB218yew+RbuKJQkIaAA5dThjYj
	 ngOhVjYbpvCpg==
Date: Tue, 10 Sep 2024 14:41:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev
Subject: Re: [PATCH v4 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Message-ID: <esj26nonbriko4o2qqut6bsril4x5rwbwmw4qjksrnrtj2cbhl@awjqecif24m2>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
 <20240909084222.3209-4-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909084222.3209-4-towinchenmi@gmail.com>

Hi Nick,

> +#define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
>  #define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
>  #define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
>  #define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
> -#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> +#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)

As you are here, you could use genmask

GENMASK(0xff, 3)

Andi
