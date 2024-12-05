Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDD2EB1F;
	Thu,  5 Dec 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425967; cv=none; b=cgKyzsi0XRcnveKXzzwhGsIfMeaRX69++MhgXscXsz7y5ZB7DRaW7qnQ6lNMx1AVOooFF7vcoTGnfTb5qWkLAQZf8pz3PvSe3dCDQvvef/llshMm+ysLi9wFPwdiGKgZqbXgtcd5t4SY1pzVBkyz3H7q9/Uw5Hwp1ydlMKDGanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425967; c=relaxed/simple;
	bh=wZfSdvwU1UByTI8n8u554FKtKmevPut0vYAxxQ5Up9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKkkLpnDQVIQH6e3nT4w1rG5Gil2LjSXWQw9qKyIHNPROV2icmt4AoMOPqN0G39ibruKUDlg+7sG3vftQqaRVnRBmS8mz8Duq1/4bSXhxSNlbfnbp+4Ox2uowfVj6PqGBZ0UeiCFWbsuieQh6LDkTBCU33JNAQWPQRZ0CnvsOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoNbTV3S; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoNbTV3S"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so13166245e9.0;
        Thu, 05 Dec 2024 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733425964; x=1734030764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpdGZqjzUu9BvHVskpaiGe/S0V9Oz2iYcvsm/X4DJVI=;
        b=AoNbTV3S2OuKMdMkwe4dGiwMDViHE3sDKZEU/R2TFoNubMexrRZmdnb/Sc3l2CbgqX
         KjOOmZB3izpNgrbXDdc0MZNEst9ILN4mda1snHDy77xaLRFs8p1JDWfqE/IZVFPQk5ik
         OKKVAdvUIomIKc1bSUAH/EYOLLbbMG4agFjA+fK1RgkXi4eDxSYhDbo/rHUrGJEFM1qM
         LOLBhbe9ut/NHYzU0JJFEovFT2+tBVIVGyiAUI2M0W+J+CkqwBmlpXC00+qv+rfF5ZQK
         RSASPzov3BaMfKvFXkUn5+1+NAVnWvBZMHEGR/GP7enMvRpzuyT1/sob/Tk2A7cgQ29c
         10Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733425964; x=1734030764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpdGZqjzUu9BvHVskpaiGe/S0V9Oz2iYcvsm/X4DJVI=;
        b=UisAhId+1/7ljkJ+G7jJ9y/b8nkNOuOUY7q4ndvz/rkBi4GlM6PeC/7oe/oUicl+a9
         bklSlK0NNzYxs5iyoWpwMZybNjkDXqcW5kusymyw1UZYPWz9LkG5xT/VpHMKvO+rPEsl
         T2MThvFHi7lsjrOiNeFq6rTK1vwZb9B7kloaxzdjNoiTOIyhx9smaJVwD3HjwValNMBO
         I1hA/SPaFWOIOyjuTtV49Jj9LwEzDQ009AM7Yswh7FLMPDJsBay71bCdDdjWCYV3cH9/
         fZ29RuLXNDivIJ139aeWOuQOzAyNWyMSoZfV4YwnDoMEHqKGqgCPVobfhbwgtvMNy/uT
         0I6w==
X-Forwarded-Encrypted: i=1; AJvYcCVgOSOjkvoLsmLwuLtYigiWSLUhBvae6Z7VrD2j79UtvMySe5BVTOC53ReTloQvd4uLdYgnEAQAq7mDcyei@vger.kernel.org, AJvYcCWwAuZhFIhgmimjml1hY0/2VfYehrInyYf4nHDK1yiBOPpdfu1g826SDN257NHaCiunni/NoOJE4rKtJ/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAtzHMrms2nZC58g3rzJXlk68UFjEKUjJdb9lZMqgEtu5Hx70
	5D7It1Sii2ZhuL0ovQjxbjaITI6GRKYRhkyGCvO6hHZ/3MCR60xS
X-Gm-Gg: ASbGnctaw3H974IrGO43es+y2kn9DIBXxcje50qIcyYczF9hVlhitLwM4sjAtYzi8Ri
	/9IhIxvWe+7y145x18jDybx/7E1tALA90SAj2IJORQ5I0omB4gTdnyjctTgPl4LzQAsXNUOwCPw
	auB04Se3itf6MUwBYAENtKGuDFzw80GTb/33clGSyXJnqLcpO6sJRYJccutm5eNCsHeYuBltXr0
	gug4yaaZlaAA6/R2X5PgPq+lfU90Gonwz04vXUiDK0rBew2n2i7yZtHSL0ryHBtJ3j5SqLMeaus
	g9jbBBFNcpGzBg==
X-Google-Smtp-Source: AGHT+IFW6PAVPpZKULlCWiqDvfytW/VZ5XrFf4R7JIE8Xut++K0HLnO62IP5mhljlyasKXRnvZemrw==
X-Received: by 2002:a05:600c:4f87:b0:434:a7e3:db50 with SMTP id 5b1f17b1804b1-434dded6701mr3386895e9.21.1733425964256;
        Thu, 05 Dec 2024 11:12:44 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526ac03sm73042155e9.4.2024.12.05.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:12:43 -0800 (PST)
Date: Thu, 5 Dec 2024 19:12:42 +0000
From: Stafford Horne <shorne@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH] tty: serial: Work around warning backtrace in
 serial8250_set_defaults
Message-ID: <Z1H7Kp2xF_TCSxyS@antec>
References: <20241205143033.2695333-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205143033.2695333-1-linux@roeck-us.net>

On Thu, Dec 05, 2024 at 06:30:33AM -0800, Guenter Roeck wrote:
> Commit 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
> triggers warning backtraces on a number of platforms which don't support
> IO ports.
> 
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
> Unsupported UART type 0
> 
> The problem is seen because serial8250_set_defaults() is called for
> all members of the serial8250_ports[] array even if that array is
> not initialized.
> 
> Work around the problem by only displaying the warning if the port
> type is not 0 (UPIO_PORT) or if iobase is set for the port.
> 
> Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> A complete fix will require a sequence of patches, which will have to be
> tested thoroughly and is thus not 6.13 material. This patch doesn't fix
> the underlying problem, but it is good enough for 6.13, or at least not
> worse than 6.12, while at the same time avoiding the warning backtrace.

This works on OpenRISC where I was seeing the issue.  Has someone comitted to
work on the root cause?

Tested-by: Stafford Horne <shorne@gmail.com>

>  drivers/tty/serial/8250/8250_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 4d63d80e78a9..649e74e9b52f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -467,7 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
>  		break;
>  #endif
>  	default:
> -		WARN(1, "Unsupported UART type %x\n", p->iotype);
> +		WARN(p->iotype != UPIO_PORT || p->iobase,
> +		     "Unsupported UART type %x\n", p->iotype);
>  		p->serial_in = no_serial_in;
>  		p->serial_out = no_serial_out;
>  	}
> -- 
> 2.45.2
> 
> 
