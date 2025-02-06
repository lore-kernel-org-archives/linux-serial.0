Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CC15B10D;
	Thu,  6 Feb 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833144; cv=none; b=tbjCnZ596b55eP8q4aTpbsUYgGzurm/ITHlN7RMtF0jWA30djaiuFX6JIhqBNrDB0IrUR623X4xB6OnNoq6mNAhzF7q2+uNwCsrntvUALlBeMUmzDdJZcS9R6TczMhWKu0l/2uQflxyQn/kNnrYnVpbPJxtke3I+9mbBlGt4Mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833144; c=relaxed/simple;
	bh=YMokR+qy7feXtTT7P1mLW6jI3+kd5kyy3YSx0hlrotk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d97NskdCQBlmw9rpihuT+McxcuElFxklIBgSPt14WojwGPoqPVOCTCQKhXGhxK9xgxiDGd3cGleBFcqnPbQ3bsiVOACDVqE0SyRXuM0/J4ZBrRlTOK9mNFJo42Y+6ojxxrTX3fX379urYEdpeeXQPvD3EdVOc+7NFt6Rab+hhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZciL9nxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZciL9nxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21669C4CEDD;
	Thu,  6 Feb 2025 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738833144;
	bh=YMokR+qy7feXtTT7P1mLW6jI3+kd5kyy3YSx0hlrotk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZciL9nxbNtJKUWTHi71y10BV3HwmC2BBfYxd2s7LOQiLKS0jKvMpkwb4XVSTM85mo
	 4HNH9ruB2C2NJNeYCfmMZbvEF28vumPq/o18xYkD2EGfOk263Ej0wS9Td1NSxdAdr8
	 /2Kmx3xQkaslinyzVj6UQUMsC1/2lh00RECcSGwcgp8TZ/m93fbSWF7EV0hLjfshF8
	 tt0j72FRWLOA3tFT9qmtBE3fMpgb2fTqaMeNDbc3uLYb8ZSVQMKXWR2jIaT1mv5U1k
	 GenniY8+GY5Y5hzVyqL8zUQmExr7dFEeQzkgKPfhKTk9mOWyE9D1u+KNqAYqISSShA
	 iJebW1+jomVdQ==
Message-ID: <daea13b0-137c-4ab5-8388-1d46919b8609@kernel.org>
Date: Thu, 6 Feb 2025 10:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z6QvAZxiQusdaDkH@kspp>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <Z6QvAZxiQusdaDkH@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06. 02. 25, 4:39, Gustavo A. R. Silva wrote:
> Currently, member `sentinel` in `struct tty_bufhead` is causing trouble
> becase its type is `struct tty_buffer`, which is a flexible structure
> --meaning it contains a flexible-array member. This combined with the
> fact that `sentinel` is positioned in the middle of `struct tty_bufhead`,

THUMBS_UP

> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>   - Implement `struct tty_buffer_hdr` as a separate struct and embed it
>     into `struct tty_buffer`. Refactor the rest of the code, accordingly.

Better, but:

> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 79f0ff94ce00..cd04a6567a33 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c

...

> @@ -576,11 +579,14 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
>   void tty_buffer_init(struct tty_port *port)
>   {
>   	struct tty_bufhead *buf = &port->buf;
> +	struct tty_buffer *buf_sentinel;
> +
> +	buf_sentinel = container_of(&buf->sentinel, struct tty_buffer, hdr);

Bah, so this is ugly and even dangerous if someone adds a member to 
tty_buffer outside _hdr.

We should link headers in the list, it appears.

> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -7,7 +7,7 @@
>   #include <linux/mutex.h>
>   #include <linux/workqueue.h>
>   
> -struct tty_buffer {
> +struct tty_buffer_hdr {
>   	union {
>   		struct tty_buffer *next;
>   		struct llist_node free;
> @@ -15,9 +15,13 @@ struct tty_buffer {
>   	unsigned int used;
>   	unsigned int size;
>   	unsigned int commit;
> -	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
> +	unsigned int lookahead; /* Lazy update on recv, can become less than "read" */

This is an unrelated/unwanted change.

thanks,
-- 
js
suse labs
