Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3C218EBC;
	Thu,  5 Dec 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426985; cv=none; b=KFjCmS7mn18lXAitxIKOXwe97S1DFPKEt140159CmPpyA3f9XnuCBEtfdvMy9NJoU49Z71C3y9LQzkW6EnT9q2nckHQYlE9YwOp+WcHVHc9Jce7Bn/zYA95ilSlDmn5eC+HEzarJlocybQdn9I7NwJPoELXEuuvp+NOkwHfBIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426985; c=relaxed/simple;
	bh=3b1jXdg9etVi9JrSquOz+SPsW0MYcquNZqzByYhzOZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOR65obp9Snm+ghUYvG6rq67QF/0PszuSrbwaOdTluMo1UhzmNK+miLhpwMR6aba87N5byZ5fQl2jxuhPF9SFeLv88NCMcf9brQKA1W28SNP+E4INhTNOf2QNisdRpnHnIIplGLsmBKD2K/osW5pDUfXnVIOPokCZF63BEvN6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQCCAZPn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQCCAZPn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215b4681c94so11081925ad.0;
        Thu, 05 Dec 2024 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733426982; x=1734031782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot7+4CIO+9+UuMGzHA97VF17dz7xgujigYJmT7di5Hk=;
        b=AQCCAZPnwEL8cwRLLWOb4cxxSov9yncL3daB2Cwa2MQDHRsCpzw8/dbuzS0CSqN/zb
         8hi5X+JsH3alM0KcQ6ZplRl0m/s1oJWPlGl/2TKwE6OL+DdGGnyZWYvW+leTH+MEaIhP
         zpVR9c2xZXG2ZrJyzYHTMlqcUBKpK+ddtDYFIloJ0ut3dHyDTnaU/YtoKSyu5hfs+jXv
         bEuY8arcbzxhQIKRPLckLsvR3kNjx7qzXrwIdj/qEYaCClCXAyPBGdn8ck2pZ2vvKq1A
         sWcvmtvVPxkJrA9W66ufS5ILs0NSfl5osbC/quWtS+nz+Ajpmp303zgfz6bMO9w54QcZ
         o6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426982; x=1734031782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot7+4CIO+9+UuMGzHA97VF17dz7xgujigYJmT7di5Hk=;
        b=ahJYUAxbD39wqd1tUHzap2pzwxX/jHlRSfwGRize6PoSq7CH0py0Z49q4N4e75AcSD
         0WUKfgScYPaNxsTv/yVaKh/4FlUGcRZa3E091YnRcaMakkB7+UryjCZL2RbHQ3lVYDUF
         Y4fIpMgLM6hoSj0jSnFWw9m1g8TRg7zbyVgwN/G13yowwSMcQS1sj6Sg6PTuZMbO8I7E
         sTS1pPM5J2vHF0/OtvXpg+5IfQvL7PZZrwwzrhKdRfcjNnaTRam9Trf1HzpUr8zeQ1WE
         9cCRDwB/Px/SJaY9/TF/eTXFgEopx+rP+Ik3WSTXFv+o/4KLlnLjAnJoQdj/7vHd3DMM
         VQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUoKHdVBmjR5uzEgejXWymbGEaNcFy2dVebz40NT8uY8Wszdk2raALeCWC4lzZYOiY/FTcku9vOinx/X8Rh@vger.kernel.org, AJvYcCWRAZQ9bNqRSgGbDDen8049gVXZLcmwRnVkQRegM6BODYksS+2INb9Dwxr3p+0mx/qMq2in8Keqzqw9UG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0V6rwzYNQOIsxKdm/5cP72uvTrY0NYZNouWKjecGoEJ3Mva+
	9rCUHfizXKgkZy0lQOC6oli+oyu1DFFtv5ln48ovWYdFi3lc/r73
X-Gm-Gg: ASbGncu/+0hhnBb7ncYEXFVC/uTOjlHtE04VT8ZgOdUsIOGr56CAYd7LahmnZXia7fC
	2yHui+p3shLlntO6QayuSjVaI6L5GXXBtAvI6nKYfWFvfMph/VL2mzRaKBfhgHQ2EVYmtIzFeQf
	wTdh1FfF3vvWfMpCtdFKwW0hGSpwM5N4bCMVITjaiguHXrMMHtb2sQ2Is7z+Pn3roBPj3j63HsB
	wOBl+VGAfPhGivq+wYrqPpFd3IlUBtka1EvfjELkFYXQyIcjPu2af0r2+ofWGM=
X-Google-Smtp-Source: AGHT+IGC+9ZIiMjAKZTczLRkM/BRbVrEIVmxp+GMW9Lt6mgf7SCBeOZSZlipYShhS/w1BrbEfbRYXg==
X-Received: by 2002:a17:903:41cc:b0:211:eb00:63c3 with SMTP id d9443c01a7336-21614da9c0amr310145ad.42.1733426982566;
        Thu, 05 Dec 2024 11:29:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9eb7sm16069395ad.143.2024.12.05.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:29:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Dec 2024 11:29:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stafford Horne <shorne@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH] tty: serial: Work around warning backtrace in
 serial8250_set_defaults
Message-ID: <16ca11d0-549e-449d-bc26-f0e11f2f057a@roeck-us.net>
References: <20241205143033.2695333-1-linux@roeck-us.net>
 <Z1H7Kp2xF_TCSxyS@antec>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1H7Kp2xF_TCSxyS@antec>

On Thu, Dec 05, 2024 at 07:12:42PM +0000, Stafford Horne wrote:
> On Thu, Dec 05, 2024 at 06:30:33AM -0800, Guenter Roeck wrote:
> > Commit 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
> > triggers warning backtraces on a number of platforms which don't support
> > IO ports.
> > 
> > WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
> > Unsupported UART type 0
> > 
> > The problem is seen because serial8250_set_defaults() is called for
> > all members of the serial8250_ports[] array even if that array is
> > not initialized.
> > 
> > Work around the problem by only displaying the warning if the port
> > type is not 0 (UPIO_PORT) or if iobase is set for the port.
> > 
> > Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > A complete fix will require a sequence of patches, which will have to be
> > tested thoroughly and is thus not 6.13 material. This patch doesn't fix
> > the underlying problem, but it is good enough for 6.13, or at least not
> > worse than 6.12, while at the same time avoiding the warning backtrace.
> 
> This works on OpenRISC where I was seeing the issue.  Has someone comitted to
> work on the root cause?
> 
Yes, Arnd is working on it.

Guenter

> Tested-by: Stafford Horne <shorne@gmail.com>
> 
> >  drivers/tty/serial/8250/8250_port.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 4d63d80e78a9..649e74e9b52f 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -467,7 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
> >  		break;
> >  #endif
> >  	default:
> > -		WARN(1, "Unsupported UART type %x\n", p->iotype);
> > +		WARN(p->iotype != UPIO_PORT || p->iobase,
> > +		     "Unsupported UART type %x\n", p->iotype);
> >  		p->serial_in = no_serial_in;
> >  		p->serial_out = no_serial_out;
> >  	}
> > -- 
> > 2.45.2
> > 
> > 
