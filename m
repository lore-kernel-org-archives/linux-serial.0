Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDC4C81
	for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2024 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067450; cv=none; b=LfQnIZDr+6tWGSD6h8FtrlH2tcQcTL7uPAzfOFi/dha4S/KH+g8XXAj9MYYIPF6c41BFCyVXAamaLLKxYaxZcHJCvX1BZzsgFPR36XMafaRYr5GfNsw92SAernZ39Rikr+95LzH8qMpM8658Z+eMUMRZNB+C0GwMMPRsues7FTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067450; c=relaxed/simple;
	bh=ByKE6Sj3HozTKHAlHbTUe3CoW8gPIjSwnmDryKhrm4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsdlhzUJfWxWKVptbdlb01ukiVlMI3xGS2uMtfxDRQ3FWC+Gq35m5UBv4eNUhBbqSalJ2NbC1Ri4UJAlhphLd/DEt60Pqjb0rbqg86qTaoElqUsYE/jKtzFEOVqyn0vgClWWPf+ukTeGu+0TyXHo3AOJvOAi6EuUsSYnuTHlNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETbFTPF9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETbFTPF9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f44b5b9de6so39972235ad.3
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718067448; x=1718672248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyMKwjdW+KEcqrwyjEhc32ykr3bSDMWski0OCuyYqIY=;
        b=ETbFTPF9Ujaq7poOCSnn1ZZtmpkK4RTMvmINIAq4fSRpTnYUVhoQHpYruYHYRfccho
         I4l9RJTAlJBmtL0evPyxepAfDrJEFirNCq6cPCJBuoSdMzCUtCbQ+N/HeeoZmj8IXJ/S
         vhcIK69a1pfMtvE73ok7BPpVA/zeOLo/otVewU46rrgF77p55OvbaG1mZn/F3kh6qq8Z
         MqiwDFMU6q/EAUSogBj3TKHK0eti0UAxEv1DTctemvTx/c96uzHvxa0z2dsULYVQo1QZ
         LiO44aRLSwaGRlLDklawdaQTESiHyoO6CRnwA6LZ4HlX1LwcDbWGKrshEw718MNxTkz8
         TU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067448; x=1718672248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyMKwjdW+KEcqrwyjEhc32ykr3bSDMWski0OCuyYqIY=;
        b=Y86vSSeTPjbKfGXXXtP2GYeMGSH6JHNggTj0RtidyZ8l8Qbo7kjnm1oiyDuZVY362p
         HYt2gdc6e7WtxTYTZIZ2cIGRT0xoYWrokxoGjdqPpaMNZRAK82Wu3CEhDdJ8lWy38LKW
         2hCbFkFtEA8+QVeqDeBpuG3Chv8wcvLHkRzT4JeIZl24B758T6Ru0uAsCk7x80JQRoIG
         /qZkNj+IPmUcq/pyo1bl0vYo10sn/gkxeU9VrySGuevWRbWOig3tvZouOME61wxiXyf+
         92dFPi2r6xV43CD3MgtViCCx9ak1rzn+dAwrxl3uHNJOF3COvIoecRY7LFY6doRPX1m9
         Nbpg==
X-Gm-Message-State: AOJu0Yx92yBoffbe7tdUmyUiT9DeAWWRlzJODUK6Amo7Oz4WiSmDW/87
	ESDR3kiFt9y0+jNS95FuNIA7pVlAt6eTWqbRjrhQ3xUD646DAL9kiA0SCQ==
X-Google-Smtp-Source: AGHT+IHoh/api3nZEDEWts54FkcH3VmU6aWgv6yL/qEeeae/vKAyNv9uVfjQzX4yka+eMYUfs5hb7A==
X-Received: by 2002:a17:902:d2d0:b0:1f7:1a37:d0ac with SMTP id d9443c01a7336-1f71a37d47amr37709395ad.60.1718067448171;
        Mon, 10 Jun 2024 17:57:28 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7209970f3sm15347735ad.90.2024.06.10.17.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 17:57:27 -0700 (PDT)
Message-ID: <5a4935d8-0067-4517-bf80-55275f0f150b@gmail.com>
Date: Tue, 11 Jun 2024 08:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Jacky Huang <ychuang3@nuvoton.com>
Cc: linux-serial@vger.kernel.org
References: <8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dan,


On 2024/6/8 下午 10:24, Dan Carpenter wrote:
> Hello Jacky Huang,
>
> Commit 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver
> support") from Jun 19, 2023 (linux-next), leads to the following
> Smatch static checker warning:
>
>          drivers/tty/serial/ma35d1_serial.c:713 ma35d1serial_probe()
>          error: we previously assumed 'pdev->dev.of_node' could be null (see line 691)
>
> drivers/tty/serial/ma35d1_serial.c
>      685 static int ma35d1serial_probe(struct platform_device *pdev)
>      686 {
>      687         struct resource *res_mem;
>      688         struct uart_ma35d1_port *up;
>      689         int ret = 0;
>      690
>      691         if (pdev->dev.of_node) {
>                      ^^^^^^^^^^^^^^^^^
> Check for NULL
>
>      692                 ret = of_alias_get_id(pdev->dev.of_node, "serial");
>

Thank you for point out this bug. I will fix it.


Best Regards,
Jacky Huang
