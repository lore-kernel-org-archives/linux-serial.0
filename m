Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA244E652;
	Sun,  4 Oct 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117949; cv=none; b=GlrY7vj3n6Ao03W0uWynpyQJEqhCBL8oItN2W/FK02WJiAIZJKSUje4D6V41mG6sD3ttXosk4rBq3FoTX8OZJ3X3buA4hBUP3A3DJkAwPFK7s6uqhKL876ijT6dqOlIofLlk03gP3D9ndRbsTiwa+ADzKYRCBE8icjqssuT21gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117949; c=relaxed/simple;
	bh=q1YzCbaJJ6txDDEPUJITrrUK5eP6qmKcJDfx1NMphkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRedPT7y9bN1UqHKstUSH0g1PugEBo3Jg7fH5R+1b2+ukUxOrDu+nTI5NiPX/lfXJ9lS2KoT0bYVUWSgxxXc2JgC8uUI0qfxeu7hYjoelguCMulGlCM29dwjWE9chS3rJg3G23w+uiuIooCoFwU0CnRlY6hIQoCPQzJ2ABHBBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrHKcbP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrHKcbP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7C91F000FF;
	Sun,  4 Oct 2026 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791117947;
	bh=iVskhEtWYuFXojETC78Hke9cyCNqi4oMNvWDl+PNL+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RrHKcbP5O7/g/3LXqLxK5jNq7QePZHquKBg85fOL08H1uSCIWhbOfwkWcHz4mNH8h
	 jh2XqLmgSxVow55nzWPd5q1dYag0oM4zYDqpgPemM3eaOyIjHR43tHoToI8w2oTluC
	 ucEH3cjLpvGtdIEu77Ry+6WwG+lgQSLZNNaY2QSA=
Date: Sun, 4 Oct 2026 14:45:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akira Patafio <kokokoala4211@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] tty: pty: preserve open slaves after rejected locked
 open
Message-ID: <2026100435-unlinked-blurry-3237@gregkh>
References: <20261001165552.2439-1-kokokoala4211@gmail.com>
 <20261002202455.25324-1-kokokoala4211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002202455.25324-1-kokokoala4211@gmail.com>

On Fri, Oct 02, 2026 at 04:24:55PM -0400, Akira Patafio wrote:
> Opening a locked PTY slave fails with EIO, but the failure path sets
> TTY_IO_ERROR on the shared slave tty. Previously opened slave files then
> fail I/O even though their master is still open.

Ok, in digging a lot, I think this is "as intended".  You MUST call
unlockpt() in userspace to unlock a locked pty, and if you don't do
that, this all fails as you have seen.

Where in the POSIX spec say that if you attempt to open a locked PTY,
that it's allowed to keep working?  You are in control of the pty, so
it's not like this is some other user doing this lock/unlock stuff,
right?  What do other Unixes do if you attempt to do this type of thing?

And what about the pty tests in the LTP test suite, did you run them to
verify that your change didn't actually break anything there?

> tty_open() releases a file after the slave open callback fails. Merely
> skipping TTY_IO_ERROR on the rejected open is insufficient: pty_close()
> can mistake the failed file for the last slave and close the master.
> Counting tty references is also insufficient because a real last close
> can race the failed open and its release.
> 
> Track which slave files opened successfully. Ignore failed files during
> close, and mark the master peer closed only when the last successful
> slave file closes. In-kernel callers may pass NULL instead of a file;
> retain the count-based close behavior for those callers. A selftest
> checks locked opens with zero, one, and two existing slave files, plus
> ordinary last-slave close behavior.
> 
> Fixes: 699390354da6 ("pty: Ignore slave pty close() if never successfully opened")
> Assisted-by: LLM
> Signed-off-by: Akira Patafio <kokokoala4211@gmail.com>
> ---
> Changes in v2:
> - Preserve the existing NULL-file callback behavior for in-kernel TTY users.
> - Add the Assisted-by tag requested in review.
> 
> Tests:
> - The selftest failed on an unpatched Linux 6.12.69 kernel at the
>   pre-existing slave write with errno EIO (TAP fail:1).
> - Built the patched 7.3.0-rc5 x86_64 kernel with legacy PTYs and Speakup
>   enabled, without compiler warnings. Booted it in QEMU/HVF and ran the
>   selftest in the guest: TAP pass:1 fail:0, exit status 0.
> 
>  drivers/tty/pty.c                             |  34 +++-
>  drivers/tty/tty_io.c                          |   1 +
>  include/linux/tty.h                           |   1 +
>  .../testing/selftests/filesystems/.gitignore  |   1 +
>  tools/testing/selftests/filesystems/Makefile  |   2 +-
>  .../selftests/filesystems/pty_locked_open.c   | 187 ++++++++++++++++++
>  6 files changed, 222 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/filesystems/pty_locked_open.c
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index cc7f709..4024c5d 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -46,12 +46,31 @@ static DEFINE_MUTEX(devpts_mutex);
>  
>  static void pty_close(struct tty_struct *tty, struct file *filp)
>  {
> +	struct tty_file_private *priv = filp ? filp->private_data : NULL;
> +	struct tty_file_private *other;
> +	bool another_open = false;
> +
>  	if (tty->driver->subtype == PTY_TYPE_MASTER)
>  		WARN_ON(tty->count > 1);
>  	else {
> -		if (tty_io_error(tty))
> +		/* tty_release() also calls close after an unsuccessful open. */
> +		if (priv && !priv->pty_opened)
> +			return;
> +		/* In-kernel users have no per-file open state. */
> +		if (!priv && tty->count > 2)
>  			return;
> -		if (tty->count > 2)
> +		/* tty->count includes opens that have not succeeded yet. */
> +		spin_lock(&tty->files_lock);
> +		if (priv)
> +			priv->pty_opened = false;
> +		list_for_each_entry(other, &tty->tty_files, list) {
> +			if (other->pty_opened) {
> +				another_open = true;
> +				break;
> +			}
> +		}
> +		spin_unlock(&tty->files_lock);
> +		if (another_open || tty_io_error(tty))
>  			return;
>  	}
>  	set_bit(TTY_IO_ERROR, &tty->flags);
> @@ -223,14 +242,23 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
>  
>  	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
>  		goto out;
> +	/* A rejected open must not disrupt already-open slave descriptors. */
>  	if (test_bit(TTY_PTY_LOCK, &tty->link->flags))
> -		goto out;
> +		return -EIO;
>  	if (tty->driver->subtype == PTY_TYPE_SLAVE && tty->link->count != 1)
>  		goto out;
>  
>  	clear_bit(TTY_IO_ERROR, &tty->flags);
>  	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
>  	set_bit(TTY_THROTTLED, &tty->flags);
> +	/* Record a successful open before another slave can close. */
> +	if (filp && tty->driver->subtype == PTY_TYPE_SLAVE) {
> +		struct tty_file_private *priv = filp->private_data;
> +
> +		spin_lock(&tty->files_lock);
> +		priv->pty_opened = true;
> +		spin_unlock(&tty->files_lock);

It's kind of obvious that this is LLM-generated code as it loves to add
random new booleans and doesn't know about properly locking logic in the
kernel.

Think about why you are attempting to use a lock here, and yet the rest
of the function didn't use a lock at all, doesn't that feel "odd" to
you?

Be _VERY_ careful when using a LLM to create a patch like this...

thanks,

greg k-h
