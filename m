Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF7653;
	Sun, 15 Dec 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298512; cv=none; b=WKEpTKEgFERaAkKHDYCgNP9FtMZltE919grPywyeY/ta133cg+JkmSPHJIDOQjkm9tAT6bmCQBtMARbSgn4/IgwQKByDjRXLG+cAOo8drlC2q5wv11qREm+6ztwZ0N434pc+Z+zw6uadx98uA+UDfP/iknWOrvq+TZ0+rT+BDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298512; c=relaxed/simple;
	bh=L2jEgesMzvRR7s8Z6CEUkD1ctQWX2RVk/SLoG5TfXQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN0g2SAlYfIwpZqF+PvVf9UL4vLMkvzfKt1e5zQNTcWylUdzR054i4LH2XkJFIeargPhzf64MmRPKlDUKiacr1MJh1g9UbitYXaBNzxOK5OdOUgk4cwnNaQsYac/woQ+yuHzL68EebejYNJienbwI/4LLevrEWdpYAl7/8acYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK7LBXHR; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK7LBXHR"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afe70b41a8so935447137.3;
        Sun, 15 Dec 2024 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734298510; x=1734903310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2jEgesMzvRR7s8Z6CEUkD1ctQWX2RVk/SLoG5TfXQo=;
        b=BK7LBXHRrB3Tk7/a6DSlZvPglasMCnDBYxryS4gaEtWr553RJvs+XPKqNqzNl05t4H
         cwEJRuf2y2epRKJKRGiw4wmkJyflNJJelBDH0DG3AQ6OW8YY6jj0AVcadxJWMAYuSM8x
         d04ZT9dPaiNReFyDg3ydcgDvwEln8NOH+GxiXOiWJegE1smHLcG90jcude0IuicXU2Wy
         jqPDFI2ScC5Ldd48jpkRIrzgfVy2JtOtnEj+tXqm0zxOlsaUsXdh3wiYY8NTRkAuUOIl
         3hk6GW1Y3xRttcjxxtSfhSPA6eTQNE6MMcHBmrOQweseLZeceC5TD9NZ9fIA1qltMmpD
         d2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734298510; x=1734903310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2jEgesMzvRR7s8Z6CEUkD1ctQWX2RVk/SLoG5TfXQo=;
        b=gCbxJdRUJ4KJLyPQNoXk2Viai3ziGTWbZBzOaW1aj1R4SPrgh6h/wd4LSMvYE7Gv8b
         ROkq0+5R0topDgzXCcFEqpevMofaBW7tHhS0m3qc8qcoSybk6bSYGzJi4eufGEy7XklK
         YAYOWuH+bpwjebpmsvoO0W48GtbTEqSSjOvAmYfyXkvzJEM5qmE/W9L4X0sdyjHaJcpM
         JdgBx42+bi75ZsybIfODPVChgi50lJcuu0pU0fdGCBz+xsc+l/zkXJj+hBWNFnMpph9c
         gntLhN85mW7z5GY/uD9nYW0XZ5qc0XkVqGNOelEjQ1L4hkXfA01QTF/ZGT6PTdpk8R+5
         DEew==
X-Forwarded-Encrypted: i=1; AJvYcCWx8TJXlH7ShLpHpGz6kf0X7pUJcIfbGiImnFPQPtpE6OCzibDFLo24Hn//FQ7Kgv5eeaxJ/Kpvve9oJck=@vger.kernel.org, AJvYcCXoF1we4SCRd5mvD+cJLzHzuhMkzYJWX674LcF6JCTfYZQOX6V4J0/qJIgbnka99XTWgz8BzF2SKLUNpGBF@vger.kernel.org
X-Gm-Message-State: AOJu0YxmP+jgratW2Dc0C3GCkbXV13hUxlp9kyyJG+6uidWMx2QNyA9u
	IUnbDp12DMmSilsLSpl+eXmiVLbMFfq4qQp3I3bX3L7JytSGigHY
X-Gm-Gg: ASbGncvis8MPthDiPXkvXkt+OqO1aOvVIhaw04KMfYGYPEYGQLZAER7rBpjTu0VBgGg
	YaSd7n1dL68T4uA/4vaXiXyG/OBr8XA2s8L81Zm4j26mvFYqhR1cy7x1AzpSLHp4SMIDHIW3gMQ
	pMvKli7FOQFN7fXBb5fI3T4kzQ/yapza/lsapD2NuIhGj5/cWrDhmMtwu+f3D6x1a+yTLO3Hjay
	XFPXAkSF5euBtngXFnT4AxihlNnnu8cAg651C0+pO6SgDUy/Pd2VryZonQpXYJ20LDEaOY/RzaO
	kLWoZxq85ydaL5ipfRv6s8mkO2qYJAYBHsCFVBZrsQ==
X-Google-Smtp-Source: AGHT+IFlRh31IZ+010iuh+ajbG0NCjdTOV+i60VdK+dpdgRUsWkgjNgSf22bmdkA9RYHu2dPuVqQjA==
X-Received: by 2002:a05:6102:160b:b0:4b2:4950:16fe with SMTP id ada2fe7eead31-4b25d9c021emr9591228137.14.1734298509990;
        Sun, 15 Dec 2024 13:35:09 -0800 (PST)
Received: from granite.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b270233605sm597637137.9.2024.12.15.13.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:35:09 -0800 (PST)
Date: Sun, 15 Dec 2024 16:35:07 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>
Subject: Re: [PATCH] tty: mark ctl_table as const
Message-ID: <Z19Li6s6W1JI4nqx@granite.localdomain>
References: <20241215-tty-sysctl-const-v1-1-96884e456126@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-tty-sysctl-const-v1-1-96884e456126@gmail.com>

On Sun, Dec 15, 2024 at 04:30:25PM -0500, Luis Felipe Hernandez wrote:
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows struct ctl_table variables
> to be placed into read-only memory.

Please disregard this patch.
