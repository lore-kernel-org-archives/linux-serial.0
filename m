Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2C190676;
	Tue, 10 Sep 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972573; cv=none; b=Ybkpl0ruPfY6OiD89CDdWeObLF9Zks+CStTXBeGs5/tJ7JBjixIJtU5nlNXVpcgAlBMirCZw1R65+dU9B5n3qdy+tCT/wNl8GTokTMVbnJOOQ0JQpfLLzjMHxIKi0KYG7I/ptfXg/tZjgUZY5yT+WPcMOE+5CIsRR9pwMu9j+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972573; c=relaxed/simple;
	bh=MlSj5jUkoyVoDCtopJzI+zIvFrTuWFOekT1+QNbIaII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgpgK0D/BToNffCw0xao0QAHZ/tK65ADBpTCdVN8pW8zWHz09PK3pdnrD5asjrKIgZqp2yiCRpVg3zKyed7K8wXajGV1B2s7ZDLOT4HB4hjNoGuPOIgie3snUoLr6Ff/wv6Jt1SnMxh2X7fym/rR3hizeSqRhD/ZCx4mHoWT47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU1E49Rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU1E49Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A71C4CEC3;
	Tue, 10 Sep 2024 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972573;
	bh=MlSj5jUkoyVoDCtopJzI+zIvFrTuWFOekT1+QNbIaII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GU1E49RnJiJgWn8UAxsiW24YYwMsNj4gyCGPQO+vB+09YCD2Oy41TPYDa/5i444v9
	 sAAZoFqYgpMs2FYkwCvtF7aWtRHTupjnx5PmU0BSt7nRBwxYLiMxNQv9hGtBvYeSIS
	 UlnKxvyuALNKa2T9uev9C5k1SMpiqsorUhPvwmyABeF5lD1WwGCQ0dBSyJ9OozrrxL
	 XgACRan/T7aw56AoK11VRa5fDghjwjQbRJLQvCVANnh6qsv0LGWAQbQVH5Tmu0W2rJ
	 XIsVQ98cI3GqO+teZzS9aYdaB4URPfRwda3g9i8K1fDfeURLwaz6pWnNz2FbLh2z8A
	 jQjoFP8fgMVEA==
Date: Tue, 10 Sep 2024 14:49:29 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev
Subject: Re: [PATCH v4 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Message-ID: <jgdwt5y3tt2lbwczuxwea3bgqms4rciszbkligvaou6pzbzrbu@72ybekeppr7q>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
 <20240909084222.3209-4-towinchenmi@gmail.com>
 <esj26nonbriko4o2qqut6bsril4x5rwbwmw4qjksrnrtj2cbhl@awjqecif24m2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <esj26nonbriko4o2qqut6bsril4x5rwbwmw4qjksrnrtj2cbhl@awjqecif24m2>

On Tue, Sep 10, 2024 at 02:41:31PM GMT, Andi Shyti wrote:
> > +#define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
> >  #define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
> >  #define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
> >  #define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
> > -#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> > +#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
> 
> As you are here, you could use genmask
> 
> GENMASK(0xff, 3)

GENMASK(..., 2), of course :-)

Andi
