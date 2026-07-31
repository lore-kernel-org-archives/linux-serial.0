Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995C2DF719
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506047; cv=none; b=Q2HNEwwcl0MadS8gOKox6eE2Q/4U5bPGhlTKVsO4UF72T1NDJbtiaOimDp0XLaDxqyaOa5EAwHX36cg74WJVnAfbSNdlLNSgK4UMTMrgXRjvUQlFVunLFLBq+6ZlcNyH833UnAm9tqE9WIcJ9gczKElD1QRCGbWS+krOnXVIM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506047; c=relaxed/simple;
	bh=XnSPYg57DRaO+9NQhcdSDefLNSu6VNnPlnWcrN68V94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0PY2VcPgHMjvqkW+JE2n9h19Q7EedXh8DgbQ9HkONWKi/F8sHfp2u9QIBmaE5Krgze0mrBL7dArnFUxEeg6EKFhWdG7vFMtX5K6/OrNNdbtyU/6ZaVMcWF9FxsiCYO+mQQISCEIyCFIlhb3KwcDYtzImK/XZD6LNEUGUDR3qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/OMwmfL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/OMwmfL"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1670dad7a8so134263166b.3
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785506044; x=1786110844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q07s+fTeCEbc39agdRyb/qs2zGQJBvKVPPRteZKniHY=;
        b=C/OMwmfLeTNvCjkzJjWg2+i+8Qre6Xfz4wCLaYmw3GFF6o3BGnZYi6dNok3LjGNZ8h
         HrsENKtARG3q/i8mMh+WvaJoYXnvZob28BmVIggaILbj+Ow6ySZShXXyQMuDknOYBxM9
         EK46V1KHO9DWacVjeVXPbUIOaGdDpnBLsWV+2OFBexYCkU8pDcG6YwrX8PNFnJ2FjC3N
         +S17i6GJ5DJFei9M5OwJHj2n+WPfOV0t4BdiwPyy0NBOLlosnCVaj8w8DHhk5qGCb5MA
         0fNuBmQeEYuyHYd0AEV33GRxvpx3VEhZGt/WZaKjLYvoWP/sY5KEDmQxXpXPUNFcKsoN
         GG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506044; x=1786110844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q07s+fTeCEbc39agdRyb/qs2zGQJBvKVPPRteZKniHY=;
        b=b4B1ip2CQ8y0FS6Di76VwGBOUy7+y0RCu6lMHzOyCawS1Ae9PayAMp09y42+mV+YiH
         uhZrPhIhGTDCenaE0UvmkH4JG9sBanQ0WZwF9gZOMV3RgEhvM+wbTBfUQFNewdwGGPRX
         y1BxPGNJgBvq++3SVFn3eLgokmnLE+Ah+wsFc0WE8piznMElgkI03bBJeuJpd0HPLpB3
         jUZJotqgxKtELJVQqEem070ZvMVovZ0bXW9yel8cx/uvqEn4luMN6trG87rlopavS20y
         AZbrR1NTbEskX6r92uvwl1imHN78rqp6foYt6OmwBJo+L2MkuF3mUJp8pI/pfYV1is3l
         Ca1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqyXyOC+Al8L2oB0rXCdyXAHkaRMOA2b3+P1fSYWAMwg2xhIRIXbVuWZAlo42qTryzw9sd+EzfDqOHQYBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDm4a/EdQua3qUjggdCXF39I/Ns4iXlgPb3v8j89TVeS5eN28E
	qZ655DumeUVQa5aOYgxGGRj9azt/mgsVe+GXcmxnYimePGxQw07juz9+
X-Gm-Gg: AR+sD10rOv+7ClquE00NiTM7fRWvVqYrcPJqG3hZ3vgD53LmjCz45qoBhXoB4H9+iwU
	zNDTGHP8bm/XUb8PG4J0YO8iil9k0kDxhUTFOnavkML5JGQoyiokUh8Bs5rnbIt+q3f9LQ566hm
	vaRZMxZvPP1LPlyDqCCOSiTzWTwmq6lVPN/5BJGyqk/YEvXAILfdTgFV830LC5AwvPVzioIfB4S
	mDekxTGOBdjCvTsYY7gi0EcG6eobBUYeAjx7gUGilgNLoHDIPJBvaY5cvImCtuXDHUESTR95wBJ
	vY7awJ4tn064Ca2Bv3JUt1v+pSeQXDyw48wqsfcwJnHfeSVN/Z1dwx+3mVct26YEXJxUMrXIKo8
	qpj1MhruTSnNL2+di787yW7ocVhtwhT4kr1BhNMFqsPCxXcp/P4h1Am8eoUFbn7iOhn3/VQz/M0
	LQMvp4dtsIDEhBXZBKkpSdfcgMSBt3O2UYlroesVsr+CXi6pXn0pEMmdVuNo7VtmX2kZiuIVRb3
	pxnWcSISVhIH1UlHLf6AjkCS7isUbA7Shcox4vxlRuS9cOqMGch0qVFfOHiL9g1jBNNFX2uISEZ
	hKdpyNW5JQqMSLn/J13ZXgU4R68Pc6VFy2Gi9Nf4+Sujyo2U7ejQ3Fpybr62bj5DdQ+h6zA=
X-Received: by 2002:a17:906:7945:b0:c19:fb6e:5fec with SMTP id a640c23a62f3a-c1fd23ccb41mr126779466b.18.1785506044262;
        Fri, 31 Jul 2026 06:54:04 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3ca3b53sm165306966b.24.2026.07.31.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:54:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:54:02 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amynpoQscIXD0fu8@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
 <2026073011-crock-utmost-6392@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073011-crock-utmost-6392@gregkh>

On Thu, Jul 30, 2026 at 04:31:51PM +0100, Greg Kroah-Hartman wrote:
> >  
> > +	mutex_lock(&imx_uart_ports_lock);
> 
> guard()?
> 

I'll use guards for v3.

> > +	unsigned int line = sport->port.line;
> 
> Why are you reading this outside of the lock?
> 

Good question. The local variable is unnecessary. I'll remove it.

Thanks,
Karl
