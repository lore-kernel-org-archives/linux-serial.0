Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAF34CFDE
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887102; cv=none; b=nxEr0BzIyB/36aYP3t/hB+8S6IGh8WzwT/BYMMYBp2qeiGtLspgz/YvtjBY20O9xH8k5QnIYbQQbAPBSkXhqzjGkT/c1Y+xvIFtqELOewM9wHG9ULJv5KxlqfUUpR+y1nCk9UqZNstLNTJTRqaF2B0TV/UlHFnQoPdTFq5CwoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887102; c=relaxed/simple;
	bh=pIo1tgaaINM3a3WYKaO6yshb5UUg8B/f5DzqFKT7IZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=XQsaKF9Yl8BvZyGtTTIjxEsJ9lUY7S/mPWji/vLIZ7yX7ksfr6Kbki1TEWfGoV/MezOB48uR4Cu/GM/qxkw3GnBjJKERtLH+xZaBRFY2Ha9Zivt9eQV5m+uBA7PDlXCIslhOWi8JZUu6f9fiRJJstx2gMZwa0erqhXtEYayYhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgCsyZ59; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgCsyZ59"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0f64df6a6so3155417a91.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 13:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887097; x=1791491897; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VIRDdFryvNABkvTz90F+SziqY6Mo856UvSO3Z/Ye4Ro=;
        b=qgCsyZ59vKIFzQ/Z37mA1Niu3be5KDI26XlGMWqawuHVUPt1fCWe/tCIX+fDFPLwyC
         qx5sPWNomh67SLBtie4GJTa1lZMfAFXVFqHPfx4iZ/Qiexz5vS1FbWVBayPKKp2GfEUi
         EqKAPL5ECRwki0nc/JT/K/H4JfTm+G5drwZgu8McHEyte5m7JjMc8+i8EskinHmb/xyo
         lMwi1FmTl5WOwAeFwZYe5L8u56jiuqYXkXknZDm8aiBahDxzym6EHoGTc7AN7bT5dfN0
         RF2B0U2E5O9PcCtyfVXyJLnF853Z19mdIpuJEbw4L8l1ps/Wj3Q5gupAd5VxgdoyWNYF
         zTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887097; x=1791491897;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIRDdFryvNABkvTz90F+SziqY6Mo856UvSO3Z/Ye4Ro=;
        b=PCAVvNU+y2WhSkQARKebOpQbe0+VDcLZZOM8e68Bb1in8JeJhHQWfNbqBizuzia4Xw
         IGR1iOGYalaKPFlvjIpacr7T3x7pEhULqK8jvv/l6sPHxYRw1iu3W5TBdKvmGXMMC89U
         goVLHCXAzF0/r/p1AwE2eo9acyFJNJY2uVhWDuSUZUNpgdcmuLwX1GAPE+Ez79k5Daq/
         jlHpY9TI/+kzKQAuYd1o0EbiF9eb6gTvY3LObUH27hhCQ1Oisn7dH1cGMt4uAA18sAjo
         6Q9F3JnH84fVbsjNrLxnTBQ5FfkDzsKI8mID3f1hRAGlQFeowIPy8toP8bsZgComaMWU
         aMlA==
X-Gm-Message-State: AFq9FYKLUvmscVMDMr8t5ZPGFUWXZ0pXRi2eFJi9j9GzrePGKIQXpjna
	bQ+YYFWvLgDdIrMsLvHinmC8WsXGXsAJ1677Oz0K6v9BQcVbw/VkuTaB
X-Gm-Gg: AYBFou0K1RKNILYeMcG8ueran2wbrDQv8wZPMNkJPcZaZpXmB1l0OfjGFFlNNmnjSiB
	ZN+174/0BHshTtLUuQGz87YT4jk7WRhBoZVXWF8dn0TNPKDbIlvHrz5Dtl0RneKOC1ulYzIVh6a
	8eBpM9aPA7+NbSaUJnN6qJtuCEXm43OjNiyH+mT99ScG8FLZc/1CxV1uk/dgESu7WtWum70rgfl
	jajQ5XrNVQI+mxUPFKZz0cTo7v6EYeERzhZbfEH9GO14nvCmLo2iNSgLZKCilu81fWl7c+x8W05
	3jqZsop4ivbXZHllcBwYypqjQdxG5iDTBmqAIHm/vqZWI1wnt3jWTf2kEuNKhg7bfvp1Sm/uIYP
	m3033zXIIghmET5ukXLxSQyQdpzOiajfwsqfeso5nqX43VuIasYrUnpqvkiqFuHnl5tgzifQA/N
	wqXfiHDa7vHn+KKkVnldXyMF1QXRnaSFMLAnzp/QR+3ej6higY0VyM+ML7ZC4o+tYFG8tI4Fyjw
	thpOkud9iKhXPFHs/06UD/t4Q9Lh/5WYjqeFlHGFWf9H3P7gri43z0fgDBv7CChLMP1Y8U2uv4v
	mXICHmw1NWbsohklDFwhwgWTM3HVXBYolbCuCQKYMJd+aP4rwsfNe6GVHVw=
X-Received: by 2002:a17:90b:2583:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3a6cec53ff9mr594696a91.26.1790887097188;
        Thu, 01 Oct 2026 13:38:17 -0700 (PDT)
Received: from localhost ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dcdac9f7sm89248a91.1.2026.10.01.13.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 13:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 13:38:15 -0700
Message-Id: <DLTSHPPY40S4.1G7I24UTEFX9C@gmail.com>
Subject: Re: [PATCH] serial: cpm_uart: use irq variable for
 platform_get_irq()
From: "Rosen Penev" <rosenp@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rosen Penev"
 <rosenp@gmail.com>
Cc: <linux-serial@vger.kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260925181530.52953-1-rosenp@gmail.com>
 <2026100157-unleash-anime-e2cf@gregkh>
In-Reply-To: <2026100157-unleash-anime-e2cf@gregkh>

On Thu Oct 1, 2026 at 1:46 AM PDT, Greg Kroah-Hartman wrote:
> On Fri, Sep 25, 2026 at 11:15:30AM -0700, Rosen Penev wrote:
>> struct uart_port has its irq member as an unsigned int, which does not
>> work when platform_get_irq() returns an error.
>>
>> Use a local irq variable to handle this and write to struct uart_port's
>> irq member when platform_get_irq() succeeds. On success, it returns an
>> IRQ >=3D 0, which is representable by unsigned int.
>>
>> Fixes: 831603b3e8aa ("serial: cpm_uart: replace irq_of_parse_and_map wit=
h platform_get_irq")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202609251916.1XlVHLwd-lkp@=
intel.com/
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>  drivers/tty/serial/cpm_uart.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart=
.c
>> index 39f54bb7b485..ca0acccd3dd8 100644
>> --- a/drivers/tty/serial/cpm_uart.c
>> +++ b/drivers/tty/serial/cpm_uart.c
>> @@ -1517,6 +1517,7 @@ static int cpm_uart_probe(struct platform_device *=
ofdev)
>>  {
>>  	int index =3D probe_index++;
>>  	struct uart_cpm_port *pinfo =3D &cpm_uart_ports[index];
>> +	int irq;
>>  	int ret;
>>
>>  	pinfo->port.line =3D index;
>> @@ -1524,14 +1525,15 @@ static int cpm_uart_probe(struct platform_device=
 *ofdev)
>>  	if (index >=3D UART_NR)
>>  		return -ENODEV;
>>
>> +	irq =3D platform_get_irq(ofdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>>  	platform_set_drvdata(ofdev, pinfo);
>>
>>  	/* initialize the device pointer for the port */
>>  	pinfo->port.dev =3D &ofdev->dev;
>> -
>> -	pinfo->port.irq =3D platform_get_irq(ofdev, 0);
>> -	if (pinfo->port.irq < 0)
>> -		return pinfo->port.irq;
>> +	pinfo->port.irq =3D irq;
>
> Why did you move where platform_get_irq() is called?

So that platform_set_drvdata does not get called on failure.

>
> thanks,
>
> greg k-h


