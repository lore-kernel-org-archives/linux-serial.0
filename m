Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729A157465
	for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415891; cv=none; b=qdag/cu4Pl0dTP3WOfsXxb80aC8H31q+nHHmY4vq4KjWc8C/PxXI8tYYjSJpaebqAfnGGQLyR1BFomVfK+IHnO04ItxeetZirJ4pvgn8P9hMewgTTlKcQ8NiNWSe7F8oT0J78lTcQzqAdwXQm29VtjxnEO+fEVIkkYdnfohhjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415891; c=relaxed/simple;
	bh=K28/z7QwIeobQDU/vrm+DEec3wrz9qnljeycGV8KQZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQH3levpkPf5d54317mri5RyBGZYShkuMzYBN4xD6Zv9p/QJhiJHiR4NhZedicEh2oeIeiL23XFT85HzEon13mSSEODbBXRpuG2Eeedv0wbKPIZillQ+PdHQTg+Gm2HTYnQm3QV5oACxAOWXBO9XmDMD8F2rgoSk7QEZWj0hZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Q7TD/HW8; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=t+YaG54F; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Q7TD/HW8";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="t+YaG54F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=Jyt0wxZCqrJX4sJ0pBWunQCrP16mlcdWeo8PdzECLyE=;
 b=Q7TD/HW8uG4Pk31shNysm4oOEbJyoZ/eHkxNHe0+VavQpzKRIRv78Seb2qKse3HekXUWkm8i3QpAXk9bLDcYvZW5UYbh5D8GLzKbcyjwpXfyp2Y5O0l/5D5yLOFhrM+1RM3+JmEcqS+vi0ipnyvimQHQT+Gt27mRdHZe2AagMzTx6FdqY1Uotyh37ykgP61JHzHFVjXwVFCR3cQGn797CKsA9LAnK4PeKD4pjChXqGb+uXxAzE6VVAAkIWuls5zW8NztZgD3Cuo3sDeY76UVEg6TZmOmuuloBKSHsu3xcYBE36a1ZCqczgi6VSiO7sKtSNnoqXxejDcUo7sSqRUF4A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4720F24009B
	for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2025 16:51:21 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0c1025a6cso371290685a.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2025 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740415880; x=1741020680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jyt0wxZCqrJX4sJ0pBWunQCrP16mlcdWeo8PdzECLyE=;
        b=t+YaG54FqTEsNQo4rca0STCmSCAEfvjezbUwMFCj1Wdme5a6P8RkpdtDNpeFV46+XS
         lKJxTjaagQzD9EEiaocqxkmUOeVnRNvoP0Wqs4bEywH1BXFGgjnr212iLgXaOFOoE5Ro
         t/LeusVXFaJ10Y61XDOqcWwwFm9qkc2GP4kInkPe2H/eqyEs4NUDANeeL8N0tCmyQ3Qn
         pCY4mewAADuCa/Z1QqU+AZciU7DxuIc9cJLaSf/7y4nKOHpKthIYcspJWysTSucrocpp
         4bxeIN/4TrxSOKydDDHayMmScfhJT+u+uFMl4V5kMv92cSOdCva2ShYbM1ZmHQmpYAYw
         twjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415880; x=1741020680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jyt0wxZCqrJX4sJ0pBWunQCrP16mlcdWeo8PdzECLyE=;
        b=fvjS4eHF6vukK6jrX5Uz+jnzMTvdCtObv6XChUkDer9veUVlmdBhB/uzjCE7iwVOxY
         P3dP9uo5lBom9FYa2/ipP96wbRXNfwBX8jJDjKB0ChAjrh6JtbAUQzr7cCpB/HvLrfGi
         be9S1Wrkzpw/0P6abbBwW+T3nj0URJGMFkyPOh6t7yKncvILGCRaqeBLUEqi4eatcQ0H
         ihevaaPFxOIZQFH0hk7JwWwBnJ1Rsmic0a5m3uW10AWi1ir4PjXsgp0ydEg/WEYIGA7N
         B5YuixOcCoo7/uYU1XIf9mzRkZ/mEcrDb2twXxnbLtMpYZkzVxc/JkhNl8Mzcreha4Gh
         9B6A==
X-Forwarded-Encrypted: i=1; AJvYcCV+rOjFgHJM7uk2iTVufskg1YAfjq+hZvOsEUBOX5gXOLPODr8gYtK6oTCfNGNLqnU9bexRDCVKXUEj0bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3iG0HHQm0KPIQAk1DLWZKZMa2z3TiyYp3QVL1I4yu0OrHakR
	z1TegzOCfA23oNW6v6JWiMp2I64yOe64ES621yRowgIDHVJ2gzvD78FhlLdbganS1sRY7x5x9x8
	+t+cbWB2a8dbuBivUWNvnnDd7BY2egMhFbcxc3GZmiFOZ9o3N4WtQ+XrnJdgw37aFGkzOeFtqkt
	G4EbQhO8gj2ZhNY0g=
X-Gm-Gg: ASbGncu6Zi/YtbtNqGZpHy4fsrIuR3nEmFzf06hFNyn2eJ4EJBaO/zIlJyvfRwHQaXm
	60Rj8DHFJ6tN0qHz+QUDXhnb38+Z1gOsA882bhjlBw1O4ZwlXhnYqGAT6W5MnFt6NA9IOgnWJoy
	ITHx4dOo3cbIpzNWjI6XRK49q4xGgw+dyHXrL8kYJJG5c0RBA4ddNNubAbDBrw/OWp119hh8H99
	AoU1Ic5GgCF3oiD9s8OiFIL55NkYOR7ljpliYakaiKFbufdr+v/pFfL5NWzZZIxN3m+HfLIlD9u
	T1rJPrJnUbXtMSu3vImDj5lv3LVg3ZU4wXCyhj6M5x7Md76+/3kQUPzxd2WklO9oIft36nRrMXs
	DDz5i3IzPnZXIFkudsVQebzfAkWrV1p5ZbChE
X-Received: by 2002:a05:620a:2985:b0:7c0:b685:1bb0 with SMTP id af79cd13be357-7c0ceef77f4mr1723519885a.17.1740415880333;
        Mon, 24 Feb 2025 08:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+l9174nk3i6VHzzdNLPRKcdildnJV0MBhHekW79kq7PRniYea04k3F6dvly7pRsJDJAeTJQ==
X-Received: by 2002:a05:620a:2985:b0:7c0:b685:1bb0 with SMTP id af79cd13be357-7c0ceef77f4mr1723516885a.17.1740415880028;
        Mon, 24 Feb 2025 08:51:20 -0800 (PST)
Received: from ghostleviathan.computer.sladewatkins.net (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0bde74158sm686422185a.28.2025.02.24.08.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:51:19 -0800 (PST)
Message-ID: <2faa8912-a699-47d9-b9d6-dc2fb22fe7c8@sladewatkins.net>
Date: Mon, 24 Feb 2025 11:51:18 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
To: Wentao Guan <guanwentao@uniontech.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
 Jiri Slaby <jirislaby@kernel.org>, Ferry Toth <ftoth@exalondelft.nl>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
 <tencent_09E5A20410369ED253A21788@qq.com>
 <2025022434-subsiding-esquire-1de2@gregkh>
 <tencent_013690E01596D03C0362D092@qq.com>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <tencent_013690E01596D03C0362D092@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740415881-ACKQHHUfjdH5
X-MDID-O:
 us5;at1;1740415881;ACKQHHUfjdH5;<slade@sladewatkins.com>;e351ccb998625a5b6fbcb8b8ff80ea34
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/24/2025 8:13 AM, Wentao Guan wrote:
> It is means that 'Fixes xxxxxx' tag point commit will auto be backport 
> to those stable tree with xxxxxx commit without cc stable, correct ?

If you mean that it will be "automatically backported to stable," then 
no. Ask for it to be backported, or submit it as a patch the proper way: 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Otherwise, I have no idea what you're talking about either. :-/

-slade
