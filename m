Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8FF10A
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 01:20:21 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1f0616a15bso606181666b.2
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 01:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372819; x=1702977619;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVPktY1IV3vvmS1RUV+zLONoX32D0QKwSLpQeB/DZl8=;
        b=jB+LTz2ldI59KZr7VGBTaWnCYeeJVwpLMtbIcuTF4RIYuJYuCUjUuVIbjwSqtdRcLS
         Ipu0HpqfjwP2bo8T4YApTsghGIKEMsPS4kKUE9TuQ9MU+poIOX7eroRpiwwDoa4PV003
         25v4WI5zG994lniUYZ9tQ5JgR0AA0rEErAELJorYLdjoQTxsBl9xOeEGBs/2SeGOkxXi
         9FN55pXeNbUELkDi0uQf61bIxec0Xu4SiqNbi9Tgs7wQdFMuDGdYI3xAZ6GvuNacFLvh
         eKIZDnszNsfkQb5CZLUmnWA5sOvCIhIKesMO2h1sN7UVGMnykD5SJfp2/CcRXAJCDU4+
         KaFw==
X-Gm-Message-State: AOJu0YzxoUhqFTNfrDA6+Jmbf+iTzlq/2VAeU7jOCNHmWe9GwAH9+rJt
	1viGTPmn4v6SQSE6onk3nw4=
X-Google-Smtp-Source: AGHT+IEvhzl/5YgrAzLWbiRw7WGBgKL28GrRH2dXThZQwPn8MXYXoyw7uKTzBiVnW9fqW7soaOo5KQ==
X-Received: by 2002:a17:907:944d:b0:a03:6fd8:f14b with SMTP id dl13-20020a170907944d00b00a036fd8f14bmr3818776ejc.28.1702372819258;
        Tue, 12 Dec 2023 01:20:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a1cc1be1158sm5957617ejc.165.2023.12.12.01.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 01:20:18 -0800 (PST)
Message-ID: <0fa1b1a1-5470-493b-b156-aabbe008fe13@kernel.org>
Date: Tue, 12 Dec 2023 10:20:18 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty/vt: UTF-8 parsing update according to RFC 3629,
 modern Unicode
Content-Language: en-US
To: Roman Zilka <roman.zilka@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org
References: <CANZiGuGZn4uPLw7=U95ZQtMFW3pWi4Bw4rrkCdq=X1641KLy9g@mail.gmail.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CANZiGuGZn4uPLw7=U95ZQtMFW3pWi4Bw4rrkCdq=X1641KLy9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12. 12. 23, 8:40, Roman Zilka wrote:
> vc_translate_unicode(), vc_sanitize_unicode():
> 1. Limit codepoint space to 0x10FFFF. The old algorithm followed an ancient
>     version of Unicode.
> 2. Corrected vc_translate_unicode() doc (@rescan).
> 3. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in Unicode -
>     - accept them. Another option was to complete the set of noncharacters (used
>     to be those two, now there's more) and preserve the substitution. This is
>     indeed what Unicode suggests (v15.1, chap. 23.7) (not requires), but most
>     codepoints are !iswprint(), so substituting just the noncharacters seemed
>     futile. Also, I've never seen noncharacters treated in a special way.
> 4. Moved what remained of vc_sanitize_unicode() into vc_translate_unicode().

Whatever the patch contains (a _packed_ attachment really?), you should 
spell "Why" part in here.

thanks,
-- 
js

