Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE033DF;
	Tue,  6 May 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513201; cv=none; b=pY8Ylz8Vutp6sxxsioQELc9utXcpsuaaRAHPuJ+5/YX7TJ+CXmxIW8ivwsuycRD2wzrSOMXulKi48RzRjBd4EZBrer1IKxVRniur7jTLkVBKxLFpfWU8MUS14UO5kvMztjp+89sDQveDHeAKlSwpnybkgYSNI/kw0d+S1up3kkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513201; c=relaxed/simple;
	bh=RnqLr2aNSgtNJPVm9QkWt1ci1fAjU/AK8o1DXpNSegg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTZJ8wh7lc4OOs9SMKVJgDHwMnWQNkBcOsKmDsVIvSaOYihbg1vhaNdm6Vl/DnC7NvGymDs1OIPdkyRio1Dfk06VMbk7KA9HEXGGHhG+5BoEu4LIn2Rq2xwV05jqBOjP82L5+PV7hJ4RsooGUMc6QE2JiMBatfgwWu1ITZbrcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntmrBBix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntmrBBix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EEEC4CEE4;
	Tue,  6 May 2025 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746513199;
	bh=RnqLr2aNSgtNJPVm9QkWt1ci1fAjU/AK8o1DXpNSegg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ntmrBBixvNhNmwy6gGIBO/+guMHb0lOvrJwM93dC0qQuwrhk9r9dKEnXZT/K/2DSR
	 toZlQWKCTqAk74kQR9CvuwMsxtgeSIyFfjTY1Z0pnAlFmknIV/W0f/hIXSNk/RLMRi
	 IEwmVsOcczzvfhXlC/QXN1zAVMJSh7aWIrIzdTyu9T8Q9lgCoKv9Xc25XkN/+N0Ee+
	 wOIlqRLpP88r9fzs4AKdYPPMv6LODD+Usx5+EFyC4zDF5rpdaEMACzmf76xGmL154m
	 aNjtTdGVV7oczYg7tY45e9Fds/hNXMMQmyDt7aXXarmX8WnD9pVydLnTXwhqCFjG/r
	 sDnHL9qaXJ/Pw==
Message-ID: <1a91b1b3-a8b8-4040-add6-857c8207b97c@kernel.org>
Date: Tue, 6 May 2025 08:33:16 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] vt: introduce gen_ucs_fallback_table.py to create
 ucs_fallback_table.h
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250505170021.29944-1-nico@fluxnic.net>
 <20250505170021.29944-5-nico@fluxnic.net>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20250505170021.29944-5-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05. 05. 25, 18:55, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> The generated table maps complex characters to their simpler fallback
> forms for a terminal display when corresponding glyphs are unavailable.
> This includes diacritics, symbols as well as many drawing characters.
> Fallback characters aren't perfect replacements, obviously. But they are
> still far more useful than a bunch of squared question marks.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/tty/vt/gen_ucs_fallback_table.py | 882 +++++++++++++++++++++++
>   1 file changed, 882 insertions(+)
>   create mode 100755 drivers/tty/vt/gen_ucs_fallback_table.py
> 
> diff --git a/drivers/tty/vt/gen_ucs_fallback_table.py b/drivers/tty/vt/gen_ucs_fallback_table.py
> new file mode 100755
> index 000000000000..cb4e75b454fe
> --- /dev/null
> +++ b/drivers/tty/vt/gen_ucs_fallback_table.py
> @@ -0,0 +1,882 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Leverage Python's unicodedata module to generate ucs_fallback_table.h
> +#
> +# The generated table maps complex characters to their simpler fallback forms
> +# for a terminal display when corresponding glyphs are unavailable.
> +#
> +# Usage:
> +#   python3 gen_ucs_fallback_table.py         # Generate fallback tables
> +#   python3 gen_ucs_fallback_table.py -o FILE # Specify output file
> +
> +import unicodedata
> +import sys
> +import argparse
> +from collections import defaultdict
> +
> +# This script's file name
> +from pathlib import Path
> +this_file = Path(__file__).name
> +
> +# Default output file name
> +DEFAULT_OUT_FILE = "ucs_fallback_table.h"
> +
> +def collect_accented_latin_letters():
> +    """Collect already composed Latin letters with diacritics."""
> +    fallback_map = {}
> +
> +    # Latin-1 Supplement (0x00C0-0x00FF)
> +    # Capital letters with accents to their base forms
> +    fallback_map[0x00C0] = ord('A')  # À LATIN CAPITAL LETTER A WITH GRAVE
> +    fallback_map[0x00C1] = ord('A')  # Á LATIN CAPITAL LETTER A WITH ACUTE
> +    fallback_map[0x00C2] = ord('A')  # Â LATIN CAPITAL LETTER A WITH CIRCUMFLEX
> +    fallback_map[0x00C3] = ord('A')  # Ã LATIN CAPITAL LETTER A WITH TILDE
> +    fallback_map[0x00C4] = ord('A')  # Ä LATIN CAPITAL LETTER A WITH DIAERESIS
> +    fallback_map[0x00C5] = ord('A')  # Å LATIN CAPITAL LETTER A WITH RING ABOVE
> +    fallback_map[0x00C7] = ord('C')  # Ç LATIN CAPITAL LETTER C WITH CEDILLA
> +    fallback_map[0x00C8] = ord('E')  # È LATIN CAPITAL LETTER E WITH GRAVE
> +    fallback_map[0x00C9] = ord('E')  # É LATIN CAPITAL LETTER E WITH ACUTE
> +    fallback_map[0x00CA] = ord('E')  # Ê LATIN CAPITAL LETTER E WITH CIRCUMFLEX
> +    fallback_map[0x00CB] = ord('E')  # Ë LATIN CAPITAL LETTER E WITH DIAERESIS
> +    fallback_map[0x00CC] = ord('I')  # Ì LATIN CAPITAL LETTER I WITH GRAVE
> +    fallback_map[0x00CD] = ord('I')  # Í LATIN CAPITAL LETTER I WITH ACUTE
> +    fallback_map[0x00CE] = ord('I')  # Î LATIN CAPITAL LETTER I WITH CIRCUMFLEX
> +    fallback_map[0x00CF] = ord('I')  # Ï LATIN CAPITAL LETTER I WITH DIAERESIS
> +    fallback_map[0x00D1] = ord('N')  # Ñ LATIN CAPITAL LETTER N WITH TILDE
> +    fallback_map[0x00D2] = ord('O')  # Ò LATIN CAPITAL LETTER O WITH GRAVE
> +    fallback_map[0x00D3] = ord('O')  # Ó LATIN CAPITAL LETTER O WITH ACUTE
> +    fallback_map[0x00D4] = ord('O')  # Ô LATIN CAPITAL LETTER O WITH CIRCUMFLEX
> +    fallback_map[0x00D5] = ord('O')  # Õ LATIN CAPITAL LETTER O WITH TILDE
> +    fallback_map[0x00D6] = ord('O')  # Ö LATIN CAPITAL LETTER O WITH DIAERESIS
> +    fallback_map[0x00D9] = ord('U')  # Ù LATIN CAPITAL LETTER U WITH GRAVE
> +    fallback_map[0x00DA] = ord('U')  # Ú LATIN CAPITAL LETTER U WITH ACUTE
> +    fallback_map[0x00DB] = ord('U')  # Û LATIN CAPITAL LETTER U WITH CIRCUMFLEX
> +    fallback_map[0x00DC] = ord('U')  # Ü LATIN CAPITAL LETTER U WITH DIAERESIS
> +    fallback_map[0x00DD] = ord('Y')  # Ý LATIN CAPITAL LETTER Y WITH ACUTE


So you are in fact doing iconv's utf-8 -> ascii//translit conversion. 
Does python not have an iconv lib?

 > perl -e 'use Text::Iconv; print Text::Iconv->new("UTF8", 
"ASCII//TRANSLIT")->convert("áąà"), "\n";'
aaa

/me digging

Ah, unidecode:
 > python3 -c 'from unidecode import unidecode; print(unidecode("áąà"))'
aaa

Perhaps use that instead of manual table?

-- 
js
suse labs
