Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468D39FF3;
	Wed, 11 Sep 2024 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037956; cv=none; b=SU7TU2xYmLe+ydIhOl1arjhvn/RbldMlN1xRDHkz1166rnIPt3Z2OE3Pc+4lqkee3ipGRCU+zYmMmlqQWoULdXj0mFyEI/OM4s1ruhhkv4V9ru28HkS95auQzSbsiw9HiaxioixYxQrMtG4nobkglVxn9ttKdFEBFoJtbWVWV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037956; c=relaxed/simple;
	bh=AnBtxco3yRC51pzCXppKC33LfjwOacVSPC045P2odLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl6B/ukfFna2f4yyVeY7aC8KbgjIozxqnhgv/G5zoRCSTfeKfHrVzUA4P2CitpOrsNyjN6l9pguO6dq7OSATLqnQADsueyD3Kv5RtfjdFeQF+sQivVSD/ozzw+D3w7bRzgVTSsrCuVvYjjZbo0dNkVFTflN3Dy4l5NZcbISbafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyaXfzfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyaXfzfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29470C4CEC5;
	Wed, 11 Sep 2024 06:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726037956;
	bh=AnBtxco3yRC51pzCXppKC33LfjwOacVSPC045P2odLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyaXfzfp0N9utDj/WgncNM5H4nYSjzr+DbKX+xFt8XIq2QspYHW2DYjErrz/DF1DT
	 OwlCyu5MRhTMvYvFNu62d/6ywcff20VuLgidMxx3W5n8izbfU9mB/TFePKU6Sbm3CA
	 Mn66TQWhGJNLeTkICQytxR3aVBg4qHtIvAUg4k/koQLvAMuRMjhodYQEfsZSYZWC17
	 QpAKhgmA+WX7jAElGoqaH838cGhrEN2wcjlSba17FIk5TAHYWjM+Xv1qWfAGvLy7Nm
	 S8jaHNfanJUch5nwr0VOPui0pqp8yc80fMp/0A5VRzxwwhsKFkGLSYmIzFeFVS3Scl
	 OvMIrBuGBGOvA==
Date: Wed, 11 Sep 2024 08:59:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v5 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Message-ID: <r2y7z623256y4u4adttdp2romnbd5v3rhutw47yozgvpqyxatg@2gpc4yfy445r>
References: <20240911050741.14477-1-towinchenmi@gmail.com>
 <20240911050741.14477-4-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911050741.14477-4-towinchenmi@gmail.com>

Hi Nick,

On Wed, Sep 11, 2024 at 01:02:13PM GMT, Nick Chan wrote:
> Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which is
> enabled by bit 11 in UCON.
> 
> Access these bits in addition to the original RXTO and RXTO enable bits,
> to allow serial rx to function on A7-A9 SoCs. This change does not
> appear to affect the A10 SoC and up.
> 
> Tested-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
