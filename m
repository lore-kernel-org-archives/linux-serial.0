Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710403;
	b=sGdCq09q67N4X5H9DYMD1BjV5qbeIzJSBADFRtqLWiZVCWnkjmCtNgEbT5Z6HDDGYfR5
	 MSEBdoKcoP968ocsvvhFs69L+rkVIF6XzdELtVpQsWapzjdAutcvPFe4huiZcotBCddAb
	 mgJF5ox73+VrfDmsPAjPKYu3+YwCiK0Crx4HcFB7mxUdLaVhVG9MO+6thLfEsFSd+CabZ
	 9rzey1qxi50ziLQKCWdqlJ3v4Zt4K2UqNACZgQAwDoB38uoIfutTFHEgQm+9y6m7029WT
	 uIRrTTcpVvz/DQ6bUTnkc9YAm49Kz6Sd7VqTCdqxUW3Uk3EbIExsu+Q38aSBe4QE2sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=b5z0ThmhKJxf+xijCxTwHDNcpYA1yXMLZrxPppTehao=;
	b=5Vz+Xqf++Gs61KZYSeUb04kdayXuUbnxfYJSpiE6cXKtTRvMdUnfKsz+/7ylcyYXaTSR
	 XQRL7anvgT8IeZtyvceQbB9ZpGrXcBVJDsIZB30s67b1YOqefY0ZWf/gnWZVy1RhPKe8F
	 zElJUDG9uCMemJrLDe2ZQiz4ZaWNAtVLCflNlZ0lMUebV/Edh6qN/8gL2HGqO5BwHa7og
	 biNdGQIhTpazhEkTEd2BdGiqrX2HCOfXk5+sBkwyQeNqYpSotgzT9E3OR3K3oswwNXoGp
	 onoKx6VIoT89XD1DTWwwYbDcVlMT8hDIR3MYV/Qp8PVwkgGssBvZWuIAkg8W3Is1r1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWqOYqNw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19143606A31E
	for <linux-serial@vger.kernel.org>; Thu, 26 Nov 2026 16:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19143606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWqOYqNw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so65468975e9.1
        for <linux-serial@vger.kernel.org>; Thu, 26 Nov 2026 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710401; x=1796315201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5z0ThmhKJxf+xijCxTwHDNcpYA1yXMLZrxPppTehao=;
        b=OWqOYqNwfRknSLG3Ui2p0CUMzmdffJ+xpc+fI/s2lv1UICyhWkc3eLDOBEJSzgZMed
         nKtBmDRBiVQC9MZJO84AP2i3xMlqHNlE3gbIFsr8q1yHaPFP7NaJfe0rn9Dev5F69Yj6
         p8T8x7I/4eD7VYDem3U1pZNyknc0W/H0VT3whFayHTw5d49Z0E1sx0l0D91/VC++UfiT
         EwNG3NVm6B7w4t4QzEMklUQ+1SfKrm39ZguERfr9VStotI47k60AnOsLpuMtfG36fRla
         mkyFIqiFYyRKFnicRBSrmEO7hAmYVsPtvVwOyuD4XQC+cWT6022skyvMewx2xRmdeh1O
         Z/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710401; x=1796315201;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5z0ThmhKJxf+xijCxTwHDNcpYA1yXMLZrxPppTehao=;
        b=dR/JC3HVbjfuNQvKAaGTu7Fp5rzcDpcFdiCZPULpJHaEBlKraLFXx0//yAbdN0hZVX
         Zu9ZeJ8h7Cxx1M8SKvgNj7QWp70jQLxgG7vU3U2mayPWm+/9N81fKLPfzDR9Ei4qpUUN
         kcTmfBz/manW3MSPNQC63XvdlenLmZwcMitYHC4m+ec3UpHbDD8uLTE27iV7AOaM7xP3
         sBWYFnmaUK/2v69Apsr+Qw/M0dtVlK1jr4TKd6zl1vDEwqxYmbyOECJAotPYz2Tdfiri
         lZ2v7p7BOCim3wZkqKnmk4ylp0M2esuJqm+1bHrb3jyjMPrkKTTpTtXuoxhweJUkttQ7
         XDzQ==
X-Forwarded-Encrypted: i=1; AL+hErE6g1dHw7/R98goF2JnnishpCilpUglFelCAv1rNvotmNTapilAW7RPgmtlRjJin5Vm0JZ15iQvQb5dptI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SL4R980XztNI7siHJU/kBIRnsz3c2/BhUj2uICNllLoQYTC8l
	Yw6SxopLZP4j8nPwfldmTtIqSMc0fa2UMHWPLnLWOK38ow+rnFGGIGw9
X-Gm-Gg: AZFdTZf3rygegBKfYSq1vb8eot2CFOcAaPaWPFQ7Y/Ed8slr1+CABMIFHn27JTLZie4
	jGVVO5OfxPPaonmSaURKQ8S3uMGlpbIJKvoScWdIsYFPm4AdY7GsBKEAv1fM9vOJ7nWHeVKRM6Z
	vGu1vcXUif7HBGVjl5JNjMHTbF8p0RIooskaaEs2W+2qD3iPKBbVFOv+SEpnnjN1N5CUNXKo1dh
	mJyHkvlD9/biPTRHIEXO2yBvH6SBfDUHzq35/Tze8EQP0HQo0+s1hIJsgRo2geaTFklDs3lmRho
	bSQqz3b6gFw9xhmRltH1RAK0kMLQ2FdOIdJeqZa7TC3sWX6UzhZLHm5AApZQElmtYdAsQw5DD4Z
	+1L9sS0uJEZiUMVR1TidMSP/iUTaYW4+TII72ARewiVXslYgI7DrdRL51NgOYIpCe0nUwrqLvAc
	wkPWVYO2/8e8jykdxFG70k2FIlXoUbkDwy+tOn+V8MfVpiY3ZvHyXWytrobCPg+0txlinKOC8sL
	wTKFwawrQ7fgazaSGVS7I/9U91vtLSuJD7R4T/h7uHW0FUrdCnDcZIsOzO606UIax9JoDdpbh03
	jW7sRb0RG7ptf3w1TfN27gfRc1eJjtxpiQ6lAJquAix2i1eEhZxsQVz/06dRt7dl325BlHTjU/E
	5iHd6Pw==
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id 5b1f17b1804b1-4bb8880f0e0mr442079825e9.5.1795710401231;
        Thu, 26 Nov 2026 08:26:41 -0800 (PST)
Received: from ?IPV6:2a02:e98:40:8091:3818:6731:d35e:a255? ([2a02:e98:40:8091:3818:6731:d35e:a255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm574510785e9.2.2026.11.26.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:26:40 -0800 (PST)
Message-ID: <ef3ccabd-5093-4ee6-ac21-20e08b97b510@gmail.com>
Date: Thu, 26 Nov 2026 17:26:40 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: pl011: Reference rs485.yaml
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Matous Hybl <hyblmatous@gmail.com>, Miroslav Ondra <ondra@faster.cz>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20261121-pl011-rs485-v1-1-0d18008f4a12@gmail.com>
 <20261124195705.GA3075022-robh@kernel.org>
Content-Language: cs, en-US
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <20261124195705.GA3075022-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Rob,
thank you for the answer.
> On Sat, Nov 21, 2026 at 04:10:33PM +0100, Kryštof Černý wrote:
>> The amba-pl011 driver supports RS-485 and parses the generic RS-485
>> properties with uart_get_rs485_mode(), but the binding does not allow
>> them. Reference rs485.yaml.
> 
> Is supporting RS-485 really specific to the UART? Can't pretty much any
> UART support it? Whether a driver does or doesn't doesn't matter. If so,
> then serial.yaml should probably just reference rs485.yaml.

You are right. Some hardware might not be able to support it properly, 
as it could lack essential registers (you need to know when the 
transmission is done to switch the direction pin), but I do not know of 
any. As I understand it, these properties describe the attached 
transceiver and its wiring rather than the UART itself, so they belong 
in serial.yaml.

In the next version, should I then reference rs485.yaml in serial.yaml 
and remove it from all of the other bindings?

> 
>>
>> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
>>
> 
> Drop blank line.

Since the change would then move to serial.yaml, there is no single 
commit it fixes, so I would drop the Fixes tag as well. Is that OK?

> 
>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>

Best regards,
Kryštof
