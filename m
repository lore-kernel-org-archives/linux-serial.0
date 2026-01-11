Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFF54654
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142804; cv=none; b=M1hAWIsvGEmCWM0yfVJJA6PNPoTVxFWXIVI0exUuPksMYttqYsq+My9k/ZZ8HOHafp6mq02xhiyWCO0vgopfb9nicQCV5JO2ihkWIUTr/0xbVxLPUroceEfuyarse4icBDAH1Pp1nPWEmHhSFKJPLxeWYlmQpiPKy0oFcM8VwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142804; c=relaxed/simple;
	bh=L2SAqNmu61MHKLD0agICr57xkRB0iGTI91g9rMmmRgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPgyJmwsblvn7ILVJXee8+WAbfPUYdtL/ha/D4YCrWoPIhhkZ2xdxuwg4Fv2MRGgn1sHoJOXyj8HnjNFVOssMI/5hZIf+2/Ep3O1vkZ+ydOkAiJVwNq2N7XuHx4G+mxvoYfcOcfGCby/2/MZJtFSoXnWQ1NWj+LMmQ9laHSEmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qam1s0sk; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qam1s0sk"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so9507808a12.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142800; x=1768747600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=998LIQD26tTlqKe1Nt9hPTV8z5SAR5Xb1tsWRfDj7yM=;
        b=Qam1s0skrMJn1KfWZxSe96IKP81h22WhBDibkbxgWIUwpBSQNSN536T77TtojW3nxq
         kLFoyDPha3E1j8A98VyQxWws3pi3XVHEjYrLvuh2AjL/vNPcDkas+WMRnHVItePkIK5p
         yjOS8EtefDgl07rBXwJ/tP65Y/Vw1sE6EhWNK6+VRchLP7n6emPQxYYi/5H9xtlL6/P/
         ns7a6XFDQO9GAFW8hheFyqWsQk6Nsce0VyXmYi3J35Jk+Y3cTtzFIsWLZLPcx+gnyCUs
         9g1Vv5mta+IVdq3zoLjpJHhxhqt9cTIhUzchJVlA7JHMdhTyomaoN/CV+gPsigwenQok
         wOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142800; x=1768747600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=998LIQD26tTlqKe1Nt9hPTV8z5SAR5Xb1tsWRfDj7yM=;
        b=TbeE40SxnRCW9zQm/ehGs8xsuQ6f2lNS8Qc+FtnBkd1lWdseBRkJl8D4MVK9Tk8e5Z
         +8l0pdEdtd8JQeApCsrOzKBBLmxeRFctLCJn15mCTxAu05edyyp6XGNC6oTO68BL1bpx
         v+W1GEk/7TE4baRTa3Hz2RffAXPvhcRTqeaxUf+Gm1aPnd51loYW6lqzKoIlpfWAMhY0
         KETXEcbGHaBX3QHrRcaPWdDXLQ7XBDR/AwzagPs/r6tjhKYB7PVVJtibNTXKuKEY4Kea
         EnYyjbboYnEFKZ2A3jtCtNmrh50ISNm2XSNnQStmuEMdEDd6ui7DyVenfpG/i4EIthWJ
         Zd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYBCFD4/0gTWHyXPs3SGc89q+LSXsp18L/x6b3t+vJunHWzUlrzOWsTAK5mri4VvOx77tFrvj8GP8SLVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wGWLKYy2jJh9oz4CmihoxXArq8c+cqulTNJoPr6gjIPIUM7d
	TwJ1jeTAchHgvk4/XzfPZQPoVG5X95Wzp1pH8G+vpNbwfpe/GJZ3aWgf+9AvuwJzkK8=
X-Gm-Gg: AY/fxX5eu8KS42W0qcniS4UUEvoGnQh/P/ks8gLKasm1vlP1A4YWnm4T7+HjN2Bysdc
	3PZQTS9etL08pPDeUUOuf6ZN4RWfG9hTN4I+UcLwWvqoNh1QcbzhnLrCv4wNsMQqjyOyQ+CIN0A
	64aJI7FMlNb031ZQzk3EZPZK7Ra6R+cX0fL8AFtoTbr6YM/R3UnSqZtPnLtFMWjByp97wd1rImz
	QVXblmd7gkabq+uYgnNr3sQjbzt1ByIOFPsOvk+xkLk21btn+Y7miNj+rsBerBGDnC1L7Y7Q6kI
	6v2VCkoYMdBYEoLm3Nf8/9+jZqR2SFFqYbN65VgDVy8uXeR8sZupSm+JEoENuntjaoGl9TSFMQq
	PAbcmO4cpF6K0Q1xWGpIqNoZmqn5dgsK2blsw0/3Zy5FehLb2+Zr/OyEJQ/NVPHuFIbNecYcfHy
	BneqGkKrTEv41iJWi7xTOCuao=
X-Google-Smtp-Source: AGHT+IEEnxtsLJjgQBqtCtTKdKKJ7nKe93tErDCONdjzSpalyD4Cf1jf8cogFFk+Jwao/l06OHgHEQ==
X-Received: by 2002:a05:6402:26cc:b0:64d:498b:aeff with SMTP id 4fb4d7f45d1cf-65097e8e49bmr13880469a12.34.1768142800347;
        Sun, 11 Jan 2026 06:46:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d4acsm15318996a12.30.2026.01.11.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:46:39 -0800 (PST)
Message-ID: <0ca4477e-cfd8-439f-946f-9d0205b62c6a@tuxon.dev>
Date: Sun, 11 Jan 2026 16:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] dt-bindings: arm: AT91: document EV23X71A board
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-15-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-15-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Microchip EV23X71A board is an LAN9696 based evaluation board.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
