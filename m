Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0645BE4;
	Tue, 21 May 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288425; cv=none; b=HRehXNVGFczj7pzyxnGTGlOL9ec6fzfkBYUEdIK3QpantXcAqsCCT1OUnzUmR81wPBxYLdOa/xqzO6PC2CBryLsFXcRO73h0Iv18XNrpTGJxw2rQHr/EtSONOAB7GAhWUIjtxowN/wBIQ35wBWIA+s/pcRL8W0VQCY/M/j6KKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288425; c=relaxed/simple;
	bh=hJS2RR8aVknN6ThkqUFI7laRMezAFpVk76pzBbaVOcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/8tZDXujVw81bgHb5UIZ9V6aqlJDYO60lkMBEZqIOTk/d4NBMm8qok4UTVG9JoKLhWhb4K3ZUwkXOeRTl9QOiMJJKlf8iQIyJdXnrxGbrWyIYe0GEp5dLzQWo6q00ltHV9n35ATf5CsyVYRQgl+zy2Zf4Epf/U1cc3z3a8Zwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4202ca70287so21794415e9.3;
        Tue, 21 May 2024 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716288422; x=1716893222;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuaVmJGr5Kq6ft/XK2PUm0gpxXEysYv+8xDN87xLZ7E=;
        b=h3tb6RW64EgpMDcZUwTwPVPiO62lMzcRJ8k46CP6F7B760vJCnLmnVVL1MDCkO6530
         bitKTeiBSQLq1SvQEmUVOQwyxy49+6/S5M/FKkO4BLeZwq2fvdC/qVOS4ULXsrnHDzje
         21kJIJVawaEJGw7VPDhxnjzgirzc0PsTKuKaFEUbLeCH8CWmO0KvN6CKas4mUBdyjxbc
         0z+2lfzIySOQVg7Y+IHDAjUM3GYfKJiULyRZGrGSNhMcmARJrBFe1a5gxxE49KTnpXtp
         A1FYFrN9zfK/ZtsPR+CQjKnXQNIqZVyOXRMgwCilAZP64smZ6n4bSyIaPXzMjqRln6Ze
         FDPw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Jl32KHGwn9m9wbksjmh2L096VScE1W96stVu7gGzbfrN4IGfJRUsRkNW5sHrtjwoTqhRFepc/bOrqWoCU4yxjPaKadIVxTMK41KWa1EzS4DWoCfw7JfVKo+ibTQPlj/zslVZQ/o6CclO
X-Gm-Message-State: AOJu0YyeWdjCHmS5mpRECEnfX7HlOJHPvoe4VNuoqxXRZSD6tpZWckAu
	RnqprjPZNM4U9/wQuJyTcOJHyVYZkXdBIhIFdSR+RyYp3EiR/Q+hyPKSjg==
X-Google-Smtp-Source: AGHT+IGq4zPt9iYC18BD3xfEUiPic9psp5wd0btkf+Q3CHOuhoyEWSRcJgUaqr4nwGDKBhisikTRcg==
X-Received: by 2002:a05:600c:a02:b0:41f:d1e0:5ba9 with SMTP id 5b1f17b1804b1-41fead64487mr335747315e9.37.1716288422266;
        Tue, 21 May 2024 03:47:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe9011sm458838635e9.7.2024.05.21.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:47:01 -0700 (PDT)
Message-ID: <63a5a3c5-8362-4b93-a50e-10c9cdcffdd2@kernel.org>
Date: Tue, 21 May 2024 12:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: N_HDLC line discipline: Race condition
To: Dianne Skoll <dianne@skoll.ca>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240424173114.035ddd7b@gato.skoll.ca>
 <20240425140127.6504ade1@gato.skoll.ca>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240425140127.6504ade1@gato.skoll.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 04. 24, 20:01, Dianne Skoll wrote:
> Hi,
> 
> I have (somewhat) narrowed down when the kernel bug appeared by installing
> Debian 10, 11 and 12 in KVM virtual machines.
> 
> The bug is NOT present in Debian 10, kernel version 4.19.67.
> 
> The bug IS present in Debian 11, kernel version 5.10.209
> 
> The bug IS present in Debian 12, kernel version 6.1.85
> 
> So I guess it was introduced sometime between 4.19.67 and 5.10.209.  I'll
> take a look to see if I can do a git bisect.
> 
> [To recap, the bug is that the N_HDLC line discipline sometimes
> coalesces two write()s so you get them both back in a single read()
> which is contrary to what it's supposed to do... preserve the write
> boundaries as individual frames.]

I believe it is a correct behavior after all. As you use pty for 
testing, the "framing" is lost during the pty-to-pty pass on the flush 
to ldisc path (receive_buf()).

[ T1056] n_hdlc_send_frames: ptm2 sending frame 0000000081e69927, count=6
[ T1056]        frame 0000000081e69927 completed
[ T1056] n_hdlc_send_frames: ptm2 sending frame 00000000576db119, count=5
[ T1056]        frame 00000000576db119 completed
[  T123] n_hdlc_tty_receive: pts2 buf=00000000a616a2be count=11
[ T1056] n_hdlc_tty_read: pts2 rbuf=00000000a616a2be 
kbuf=000000004abc3c35 offset=0 ret=11

thanks,
-- 
js
suse labs

