Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1813C3CD
	for <linux-serial@vger.kernel.org>; Tue, 26 Mar 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482555; cv=none; b=Lvwa9g1VXLRRyqiEkrecuXkFLgiKhSyZO1WI66SkpFG3aivjVGawSp47gMg0fLYZ3qAeGj8WuKp+nfS8DnwJTMBjBZNEo3Y/YG7MP29cSWAVG6ubi3kpzNYo7PcO5fwtB1vefqowXR2siJMBC/CISVJmF9ype4g8h97l8X5Ybmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482555; c=relaxed/simple;
	bh=ckIAyLQl5mq51v12U33D/Ha/ZKgjrWdTuDjM1X+ZMIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uun33jBQVxeeT/Jt4F3p9l3UaHsvGJY5CADw0KhrTHU1QyfZfLgi78wxsOmSqt1OKTfc/Byp8WpS1TTCGc92Th6Qx0IMbdets6e7v4zdYd5v2Lf/yzjm8+BU0nODmH6XX+LDSPtyrK5eN4EdOXDNzcPYR/W3jHXNfwfvwUQX2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXaoxIQq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXaoxIQq"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso45286039f.0
        for <linux-serial@vger.kernel.org>; Tue, 26 Mar 2024 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711482552; x=1712087352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiANCJrg/wRMLPS+Tm1vUgemn4LO4mSL7aK+8H//EqY=;
        b=WXaoxIQqaM98i2aCaKG1CXVdG9T66N85m1rd1MIC+bgH4UtyblpZOLcuoRLU5fs2S6
         gErkcytQbU7zfdmIQpomF3Cr4WYps6zspV9u6+QaPwVpeUQkrEk4a5Xi4VOeRHR2XiE5
         Xd5gG8fCYdeNpJl6bKwrwR4sLswTH65TYFKNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482552; x=1712087352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiANCJrg/wRMLPS+Tm1vUgemn4LO4mSL7aK+8H//EqY=;
        b=cixMnK8Yph7B+j1ELtn/yY1Jgsx0nhgErZYY+CA2U2fBOwWRrFjRo5uHnnu3BJhQeB
         79MfCAG3kwF9vw7OIesbr5IxUkIEE1ybkF4btwM+b30XkzdDoIGsx90jzCx1FOwD0MIW
         5Ntqmx5bNzQuiZdwNKx1USLVqENl68MfObBSxVUrNeZTPQY9ZkWhv2v/oK8LRciE2Pfa
         p5YSakAGlz+VoJkyXWdua9keViurYbP4cBtfMeF4czQDDgzcOGTLXMKWdfWMDoZMnjuw
         qQMyxzm90EV23+suZfQwUM9f6Ocq3S4VO9YN+7YSpvfAXhm/Jm+GG9qzKVwi3NvyDfl6
         cmBw==
X-Forwarded-Encrypted: i=1; AJvYcCWWaydtt6SwBoau0vGrD8jkve6ylhDMo72ojx3K3ltotzMVCQtYdFnl5b+U9OxN8c/1cWE9TYz/g9E78tgaiWUJNg/XLfV6peCnRAEH
X-Gm-Message-State: AOJu0Yw8jJLBJomBJn8CeuTgmJu0ZeJMo6b5nrUsn/LLxCxYKv6Msxmg
	4xwn7mxUyF31Jf8DDKn0eVSC+JY0bJSn+l55R1b0bwGoEv7vh/1Dy8ULuc8CsZtxK4JouPoyT5F
	9
X-Google-Smtp-Source: AGHT+IGa8PwsF4Gc4Jfzc/5pVDeCx6+YWmIQj5bTrUxyJHndqjf4XpTOeOLeEaqgdiSKQz2W7xIYeA==
X-Received: by 2002:a5e:834c:0:b0:7d0:6728:66eb with SMTP id y12-20020a5e834c000000b007d0672866ebmr3473863iom.1.1711482552185;
        Tue, 26 Mar 2024 12:49:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id eq27-20020a0566384e3b00b004772b93a134sm2824161jab.3.2024.03.26.12.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:49:11 -0700 (PDT)
Message-ID: <6b0e9e08-62c3-4fed-95d8-185ceb4ce67f@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:49:11 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kselftest/tty: Improve integration with automated
 systems
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
 <2024030633-managing-identical-9b92@gregkh>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2024030633-managing-identical-9b92@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 15:51, Greg Kroah-Hartman wrote:
> On Wed, Mar 06, 2024 at 07:21:24PM +0000, Mark Brown wrote:
>> This cleans up the output of the tty_tstamp_update selftest to play a
>> bit more nicely with automated systems parsing the test output.
>>
>> To do this I've also added a new helper ksft_test_result() which takes a
>> KSFT_ code as a report, this is something I've wanted on other occasions
>> but restructured things to avoid needing it.  This time I figured I'd
>> just add it since it keeps coming up.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Thank you. Applied to linux-kselftest next for 6.10-rc1.

thanks,
-- Shuah
