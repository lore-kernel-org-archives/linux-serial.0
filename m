Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9AFD53F;
	Thu,  7 Nov 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969096; cv=none; b=eGVoLExaSPl7rwYTi9FbjqWFJWGNO88OqKADMtJtKZ0eYv+u099GoBoiczjV+sYEcjxwWFlJn/lSBl1aRs42+ZvbigjTFJqOTM/pM7A5Oz/2rAsTFg8m5eD2VR5A8nkJ1M1mfr9uM8XHR8z7TKNey41Oa7+1HDS9u6ijLx2YwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969096; c=relaxed/simple;
	bh=83ZkUERDxgt7MzsgkjxUaup4+Z3WzAyWmKSxenp1urc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qutcFWQOLzRII0koQvvO5+rHGkE+hEjGpTVXtdeOnohl0RaYhU3ST1ysNO97itQJjTVZN5Jfn3vSIsjL/NcmwGOh3dbAfqXxvDs+C8oIfzw/oP0mlvDdpmJ5CSYN4lK8vCbLs6gfSNxpCNglRzv03cVzFsT2UhKtWSVBhhQKa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdHXX6BR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdHXX6BR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C48CC4CECC;
	Thu,  7 Nov 2024 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730969095;
	bh=83ZkUERDxgt7MzsgkjxUaup4+Z3WzAyWmKSxenp1urc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdHXX6BRz9K72N/5L4TvmybrMeJstfwv7qZuLw41eh4Mqx5IJB3OGqWo3lGtHByB7
	 G5cX1rQjbKkcrj6e9fZEongbzeYvYKqxIx1hqgvVHt8DiiKYRYC1C/hmEKmJxDfUnS
	 t6q9V+yU7skBy9WS233hJTVI9jxJ1mcs51BbQnKs=
Date: Thu, 7 Nov 2024 09:44:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: synclink_gt: Fix incorrect formatted output
Message-ID: <2024110730-outfield-gigolo-e388@gregkh>
References: <20241107032936.2702-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107032936.2702-1-liujing@cmss.chinamobile.com>

On Thu, Nov 07, 2024 at 11:29:36AM +0800, liujing wrote:
> In the struct slgt_info structure, the type of info->tbuf_current
> is unsigned int, so the output format is %u.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index bd8d92ee7c53..0c51c6c28080 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -519,7 +519,7 @@ static void trace_block(struct slgt_info *info, const char *data, int count, con
>  static void dump_tbufs(struct slgt_info *info)
>  {
>  	int i;
> -	printk("tbuf_current=%d\n", info->tbuf_current);
> +	printk("tbuf_current=%u\n", info->tbuf_current);

How was this found?  How was it tested?  Why is this code still in here
at all?  It all should be removed and if really needed, converted to use
the proper in-kernel apis for this type of thing, not a random module
parameter that does not fit in with the rest of the kernel.

thanks,

greg k-h
