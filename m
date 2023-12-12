Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250F3399E
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ueq2+8VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6FAC433C8;
	Tue, 12 Dec 2023 15:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702395401;
	bh=NppgUai8ObnH0XLPs3DqgNdMjuEFldpM4HollsD15VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ueq2+8VXTj7fCclJkPDr2zQh+Pn6gCOWnZxhoFW7FjFw2hGGkAeauNqDcuP7LImNQ
	 D3UZmiTZDlqwujCQWELHaNx99vAARBxKbz46/VXGxDpblrSGLQfNXPjOXN/RT8s2/5
	 wxIjRTQik3cB5IwFQsMlxcKc8BjJfXiv2z0RCMng=
Date: Tue, 12 Dec 2023 16:36:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman =?utf-8?B?xb1pbGth?= <roman.zilka@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty/vt: UTF-8 parsing update according to RFC 3629,
 modern Unicode
Message-ID: <2023121201-ecosphere-polyester-8d37@gregkh>
References: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>

On Tue, Dec 12, 2023 at 04:13:20PM +0100, Roman Žilka wrote:
> vc_translate_unicode() and vc_sanitize_unicode() parse input to the
> UTF-8-enabled console, marking invalid byte sequences and producing Unicode
> codepoints. The current algorithm follows ancient Unicode and may accept invalid
> byte sequences, pass on non-existent codepoints and reject valid sequences.
> 
> The patch restores the functions' compliance with modern Unicode (v15.1 + many
> previous versions) as well as RFC 3629.
> 1. Codepoint space is limited to 0x10FFFF.
> 2. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in Unicode and
>    will be accepted. Another option was to complete the set of noncharacters
>    (used to be just those two, now there's more) and preserve the rejection
>    step. This is indeed what Unicode suggests (v15.1, chap. 23.7) (not
>    requires), but most codepoints are !iswprint(), so selecting just the
>    noncharacters seemed arbitrary and futile (and unnecessary).
> 
> On the side:
> 3. What remained of vc_sanitize_unicode() is in vc_translate_unicode().
> 4. Corrected vc_translate_unicode() doc (@rescan).
> 
> This is not a security patch. I'm not aware of any present security implications
> of the old code.
> 
> Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 36 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 156efda7c80d..215e162ec8af 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2587,23 +2587,11 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
>  }
>  
>  
> -/**
> - * vc_sanitize_unicode - Replace invalid Unicode code points with U+FFFD
> - * @c: the received character, or U+FFFD for invalid sequences.
> - */
> -static inline int vc_sanitize_unicode(const int c)
> -{
> -	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
> -		return 0xfffd;
> -
> -	return c;
> -}
> -
>  /**
>   * vc_translate_unicode - Combine UTF-8 into Unicode in @vc_utf_char
>   * @vc: virtual console
> - * @c: character to translate
> - * @rescan: we return true if we need more (continuation) data
> + * @c: UTF-8 byte to translate
> + * @rescan: true => @c wasn't translated here and needs to be re-processed
>   *
>   * @vc_utf_char is the being-constructed unicode character.
>   * @vc_utf_count is the number of continuation bytes still expected to arrive.
> @@ -2611,10 +2599,7 @@ static inline int vc_sanitize_unicode(const int c)
>   */
>  static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
>  {
> -	static const u32 utf8_length_changes[] = {
> -		0x0000007f, 0x000007ff, 0x0000ffff,
> -		0x001fffff, 0x03ffffff, 0x7fffffff
> -	};
> +	static const u32 utf8_length_changes[] = {0x7f, 0x7ff, 0xffff, 0x10ffff};
>  
>  	/* Continuation byte received */
>  	if ((c & 0xc0) == 0x80) {
> @@ -2629,12 +2614,12 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
>  
>  		/* Got a whole character */
>  		c = vc->vc_utf_char;
> -		/* Reject overlong sequences */
> +		/* Reject overlong sequences and surrogates */
>  		if (c <= utf8_length_changes[vc->vc_npar - 1] ||
> -				c > utf8_length_changes[vc->vc_npar])
> +				c > utf8_length_changes[vc->vc_npar] ||
> +				(c & 0xfff800) == 0x00d800)
>  			return 0xfffd;
> -
> -		return vc_sanitize_unicode(c);
> +		return c;
>  	}
>  
>  	/* Single ASCII byte or first byte of a sequence received */
> @@ -2660,14 +2645,7 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
>  	} else if ((c & 0xf8) == 0xf0) {
>  		vc->vc_utf_count = 3;
>  		vc->vc_utf_char = (c & 0x07);
> -	} else if ((c & 0xfc) == 0xf8) {
> -		vc->vc_utf_count = 4;
> -		vc->vc_utf_char = (c & 0x03);
> -	} else if ((c & 0xfe) == 0xfc) {
> -		vc->vc_utf_count = 5;
> -		vc->vc_utf_char = (c & 0x01);
>  	} else {
> -		/* 254 and 255 are invalid */
>  		return 0xfffd;
>  	}
>  
> 
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> -- 
> 2.41.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
