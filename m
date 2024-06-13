Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AC79C0;
	Thu, 13 Jun 2024 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247257; cv=none; b=Bt0aqMvXZ+Cwm2uIDNCkdrbu7U6hua/0+dvn1iQIhO0FmDCX1AV5QGQOJmmXSD+puR6TF7mFHQyWQhCuOoiCOtzliq8Ls6N3DJOfAqopDam8DXDYZNSFH0gBwM8oOP7dbjhP7N2I9lv05QvX4xjXWQ2V293yHcESiH/r1vwNluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247257; c=relaxed/simple;
	bh=832EzqDxWJ7nN/P5FfuAYp/Z11o7CeTnyqHfsasbrm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYqTR1vO49Zdee4HsuPe5qYrSg6yJgTzKHrVYBAQpw3J4h+CToJUkEp0W6fVs5O5sPTX35IzmV1K2VJeB1kXxekLVuKH6ZpWtOS3mTCXSxqr4CqCDJgLZaMjTyfTsgUjVfpPq30J5MC2uBdcQtj0nZLaRUKdOX4X0w7o8VYNRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKvjd8qb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKvjd8qb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-705c739b878so756530b3a.1;
        Wed, 12 Jun 2024 19:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718247256; x=1718852056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNmwMejHmNOh8I+RARUVaSfw/MphRluAD/hWf+7EyHM=;
        b=bKvjd8qbuqszAWGmOoB8PwT5G3E+mgOFJjf5siuVPSY4+hmxgnTs578I6ThWgxMhpi
         yov03gOC7rwMeJDjoRAX3E/EC6StGx6+jBv+2if1AdjMvzy3luqY5CUKAwp7QQX2GOFt
         PWcRFtZRXJ67ZdRWV4//Ke5zZmAQ7nv6T7hS1RPC+Womy0iqLpbqPWKTtldKtjUQfuUE
         01UMnc1tInL7CUB7PgjQXWgwLe30AdmTttJ04qQn0/31icNHdBjFyYdABqwsNnIXe7kc
         8rxfob/uYVl9kVTZfGK5do1s1mV1H14MbG7BXPYq4RRQ31Ddz8bcuGMJ/6n0NwmFuGbz
         azeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247256; x=1718852056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNmwMejHmNOh8I+RARUVaSfw/MphRluAD/hWf+7EyHM=;
        b=EtJY6GObqyYNeHUY/BozU2aDYJwg0UQDULSUcx0V2NI5qfd3p1BqDoiViZHQCVVyxY
         CVsJ0OabMV6QckLrntr/3fJsrAeJgJc+KmTGTtWpOTxS3mx/Q2gIR95aRRsP18A1HLnX
         NZ1+8pqFTBWCvs5kJswN57ADqO2j2lvPPNr8FzL2gDWnJAnyXR5tieG5KndZJrXqYFjl
         xkaC/aijqHvhplYtB3Xj1rO39taC+9ANLvLKmlN+W1cW4kAVcAjzlKSqR82VS2VQLB7q
         fIqKKIqayk4IvcZgDRpbWlamMDf4069GLDCftcyattdmn7Mewx/kpMoh5Ly8j2dYI95B
         8S1A==
X-Forwarded-Encrypted: i=1; AJvYcCXkpgiPRkczceBsP9V1Jlwcr9u2k3gW+NMaEM+nOAum3Zw0XxyDoZqImw+Vb7lTgFI3pbey+0ZoPnelEcdbqZYVX7QVPCzKaSQ5bY1yH+Rcj+5R6w7zgW+qTgAjWWb1aZKfUYcS7vR6yZVI
X-Gm-Message-State: AOJu0YyrtkjwAn+GKRuksAcU5RZ6wjAyqMjhjfXzrHXM6vZGGUgl9/k4
	tvfnKmxIfUktNetSdrqYf2xyjQTLmTH34eamFXZEYqb1CJr2ukAg
X-Google-Smtp-Source: AGHT+IGbL59FB/N0ejH67gB7kJ3RteUZ72f6jaqWjh8P39UHzwD8iyB1oIQqw4Is9dSdRe11OIbXhg==
X-Received: by 2002:a05:6a20:7485:b0:1b6:dc44:8211 with SMTP id adf61e73a8af0-1b8bef9e17emr2373909637.1.1718247255601;
        Wed, 12 Jun 2024 19:54:15 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc925fe7sm296762b3a.19.2024.06.12.19.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:54:15 -0700 (PDT)
Message-ID: <12baa918-2066-47b1-ab88-27d1dc6041b2@gmail.com>
Date: Thu, 13 Jun 2024 10:54:12 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: ma35d1: Add a NULL check for of_node
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
References: <20240611092251.159149-1-ychuang570808@gmail.com>
 <2024061118-sycamore-leggings-05a9@gregkh>
 <73d2167a-84ee-40a4-a68d-ba25229ff8ce@gmail.com>
 <2024061226-laborious-jubilance-8df8@gregkh>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2024061226-laborious-jubilance-8df8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Greg,


On 2024/6/12 下午 03:23, Greg KH wrote:
> On Wed, Jun 12, 2024 at 08:43:54AM +0800, Jacky Huang wrote:
>> Dear Greg,
>>
>>
>> On 2024/6/11 下午 07:11, Greg KH wrote:
>>> On Tue, Jun 11, 2024 at 09:22:51AM +0000, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> The pdev->dev.of_node can be NULL if the "serial" node is absent.
>>>> Add a NULL check to return an error in such cases.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>>    drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
>>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
>>>> index 19f0a305cc43..3b4206e815fe 100644
>>>> --- a/drivers/tty/serial/ma35d1_serial.c
>>>> +++ b/drivers/tty/serial/ma35d1_serial.c
>>>> @@ -688,12 +688,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
>>>>    	struct uart_ma35d1_port *up;
>>>>    	int ret = 0;
>>>> -	if (pdev->dev.of_node) {
>>>> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>>> -		if (ret < 0) {
>>>> -			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
>>>> -			return ret;
>>>> -		}
>>>> +	if (!pdev->dev.of_node)
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>>> +	if (ret < 0) {
>>>> +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
>>>> +		return ret;
>>>>    	}
>>>>    	up = &ma35d1serial_ports[ret];
>>>>    	up->port.line = ret;
>>> What commit id does this fix?
>>>
>>> thanks,
>>>
>>> greg k-h
>> This patch fix the in tree ma35d1 serial driver.
>> The last commit for ma35d1_serial.c is
>> '6b64f8e360c00f180cffa1806095cdd2abc55b16'.
> That is obviously not the commit that causes this problem, which is what
> I was looking for here.  Shouldn't you include a "Fixes:" line if this
> is resolving a bug?
>
> thanks,
>
> greg k-h

I got it. The  commit that cause this problem is '930cbf92db01'.
And I will send v2 patch with the "Fixes:" line.
Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver 
support")


Best Regards,
Jacky Huang

