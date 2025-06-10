Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438725B69B
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521953; cv=none; b=mexFV6mQh5cOgxhqoF7pBLxWgqgLSoij2heeOEU4cWOgxI/P94f/SQm7EOHsU1nNZbRITIDU0iUZoimSzycZL1MmzMCx0pt3N4JYcjz0t0Wkdmk0+5mkHpesvRA96jEaS8YWCJJ1wyuSkOoZZw9iuCimG8+b+c51iS2vD4P+6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521953; c=relaxed/simple;
	bh=iWFOP9WZlja72I3isuQU8gJM0V8eA2F3TVvhPtI8VDY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fk+CMM7514yXh13xyj+vGuHDuczZU237KdxZKO3y5Kpw6lyHPCtOIwmEC65Rn0uLkJZj+/DAelgyT/xzYSYvcmOtGqyZTWdjgYrQyOvZ699vD/rK7HQL414B+bopkPLgVm9V9yUKk6iMf3eqx1jb5iw4cnOjdTLCS0aJlZnxOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dSeutUWM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dSeutUWM"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0ad74483fso49106786d6.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 19:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749521949; x=1750126749; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRLnIcpkOxwkeEtbycns6xLH/gYtJX4X9M+po25lPww=;
        b=dSeutUWMZuAUJYK37xTYOTml4PucB5nqFMFt7al7jQR+k9GmPsTscWIbPDelXwPcjI
         q+iLEgaK37yOP55fdMc6Py4DhB5uw6SeRwXXX/tvBhMiqRmf6bytHmfePW6HPWIBWGTz
         TjVxwiZYQ6XCRchupc2gwUuegZajJljn/a9GOk/lwR+9wWXQzASRulzVzFaCYHXoPOKx
         0/49sa6YA8UAgS6ju8Pkb1Oy4pq3Y0ymAeraJAU3nUoAO3+7DiRU9ZU7E865DPdempAV
         KKCJ1b05rET49FesJukpUh96gQ5+0M6kIsJoDWnk0wD82wBtQUkwoepJQfhuqT6cISBr
         Zipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749521949; x=1750126749;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRLnIcpkOxwkeEtbycns6xLH/gYtJX4X9M+po25lPww=;
        b=OhS8M5aoQt80wSyjgM+XF38we/LShcPej6ResYdSMk+ApL2Q7t9jAdSY4pdPL6Xpdu
         gKs80fG684gZg0zBDkTQ7Nl04udWGdUV+oK0kx/woqKyMJf4H1THpBfWN9I9mQtnMHiC
         lIMqGpS6ToyN8JzwQJtdSYWQ+LwiK8dywoj//iRbCw1cCJXSQSHxrdCto0rEvILvoZaj
         +5TDRW438PpVHZjtAty5a+A5Gm7HFAZZ9mouC2aWw1MWksfaRykd4wtdmQMwzQtH9L+1
         7OMY7RQWLchxszOq7EvLWnYiD64dnOoKzX9UPQ6XZLxuExUi8DPDbj/hR16YZ6Obh/Tn
         EJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlncxK34F/3gviIVli45cyTUI6ltxdIlCZDpGKozHjD3/9Pvk64/vgCvFbDnfuoXEWbGM93o87/uVzjfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbeLO4Pz42a3X4qO5mUqYMRIW+7VPJaylx3OMzRYIPfY3PXwv
	Fx+hA5Ld2eqlPpnQSFpOh54MYIfgHyojI5h3r3ebKNXTIwNbwj98lZgoYg43pmz7rJTuTioCb/z
	svzO6
X-Gm-Gg: ASbGncv5toriowY1I3SAEcX6q+7qcXEKZr+BQanwx+9qGRVoEEvY4Z3pdfn+y1lJ9YE
	sWfAnTb10O9fiu9iXItzBscxAcW6zev0YgqCWmldEk8j3aAMP12O+HJ6rfR/kTjae1WzwCzULl0
	G7FsItlRzmaR57M71YY8gtORKcA2ZQkpwfw2yV4STe+61E8JG02D9cn6ubYl7JEgIy3FGqVmlti
	qc5Cm0NEHsspp8m5CS6c7X7oNufWB01ha9AyytD0ygoQv/SU8jUtXO5/N58TNWptQLfeOiHIrpR
	HsA6932CvS9YR13byWnh04n6CHIcvbrbNeQMFForT7p0JVEz64qKnmIXUkAqmSiMHvS7QZOzl5f
	uWfqV/ROnv/0sHWFWjNnfwLYRN75XG485DWo=
X-Google-Smtp-Source: AGHT+IF55VFE5OHV9fkwOW70kmDImiJTC0v7JtnzSCoxcmtKHEv5DFBDHaeZWRIyBnJYWWiQyGQlAg==
X-Received: by 2002:a05:6214:2623:b0:6fa:ba15:e7f with SMTP id 6a1803df08f44-6fb24c4f370mr12979286d6.9.1749521948941;
        Mon, 09 Jun 2025 19:19:08 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1cc2fsm59712066d6.74.2025.06.09.19.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:19:08 -0700 (PDT)
Date: Mon, 9 Jun 2025 22:19:07 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] vt: fix kernel-doc warnings in ucs_get_fallback()
In-Reply-To: <20250610000251.282760-1-rdunlap@infradead.org>
Message-ID: <6rr665sp-3q45-66q8-snso-5071q34q71pr@onlyvoer.pbz>
References: <20250610000251.282760-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Jun 2025, Randy Dunlap wrote:

> Use the correct function parameter name in ucs_get_fallback() to prevent
> kernel-doc warnings:
> 
> Warning: drivers/tty/vt/ucs.c:218 function parameter 'cp' not described in 'ucs_get_fallback'
> Warning: drivers/tty/vt/ucs.c:218 Excess function parameter 'base' description in 'ucs_get_fallback'
> 
> Fixes: fe26933cf1e1 ("vt: add ucs_get_fallback()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nicolas Pitre <npitre@baylibre.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: linux-serial@vger.kernel.org
> ---
> v2: add Jiri and linux-serial. Mea culpa.
> 
>  drivers/tty/vt/ucs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-616-rc1.orig/drivers/tty/vt/ucs.c
> +++ lnx-616-rc1/drivers/tty/vt/ucs.c
> @@ -206,7 +206,7 @@ static int ucs_page_entry_cmp(const void
>  
>  /**
>   * ucs_get_fallback() - Get a substitution for the provided Unicode character
> - * @base: Base Unicode code point (UCS-4)
> + * @cp: Base Unicode code point (UCS-4)

Please delete the "Base" word from the definition as well.
Then you can add Reviewed-by: Nicolas Pitre <npitre@baylibre.com>.

>   *
>   * Get a simpler fallback character for the provided Unicode character.
>   * This is used for terminal display when corresponding glyph is unavailable.
> 
