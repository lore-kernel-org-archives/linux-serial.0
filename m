Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89A1D516C
	for <linux-serial@vger.kernel.org>; Tue, 21 Oct 2025 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027778; cv=none; b=TQgWfvj3YI+FtIjnqIINvczkcm34yx01lrtNbGAijvi7kg1yo7Rwxhdgv+NQRqeDwa0Jkrbe36o+24Dtx1ZjY+FcKsEDfMXuX8hSzrM++A+Q3Q82dBQvgISVHHrB9FHCoWkH8O0jQEU8po3rvjCrakZW5/TNapLRPcgIreZgEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027778; c=relaxed/simple;
	bh=oREjrN+X/y48rGrIJfKmFvJ9XngM/DSliLuC3KnJUdQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=de97WDRY6Gn8o0gba2+DRi6Fg/1DTvylul7bx7CNiHQdaKoPskL02hZ7UcD4HQYLkHzD5maqjKwzP1IhPVgFyXxroYVKAedCz0BjmC7Korie0Gt2DA5VXHzxft5xMqgUEwJRpCEqD3h1hIKuPQcGvlalAT9lcfKrMs8mhc2Qshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVH4GMfF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVH4GMfF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso6382835e9.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2025 23:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761027774; x=1761632574; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oREjrN+X/y48rGrIJfKmFvJ9XngM/DSliLuC3KnJUdQ=;
        b=aVH4GMfFUDr3UoyuypPuwmndyYSCVEM2L+ALMj8a9xRA2zhE8XVu7BIX/6F5XqG5Wt
         zwfWH7eGhC8W0N5TTR8/Oi32ylR5WX9rHAc9vUGnLWwjAbbV/tllXzgcJB4ZRFfRY8xA
         JAYZ44+A1CrK3JkhBwBdl745ce9xSrHfO38n4nS1ViThZY+9VREWQZ3VEFb85/Wtti7N
         DCARyvmED6oNjnY96z01nvJkpr55km7cKEcUAqrxYg0n9ka/3DLyuMzgv9vcRvjEVN3o
         cNItaVzTbRIU/s9mnYKeZFdrPwFDAtpmUVFBj73ZU2EmchsxJCKZ1hptw0eUcyMn7Smr
         /O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761027774; x=1761632574;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oREjrN+X/y48rGrIJfKmFvJ9XngM/DSliLuC3KnJUdQ=;
        b=Snc8NXE6KnkpvQY5akP3W1u09qnS5BTEIInpuYQcRf0CS1T8W95Odq33NanvukT9Kf
         AXT/00TbztNsrvDhitY/Zi5i8bnLaZ51TqG6si7a08M9LhVM3lteMeeZVse4hqA8Jaoa
         KZxQF88N+k8QvhD2+CA3SCsrp7I26vQsh7MaFWxCEBkcTOyzDevJ6th4LoCF2mzJb4QO
         AvmPEum5iBbDfWjDFllRDOFEP5ppjze2A/ag3TxEyNntI38Xej5rL1vYMtj13mByC4qy
         Jw6D10+jCOVlGPHyoYqj2m5c9y3NJ3SyG6dfQ5sQCNY/m6bMONaHCtCK5k6FjOFo56Gu
         GcUA==
X-Gm-Message-State: AOJu0YyKP0B+3VxVDhsbxjdV5jOLS5Qa4ualX1vDlFXIOiNGDOLxP0jI
	OXK4F5WDiyXpmUVJtX5TYQk4F1cN6BpxuSxsPSba8wyBdeRuGBGlSOS0kjMV4d0VzA==
X-Gm-Gg: ASbGncvwI3+g2CM9ojlpyHtXQhHVuueYeEa11goMCzT4rAjBIoFbtuF5subC9SrCEq2
	9fO6WjtgfjgB5OvT9UrG4NEBL0tGTfE34EcK4FSOJ83Q+xqyjKnqjj5i57k42lt4onnhmJz8Zl5
	bc7ESHuWwWAAkfA2LPQxqhCEh97C1I3Z2pdjfFrC6/5cSmVksdPHJ36msc3bQbfcffK5HLNDUyr
	VXLbOJUmRPrirPspkRSrY8vX9cbqbD0b3ak/tsCVTFqF4H7lSPmgogS5hzn8b47rMOWEsBNnXvM
	YqUiwA9uTtGGPngF8KXKNDtieCjejvD8nh3bAYHdWcCDg1VT5pnfIBCnMLREOea+pASKtgTKPOj
	w84Hkwm/Xpc7m/TiuBBE60P9SVUHQMQCNA0fpbmuBbPDFwR80al75B80R+VIlCRxCgA/8/wtkG0
	2OSWv0pnBxMqdLwv1eR6CfNtwyrCAfYvVPAgHXsQzb+SsgtcTnfRFlMrEUP8wq
X-Google-Smtp-Source: AGHT+IH/mYcxUXcVZj6z/HVljsvUxak9RakZPz03sN1pNoP8FTlCnyUVdH+kIOPJ9di3IgcilVOkuQ==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-4711786c79emr135303235e9.6.1761027774503;
        Mon, 20 Oct 2025 23:22:54 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce56csm18427751f8f.50.2025.10.20.23.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 23:22:54 -0700 (PDT)
Message-ID: <9515bd4c-4bb6-4535-818c-283e69feb0a7@suse.com>
Date: Tue, 21 Oct 2025 08:22:53 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jan Beulich <jbeulich@suse.com>
Subject: your change "serial: 8250: move RSA functions to 8250_rsa.c"
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jiri,

in this change you moved code from 8250_base to 8250. The latter has always
had a dependency on the former. Now the former has gained a dependency on
the latter, i.e. a circular dependency was introduced. Maybe modern module
loading tools can handle that; on the first (older) system I tried they
can't, and I had to resort to setting SERIAL_8250_RSA=n as a workaround.

One related question that came to mind: Seeing that both drivers are built
depending on the SERIAL_8250 setting, why are they separate modules anyway?

Jan
