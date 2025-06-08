Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DC1D9A54;
	Sun,  8 Jun 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749378327; cv=none; b=UOV6Rv15B4Lo4Hw5zQFROafybD/ZIz0AePW0er2pj7+GYSbirhNP7JsTtKsC0SIEEAKoUyNPVIkEn6H1J+Y/+VZizow85uAIbWzHqNBXpPnnKoYlqqyUODMsOJJugAQK7LvW/l1pRFTb6vqweOC+MWec9pvjZf3GDtP9eA99QCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749378327; c=relaxed/simple;
	bh=EwWnuZDwL8CWjwC41WMTajpnEVqWFoYdtMhyQl1IhA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOr3V+Geze4LRlyrAlqO/VKI6T7j+XP1K4O/QMMewk5j88E3V5TpEvQmhEmrFkYBq+LnjcUUjka453thaPDSwrmoQeWX3uZ+j7wMTi4nHxCPHpZH3yVIiracpxgNT3dIsLe3/+n077in1mj7zF4qXE+ZvJgQAIyJpQ2lXUuPBUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ku73px7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ku73px7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F0BC4CEEE;
	Sun,  8 Jun 2025 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749378326;
	bh=EwWnuZDwL8CWjwC41WMTajpnEVqWFoYdtMhyQl1IhA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ku73px7I20qXjVqAYUEMB7OvTYjVx6ex1FP0Y9tqhW21mEYL1NwTOnpX3Tkqim+4b
	 BfyfKeOub/T3nv27BzHkLvc4eaoW8AhGQ9pfECAvRJ+pw2Lb9591zvqAxW5Rc7/anM
	 M3zjX6TpzfEQ70ww/GA6xvHAkNYCXAEyj8iY3pCE=
Date: Sun, 8 Jun 2025 12:25:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: jirislaby@kernel.org, kees@kernel.org, skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] tty: replace capable() with file_ns_capable()
Message-ID: <2025060848-exact-sasquatch-a899@gregkh>
References: <20250607134114.21899-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607134114.21899-1-pranav.tyagi03@gmail.com>

On Sat, Jun 07, 2025 at 07:11:14PM +0530, Pranav Tyagi wrote:
> The TIOCCONS ioctl currently uses capable(CAP_SYS_ADMIN) to check for
> privileges, which validates the current task's credentials. Since this
> ioctl acts on an open file descriptor, the check should instead use the
> file opener's credentials.
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

As you now are affecting the user/kernel api here, how was this tested
and are you _SURE_ this is the correct thing to be doing?  Did you audit
all userspace users of this ioctl that you can find (i.e. a Debian code
search) to verify that they can handle this change in behaviour?

I need a lot of assurances before being able to take a change like this,
for obvious reasons.

thanks,

greg k-h
