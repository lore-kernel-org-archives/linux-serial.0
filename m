Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32BF158864
	for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708730; cv=none; b=PCqExTZcKscKiLmIpu1GHutB+joghKv5S74WWSnw+Hq01gnn+/prB4DCOQHMOVvC+4elM2HZWSh7R8pOIDTKunnzwGEA20OlXt4Gn48kjKc8BEP6jUHnE7wUtFqW1Bv1EeKSOknF7wHVw+u9eyPsKBUGKYjglQLfqPEj7G1yFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708730; c=relaxed/simple;
	bh=qQYAU6pzROoBuuHRkqrRKpetO1lSkUzkb0VMCTaossc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSwPX2FU+pZyLpk83JrlPUCi0kuh5KSrv6qm2Njp2MCn1xlZ7yrjEHmXFJBa78/WVu5JwTa0H++9kE+xXd1ttBpMKzZ8KY2Xc/p5+b7bDpzIDllKLHvmLA1rhforc5Qa1WjEj+M/D2xGkDhfc04Q8pqByx9pjiHfo5JsFWmwkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=ScEvaDqv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ScEvaDqv"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso4813123e87.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2024 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1718708727; x=1719313527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQYAU6pzROoBuuHRkqrRKpetO1lSkUzkb0VMCTaossc=;
        b=ScEvaDqv1yivkTXgchmNJzkAAKEc6IBRtJyP9mOp8b4A/xZ6fwK6FJBssh7QFrtNxA
         Qsd4DVKkdsgD6bWMwGQXZp2wgLHHT1j9BJgFpvlnZBf8LVB1lViGfmYyZQPf8PQltkdX
         oJaGQ1h0ekK7g49ZfT5OsEbO/mRxpYBXVRLXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708727; x=1719313527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQYAU6pzROoBuuHRkqrRKpetO1lSkUzkb0VMCTaossc=;
        b=vGrR1iB6VdcrPkwqTom1p0G2SIpmY5iMU/AXxdBNksictPuHZdEcIUNYArknMMO1H0
         9hXngputUtGlSYL8AW8gyWd1U0F7zONTOqEuGUvkEND/1tDg8GgiKQ+Z9pALui0PiyWz
         AObxHrSot8n5ecq5DBVJjXxgRDVdfWvhPrJqYMZG5Ql8hTVShgzzwty3bQzsqN6BUkg1
         HviFzLkecgDukkrR4FwIwIp9H6kGFz9ST9XTcMk1Qc4+rslY+RhPtwyuP3wUYe4xa3pq
         MSBXFCSkTmIYm4OuH3mMb0M0AdSYdA/MCchfGVvzu+Fk4DtZi/FOfpvyGqjoAH0Giz7H
         oTGA==
X-Forwarded-Encrypted: i=1; AJvYcCVya82Al2n6c18WvIKUK8kZ/VgZu155ClWn1hFlN8D7GYNbNEiW584f3TAqWhekWevk3RQun5nMbBmpnzFIrY/JBFYRxa/rRbNlm/QN
X-Gm-Message-State: AOJu0YxT3aam5DYRd/MxDvqA6J+ndvGEs+LK71RBHDxcce4xzKwoi8FC
	DHb3q6Z+EhVwZkCWZRF7Wsy4ycMBBVixWeOTs8itpdWzHBKpTp8eKKcyxIrpSMI=
X-Google-Smtp-Source: AGHT+IFNlsfM3APxVmAxEWghwl5cNejfef9/uKTOCWJh/jMtDLGzSKZtnGgEwqQDQ/JYkfU811H5yw==
X-Received: by 2002:a19:8c5a:0:b0:52c:88d6:891d with SMTP id 2adb3069b0e04-52ca6e5637emr7505157e87.9.1718708726703;
        Tue, 18 Jun 2024 04:05:26 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28722f9sm1481146e87.167.2024.06.18.04.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:05:26 -0700 (PDT)
Message-ID: <63f0a3a4-f1ea-4b85-afde-d7b82bb95ade@rasmusvillemoes.dk>
Date: Tue, 18 Jun 2024 13:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: ensure RTS signal is not left active after
 shutdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2024 14.12, Rasmus Villemoes wrote:
> If a process is killed while writing to a /dev/ttymxc* device in RS485
> mode, we observe that the RTS signal is left high, thus making it
> impossible for other devices to transmit anything.

Ping. Any comments on this? I'm of course open to discussing other ways
of fixing this, but I'd really like a fix to land in 6.11.

It reproduces completely reliably for me, and I assume it affects any
board with this IP, not just imx8mp.

Rasmus

