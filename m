Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88F28F519;
	Tue, 17 Jun 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161889; cv=none; b=D7pwsI/uyFLPTmpcGMlsPctp92PvpsKoajxDBdKik0yXV31YaJkIf+WOVWrHfz5L7BVDZD8m/O7m7HInLu7h2ZUMtIx2gJ5vH5KylMOQR5u1Y7oVXIF49sxl3D3RHRC3DiZ66TFrEhK+TKYBVi+SI2oCepLf4673GCC+KZGWHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161889; c=relaxed/simple;
	bh=rfk7FiF0lOcK1XJobZRLILVg/IGnNJQDHCvjJMTre4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU2bxnor4VfNqSyQTAjV2U5vhjqpTYec23NMq9zBv0gNNoXTIZkYg6QCCggsnorEVi4pfe6ss5zy0KEViEmhxmQYRR/vIvZ16WzRBU9J+CZuCJIAW4CX4JozYylVX0LrY4M4DpBQNGcab1WmBwaGLt+S3mzvxgLeU83pKPEXc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX2BYbm2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX2BYbm2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45305c280a3so23185405e9.3;
        Tue, 17 Jun 2025 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750161886; x=1750766686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBHeAKw5ugZZFecnxceACnihCxbJc4Qc9dF4pQfrgXc=;
        b=LX2BYbm2JzGOXdnMHvEOZjSKjzw4ckfnORv3tRMVBHipXdRgpLpocBK7dE3veHZUg2
         2Jq0BDS3WR1kUGgFqCVayVLa6wWMiLxRk70/kRVUP2XMLGzft0DLavoePBEG2w7ARjaQ
         LjxoK+rRxHB5VV8eCNG1fnpm64j3lNlfiWVejT8M4M/oNDeYjjfVtUegqIlns7++PAfP
         6kJoyGEeJZc8EcXmMg0uWtkvx3mVRzXOs0jzKGG3mWQBcPn09qi7IjwDq1EPxDknKlHF
         O952UAZPXNjlI+0U0yd+I6sSQq+WsqcTAt/ksqX+PWQF/sjXFAPY16W6LgeMo7HTrWe3
         UaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161886; x=1750766686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBHeAKw5ugZZFecnxceACnihCxbJc4Qc9dF4pQfrgXc=;
        b=VQU0wJNsliUpca/m8OEsADQplJHSy8oRmbdvwRyR8X5eDPB33/XVlsdMiXxed4ion7
         VHgXW5yhMDj6/xdlG08r2LtIqU3p2Dq8DPd5+PtsSwn8MYgenSSt7oc9lbn5PgXhGGho
         icTICFFx/GlF9werZn5mlyArraServmtYK7Qbt5DWbiU4B0OSQUpBVs5tfoyusghYJPd
         sTkaDhVfYBpkUi5xMgE/wFSKZ9ntcHYlOgzzqNuq/Xq26ErgKojCpDcJQF57fve76uYH
         CR1TswnwvNxCx4EpAwh/+bxIdCoMimpQ3pmdkmgKJbVu2ZMg+v9zVW+H4RPnYKUvS+EA
         kPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjm6eGhwiz1izMLFVbpeQN5DWZauN/VjPd7ZTv/1ZTIQ7EIkBf1fdGL8ErqGC9nezWZcBjVyeoH3PmlGk=@vger.kernel.org, AJvYcCXzX4hzDaCgx+S3HgIsjb1czZ54oSBnbe1A8kQUESXb8OQDLuLgrjZKoltgV/DZHOgE3Z0y1es7Z4bb4n4L@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJ32OwiSYhWCJUI24giiJebz3qcbXhP0TJ9+aFYePVtES/eMN
	EoHjxN4KLhngDBItE8vadQ5jtgtZKOp864+uDrOYijQr2sWgch+SVQF0
X-Gm-Gg: ASbGncutUXCRGDmmyhBbu68Zamk3Zk59AIDLV+NYEz6+vLM/AnUh9/c9ZruTCtA/8pM
	4Y4klQUFTHtdkWw2qYahpsV6Q2B8NbjdfR/nEcIPP4/BY4leUTk/evxeZi7c0luA7z4eKe66qGr
	zX/22VyIcDWTE9sKYfQd2laex2CPgTG8Labnzj6iy4eqJbO3+z3MdqV4HjLZc1ZaBAhK0Wm9oOs
	G7KM6uEox5WP/S6P/XYuJpFj1qZtI9PJr3vfdzttD5vtemQBPqui0evfWyrRKC93TxHWJyT0f84
	8jqOVEte4E/nXI40eOlyjEOBQQT+TjMrFe5S1ehLhzbIYl1k+HxSgC7y8QxUIVKvp7APvzBpH5U
	M3XSkCP0UhPWA3BfvQHdL1XEe
X-Google-Smtp-Source: AGHT+IGmVJOqVjr2VDFVGKHhn97Oi9W87DltDZ3k18EklWE4Qpu3vNOETU6VYKXRArKUhMPQLl1vTQ==
X-Received: by 2002:a05:6000:430c:b0:3a5:3517:de3e with SMTP id ffacd0b85a97d-3a572e6bc97mr11266548f8f.35.1750161884721;
        Tue, 17 Jun 2025 05:04:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a60d0fsm13613548f8f.22.2025.06.17.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:04:44 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:04:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, kees@kernel.org,
 skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] tty: replace capable() with file_ns_capable()
Message-ID: <20250617130431.50f761dc@pumpkin>
In-Reply-To: <20250607134114.21899-1-pranav.tyagi03@gmail.com>
References: <20250607134114.21899-1-pranav.tyagi03@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Jun 2025 19:11:14 +0530
Pranav Tyagi <pranav.tyagi03@gmail.com> wrote:

> The TIOCCONS ioctl currently uses capable(CAP_SYS_ADMIN) to check for
> privileges, which validates the current task's credentials. Since this
> ioctl acts on an open file descriptor, the check should instead use the
> file opener's credentials.

Is that right?
A terminal will have been opened before the login sequence changed the user id.

The 'best practise' might be to check both!

	David

> 
> Replace capable() with file_ns_capable() to ensure the capability is
> checked against file->f_cred in the correct user namespace. This
> prevents unintended privilege escalation and aligns with best practices
> for secure ioctl implementations.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Link: https://github.com/KSPP/linux/issues/156
> ---
>  drivers/tty/tty_io.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70eb7..ee0df35d65c3 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -102,6 +102,9 @@
>  #include <linux/uaccess.h>
>  #include <linux/termios_internal.h>
>  #include <linux/fs.h>
> +#include <linux/cred.h>
> +#include <linux/user_namespace.h>
> +#include <linux/capability.h>
>  
>  #include <linux/kbd_kern.h>
>  #include <linux/vt_kern.h>
> @@ -2379,7 +2382,7 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
>   */
>  static int tioccons(struct file *file)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!file_ns_capable(file, file->f_cred->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  	if (file->f_op->write_iter == redirected_tty_write) {
>  		struct file *f;

