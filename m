Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F035F19B;
	Thu, 12 Mar 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325111; cv=none; b=WttfJB2bZ/sMudz571cQYpCJJbvh5wwRs8epiT/BofQ5mGR51wUlD81TDe58HRTjWArwlzvvEMWkTHxo9bKj9syfxcmaLc61QZksqY+RnOpHFfhkoVRpzFQh0wu7uq6iISNJrby/9OKyWeDdY5VjwlAyOB8ge2yQqk+FA3GVrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325111; c=relaxed/simple;
	bh=j6BdVXw7bkCcZeN9ARifraFpIDqvkpc81KikPlmlUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY0tnylX+8MoSxRIyZeS3xVUV8tffHru2bwB3wlD1Mkzmx5sA/xmWZbbIWjmrrqBKHMBWp6teBQFXzCxL+/5FqpcKKfFNl6CcBeeVqVI5ER5pkXSWE5sv8xecNpqKeolPD5JV6uAMa+sVwlN5vH17JmIjR+n6DjdIKZE+4dZQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zHvDklU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zHvDklU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D92C2BC86;
	Thu, 12 Mar 2026 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773325110;
	bh=j6BdVXw7bkCcZeN9ARifraFpIDqvkpc81KikPlmlUXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1zHvDklUsBOtW9IFz7w3p6zWOoNzDvoMTBXtEuGRgeQA8BeE8p9TjShVkrVwcpq8N
	 VuFEjHxcAjpp1GPZjjJEgtn74064an9NtyXm/8jFfenX78UURq8y/fpxqSVgGdQh4D
	 cKCWAovitXRAKwpXEzti5vS/ie6hsvgSxo8lQ6OQ=
Date: Thu, 12 Mar 2026 15:18:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: vt/keyboard: Hoist and reuse variable in
 vt_do_kdgkb_ioctl
Message-ID: <2026031255-rudder-amusable-1d10@gregkh>
References: <20260302153255.6278-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302153255.6278-2-thorsten.blum@linux.dev>

On Mon, Mar 02, 2026 at 04:32:52PM +0100, Thorsten Blum wrote:
> Hoist 'len' and use it in both cases.

Why?  And what is "both cases"?

> Add a comment explaining why reassigning 'kbs' is intentional.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Keep 'kbs' reassignment and add a comment why it's required (Jiri)
> - Link to v1: https://lore.kernel.org/lkml/20260226123419.737669-1-thorsten.blum@linux.dev/
> ---
>  drivers/tty/vt/keyboard.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

I feel you just made the code harder to understand, as you added
complexity :(

> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 13bc048f45e8..88fd4ef2634a 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2000,17 +2000,18 @@ static char *vt_kdskbsent(char *kbs, unsigned char cur)
>  int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  {
>  	unsigned char kb_func;
> +	ssize_t len;
>  
>  	if (get_user(kb_func, &user_kdgkb->kb_func))
>  		return -EFAULT;
>  
>  	kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
>  
> +	/* size should have been a struct member */
> +	len = sizeof(user_kdgkb->kb_string);
> +
>  	switch (cmd) {
>  	case KDGKBSENT: {
> -		/* size should have been a struct member */
> -		ssize_t len = sizeof(user_kdgkb->kb_string);
> -
>  		char __free(kfree) *kbs = kmalloc(len, GFP_KERNEL);
>  		if (!kbs)
>  			return -ENOMEM;
> @@ -2031,11 +2032,16 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  			return -EPERM;
>  
>  		char __free(kfree) *kbs = strndup_user(user_kdgkb->kb_string,
> -						       sizeof(user_kdgkb->kb_string));
> +						       len);
>  		if (IS_ERR(kbs))
>  			return PTR_ERR(kbs);
>  
>  		guard(spinlock_irqsave)(&func_buf_lock);
> +
> +		/*
> +		 * Ownership transfer: vt_kdskbsent() returns a pointer
> +		 * that must be freed (new buffer, old buffer, or NULL).
> +		 */
>  		kbs = vt_kdskbsent(kbs, kb_func);

That's fine, but what does it have to do with len?

confused,

greg k-h
