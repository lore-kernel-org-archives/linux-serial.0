Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C622156D;
	Sun, 31 Aug 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756620898; cv=none; b=hDA99IPZh+o68PIzzpTH64ZDiZU8oCM5X7OFfpATgi2JMXve6bkpJBd/XhvSf2b1KbjadIYt0SJtiR257Om2nJ6uGIDD3qLHZNh+xSAPyu6YGbIrzbs/i4Ntiz3dvFoNUiuk5/xY8BjNI+SnzKbfVPR2WCYvDFPcFMJEYXH7qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756620898; c=relaxed/simple;
	bh=V+YLe5IQWYGwZEbw0X1urY15Dp2x+M8Mc6WWY+aY0y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQPE7THYLpIbU8Tam/nz45xeHiYkA8GkEVUiv3exZjF3+O+fcJshA2T02ug2sxVt0aka6kBfgzkJ+UOrqsygXsu3kb9abOQxfr0l01gYTBrOfFK+szxBJU6C+JiJWOkJF2SnFTuA9fP0hr7zfSYgJUil1pCOWSTcP8wFruuFTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZQ+Gjq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZQ+Gjq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2EEC4CEED;
	Sun, 31 Aug 2025 06:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756620897;
	bh=V+YLe5IQWYGwZEbw0X1urY15Dp2x+M8Mc6WWY+aY0y0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aZQ+Gjq/ef3m78XD3ozlHdLSFzKy77N8v0QcidJK0vVI7mMW3SJsDLzzO548+A6g7
	 jC6qWva8naW9yyb1gZWbJTqNTVqVV2NDuK//fMuxu+VuO4eWLtOGMU24NP38vt5Jfq
	 2ag80tGNHS9VsXDFzJo5fAKPrZXEteqlXamVxbYGjKI4eJkmkQ5i470wgeUSdLGUKM
	 zYvj/HdUjtaHnJYHk+m0U0kXRga+RM0lKMr3lP0JD/xVaFgUKjwzfO0aWlH6EdE9iK
	 W2+pJMRsMoHaCWDlYc+tAEICPUL6E2IaeEOQMTUamgcqELU3QgE2ZTRYELhQEqAJDv
	 arwLjohMXHcVQ==
Message-ID: <339029f2-1f54-40ea-8880-e68fbd351755@kernel.org>
Date: Sun, 31 Aug 2025 08:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tty/vt: 8th bit location in vc_uniscr routines
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20250829194908.24852-1-soci@c64.rulez.org>
 <20250829194908.24852-2-soci@c64.rulez.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250829194908.24852-2-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 08. 25, 21:49, Zsolt Kajtar wrote:
> Both vc_uniscr_check and vc_uniscr_copy_line assume that the 8th bit of
> glyph is also the 8th bit in the screen buffer. However this is only the
> case for fbcon at the moment. Vgacon has it on the 11th and so the
> conversion won't work correctly in that case. The patch corrects this
> oversight.
> 
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/tty/vt/vt.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 869261141..c6c931047 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -493,7 +493,7 @@ int vc_uniscr_check(struct vc_data *vc)
>   {
>   	u32 **uni_lines;
>   	unsigned short *p;
> -	int x, y, mask;
> +	int x, y;
>   
>   	WARN_CONSOLE_UNLOCKED();
>   
> @@ -514,11 +514,14 @@ int vc_uniscr_check(struct vc_data *vc)
>   	 * unicode content will be available after a complete screen refresh.
>   	 */
>   	p = (unsigned short *)vc->vc_origin;
> -	mask = vc->vc_hi_font_mask | 0xff;
>   	for (y = 0; y < vc->vc_rows; y++) {
>   		u32 *line = uni_lines[y];
>   		for (x = 0; x < vc->vc_cols; x++) {
> -			u16 glyph = scr_readw(p++) & mask;
> +			u16 w = scr_readw(p++);
> +			u16 glyph = w & 0xff;
> +
> +			if (w & vc->vc_hi_font_mask)
> +				glyph |= 0x100;

This makes sense, but introduce a helper, please.

>   			line[x] = inverse_translate(vc, glyph, true);
>   		}
>   	}
> @@ -561,10 +564,13 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
>   		 * buffer of its own.
>   		 */
>   		u16 *p = (u16 *)pos;
> -		int mask = vc->vc_hi_font_mask | 0xff;
>   		u32 *uni_buf = dest;
>   		while (nr--) {
> -			u16 glyph = scr_readw(p++) & mask;
> +			u16 w = scr_readw(p++);
> +			u16 glyph = w & 0xff;
> +
> +			if (w & vc->vc_hi_font_mask)
> +				glyph |= 0x100;

And use here as well.

>   			*uni_buf++ = inverse_translate(vc, glyph, true);
>   		}
>   	}


-- 
js
suse labs
