Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F51D52D
	for <linux-serial@vger.kernel.org>; Sat,  1 Jun 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248266; cv=none; b=jPRUtYPawrLL7MEbMNJr+ERUf/VYkRhzawwRspoXfNN0TB/HMbGiUdijJTyBHbajzSoeyWnnDBZiS8oTuEJBDiFcdPRpf9/uSxkoR8LRH1kXmHi/22Bq/Vps5PSZhKOT4tDQ7kXnZQIwsQI+avm1F/kbGazgGCTkl+rgQW6nNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248266; c=relaxed/simple;
	bh=BphjQRETVWbwBOAt1OllarMy3luzEImV7QmudLn3qmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0Xu65VsOXABUlK15B97bHSe5Gd/WoisXEWrePXhRCVP2mNzUi1ATjaoyW/l/F4G4Zs9OQw74Q0arISfFwFZ6ihP+nHS9jcbzS1NGQJICY2gExZBMsl74OJbV090VuwWZlVYPzyhbbJrKmM7T6792eDwSpNv9g7gIiPiagd0rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eM/1NjlS; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eM/1NjlS"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b680c1fdd4so1754692eaf.1
        for <linux-serial@vger.kernel.org>; Sat, 01 Jun 2024 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717248262; x=1717853062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt+i0sxVsMuHjVEcrVWQMAKVvSmo+Gr49LOIyPK1iNY=;
        b=eM/1NjlSF+0OWixIFuCWqzdPybfwR+pS1w6ZjBDqAMgdf5WdqdqXMvXEK0dXVPyTvg
         qAp4QayV4JEr8VAvb1ZLYAfqXFehX8IBewWRuuIJDF7s5XP5bEYupTXPEZmR2xGHqISD
         UHxSo7Qs4oUO3kH4aGCSzpd+E9SGGNbeGKbqqVkueG2voeW3DIhF8s0ixXSthajLZe9Z
         dNVujAvq6/T+aKDzn5MvZbXO1225vM7L/YXGakbMuBowAUiHv/BxzYFmiTShd/khjOAB
         dzRdsmIzTo3oYAbmqr/iGIbgvCTnDQI/5h+bVceqg/txIekQ3yG+SaVaDYg9zAuKCxKN
         OlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717248262; x=1717853062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt+i0sxVsMuHjVEcrVWQMAKVvSmo+Gr49LOIyPK1iNY=;
        b=DN0Hg8PA30WClSn6ChO+3Sqo09g6ABF+wqUvor/9NZOf2+4gbbOSSTENNZpmDoJ6R8
         oSqoUnePmDzqkTLvNHu8UdCWBWjtLPxJOPG0GwVN9lw4Nw7MmiBczlXOm87X0brICZCC
         kwGLcpLldSrIbUAZAR+Sd8YbuMTyyitSXcvMb7H+V+Aa+Ov8KVaqG3S2kT2dWrA699R8
         JRJk0RJXZKHhNgiNfmz1T3UNVN4ofmmOBv1VujlLRZC0Efx1JJLYmFgs/xjjACimujSI
         jkqS4L9kMbJEOMOvtsZso8I+Gx9FZW0qkG2scdwL0wA/RS5phinvwTLwYApNCT8eMGdc
         1QtA==
X-Forwarded-Encrypted: i=1; AJvYcCX0E3oII05xuWzJipr2WOFmLHfquQJ9Tn8BsstrxhIBc2uEej6B3EnC+Q2gPvJPb7e2hbczb8n5YCiK6831HK86IZ34UuGiO4TSleKj
X-Gm-Message-State: AOJu0Yxm0IDMK2XlAeZ0plj6AfjT1f/8+uiFrZwctx2O3fgMjRMbd5WG
	YULT5rqiZnmBmhbr6PkW138JuzsX2LvuH+39bZQlPDZW8W7Fg19Gy4Mga+dOidE=
X-Google-Smtp-Source: AGHT+IEg6kS/wR5RWxdPsnGs7my1NhP3YasRHzi8dIGsio7Q+noAk2+4JJWAd516R+lZXOxqPSnW9g==
X-Received: by 2002:a05:6358:6912:b0:199:3812:756d with SMTP id e5c5f4694b2df-19b48ad631dmr636451855d.1.1717248262547;
        Sat, 01 Jun 2024 06:24:22 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a88ce90sm2722033a12.92.2024.06.01.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:24:22 -0700 (PDT)
Date: Sat, 1 Jun 2024 18:54:15 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 2/2] serial: 8250: Extract platform driver
Message-ID: <Zlsg/+H6l/d7LVPe@sunil-laptop>
References: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
 <20240506140308.4040735-3-andriy.shevchenko@linux.intel.com>
 <ZjxdR1UvNlB6ctDZ@sunil-laptop>
 <ZjzUfznxVkyWGPAx@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzUfznxVkyWGPAx@surfacebook.localdomain>

On Thu, May 09, 2024 at 04:49:51PM +0300, Andy Shevchenko wrote:
> Thu, May 09, 2024 at 10:51:11AM +0530, Sunil V L kirjoitti:
> 
> > Many thanks for helping with this!. Just few questions below for my
> > understanding.
> 
> You are welcome! Meanwhile, can you test these changes?
> 
Hi Andy,

Sorry for delayed response. For some reason, it landed in spam and I
missed it. Thanks a lot for the clarifications!

Tested this on RISC-V and works well.

Tested-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil
