Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB942050;
	Sun, 31 Aug 2025 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756621549; cv=none; b=NB2KU0H0YVFHTv+96zYJ8fptBFWDNqfAPVCHJZQW3T1VoqTRY1tCAPlrhHhtg9a4f6mLROFJHAVv14s1MA9TsUvw5QG7CSlyvxVKwqhG7UI/y4DC8ryw9XbA1aFxSx/yApElCta7hkSTlUBxdg/951EyPvhBOkjBrSDpAyYD5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756621549; c=relaxed/simple;
	bh=+CDr5CmMVVcfHGgCI//H7hmg0CTkNc1KJZwNEhOZN5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QqqhWvuT6WvDbBkYAYvV9TubdCoU7P8IeAUVaaaiC6r+hWkHlsgXHLwo3YBc9VQ0lLsgOZU9uEsKlocoZFudoy7p7nMHnhpEYo4X2Tvh6FwyRWk8ErxuhBJp1/2zy7zKpy8WOHESto5jvff4zeLs9ytKA4LvX401xKUuL1ocDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oduuk+63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oduuk+63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E842C4CEED;
	Sun, 31 Aug 2025 06:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756621549;
	bh=+CDr5CmMVVcfHGgCI//H7hmg0CTkNc1KJZwNEhOZN5U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Oduuk+63kXQyoLLGEphjZkDEyT+LZIw5dnHNxQj/n5yFknHWxusjFOyout7addpHx
	 F0y8uTaazisxsH8wyRsBA2IgE0EW6pRSHbiSIsW06yleRLfoNq28fsLZf0VfR1sNXn
	 hvnADSXkOMhP/VpCgR20NX2yGKoTPfbI22hpOuYNKOuPP9J7xw9BWupd6hgNIjC3AH
	 cNT5R2Elo7xxvqn40PNDU+Dkd32/YbUjO07YlcjSxo/IEgRslY4VTauWtKxFA39j5l
	 sPmZBG05RB5VgppxI6AvH02GY+ZY24rXPZDU59QsYhqyz/xOKDp0b6PXFPbxoMp/Ps
	 Y2py6jte4WN6Q==
Message-ID: <6e52d938-3ac2-4779-b70d-9cc58c16c266@kernel.org>
Date: Sun, 31 Aug 2025 08:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tty/vt: Prevent 8th bit corruption with soft cursor
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20250829194908.24852-1-soci@c64.rulez.org>
 <20250829194908.24852-3-soci@c64.rulez.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250829194908.24852-3-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 08. 25, 21:49, Zsolt Kajtar wrote:
> The attributes of the soft cursor are configurable and one would rightly
> expect that only the attributes are to be affected. But that's not
> guaranteed for a font with 512 glyphs as the 8th bit is in the attribute
> byte. This patch makes sure that really only the attribute bits are
> changed by the cursor and not the glyph's appearance.
> 
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/tty/vt/vt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index c6c931047..d54f4d24e 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -823,6 +823,7 @@ static void add_softcursor(struct vc_data *vc)
>   {
>   	int i = scr_readw((u16 *) vc->vc_pos);

It's terrible how the current code uses weird types (int here).

>   	u32 type = vc->vc_cursor_type;
> +	int mask = vc->vc_hi_font_mask | 0xff;

But since you are introducing a new one, use u16, not int. Esp. when it 
is a mask.
>   	if (!(type & CUR_SW))
>   		return;
> @@ -836,6 +837,7 @@ static void add_softcursor(struct vc_data *vc)
>   		i ^= CUR_BG;
>   	if ((type & CUR_INVERT_FG_BG) && (i & CUR_FG) == ((i & CUR_BG) >> 4))
>   		i ^= CUR_FG;
> +	i = (i & ~mask) | (softcursor_original & mask);
>   	scr_writew(i, (u16 *)vc->vc_pos);
>   	if (con_should_update(vc))
>   		con_putc(vc, i, vc->state.y, vc->state.x);

thanks,
-- 
js
suse labs
