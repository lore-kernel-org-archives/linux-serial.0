Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDF16CD23
	for <linux-serial@vger.kernel.org>; Mon,  1 Jul 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846658; cv=none; b=j7GOCdkGS1YEacWkd8Lk07j2e04FXAV/gruX2wVO5DEURuQCzYSW/1HTIeKa0aPYHLL/1l2eMe+fWzdPehk/0mzxPjx4Y1YR6y0ZBKVcBs1GXefjewSEkKKAsbUVNmV71qwKPHogZXXWf95XsHIfFNLsUi1wAhJO+cnHYjgrplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846658; c=relaxed/simple;
	bh=lJT8Lk2aPlRqITXr87EIXyw71vgY9gkIgdZoXFH70G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1dg0VkQKLj05clsvQ88p3XteXc+v/5fbHGcOgSQZ1w8pRL/jLGRsOPhppC5JmXt9MjXNyG6Z2aL2+GX0+Am14PXoR2IWNE2L8NghSUIWpeupL5rKkFdk6iYQdJevqdCntGTE3gLnBLKyOXN8DscHikGrWORn080e54s6TWwQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eIlMUIsK; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIlMUIsK"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c9cc66c649so1935821b6e.1
        for <linux-serial@vger.kernel.org>; Mon, 01 Jul 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719846656; x=1720451456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0BExY/qBhAXsCi0xgA49Ox7G6qkL3RnzSr6IH+J4yk=;
        b=eIlMUIsKEdKstlBV3uwgODDr/9HZW4ug3+RodzjQnnomezk3zGX2KMVLpAZ1W+MkGc
         xk5QyWFL42F3ohfKOMoT29bcZ2W3Qpqj1Ue6IOSU0p5UjPrDvuDjaX7SvAwCXFxFQ/47
         2+H8SwUCGktbfKbw5SxVzP4MSOb+X6XpwZA12Fd3ROJYF5h8x2GTuAgrcek19+lCfAQs
         GKcu0D7q8x9rRJrdjxrYOIVRFoZR9n/vzdfwwpI4nJa+aHfYszQT+Z8aLCR4umIdtmuH
         aMnJS4ZjCvrzak5bzLxlm2lr46xEyOe8HHPg3pkIJ9DrsB62i4MXdwSDS3rbJTaUDCCS
         d0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846656; x=1720451456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0BExY/qBhAXsCi0xgA49Ox7G6qkL3RnzSr6IH+J4yk=;
        b=VuYOa63wkzEW75C0mqlnApf5gUc1RkPqafHuaPSXejpVr775ZlKOjHWsbZpAiGrHNU
         UpHQ5mO7me1JZjGjBvXHtA3jY02EGTd9ubSzfx6wiskkrlnaUqINtafJDoa6kfXouzq+
         Qe6uqpKQh/v1OToLHiPsMjS/Zw6PfSfz9Jy575CAIIiReQplwOkD0upvDQakkbs5RhDW
         kGcKcvnSyXbusshTkTRjPDglZCeGl7xmCowgw3z0RL23dx/xexNIL+cqq1ABkAxaD7s1
         WugeaSln++kPrN1I4Xf8GnLdjP4u02+2dc1OSzEcH9azsOLIwFSAvdgc5pNzGSwfSAKw
         BycA==
X-Forwarded-Encrypted: i=1; AJvYcCW7P81WGvlnddy/JCAzPYkdJ1clYBlMqrbkg8nGVfLGJyY36k/c44zkkjOH+D3FKkRb8oK//3k+kT3pjfoXoGdeHSuYlJdyTejWzSC2
X-Gm-Message-State: AOJu0YzAxip2XZ8dwH4rKZaLEv0oRW1NpQ+opXwj4WqXXSqJKAEcdNxF
	2G62oyKnZqPXYjt7/NgcsfzvapGlJoPJz4mjSE4wwOMp/Db8mWEk8NGtPRip5q0=
X-Google-Smtp-Source: AGHT+IF6YwJN4Ni+B2pppaly3KNc0+sFLlPuO2iiu2oQ8LDkTrCGjp/JFalsvNhFMjuistzCA5vRBw==
X-Received: by 2002:a05:6808:3014:b0:3d6:32b7:7364 with SMTP id 5614622812f47-3d6b5686a38mr8478530b6e.57.1719846655648;
        Mon, 01 Jul 2024 08:10:55 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e8c6:2364:637f:c70e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fa00133sm1368692b6e.28.2024.07.01.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:10:54 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:10:52 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v4] tty: serial: ma35d1: Add a NULL check for of_node
Message-ID: <e3cfc874-e590-4b4b-8822-972d8c7fc98c@suswa.mountain>
References: <20240625064128.127-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625064128.127-1-ychuang570808@gmail.com>

On Tue, Jun 25, 2024 at 06:41:28AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The pdev->dev.of_node can be NULL if the "serial" node is absent.
> Add a NULL check to return an error in such cases.
> 
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain/
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>   V3 -> V4: Move the version info lines to the correct position.
>   V2 -> V3: Added the "Reported-by:" line.
>   V1 -> V2: Added the "Fixes" line.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

