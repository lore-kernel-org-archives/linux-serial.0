Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4210E3;
	Fri, 14 Feb 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510182; cv=none; b=X6c2ltrFjd09mCPiBGIYpjZ//d9Qm2fFeASn6J6ONfEH3/kn101ruiuLq28MUAas+am1VhItDnJ14YH+rpmdm2TI7s6mVQPq1C5zgbHsnMHXGe6s9LGZWdH8ViWgZtEoz0Fi6WdQLntdp9fjuPvE5PEi4I6Dnb8dO824H2CVX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510182; c=relaxed/simple;
	bh=mJPCGK5odp/3F1yq1vx2hbjH1X5QwRdLiHWGZIvwguQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfIim0OO3V5jImjG1HSvcFiRs4fLBM0QmwBAdLuKs/Vly7SjyKRjUJNrFD6PTjj561ff4CsgiSHn3sIJC59S56Nf6C3bgr2dUC/hlAkeiYoFl0pznUo4UfbL892EyzW4GY6d1/EFztLvbk8cmeb4aEVKS+tWRQ57SVFf+OdX1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqa+OrjF; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqa+OrjF"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52067a2ca31so884690e0c.0;
        Thu, 13 Feb 2025 21:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739510179; x=1740114979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJPCGK5odp/3F1yq1vx2hbjH1X5QwRdLiHWGZIvwguQ=;
        b=dqa+OrjFNDta23Kly5sQkwiESy+rkoxiDoAAg2Kf1qdlh8qKl5NeCC/+ftO3cLVu6c
         p+tK4LmACOOLDdlg8uHRUe74w0JGM1YkfPybxQHMfQwzJ36Hjwzakqf1a2KWMgKRA/mb
         IwWKiuH0JIx6QUxP5xuj5oUBeaX8RivzMVlmsVw619ok+xKYgArbKUpOm9iKqjI2evHg
         4TQP0NMWgy7BM/MLHqOcSUwdjFLinS9rhH5DP3kSQAj5npU2Z0k0V65JWnKVH2RD0u1J
         0xL3y+FGYmc5ujE0raoeMblJ8hRJe6DeNm7wKVCN0QQ3oFejH1ZOMQ8zPpQ+j77rpqNs
         KvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739510179; x=1740114979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJPCGK5odp/3F1yq1vx2hbjH1X5QwRdLiHWGZIvwguQ=;
        b=dra4uCBGbnkXnrsuJDvpy50yze5onz568e/kAv24LtrmeVP46JsfnefqL+7uLXn7rX
         XD3Dg73jzE33eVbZMxHXT8zFJQrLucS78PfyC36y63F7bWcnekuSWX/2k5iIvcWP6cyn
         gpUyiRglwZAi3zybdDfu6oBdy71fFoFMK2zk/z5hYrhnLSGgXRGsLId8srqD3ouq8604
         NB9Nvt/opwHf1Vcsztj1hJopqccJ2gBuknIR3bVgJ3+LMnVJZS0cEpsEkjDmugP/K2Ws
         T/ieCj7PTxrX72jukgNiIa+yc2lVBzhJBO8q5tp3PvGj798VrXvQvbc+vfxRjZ8xxQ+D
         kgzA==
X-Forwarded-Encrypted: i=1; AJvYcCWrWxCTdjoT78wfvhYuxOxFpBtiuE9HTJxvS08cO13JGddKiIFy+naZEu+gzCoTX4hJAcVFnqAQh1uzVB3TVGHXSmI=@vger.kernel.org, AJvYcCX0NH1r1BRz09B0ZDTxKBsmnQp7wHr40iL54wVsDMTJ9SnKTv5FzDiG7KCuTmI4YZ6Nnq7ffy9n/gY7@vger.kernel.org, AJvYcCX7wcFwS4t9L0tZS6jITMDJiytVCwZxnA2QKKZTLh7wx+WerJedX+q17DcZZkmtyZvI8GJ8FNdS1EuN3ShO@vger.kernel.org, AJvYcCXq8pHO0jDCy060Wmd5N8esiiH/7XNuiL3UYL4Zz/EuxSoDsiAGTgQsG5KoFoTfgP3jJoRLVs87Nc/vUsNj@vger.kernel.org
X-Gm-Message-State: AOJu0YzZidiuyPEshwL+C8/ocwjj/hCjyppxlD3Vo0JoyTHCwfnb48tC
	zTGGQo9H+ASkeT6tmjZyN1nC9/CLqWblkxZjkInazCCm+rqckIeptmH62fSf
X-Gm-Gg: ASbGncsq7mI77CdPHNls9hqSIQ9W+dTveF5Qxf4XGKr8kezNUEYMHIPI6InrJej6gb2
	njcJfCZD5ssvhmwNqBfwCmMv58Be5ALKgaYqAxY9XjbzTmOa0pYIm1MRPOIgjcnfN284dC5tGp2
	7Jco3XKBxktHAPGeqgCTaA6/3qEcSkbcLawhatOdwLt6WrbtalApL74+vYKUYMB798VWJ/c9gFv
	esVlqkxLoocn55cV+ViYlhy1woOJ9JwFwNH8Exw+v13v2trsnRWHDTuRbKgOF2uRnprcKFf3G4M
	EdM5k054dKVHfMdyVJS9snv8K5+Zwu6sxZHDQOdevVJLRqHoIgfEV+BEGameRQ==
X-Google-Smtp-Source: AGHT+IEX/WNSDCKa8Dsz6ngWsn6DG/0ewhNCAlkMgc4RIwRsVlbZHvPWOyn7kEIjyOMg4W7RwOqfFA==
X-Received: by 2002:a05:6122:c97:b0:520:61ee:c821 with SMTP id 71dfb90a1353d-52067b68446mr9334990e0c.3.1739510179222;
        Thu, 13 Feb 2025 21:16:19 -0800 (PST)
Received: from droid-r8s ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207aa3ffa9sm459940e0c.8.2025.02.13.21.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 21:16:18 -0800 (PST)
Date: Fri, 14 Feb 2025 05:16:11 +0000
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	robh@kernel.org, semen.protsenko@linaro.org,
	wachiturroxd150@gmail.com
Subject: Re: [PATCH v1 2/3] dt-bindings: serial: samsung: add Exynos990
 compatible
Message-ID: <Z67Rm0HoEqGsiL/F@droid-r8s>
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-3-wachiturroxd150@gmail.com>
 <fc341dbf-3add-4728-9ec5-7291ad3bcbe9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc341dbf-3add-4728-9ec5-7291ad3bcbe9@linaro.org>

On Thu, Feb 13, 2025 at 07:20:22AM +0000, Tudor Ambarus wrote:
> doesn't the 32 bit register restriction apply to uart as it applies to
> SPI? If so, you shall probably fallback to gs101.

Of course not, downstream of the UART serial driver there is nothing
specified about 32-bit access restriction, nothing explicitly
in the driver. [0]

https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/drivers/tty/serial/samsung.c#L1543
