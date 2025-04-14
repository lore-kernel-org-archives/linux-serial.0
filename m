Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8C1624CE;
	Mon, 14 Apr 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614262; cv=none; b=asgfsxgZGFvQNSjGLCmx9/3Q8PgQkSgMbpoJaJZ6czXT85AIRzRs4GBCHOUJ/jOOufSKaZuizien9158F+K6PrtvpAJsaz57JpsJMaHrOCZRkqLI4KHpBHINIrrfr3CZJ67HORpS4tAgjWk2VquLTjzYn1STohhqIqsof/YP8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614262; c=relaxed/simple;
	bh=ow4VPVSfISjDPYdyBMU/7JUZsHmuWJmK278b3Re5Ka4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaM4gxA9eSGJVE6+TsNlT5Hr16Aki+eg489qYePeWJAClaalOqbJ+dBB0+8kPw6H2oRl5tthCcnI0Xx4DtXrgZP0ueXZQFjVWodHd9ZZaoY+1j9UDDj0O7/M56v6uxTVkjjQYFkJl8LM5B9MTvFDyI6GRODb+FAcD/bjXQWMj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGk2/sMN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGk2/sMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CAAC4CEE2;
	Mon, 14 Apr 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744614262;
	bh=ow4VPVSfISjDPYdyBMU/7JUZsHmuWJmK278b3Re5Ka4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGk2/sMNUtXNpH8pbQAYjGmPXDyC4bIKK8xPVGGpZD4nqcHh0LWcQLHAXmL9TrpkG
	 Y1YVbt6DFgN71478p/BPzJtMrTuDYnnpBPpv3VE7kiaJ8OU03UNzDVMRYpziQVeWZi
	 qa0Har+0hFl8JLShFZaQMJby39IM2vqxbBAM9LyfYA9OkmV2q9BCmOb1WoluqwBdyz
	 kdNnX+kdvjUm85IQzUonrmco2ZY2msfDBEVycNZ/pp+sMRTnkAT1KnWYIxlksSFSqX
	 DGTYorskeNbzBqWf5EMn6RKxZctV0H1eJoW7IHCB4k0rt3j6h+24MS736C72/rC5dV
	 Dp8lFd3eI/qSA==
Message-ID: <e1cfe5a4-5b4b-4b72-821c-9fae81fff3fa@kernel.org>
Date: Mon, 14 Apr 2025 09:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] vt: introduce gen_ucs_width.py to create
 ucs_width.c
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, Dave Mielke <Dave@mielke.cc>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410011839.64418-1-nico@fluxnic.net>
 <20250410011839.64418-5-nico@fluxnic.net>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250410011839.64418-5-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 04. 25, 3:13, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> The table in the current ucs_width.c is terribly out of date and
> incomplete. We also need a second table to store zero-width code points.
> Properly maintaining those tables manually is impossible. So here's a
> script to automatically generate them.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/tty/vt/gen_ucs_width.py | 264 ++++++++++++++++++++++++++++++++
>   1 file changed, 264 insertions(+)
>   create mode 100755 drivers/tty/vt/gen_ucs_width.py
> 
> diff --git a/drivers/tty/vt/gen_ucs_width.py b/drivers/tty/vt/gen_ucs_width.py
> new file mode 100755
> index 0000000000..41997fe001
> --- /dev/null
> +++ b/drivers/tty/vt/gen_ucs_width.py
> @@ -0,0 +1,264 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This script uses Python's unicodedata module to generate ucs_width.c

That is obvious, no need for the comment, IMO :).

> +import unicodedata
> +import sys
> +
> +def generate_ucs_width():
> +    # Output file name
> +    c_file = "ucs_width.c"
> +
> +    # Width data mapping
> +    width_map = {}  # Maps code points to width (0, 1, 2)
> +
> +    # Define emoji modifiers and components that should have zero width
> +    emoji_zero_width = [
> +        # Skin tone modifiers
> +        (0x1F3FB, 0x1F3FF),  # Emoji modifiers (skin tones)
> +
> +        # Variation selectors (note: VS16 is treated specially in vt.c)
> +        (0xFE00, 0xFE0F),    # Variation Selectors 1-16
> +
> +        # Gender and hair style modifiers
> +        (0x2640, 0x2640),    # Female sign
> +        (0x2642, 0x2642),    # Male sign
> +        (0x26A7, 0x26A7),    # Transgender symbol
> +        (0x1F9B0, 0x1F9B3),  # Hair components (red, curly, white, bald)
> +
> +        # Tag characters
> +        (0xE0020, 0xE007E),  # Tags
> +    ]
> +
> +    # Mark these emoji modifiers as zero-width
> +    for start, end in emoji_zero_width:
> +        for cp in range(start, end + 1):
> +            try:
> +                width_map[cp] = 0
> +            except (ValueError, OverflowError):

When can this happen and why is it not fatal?

> +                continue
> +
> +    # Mark all regional indicators as single-width as they are usually paired
> +    # providing a combined with of 2.

s/with/width/

> +    regional_indicators = (0x1F1E6, 0x1F1FF)  # Regional indicator symbols A-Z
> +    start, end = regional_indicators
> +    for cp in range(start, end + 1):
> +        try:
> +            width_map[cp] = 1
> +        except (ValueError, OverflowError):
> +            continue
> +
> +    # Process all assigned Unicode code points (Basic Multilingual Plane + Supplementary Planes)
> +    # Range 0x0 to 0x10FFFF (the full Unicode range)
> +    for block_start in range(0, 0x110000, 0x1000):
> +        block_end = block_start + 0x1000
> +        for cp in range(block_start, block_end):
> +            try:
> +                char = chr(cp)
> +
> +                # Skip if already processed
> +                if cp in width_map:
> +                    continue
> +
> +                # Check if the character is a combining mark
> +                category = unicodedata.category(char)
> +
> +                # Combining marks, format characters, zero-width characters
> +                if (category.startswith('M') or  # Mark (combining)
> +                    (category == 'Cf' and cp not in (0x061C, 0x06DD, 0x070F, 0x180E, 0x200F, 0x202E, 0x2066, 0x2067, 0x2068, 0x2069)) or
> +                    cp in (0x200B, 0x200C, 0x200D, 0x2060, 0xFEFF)):  # Known zero-width characters

Convert this if to a function.

> +                    width_map[cp] = 0
> +                    continue
> +
> +                # Use East Asian Width property
> +                eaw = unicodedata.east_asian_width(char)
> +
> +                if eaw in ('F', 'W'):  # Fullwidth or Wide
> +                    width_map[cp] = 2
> +                elif eaw in ('Na', 'H', 'N', 'A'):  # Narrow, Halfwidth, Neutral, Ambiguous
> +                    width_map[cp] = 1
> +                else:
> +                    # Default to single-width for unknown
> +                    width_map[cp] = 1
> +
> +            except (ValueError, OverflowError):
> +                # Skip invalid code points
> +                continue
> +
> +    # Process Emoji - generally double-width
> +    # Ranges according to Unicode Emoji standard

No capital in "ranges".

"to the Unicode Emoji standard"

> +    emoji_ranges = [
> +        (0x1F000, 0x1F02F),  # Mahjong Tiles
> +        (0x1F0A0, 0x1F0FF),  # Playing Cards
> +        (0x1F300, 0x1F5FF),  # Miscellaneous Symbols and Pictographs
> +        (0x1F600, 0x1F64F),  # Emoticons
> +        (0x1F680, 0x1F6FF),  # Transport and Map Symbols
> +        (0x1F700, 0x1F77F),  # Alchemical Symbols
> +        (0x1F780, 0x1F7FF),  # Geometric Shapes Extended
> +        (0x1F800, 0x1F8FF),  # Supplemental Arrows-C
> +        (0x1F900, 0x1F9FF),  # Supplemental Symbols and Pictographs
> +        (0x1FA00, 0x1FA6F),  # Chess Symbols
> +        (0x1FA70, 0x1FAFF),  # Symbols and Pictographs Extended-A
> +    ]
> +
> +    for start, end in emoji_ranges:
> +        for cp in range(start, end + 1):
> +            if cp not in width_map or width_map[cp] != 0:  # Don't override zero-width
> +                try:
> +                    char = chr(cp)
> +                    width_map[cp] = 2
> +                except (ValueError, OverflowError):
> +                    continue
> +
> +    # Optimize to create range tables
> +    def ranges_optimize(width_data, target_width):
> +        points = sorted([cp for cp, width in width_data.items() if width == target_width])
> +        if not points:
> +            return []
> +
> +        # Group consecutive code points into ranges
> +        ranges = []
> +        start = points[0]
> +        prev = start
> +
> +        for cp in points[1:]:
> +            if cp > prev + 1:
> +                ranges.append((start, prev))
> +                start = cp
> +            prev = cp
> +
> +        # Add the last range
> +        ranges.append((start, prev))
> +        return ranges
> +
> +    # Extract ranges for each width
> +    zero_width_ranges = ranges_optimize(width_map, 0)
> +    double_width_ranges = ranges_optimize(width_map, 2)
> +
> +    # Get Unicode version information
> +    unicode_version = unicodedata.unidata_version
> +
> +    # Generate C implementation file
> +    with open(c_file, 'w') as f:
> +        f.write(f"""\

Why this backslash?

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ucs_width.c - Unicode character width lookup
> + *
> + * Auto-generated by gen_ucs_width.py
> + *
> + * Unicode Version: {unicode_version}
> + */
> +
> +#include <linux/types.h>
> +#include <linux/array_size.h>
> +#include <linux/bsearch.h>
> +#include <linux/consolemap.h>

Pls sort includes alphabetically.

> +
> +struct interval {{
> +	uint32_t first;
> +	uint32_t last;
> +}};
> +
> +/* Zero-width character ranges */
> +static const struct interval zero_width_ranges[] = {{
> +""")
> +
> +        for start, end in zero_width_ranges:
> +            try:
> +                start_char_desc = unicodedata.name(chr(start)) if start < 0x10000 else f"U+{start:05X}"
> +                if start == end:
> +                    comment = f"/* {start_char_desc} */"
> +                else:
> +                    end_char_desc = unicodedata.name(chr(end)) if end < 0x10000 else f"U+{end:05X}"
> +                    comment = f"/* {start_char_desc} - {end_char_desc} */"
> +            except:
> +                if start == end:
> +                    comment = f"/* U+{start:05X} */"
> +                else:
> +                    comment = f"/* U+{start:05X} - U+{end:05X} */"
> +
> +            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
> +
> +        f.write("""\
> +};
> +
> +/* Double-width character ranges */
> +static const struct interval double_width_ranges[] = {
> +""")
> +
> +        for start, end in double_width_ranges:
> +            try:
> +                start_char_desc = unicodedata.name(chr(start)) if start < 0x10000 else f"U+{start:05X}"
> +                if start == end:
> +                    comment = f"/* {start_char_desc} */"
> +                else:
> +                    end_char_desc = unicodedata.name(chr(end)) if end < 0x10000 else f"U+{end:05X}"
> +                    comment = f"/* {start_char_desc} - {end_char_desc} */"
> +            except:
> +                if start == end:
> +                    comment = f"/* U+{start:05X} */"
> +                else:
> +                    comment = f"/* U+{start:05X} - U+{end:05X} */"
> +
> +            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
> +
> +        f.write("""\
> +};
> +
> +
> +static int ucs_cmp(const void *key, const void *element)
> +{
> +	uint32_t cp = *(uint32_t *)key;
> +	const struct interval *e = element;
> +
> +	if (cp > e->last)
> +		return 1;
> +	if (cp < e->first)
> +		return -1;
> +	return 0;
> +}
> +
> +static bool is_in_interval(uint32_t cp, const struct interval *intervals, size_t count)
> +{
> +	if (cp < intervals[0].first || cp > intervals[count - 1].last)
> +		return false;
> +
> +	return __inline_bsearch(&cp, intervals, count,
> +				sizeof(*intervals), ucs_cmp) != NULL;
> +}
> +
> +/**
> + * Determine if a Unicode code point is zero-width.
> + *
> + * @param ucs: Unicode code point (UCS-4)
> + * Return: true if the character is zero-width, false otherwise
> + */
> +bool ucs_is_zero_width(uint32_t cp)
> +{
> +	return is_in_interval(cp, zero_width_ranges, ARRAY_SIZE(zero_width_ranges));
> +}
> +
> +/**
> + * Determine if a Unicode code point is double-width.
> + *
> + * @param ucs: Unicode code point (UCS-4)
> + * Return: true if the character is double-width, false otherwise
> + */
> +bool ucs_is_double_width(uint32_t cp)
> +{
> +	return is_in_interval(cp, double_width_ranges, ARRAY_SIZE(double_width_ranges));
> +}
> +""")
> +
> +    # Print summary
> +    zero_width_count = sum(end - start + 1 for start, end in zero_width_ranges)
> +    double_width_count = sum(end - start + 1 for start, end in double_width_ranges)
> +
> +    print(f"Generated {c_file} with:")
> +    print(f"- {len(zero_width_ranges)} zero-width ranges covering ~{zero_width_count} code points")
> +    print(f"- {len(double_width_ranges)} double-width ranges covering ~{double_width_count} code points")
> +
> +if __name__ == "__main__":

Will this be a lib at some point?

> +    generate_ucs_width()


I wonder, if you could generate only zero_width_ranges[] to some 
generated.c and "maintain" the C functions in the kernel the standard 
way -- including that generated.c. I.e. not having C functions in a py 
script.

thanks,
-- 
js
suse labs
