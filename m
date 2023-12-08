Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498313FF7
	for <linux-serial@vger.kernel.org>; Fri,  8 Dec 2023 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW11Uc29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C6AC433C8;
	Fri,  8 Dec 2023 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702041149;
	bh=LRHKXloa3MmO6SoONfxXn/xJpmyyKAc/mIUHXv6+GMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tW11Uc298n3GMfqBAAke/uzS7WbHqNqrm5l7/LAA1eYmPWnqBHiGdej+PPvMGhynk
	 coRDgr19TLIFhhi6RaBoqtkSAYKsl98u+Tf/2UH580LCdsmbZ3+TsPT4ZwkYPunoMf
	 1I1dr5MchgWH1PC+o1HFr5Cxc2fzQfBBkoU1AZmvE0nybp32t0fnP6BAtKF1MyIc/I
	 WcI4oqGHtaKKnpASkzt48/aDUrgrm8wY/Lp3gwmB7X6iVadCH38r8J21InGn8BtUF1
	 uzgxqpVi4aFJTg5sTTjhV2/zt9nqCEUSqqH+Bh8au7+2yzS+V1Tc0JjdMPFuj0Tnjw
	 kvmeCou1Fl4aQ==
Date: Fri, 8 Dec 2023 14:12:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Adrian Reber <areber@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Message-ID: <20231208-begibt-besonderen-096761ac8d3b@brauner>
References: <20231206134340.7093-1-areber@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206134340.7093-1-areber@redhat.com>

On Wed, Dec 06, 2023 at 02:43:40PM +0100, Adrian Reber wrote:
> The capability CAP_CHECKPOINT_RESTORE was introduced to allow non-root
> users to checkpoint and restore processes as non-root with CRIU.
> 
> This change extends CAP_CHECKPOINT_RESTORE to enable the CRIU option
> '--shell-job' as non-root. CRIU's man-page describes the '--shell-job'
> option like this:
> 
>   Allow one to dump shell jobs. This implies the restored task will
>   inherit session and process group ID from the criu itself. This option
>   also allows to migrate a single external tty connection, to migrate
>   applications like top.
> 
> TIOCSLCKTRMIOS can only be done if the process has CAP_SYS_ADMIN and
> this change extends it to CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE.
> 
> With this change it is possible to checkpoint and restore processes
> which have a tty connection as non-root if CAP_CHECKPOINT_RESTORE is
> set.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  drivers/tty/tty_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 4b499301a3db..95d14d7128cc 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -844,7 +844,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  			ret = -EFAULT;
>  		return ret;
>  	case TIOCSLCKTRMIOS:
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))

In both cases you should be able to use:

if (!checkpoint_restore_ns_capable(&init_user_ns))
	return -EPERM;

with that fixed,

Acked-by: Christian Brauner <brauner@kernel.org>

>  			return -EPERM;
>  		copy_termios_locked(real_tty, &kterm);
>  		if (user_termios_to_kernel_termios(&kterm,
> @@ -861,7 +861,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  			ret = -EFAULT;
>  		return ret;
>  	case TIOCSLCKTRMIOS:
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
>  			return -EPERM;
>  		copy_termios_locked(real_tty, &kterm);
>  		if (user_termios_to_kernel_termios_1(&kterm,
> 
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> -- 
> 2.43.0
> 
