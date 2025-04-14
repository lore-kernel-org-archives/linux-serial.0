Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313CB1B4132;
	Mon, 14 Apr 2025 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613479; cv=none; b=HIMCDgFcLqFP9u0+LwMj50Y50iz9sTd158Beh+Tzo/ZWwPLo7zdx6501pQ0f1fB7CHCojgXrKx1GXoyrQE0N2dSXE9RaI08fGMz2hWHx1N5W+EpvxM0RaL8g32ceHBG+hdhE8tr1KCYI732if1QWp+iv6mMbTs8tcriKgZiJJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613479; c=relaxed/simple;
	bh=asO4o657iz8nQe0uAHLA3O0c3AbaHXOjJNiLc6xpZcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMHfZsC93BsozwfWQa0b5fFuco8eZq4QgEDRQ/MkzLC9MIJbMP7JP5tZCV2FBrwyrkAfZrnlDbWAJPb+6qyqfRmJ+0Qe9wQ7s81g3TQ1x8IlslqpnS3SuqPR1aTxNsk01WpOFJNA7XnWAD0MHkBrETQ55fb8PZuV8GupiYIj0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRzhjdBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRzhjdBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E56C4CEE2;
	Mon, 14 Apr 2025 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744613478;
	bh=asO4o657iz8nQe0uAHLA3O0c3AbaHXOjJNiLc6xpZcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gRzhjdBttm8QnvwtlyZLRah0rJfFxHQsMcux6mt8gjLRR7wn6z4IhVnMC3io9kMoN
	 hfQrQiL2Z9iP7naqAxb58cx17/nO2yLRC2AfC4LHNaRtRac6/4N61YrmtOBxjtFW4g
	 GmpSC26URPypH5WZT2HOhfSNyAhitQaxCQ8Rq8oPaFUv1EV+9DXynJ8EInc2NimXQU
	 BYUxZUX3guQDbuugI0YjIFcDlpZ595xgQ6Fn/5OhDlaGQw9yZC0xJQUTuUVv19kjy8
	 YnC508i4MR4MtRhhn8XzAEW6263V4hjUfQ1cE3FCsqhwjKh0f2DGhaoed7fTYCjy4U
	 rm8j+C9sxpoqw==
Message-ID: <7fce92da-62d3-421d-9cd1-f9167c05d2b0@kernel.org>
Date: Mon, 14 Apr 2025 08:51:15 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] vt: properly support zero-width Unicode code points
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, Dave Mielke <Dave@mielke.cc>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410011839.64418-1-nico@fluxnic.net>
 <20250410011839.64418-4-nico@fluxnic.net>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250410011839.64418-4-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 04. 25, 3:13, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Zero-width Unicode code points are causing misalignment in vertically
> aligned content, disrupting the visual layout. Let's handle zero-width
> code points more intelligently.
...
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -443,6 +443,15 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int top,
>   	}
>   }
>   
> +static u32 vc_uniscr_getc(struct vc_data *vc, int relative_pos)
> +{
> +	int pos = vc->state.x + vc->vc_need_wrap + relative_pos;
> +
> +	if (vc->vc_uni_lines && pos >= 0 && pos < vc->vc_cols)

So that is:
   in_range(pos, 0, vc->vc_cols)
right?

> +		return vc->vc_uni_lines[vc->state.y][pos];
> +	return 0;
> +}
> +
>   static void vc_uniscr_copy_area(u32 **dst_lines,
>   				unsigned int dst_cols,
>   				unsigned int dst_rows,
> @@ -2905,18 +2914,49 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
>   	return false;
>   }
>   
> +static void vc_con_rewind(struct vc_data *vc)
> +{
> +	if (vc->state.x && !vc->vc_need_wrap) {
> +		vc->vc_pos -= 2;
> +		vc->state.x--;
> +	}
> +	vc->vc_need_wrap = 0;
> +}
> +
>   static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
>   		struct vc_draw_region *draw)
>   {
> -	int next_c;
> +	int next_c, prev_c;
>   	unsigned char vc_attr = vc->vc_attr;
>   	u16 himask = vc->vc_hi_font_mask, charmask = himask ? 0x1ff : 0xff;
>   	u8 width = 1;
>   	bool inverse = false;
>   
>   	if (vc->vc_utf && !vc->vc_disp_ctrl) {
> -		if (ucs_is_double_width(c))
> +		if (ucs_is_double_width(c)) {
>   			width = 2;
> +		} else if (ucs_is_zero_width(c)) {
> +			prev_c = vc_uniscr_getc(vc, -1);
> +			if (prev_c == ' ' &&
> +			    ucs_is_double_width(vc_uniscr_getc(vc, -2))) {
> +				/*
> +				 * Let's merge this zero-width code point with
> +				 * the preceding double-width code point by
> +				 * replacing the existing whitespace padding.
> +				 */
> +				vc_con_rewind(vc);
> +			} else if (c == 0xfe0f && prev_c != 0) {
> +				/*
> +				 * VS16 (U+FE0F) is special. Let it have a
> +				 * width of 1 when preceded by a single-width
> +				 * code point effectively making the later
> +				 * double-width.
> +				 */
> +			} else {
> +				/* Otherwise zero-width code points are ignored */
> +				goto out;
> +			}
> +		}

Please, extract this width evaluation to a separate function.

...
> --- a/include/linux/consolemap.h
> +++ b/include/linux/consolemap.h
...
> @@ -63,6 +68,11 @@ static inline bool ucs_is_double_width(uint32_t cp)
>   {
>   	return false;
>   }
> +
> +static inline bool ucs_is_zero_width(uint32_t cp)
> +{
> +	return false;
> +}

Again, is this necessary?

thanks,
-- 
js
suse labs
