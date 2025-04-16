Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581521423F;
	Wed, 16 Apr 2025 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777751; cv=none; b=ED+E1QGzDkSE/4TsxWeMSoeZt6R7SlwtRhvoOuIEmNPJuEc1im1iQPwS0DxaZcS1aAVKZ30Xxf17z43y1AJd8RAwg2PTtDj3myKnx5Vnx5OUmB2GzGTblJeMBsRFmN88SZMDfKRxCyjr8gKpY3RU7LVYT3VZVlctovp918bWzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777751; c=relaxed/simple;
	bh=uNXA8zmXLo/ZSnb9UHBWW0N5nK1hKYKj64jUp2HilGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abTKzp1hA2mrxK+j6GJ0sZVSDH0z8Sn7vuLlant52wNMHi5uxRUu3DkgzgiOy4TQ6l1ahaUn/OmzfXRR0giut6R7DNaWdKnGI+bLGk25EifCucLpkEPJSyUl0BiwVDOg2RxKbh68oHyxgfSkl8KXrr6on2SadU0pjfaMWWTYfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g71ZL3G6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g71ZL3G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E7C4CEE2;
	Wed, 16 Apr 2025 04:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777750;
	bh=uNXA8zmXLo/ZSnb9UHBWW0N5nK1hKYKj64jUp2HilGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g71ZL3G62NXt8HGrGqgcVJ7ZDxK2MnrhRIwA4C4SIqR2CmPCKUWkJ2P0PCINuchO+
	 WYfL7Py+1FkC4ln1psDru8hMAUlTYqB7fmxb0rqXumQmfZWxYjAxFuNmqh2+R941tL
	 vRydFIKiWGNAUY3ZmzjbDiSNJXL3n750xB4xtw4lFLFllEK5RWX4SvTgSKqiQqbXry
	 yNk3BS/CmX1l1zvgy/YsNE3vRgewr+d1FzIAs37gKMUWeBTBb9XhnXx+o3vXev3ZKu
	 R+zvEW7qwx67jRRhu6YzYknPLZnpbo8DVbT9j/306TkYhQdRtaTGs+9yzJLV8mx2Dj
	 lek+O6jVGjEiw==
Message-ID: <f39d8b9b-c160-40a3-80d0-62f880122f2b@kernel.org>
Date: Wed, 16 Apr 2025 06:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] vt: introduce gen_ucs_recompose_table.py to
 create ucs_recompose_table.h
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250415192212.33949-1-nico@fluxnic.net>
 <20250415192212.33949-8-nico@fluxnic.net>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250415192212.33949-8-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 04. 25, 21:17, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> The generated table maps base character + combining mark pairs to their
> precomposed equivalents using Python's unicodedata module.
> 
> The default script behavior is to create a table with most commonly used
> Latin, Greek, and Cyrillic recomposition pairs only. It is much smaller
> than the table with all possible recomposition pairs (71 entries vs 1000
> entries). But if one needs/wants the full table then simply running the
> script with the --full argument will generate it.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/tty/vt/gen_ucs_recompose_table.py | 255 ++++++++++++++++++++++
>   1 file changed, 255 insertions(+)
>   create mode 100755 drivers/tty/vt/gen_ucs_recompose_table.py
> 
> diff --git a/drivers/tty/vt/gen_ucs_recompose_table.py b/drivers/tty/vt/gen_ucs_recompose_table.py
> new file mode 100755
> index 0000000000..91e81fb1c9
> --- /dev/null
> +++ b/drivers/tty/vt/gen_ucs_recompose_table.py
> @@ -0,0 +1,255 @@
> +#!/usr/bin/env python3
...
> +    # Generate implementation file
> +    with open(out_file, 'w') as f:
> +        f.write(f"""\
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * {out_file} - Unicode character recomposition
> + *
> + * Auto-generated by {this_file}{generation_mode}
> + *
> + * Unicode Version: {unicodedata.unidata_version}
> + *
> +{textwrap.fill(
> +    f"This file contains a table with {table_description_detail}. " +
> +    f"To generate a table with {alt_description_detail} instead, run:",
> +    width=75, initial_indent=" * ", subsequent_indent=" * ")}
> + *
> + *   python {this_file}{alternative_mode}

This should be python3. Or no 'python' at all -- I assume the script is 
executable given "new file mode 100755".

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs
