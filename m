Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05040386C26;
	Fri, 13 Mar 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441335; cv=none; b=rXXVEoDXgxGV3ys94tJv/sv874X5qy4kENVMhPwHFduq/wz9nQ4WhwS8P27uGp5t1MXqsPXsfoYyWZD8OTiHD+9kVlj3w8yIP+aAFQ2QwGItRBkJtBY76lzOZGf8FCKmjwNIPSrqNGxE8e7tbEat/lDmjVTtVIsTVfEJnyYVuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441335; c=relaxed/simple;
	bh=NCbvP5f6b/mCFhMJmC9j3yAfcF6UdIqCTsj5FlU2tpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eq1bxaNJEey2gnm05xdhKcujxpzWQSc71HBl8AoSTL2mtQjiQwhxNwyE+I0UEC0ac6Nt9A4P5chUykQdgGYhjrBgqMHetENovbtao+8DeWNSYrJjttDRRLg5DwjSkxdiO+cai3zll6fPU06EytCxa0r+X5RAI4FW9VxLVgcn4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcP2stPL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcP2stPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03834C19421;
	Fri, 13 Mar 2026 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773441334;
	bh=NCbvP5f6b/mCFhMJmC9j3yAfcF6UdIqCTsj5FlU2tpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VcP2stPLlc45efG1ATlBlz89qWp35F/JjEqHryh0F3Y9bmzCUrIvK8yF87waJcNGc
	 SjKO/CMF5u+aetYSJTviVylA5gODS1qGJBfnvoDJ/NXbDFgzMrRFnbTTCztAzTGJ+T
	 K/N6GhQ/HtDORPD/UDERYQzIFc8WQxkHxYYOhfJgoUSmJ8TFt0GP6Y9MJNbkc07Cj6
	 8ufjgksNohKApFW9NTPO4YC8qdeh9jcKhG7/rW9wjkQFs/VzzyrgiRB9uQ0UNA4nwm
	 r0d3OefD5V5LYb1e3xz0prUX/BxkOyU6H9u07+GAenyFQYk5we8A19XiohfzUuwj/+
	 9F2EnCXuH/ZYA==
Date: Fri, 13 Mar 2026 15:35:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jason Andryuk <jason.andryuk@amd.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] hvc/xen: Check console connection flag
In-Reply-To: <20260312173845.47235-1-jason.andryuk@amd.com>
Message-ID: <alpine.DEB.2.22.394.2603131535200.1759048@ubuntu-linux-20-04-desktop>
References: <20260312173845.47235-1-jason.andryuk@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Mar 2026, Jason Andryuk wrote:
> When the console out buffer is filled, __write_console() will return 0
> as it cannot send any data.  domU_write_console() will then spin in
> `while (len)` as len doesn't decrement until xenconsoled attaches.  This
> would block a domU and nullify the parallelism of Hyperlaunch until dom0
> userspace starts xenconsoled, which empties the buffer.
> 
> Xen 4.21 added a connection field to the xen console page.  This is set
> to XENCONSOLED_DISCONNECTED (1) when a domain is built, and xenconsoled
> will set it to XENCONSOLED_CONNECTED (0) when it connects.

It should be XENCONSOLE_DISCONNECTED


> Update the hvc_xen driver to check the field.  When the field is
> disconnected, drop the write with -ENOTCONN.  We only drop the write
> when the field is XENCONSOLED_DISCONNECTED (1) to try for maximum
> compatibility.  The Xen toolstack has historically zero initialized the
> console, so it should see XENCONSOLED_CONNECTED (0) by default.  If an
> implemenation used uninitialized memory, only checking for
> XENCONSOLED_DISCONNECTED could have the lowest chance of not connecting.
> 
> This lets the hyperlaunched domU boot without stalling.  Once dom0
> starts xenconsoled, xl console can be used to access the domU's hvc0.
> 
> Update the console.h header to bring in the new field.
> 
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Aside from the minor comment on the commit message:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/tty/hvc/hvc_xen.c          |  3 +++
>  include/xen/interface/io/console.h | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> index 7f0b6262488c..c407592442cd 100644
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -139,6 +139,9 @@ static ssize_t domU_write_console(uint32_t vtermno, const u8 *data, size_t len)
>  	if (cons == NULL)
>  		return -EINVAL;
>  
> +	if (cons->intf->connection == XENCONSOLE_DISCONNECTED)
> +		return -ENOTCONN;
> +
>  	/*
>  	 * Make sure the whole buffer is emitted, polling if
>  	 * necessary.  We don't ever want to rely on the hvc daemon
> diff --git a/include/xen/interface/io/console.h b/include/xen/interface/io/console.h
> index cf17e89ed861..687949bdebb1 100644
> --- a/include/xen/interface/io/console.h
> +++ b/include/xen/interface/io/console.h
> @@ -19,6 +19,19 @@ struct xencons_interface {
>      char out[2048];
>      XENCONS_RING_IDX in_cons, in_prod;
>      XENCONS_RING_IDX out_cons, out_prod;
> +/*
> + * Flag values signaling from backend to frontend whether the console is
> + * connected.  i.e. Whether it will be serviced and emptied.
> + *
> + * The flag starts as disconnected.
> + */
> +#define XENCONSOLE_DISCONNECTED 1
> +/*
> + * The flag is set to connected when the backend connects and the console
> + * will be serviced.
> + */
> +#define XENCONSOLE_CONNECTED    0
> +    uint8_t connection;
>  };
>  
>  #endif /* __XEN_PUBLIC_IO_CONSOLE_H__ */
> -- 
> 2.34.1
> 
