Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E950257448;
	Mon, 20 Oct 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973172; cv=none; b=HsXUfOkM4g7MulSvypDSbuZVj5JyhtVFjni8fPD1LB6HqSTRomZp2vE3R5CHMB+hBX1OTMfuKUG4mU4CwpKAL53TRvaPgDwn/mihlYV5Ky0QgXgE6yZvHGR3oNUW1yYiKkalbtNm1UeMDoOV3shCDTmrh8NEXC8YXP/q9WOGyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973172; c=relaxed/simple;
	bh=xL2aZT3dND/IgpLCEUeVhydDyi+sqU+McY8Wwq4tBeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTeHXHVM8/7dfh6vxmerQ1cJKZveJhL3PMfOz8Y98zz0H6PKMPx2Zaa3pBINKSq3GYgPdUq35bWluPShErPGMkSBlsBmBNTjjD/wfniwrJxcqlgzqRcKQvXYB2XM4JrNgXusfpGBq4zEnZBu66PPZfJAzfsMOAN3LeAZk9UU2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mXt7VJL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mXt7VJL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E2CC4CEF9;
	Mon, 20 Oct 2025 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760973171;
	bh=xL2aZT3dND/IgpLCEUeVhydDyi+sqU+McY8Wwq4tBeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXt7VJL78UfUaR/x42reuxZo8R8etuEGJARMSiHnI4KAduwEJu8QZgDv6IQUxL3+6
	 aA7UxGmNC+XKp5aHW5pI4gf5JW1gV2EIOttqSVdBNetKBRWI+XRMbFi4t3tDOlZqvH
	 uRgF1QcnCLnL1hlM7/C2KfNSGX49lEXO8xYQWAM0=
Date: Mon, 20 Oct 2025 17:12:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm, vc_screen: move __free() handler that frees a page
 to a common header
Message-ID: <2025102026-unopened-equal-764c@gregkh>
References: <20251020143055.407696-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020143055.407696-1-rppt@kernel.org>

On Mon, Oct 20, 2025 at 05:30:55PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vc_screen defines __free() handler that frees a page using free_page().
> Move that definition to include/linux/gfp.h next to free_page() and
> rename it from free_page_ptr to free_page.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/tty/vt/vc_screen.c | 6 ++----
>  include/linux/gfp.h        | 2 ++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index c814644ef4ee..d2029f029de6 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -53,8 +53,6 @@
>  #define HEADER_SIZE	4u
>  #define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
>  
> -DEFINE_FREE(free_page_ptr, void *, if (_T) free_page((unsigned long)_T));
> -
>  /*
>   * Our minor space:
>   *
> @@ -371,7 +369,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  	loff_t pos;
>  	bool viewed, attr, uni_mode;
>  
> -	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
> +	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);

As per the other thread recently, why can't we just use kmalloc() here
instead?

thanks,

greg k-h
