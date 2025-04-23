Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8127EC89;
	Wed, 23 Apr 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418936; cv=none; b=T5BWyXN8DBbqSIRNpyMldPFmKK7XbV/HENNw+UGY0guTDCX8ou0YDJSVjlEWhtezjyWqwp+N/xH9IferdYYRp8EeXBLbW6YLQuDtw4AQ0nHg4soc1vRwuTPD2Zzs5XHemXRvq5KodnUePD7zF2Z3cIBsPLlP7A0aU+fznBRGPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418936; c=relaxed/simple;
	bh=4Si40+ygexYmg1YkZNONSwS5KfCuHhpJXbdNq4wrsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juwYwKUBagx8JLtO6tay/pmW+P/NfrJLcDwxkQd5DqMxlf3jc6VfJHEeuyUDSwFEonWzw2AhvBLu6L3tb0iW+zRrvN4m2yq9I5aYxmsrxMZH40xOH3Xll/b6Ex62Rb02TZerypys/xSi7ew7jvswxV4rxQO5hKolb0GV5Rw6Dz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLE6fPhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLE6fPhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5164C4CEE2;
	Wed, 23 Apr 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745418936;
	bh=4Si40+ygexYmg1YkZNONSwS5KfCuHhpJXbdNq4wrsQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLE6fPhfXvYb07BvgYEWKmzLmt1uuQ3hXqSVqOJb2v113CL1ihzPkQfmO/NUEiZCC
	 ki6JwYtlnvrTEGG3mJnIKwqaTUPo3HqjD/EWsrbBVVONmsC/xdWlQkgAOuQsD9B/xZ
	 EuZYFMF4ZZHoyhECcrPoXf/QKGoNdIsk8EGoAi3M=
Date: Wed, 23 Apr 2025 16:35:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] serdev: Get serdev controller's name by dev_name()
Message-ID: <2025042354-imply-pointy-92e5@gregkh>
References: <20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com>

On Wed, Apr 23, 2025 at 10:27:00PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> serdev_controller_add() uses hardcoded serdev controller's name, and that
> may be wrong once user changes the name after serdev_controller_alloc().
> 
> Fix by using dev_name() instead of hardcoded name.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/tty/serdev/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index eb2a2e58fe78fbbdb5839232936a994bda86d0b4..971651b8e18dcbb5b7983cdfa19e7d60d4cd292b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>  		goto err_rpm_disable;
>  	}
>  
> -	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
> -		ctrl->nr, &ctrl->dev);
> +	dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
> +		dev_name(&ctrl->dev), &ctrl->dev);

dev_dbg() already has the name in it, so why repeat it again?

thanks,

greg k-h
