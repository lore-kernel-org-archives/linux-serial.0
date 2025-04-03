Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8D242925;
	Thu,  3 Apr 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668450; cv=none; b=szS/rYk3vczkAZ/+cyOwYHa7fE6l/arV6rQrEiYOoH1898Pp4+EZ3mPZEf1Z+v8+iWtvjnhjrVnjWkKkz3Matjl9fBkkdWXwuljFjqAZ2ogpp6ugcOdyr2KnaqWdnHNpTmlCTT8YYIRMWT628Nm9NxOOKz22i6SeIdpcjSl1Tlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668450; c=relaxed/simple;
	bh=UBSN/OHo4Q9PXbfUx0FETKktQcZxKW64BWiJbhHv1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIAUowuWymN2482OJ+CwGVSw4HAw7NfV5s6+u/ItKsYxgMp8uWUyIt4wS8B0SeLMWOXJKzjyjwkHzr+zR8/W8we4xTwIqViXd+YFbaKJocuKZN5O1rj5iUJpG8fY4x9Q4K86BFeDLdORxoC53mVG66pOdv3zHll8BRNnPPomw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p8eIemwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p8eIemwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2702C4CEE9;
	Thu,  3 Apr 2025 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743668449;
	bh=UBSN/OHo4Q9PXbfUx0FETKktQcZxKW64BWiJbhHv1E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8eIemwR6PUi9NVX19hvj/l50jYttMzps0V25M1eqYTqntsul/t/FC579H+I1euoW
	 VlmX6lLrg60d7Jx/wTMH0X0qnL8cRkjpfjZlCo7LbuF8zEscHclqLMkDA6DJJOoK41
	 FBX9D2rCWj9LfK63ZnBvHr8MPT5V+bTpRvanI9KI=
Date: Thu, 3 Apr 2025 09:19:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xiaopeitux@foxmail.com
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] tty/sysrq: make sysrq_replay_logs_op const and refactor
 sysrq_mask()
Message-ID: <2025040313-gem-nephew-2327@gregkh>
References: <tencent_F413E4391B578208516E16AA0FC81F2FEC07@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F413E4391B578208516E16AA0FC81F2FEC07@qq.com>

On Thu, Apr 03, 2025 at 03:15:35PM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> Mark sysrq_replay_logs_op as const and simplify sysrq_mask().
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/tty/sysrq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f85ce02e4725..c2a26abcb8cd 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -71,9 +71,7 @@ static bool sysrq_on(void)
>   */
>  int sysrq_mask(void)
>  {
> -	if (sysrq_always_enabled)
> -		return 1;
> -	return sysrq_enabled;
> +	return sysrq_always_enabled ? 1 : sysrq_enabled;

That's not simpler, it's now harder to read and parse.  Only use ?: in C
for places it has to be used, not for stuff like this where it's more
obvious if you use an if () line.

We write code for people first, compilers second.

Also, you can't do two different things in the same commit, sorry.

thanks,

greg k-h
