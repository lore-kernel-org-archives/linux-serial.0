Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B014A4D6;
	Fri, 27 Sep 2024 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413169; cv=none; b=s7Xq313xRQ6BCKD0N6h5kwT6bAdU8dY1Q31CUqWJlOIYx1vV66y0d+PUy2DL1X3qDCOtf1podg0k//kgbc6Qb4vNfOaTm5oqJEO2OsB0s0ektRq6wSKjUgR4PJYHfnssmuXzg08rMPwJeHKX2i8SP3QgiRQSLUhjgEr69TyQMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413169; c=relaxed/simple;
	bh=EDaTH0Illn9Eqnh8KKn2ddjP64yHyaCSxExYtMlMQRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnkEDNfaF22/vSCsvK5tSQAgUiLCudbFAHn2vV5e7nOXGE0qvws5O+GPDgLPubpISBeiIxKgg6Zfl7h+MbIfugI9jFQQsOo5sxEKnOFwJj+K06LnW9opD+Z8FpgiSMnFqCoRllJNM3xhpUS9JPcxDak1V/JFZpFOlOApo+94h24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so2121996a12.1;
        Thu, 26 Sep 2024 21:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727413166; x=1728017966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5CceRvn1nGQYVLaIBnfN4iwqbdraidCb1nSVb9qlfA=;
        b=Cpt1hXnqAaVai+l10frA0PSlOJGzGWOWGhDTQHo6ny6rmvGeziYdqQBHednqar550d
         YkoBSSvlOipgpTFxHUf19v9b34Rfj1kWJQw5QJawXbtwGRgo5oNI9jmEDYH6M4hgHpk4
         8BoXniLyDNfVvxtMANfzXniwKxLkq8qJoWUq6QsQJD6X+09Lwhd038pCc78BsbqmlNtj
         JXqOy7ZWtmWvrWWlJ8XFeP3VP+JsHw7QE+5pXt5UQzAsLX9KtfJ7C6RF8BmkqfuKbIgC
         R8OFpjpFC3s5qa60T0V9fPawaVo9zCsf9ZgZgvS9xoyyHhmsZwWCB0iIEYe9sdsYvuvJ
         mguA==
X-Forwarded-Encrypted: i=1; AJvYcCUxjA0h5T5hCjxc+c/fcVCjYQIN9kh8o7SeG2rX6STY+qdDMmB1mcP494tbUs619NgnKw9DoybiHQpO9+k=@vger.kernel.org, AJvYcCWMHlIISYQR7rA+mvjhikgK5hxDHyIFAdxtywC1AgrUQEFav+/gXgry9i4byXf9YrCwkvLMfHVmYUbpLCgX@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGhJC7Oo8XX1mL8k+ciYDmVsrhw1NEugONLm5fwBEcb5ZbpwI
	jwp7YfTiTtXdBXPAUPcAWEpbBYyPeiGIjWYOg6S7LmukGuaz0HkJAizwESHo
X-Google-Smtp-Source: AGHT+IHWIvCwlTapDlJGDl+AJheX87SnJGr0My8dURGzqaqh4Ka/QPc6HazkGdkdA7ynOOpn88i6Yw==
X-Received: by 2002:a05:6402:34d2:b0:5c4:51b3:d75f with SMTP id 4fb4d7f45d1cf-5c882600337mr1404528a12.24.1727413165570;
        Thu, 26 Sep 2024 21:59:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405b3bsm676709a12.20.2024.09.26.21.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 21:59:23 -0700 (PDT)
Message-ID: <7312bc09-5cad-4d0e-a7f5-2891d5b0f15b@kernel.org>
Date: Fri, 27 Sep 2024 06:59:22 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nilfs2: add ratelimiting to nilfs2 message
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <66f59678.050a0220.46d20.0001.GAE@google.com>
 <20240927021322.4088706-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240927021322.4088706-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You should have aimed this at the nilfs developers...

On 27. 09. 24, 4:13, Lizhi Xu wrote:
> Syzbot report a task hung in vcs_open.
> When rec_len too small in nilfs_check_folio, it can result in a huge flood
> of messages being sent to the console. It eventually caused tty to hung when
> retrieving the console_lock().
> 
> Reported-by: syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

-- 
js
suse labs

