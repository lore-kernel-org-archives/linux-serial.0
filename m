Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PV+GKU4a"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F318E
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:47:35 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cb7951d713so1979889b3a.1
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588855; x=1701193655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTbpm+rp6tMftUStFdiQEsAqCqUtgJmVMIVDldceZqw=;
        b=PV+GKU4aUhTQV3tEWdClWY1Hq/D5LCUwl5f6TBkRuXjZMyjgH/y2Ou1ehdfJGBzPli
         X+XF+BOlzTQOoB7MCN0yss4Uo1/8yiGoUSZLeExsFh9KerXniYZptvTbwbRf0ECM+A+l
         1+mfCtRY5Qgjj1v0+NCWEXqtor8tlrVoA9f65WaC2EtnLsK7YQsu5ZLdVNv5ikvnHmwg
         T5hyQQlrydf7N3dwWA24DdHYavSUsftpkF+Q2TL0BRX0SOXyBmUGT+5KiJ65+I546JX2
         e4lHfDa9I9cojtD3XZZPgh0VMIdGXk32z9snTGasI6/EQmjJ4fxQsvfdkALbWXfEnTYo
         8nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588855; x=1701193655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTbpm+rp6tMftUStFdiQEsAqCqUtgJmVMIVDldceZqw=;
        b=sYjqU9gxaHa97a01VH1N5rBniXpOun3lJ0h8YLqKjelM3IRZQ4I3/9/sLzi9y4YtxO
         KDIPSxAlhfHegW48e4tjtXRxwboj2CGTfstDiaQFCkBSotnZYvNY4wzxLeF/BuMDKFvB
         F8dGx44MHManeT7Tshqz4zGGK2n7pivtEpJsH3Vd1gu/vACG4OJi/SuzisTL8GOC5P7K
         2kSjMCMYVM4BuEi7oHlNT5G7mDKWOFDo8i3rMTu0vo194FeuTON2wBoUbzQNlhbF2oQO
         1OBGx5DwyGo7xrScx79HQ8GdSJ+TFmKYTnTyPL85jOo4WdzXWz6VP4RSZckQst8zmzCd
         moEQ==
X-Gm-Message-State: AOJu0YyGDe5KUdDzknO0bNLJQM0eYe0AEBLlM95KbMqPYlVP/cnS8Xkx
	yEbYY9prp3XA/z1v3GX3ZWNI0A==
X-Google-Smtp-Source: AGHT+IGpLWmqDSdVFd6CaLryGWVI12VpIaF4JYNkxPzXXmBwqK7ws85MhXqCeNh2+C9HWx6XT+XJQA==
X-Received: by 2002:a05:6a21:6da0:b0:187:4e8c:ac5c with SMTP id wl32-20020a056a216da000b001874e8cac5cmr89463pzb.1.1700588855173;
        Tue, 21 Nov 2023 09:47:35 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006cb69ff0444sm5547127pfv.151.2023.11.21.09.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:47:34 -0800 (PST)
Message-ID: <f51d5dd1-5fc9-4b4b-b012-a396b68fe184@linaro.org>
Date: Tue, 21 Nov 2023 11:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] tty: srmcons: use 'buf' directly in
 srmcons_do_write()
Content-Language: en-US
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-14-jirislaby@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-14-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *

On 11/21/23 03:22, Jiri Slaby (SUSE) wrote:
> There is no need to have a separate iterator ('cur') through 'buf' in
> srmcons_do_write(). 'buf' can be used directly which simplifies the code
> a bit.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
