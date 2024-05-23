Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B23C0B;
	Thu, 23 May 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451316; cv=none; b=NNkWrXH2HNRFHHvdZqm04KVQwJfubXUfz14iWzT99Yn6hb7z1o4/zPUzfXbgLUVBqBJrcE5vOUwuIOtDDKLM077ksiJKXHKEzfXPPKFcLv4SR/qegWruyyf/aHpay5MUhLMQI6N69B7Jp4TURbdYA0wB/h2LeUP3+awH3mMWRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451316; c=relaxed/simple;
	bh=nlnModm/nh8jhdOfTEtIpVQMLUVqOsoGH0zWuZRVCpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTqfFcM17df3rn+laqiEvcujQXyr1RFc3v4Cgm4Y7VPyZyiSYvI01PddPdhbQAW1y91OlH6AZWDmwW5ss+n9eyYUxEFPHwx8AByA2D1XhlT5UhtO5yEaQgE2YqICh58mw+6hi7Nf3mEet1+a8/zeGjzouMzcha6WGGYKhaGhw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5ce2f0deffso719238666b.3;
        Thu, 23 May 2024 01:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451313; x=1717056113;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Fnh96bQQ5jVRR33oS2zRYWhPgFRRVaEEjkHx+ZLc80=;
        b=GgV8ALKVS6NAVR1xPJfkkD5HG/VH/t+wwaI2TXeSvXykQneULOfRuAOm8YloPu3lO4
         TRuSa3KzdIti+lEU9fcAU/REluj7jhgF+cDDKET51gZo4lhs1+YmWCvt4gB5V1e6v++/
         vxj286C/N7NOfdJcYS2FOklaUDoE6QrOb4pCyakjsb1PSxX40IIansxOHaEsCa1sWwmV
         doW9JYjtRlSGlLN4040Lx5OFFce7XAZT+QCvnz8T4JdXZsXk9FDX6BHzMuZNxbyF6OiP
         Y/1TuUXUG8+eIytFuoDcq3wTUMBAAJxKiIAHAmPxyQxvjub3QgwG7jpeGkQkKgiKGDI7
         3slg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqvDednmrVe6aJTjbv1CygjiXwUkyf1GrgVoTmbbOsgeZGyksQzTCzauGrJCp71foWlaFM2CuBpGMcHAI+3WphsBBzvw3vfhaRNUx
X-Gm-Message-State: AOJu0YwnlmPxLj7u+EDwZuiEKLrun2+Avw1YibQLY4rMZkaRQ87+lsqC
	t2ZPoMe/ITQXAAA8W6Xf9EfYcSQeMPbLzEnNT5B2hjDD0vQxxX9eWbYK3A==
X-Google-Smtp-Source: AGHT+IG/YUdugBTFOJUazBlYCJ0eMIctvjpLqXuK8VrHWrQWdx9m1lGfGZpl8Yrl7RF/bCc8L8VgaQ==
X-Received: by 2002:a17:906:b89a:b0:a5a:8ac4:3c4c with SMTP id a640c23a62f3a-a622818d912mr219122766b.68.1716451312669;
        Thu, 23 May 2024 01:01:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a61b5080f6dsm532969666b.43.2024.05.23.01.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 01:01:52 -0700 (PDT)
Message-ID: <93ace08e-deb3-46e1-b318-18aecc210a85@kernel.org>
Date: Thu, 23 May 2024 10:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: N_HDLC line discipline: Race condition
To: Dianne Skoll <dianne@skoll.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240424173114.035ddd7b@gato.skoll.ca>
 <20240425140127.6504ade1@gato.skoll.ca>
 <63a5a3c5-8362-4b93-a50e-10c9cdcffdd2@kernel.org>
 <20240521101435.0b6b3420@gato.skoll.ca>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240521101435.0b6b3420@gato.skoll.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21. 05. 24, 16:15, Dianne Skoll wrote:
> On Tue, 21 May 2024 12:47:00 +0200
> Jiri Slaby <jirislaby@kernel.org> wrote:
> 
>> I believe it is a correct behavior after all. As you use pty for
>> testing, the "framing" is lost during the pty-to-pty pass on the
>> flush to ldisc path (receive_buf()).
> 
> That might be what's happening, but I don't think it matches the documentation
> in n_hdlc.c.  If you read the comment block near the top of the file,
> it says this:
> 
>   * All HDLC data is frame oriented which means:
>   *
>   * 1. tty write calls represent one complete transmit frame of data
>   *    The device driver should accept the complete frame or none of
>   *    the frame (busy) in the write method. Each write call should have
>   *    a byte count in the range of 2-65535 bytes (2 is min HDLC frame
>   *    with 1 addr byte and 1 ctrl byte). The max byte count of 65535
>   *    should include any crc bytes required. For example, when using
>   *    CCITT CRC32, 4 crc bytes are required, so the maximum size frame
>   *    the application may transmit is limited to 65531 bytes. For CCITT
>   *    CRC16, the maximum application frame size would be 65533.
>   *
>   *
>   * 2. receive callbacks from the device driver represents
>   *    one received frame. The device driver should bypass
>   *    the tty flip buffer and call the line discipline receive
>   *    callback directly to avoid fragmenting or concatenating
>   *    multiple frames into a single receive callback.
>   *
>   *    The HDLC line discipline queues the receive frames in separate
>   *    buffers so complete receive frames can be returned by the
>   *    tty read calls.
>   *
>   * 3. tty read calls returns an entire frame of data or nothing.
> [...] */
> 
> Point 2 says that the driver should avoid fragmenting frames, or concatenating
> frames into a single receive callback.  Doesn't this imply that frame
> boundaries should be preserved when you read() data, which happens reliably
> when you add a small delay between write()'s?

The driver definitely behaves as described. If the ldisc is used on a 
real HW. ptys are a different story -- it's not guaranteed there. Does 
it make sense to use nhdlc on a pty pair? I believe not.

thanks,
-- 
js
suse labs

