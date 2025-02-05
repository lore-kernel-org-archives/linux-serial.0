Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30E2F46;
	Wed,  5 Feb 2025 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733600; cv=none; b=f7RaFLFhXFY7ULIaQUONIc1vi/1DUyR1nmlZ1DGx1IrXBaffT092CV7xAcsJ8V2bCKRm0FamWGuzyGioErEkDlT+GgCieI6qN9os+dTItEldIQNl6sp0SQr0eQbijShBftfPHQ6XmTW1N7cLsVCy9LyTQX58+NpBp7/lJ6sNm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733600; c=relaxed/simple;
	bh=olyTmyyQnDsOpurGi0DOT/L1inFXLrgP7BNappqhjPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxHKc8/PmPmJGE1io2xf2f1izEUZ8Uiz7wFS5KBaRsAjLbU9LXnxfbBfqBszkI5B2HXscXgp8E+/ZPq38PM8e3YTxXzUdMF7CzHkTYRBOgjmOD8g0pITWn4N1tjlornysPMt/ri801phkEF4D5Sr+UXdBf/oBzKyPPZp7f/05wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qq7i3RxV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qq7i3RxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3D9C4CED1;
	Wed,  5 Feb 2025 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738733599;
	bh=olyTmyyQnDsOpurGi0DOT/L1inFXLrgP7BNappqhjPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qq7i3RxVFoFINa4qd69ifmbePMyLSt2NL/syiva1TqKaeDY3AGTj1bOEjSPW3bBTm
	 47NOgcsTKS0qniRku/Cx4tPCN0TQdg1E39doGd27m5X6OCXOTdOX6CSzeqhYH+R9Gm
	 0x84xyaAPadpwt79wSNjeKJbSwdj+8m2fI7iaJ+I=
Date: Wed, 5 Feb 2025 06:33:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <2025020501-doily-sandlot-8434@gregkh>
References: <Z6L1XwE-WEzcGFwv@kspp>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6L1XwE-WEzcGFwv@kspp>

On Wed, Feb 05, 2025 at 03:51:35PM +1030, Gustavo A. R. Silva wrote:
> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -8,19 +8,24 @@
>  #include <linux/workqueue.h>
>  
>  struct tty_buffer {
> -	union {
> -		struct tty_buffer *next;
> -		struct llist_node free;
> -	};
> -	unsigned int used;
> -	unsigned int size;
> -	unsigned int commit;
> -	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
> -	unsigned int read;
> -	bool flags;
> +	/* New members MUST be added within the struct_group() macro below. */

Why?  You need to say that here otherwise we aren't going to know.

> +	struct_group_tagged(tty_buffer_hdr, __hdr,
> +		union {
> +			struct tty_buffer *next;
> +			struct llist_node free;
> +		};
> +		unsigned int used;
> +		unsigned int size;
> +		unsigned int commit;
> +		unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
> +		unsigned int read;
> +		bool flags;
> +	);
>  	/* Data points here */
>  	u8 data[] __aligned(sizeof(unsigned long));
>  };
> +static_assert(offsetof(struct tty_buffer, data) == sizeof(struct tty_buffer_hdr),
> +              "struct member likely outside of struct_group_tagged()");
>  
>  static inline u8 *char_buf_ptr(struct tty_buffer *b, unsigned int ofs)
>  {
> @@ -33,15 +38,15 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
>  }
>  
>  struct tty_bufhead {
> -	struct tty_buffer *head;	/* Queue head */
> -	struct work_struct work;
> -	struct mutex	   lock;
> -	atomic_t	   priority;
> -	struct tty_buffer sentinel;
> -	struct llist_head free;		/* Free queue head */
> -	atomic_t	   mem_used;    /* In-use buffers excluding free list */
> -	int		   mem_limit;
> -	struct tty_buffer *tail;	/* Active buffer */
> +	struct tty_buffer	*head;	/* Queue head */
> +	struct work_struct	work;
> +	struct mutex		lock;
> +	atomic_t		priority;
> +	struct tty_buffer_hdr	sentinel;
> +	struct llist_head	free;		/* Free queue head */
> +	atomic_t		mem_used;    /* In-use buffers excluding free list */
> +	int			mem_limit;
> +	struct tty_buffer	*tail;	/* Active buffer */
>  };

Did you change anything in this structure?  By reformatting it, it's
hard to tell what happened, so please don't do that :(

thanks,

greg k-h
