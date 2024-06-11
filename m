Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FB1E52F;
	Tue, 11 Jun 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091578; cv=none; b=e4sNaP3wB9fw/hji5wCk8peTYxVeLAs6On+2jK9b8vds9QVlCEI5obYwnIaRa5LTZnA3fAbGlBOVtAcw7oLRnCYb5QiWHf0P3DWLBYpfbaZqFANhlDp5ZFyH+70ZBk+n8Ziyq4fDSlo6KqVbRBi74W9kDQYWPkhXoYRsMo9vT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091578; c=relaxed/simple;
	bh=637fUC182B/p/l0RQRC6xJXtXmBqhsWjWsCEztSAM6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGlGdE8bwd2KZ9knB8gkoMqb6ZIMD7stnxjF6lRU4+XavDwx5wkj7pKhrNfVECEESLbe3akST1gqzZQZanqoTPb8/LSm26vHUmrd5szM7DvJ7T9J54XFj8ax+mJT4j+h4gsOBn+MAXiox1pGdZ/dUUtjGNfGdUlxbXFdMbUKwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so949175a12.1;
        Tue, 11 Jun 2024 00:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718091575; x=1718696375;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Wm7OMeX6zk0x9ibqIrwPq0dr9kqWdXX7o1Kro22Zo=;
        b=t7CAe/Tc+j9b0NfLMwCkEbQ3TAnuPLLVPUiwtAwZ4iakJH7daLPWAvCNtlw7RP2IQv
         MYfmY3y7bdhuPfQCITlAf35wXHNYwFUfCuLrmS9bPBvlIyzY0pFsIltxj6NbVtBUgdyC
         ugxjysRp6br2hpJ3CPE5pNo97gJPD3zUBS/kSEcaIvXVeU77lYE92Rcb04PYzcP3EjMW
         NZWRD7c8fZOAKvDEUWiIwKCRLUa7o2J1ZElkVrKRhOPa6S9eCtNZPP0em7+KTgguFvUp
         /2NrP0pECMwx565/nhJQ0GjRG6HQJdNL7oHxbuTeQuEgd4hlmLoJeMv0h90AxaU/S68q
         GdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc7dcx0NdnAwwz4RVfFy2rBeKeD6yz2NmU55TMB4WtMzw+3p6qOn+a8FLqA2YIBwAKRwYtJrNUSms/Y0C0RI1IhF5JSjQQhi1eSiqF
X-Gm-Message-State: AOJu0Yx6jCP4qqW7yWby6MNZatvBhNM0hpIE65CZYMFV+1hXq3CHWkaH
	EPQNVjln/tmM0w/mHVcD/Nq27C+sDDAsP6yPn6trZkhJRFed3rzf
X-Google-Smtp-Source: AGHT+IGDcxVTO7D+1PyfZLiZ15QbdR7bwirSYTPcTt0NHFuqezRYUa/3OzHnBGMRnprrWqWu/lDHcA==
X-Received: by 2002:a50:d681:0:b0:57c:673f:f262 with SMTP id 4fb4d7f45d1cf-57c673ff3a8mr6709485a12.30.1718091575316;
        Tue, 11 Jun 2024 00:39:35 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c69d06729sm5958583a12.56.2024.06.11.00.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:39:34 -0700 (PDT)
Message-ID: <4a748c05-c74c-4b4b-bacf-664b774a490e@kernel.org>
Date: Tue, 11 Jun 2024 09:39:34 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tty: serial: 8250: Fix the amount of ports doesn't
 match the device
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-2-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240607114336.4496-2-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 06. 24, 13:43, Crescent Hsieh wrote:
> Normally, the amount of ports is written at the third digit of device ID
> of Moxa PCI boards, for example: `0x1121` indicates a 2 ports device.
> 
> However, `CP116E_A_A` and `CP116E_A_B` are two exceptions, which has 8
> ports but the third digit of device ID is `6`.
> 
> This patch fixes the issue above by adding checks.
> 
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 40af74b55933..4e88ee07e548 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -2041,6 +2041,10 @@ static int pci_moxa_init(struct pci_dev *dev)
>   	unsigned int num_ports = (device & 0x00F0) >> 4, i;
>   	u8 val, init_mode = MOXA_RS232;
>   
> +	if (device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
> +	    device == PCI_DEVICE_ID_MOXA_CP116E_A_B)
> +		num_ports = 8;

Can you perhaps introduce a helper like:
static unsigned short mxser_get_nports(struct pci_dev *pdev)
{
   switch (pdev->device) {
   case ...CP116E_A_A:
   case ...CP116E_A_B:
     return 8;
   }

   return FIELD_GET(0x00F0, pdev->device);
}

?

> +
>   	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
>   		init_mode = MOXA_RS422;
>   	}

-- 
js
suse labs

