Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kymjc8eQ"
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85758D49
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:49:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso8848b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588944; x=1701193744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXJqaP9n8CjgzoiH5n3pTHCDJy51tKrsEtKUZtGKn0o=;
        b=Kymjc8eQJqFB+1WawZGFmm5rwkRudVpD7yLbFpTDpcEFDfQBpBPuNUWbTY78Q9Oxyf
         09W0ev46NEZ91N458AfCzgP4cEjBRfi//qjT0KuivPzsXZ3WVLKnek8NhuAyIoPQXAvV
         xfNhesRazd2w8oT6Z8euPB8+VF8xnhO0ecus0eNziAG1r6neS5u5pYJuECc9qRyhstIZ
         8gBFRQf7pRNINu+Yf7sSRSCiAufAAu9OqDl6qvINZwOv6QV0oEYK6cARGM0xZTlMAkmr
         YlBUueG5VY9madjq9lwN0Jw7kYxmLV7SluyBiCe2FAbojIGJgri79N0zeE7svWyfOGJN
         tFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588944; x=1701193744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXJqaP9n8CjgzoiH5n3pTHCDJy51tKrsEtKUZtGKn0o=;
        b=SrRSLxBM20dSLEfRLu3TgEchq2eI3WHupuZlbVpwNFtBA85H/vFi/JXQQCakvP4GWX
         J1BAjxo/2aMc+ifhN3fdLrJP6XrAZZ8lPwC2QeCKdaQgktt10JIaZqz5k5RGzl6tu77X
         e0cCD1I1UavF3qRdFHFFDVPWc0+B497B5SbYnHpEnfD4XnwEHuPPwXG2ek+llzInZw6I
         S8Brrhacly+//YsdWp8BMZHoV7BKH0QKg1aX4hSYIEaJxyAkL/MXLBmuf2xbE5YrUT5A
         f/AANKCIhNdQur4sOF8HGJQdQBRkF0NZIJTC81+l5rVcOlt3bAcJayAqv1m8bom1kfmW
         Ampw==
X-Gm-Message-State: AOJu0YxFKH/yCUmOOs0i1Fcfp/fKbLeh0SqZ+Vbc44V7y4Df80ve+XAS
	oj1x/fIYt2DxC4z9qppaeKZtuA==
X-Google-Smtp-Source: AGHT+IHZYKUmQPsAZKyzIXXSlFSXyQH3BXp0aXl+SLqo3aQCcXZjl7XFH6/OhEzsyY7tAE9b5eduug==
X-Received: by 2002:a05:6a20:1593:b0:185:d125:ea70 with SMTP id h19-20020a056a20159300b00185d125ea70mr69343pzj.19.1700588943997;
        Tue, 21 Nov 2023 09:49:03 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006cb69ff0444sm5547127pfv.151.2023.11.21.09.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:49:03 -0800 (PST)
Message-ID: <b8dc336f-06c6-43eb-974b-7af251532d10@linaro.org>
Date: Tue, 21 Nov 2023 11:49:01 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] tty: srmcons: switch need_cr to bool
Content-Language: en-US
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-17-jirislaby@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-17-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *

On 11/21/23 03:22, Jiri Slaby (SUSE) wrote:
> 'need_cr' is a flag, so type it properly to be a 'bool'. Move the
> declaration into the loop too. That ensures the variable is initialized
> properly even if the code was moved somehow.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
