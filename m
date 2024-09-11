Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225A80604;
	Wed, 11 Sep 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037832; cv=none; b=i6U8Mug0hoX+eIcyt05JIn9lxDg6Dphx5u74DCziw5Q8t1N48pmBzEmNfGrixHbWVG7VJZYRQKZSzGNGGIAB/O+2tgMmK6Mc0Kz67glhqZB7MVgTr9HBn+mf8uFwiPFfGRWodKtOKI+Urnyva3fjLhWgsFVJ9BguZhmDMClk5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037832; c=relaxed/simple;
	bh=DkDSZHo3tLoBfS9FNDpX3nhDBdTeMRElINKQNI2ypm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/6GZc/epRavpik5BH8DSuPUO9aiTv26Jabn4EgUBNInVEfIgfdRJSyUaMdPaB1RGAgDtY/xD6btVT3KtXjG7lZ/m0QcuQsF3VmUALpGS2HHaaa8LMtH4Jacr/GVeWlHPyQz+qS5Yg6INSRNoCV9tWmBPjJ5ETg2uAVMsrGOJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+53XkKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+53XkKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC58C4CEC6;
	Wed, 11 Sep 2024 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726037831;
	bh=DkDSZHo3tLoBfS9FNDpX3nhDBdTeMRElINKQNI2ypm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+53XkKNHncC8E89jh0RORS1w5btlh4IRLXrX487pAtvMDg/izK/M3kfKPEnSQXJO
	 vgKF/5S0SqaNd4cECqkuAsZUbuyI0cEZ/Cy/AAPAOm4edmXZmyN1gIyAAMIqElHvtK
	 zRV127JBqiX23oL8zRCksEriiy/+QNrMv62Mbp25ILtbsh5wcKDRKVdKZlVHLSYk9n
	 NUQ3INiix+B2HttUyumNce3D8d2561Rtl7oKL7SSJg04mBYWfvlp8mpeQiA2rC/f+B
	 bOu6zB1AQrVfCpm1K7an98D/PKLi0Uch3GCZaWE/BuHCt5392nvy/aT3w+Dz/PpYfM
	 O2xPlSqijNYww==
Date: Wed, 11 Sep 2024 08:57:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v5 1/3] tty: serial: samsung: Use bit manipulation macros
 for APPLE_S5L_*
Message-ID: <7pzwy6ubvcld6zv2amt5s6cctup4du62ysxki5xzfqpys35arc@zbuv4uoht2xm>
References: <20240911050741.14477-1-towinchenmi@gmail.com>
 <20240911050741.14477-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911050741.14477-2-towinchenmi@gmail.com>

Hi Nick,

On Wed, Sep 11, 2024 at 01:02:11PM GMT, Nick Chan wrote:
> New entries using BIT() will be added soon, so change the existing ones to
> use bit manipulation macros including BIT() and GENMASK() for
> consistency.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

Thanks for the cleanup!

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi
