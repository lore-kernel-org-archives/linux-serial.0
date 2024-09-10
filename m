Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11A18CC1F;
	Tue, 10 Sep 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972533; cv=none; b=WwGrbf0x221vnOMrvIN5US7cRIddQUrucC9l6Hp/hfbRYCZtUQHaWoQZaDG/i5oqOuYWJZVZ1tgutTZe9iDLFB6wm3ptP6BXrf1v4IOkMuIX9M8gBQQkdE8SfZO8I8p6NUbKPxPzxmzoh5ajCDx4PJvLJev9TluTDWfm8WHL3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972533; c=relaxed/simple;
	bh=wSgMr4bDW2e+8C/zQmjfwmPL3IdEQC7I7Dp8R237ifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+ByFoHUBmDlDaPM5qjnyh5Qho4M77be3UjA8WrFqUNQRSXGUP8RFUoA2lCS7+TN/hS1Kr3fzV2U7hKXYYAI/zVaNT+cJY1+5WiCWvdmwg5H25iFR88NJbrwd10l9H4f0YqDHWweQryZ827tmVFf5KFU/clzkRuaKtCNaMTlLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPquxqie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPquxqie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D14C4CEC3;
	Tue, 10 Sep 2024 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972533;
	bh=wSgMr4bDW2e+8C/zQmjfwmPL3IdEQC7I7Dp8R237ifQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPquxqiep5Uxda5SvsscPtYIm8U7pNAFmJLvrRqqmV4B8PjqgNROn2SqWDZDFPDqb
	 IJ30rZJtmsovvOBFNeM7MykvZF9I0GNXVSMmD1F1lCVtqPCeJYF1HjQZ9oxStp5MN0
	 YDEsAWt3GNu6fQyGM2IFJABJR3GTc9rCeEewdC9Ki5zVqJUqKwqyh6evjXM3ey5y0q
	 ftYcQHMKh9ZARVbda1X9mQ6xbPbMwWmZwMlIgzrg1/bLbhAx2lozmCZXCeBVRPbpx7
	 ufoxdp7LbMSY62TEsjITNm50N+ZmmeYDDXD4jmZ4My9YCu3bMP2MbHhrJhjueVCgXv
	 qTakRzXAJa62A==
Date: Tue, 10 Sep 2024 14:48:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev
Subject: Re: [PATCH v4 1/3] tty: serial: samsung: Use BIT() macro for
 APPLE_S5L_*
Message-ID: <lbyvuozxjywyt46w2imk2jvwfas3p43wooj2ioyhufwkyg72da@d6stk7xk4rx4>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
 <20240909084222.3209-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909084222.3209-2-towinchenmi@gmail.com>

Hi Nick,

On Mon, Sep 09, 2024 at 04:37:25PM GMT, Nick Chan wrote:
> New entries using BIT() will be added soon, so change the existing ones
> for consistency.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

I think this is:

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>

> ---
>  include/linux/serial_s3c.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index 1672cf0810ef..1e8686695487 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> @@ -249,9 +249,9 @@
>  #define APPLE_S5L_UCON_RXTO_ENA		9
>  #define APPLE_S5L_UCON_RXTHRESH_ENA	12
>  #define APPLE_S5L_UCON_TXTHRESH_ENA	13
> -#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
> -#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
> -#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
> +#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
>  
>  #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
>  					 S3C2410_UCON_RXIRQMODE | \
> @@ -260,9 +260,9 @@
>  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
>  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
>  
> -#define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
> -#define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
> -#define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
> +#define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
> +#define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
> +#define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
>  #define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)

You could make this GENMASK(0x3f, 4)

Andi
