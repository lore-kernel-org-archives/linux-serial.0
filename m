Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BF34CFC7;
	Mon,  7 Sep 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796350; cv=none; b=X6pmYBww7xyk0Su1Y/Ps6ASZ0AgiFBKGZDj1PMrsp3/eCWaMUPQnk06djDVOxZlFaA8fjZHPY2bpzI2i+HiuLShu0MqJPPjeSijYLQcjTGrBHvnQ/e0DpBgFweqsh/RjS/r2XUQfLOMzf+ZgtdLba/73JUvfOilCqJS4cFN/Dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796350; c=relaxed/simple;
	bh=KbdHqHbCxKTm1pXa0FaJJl1Dz1Qjt8pEQzncbgTAbbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZhVI2y/SRArO7FsqKsbLkN0wB3KExDW4uWfX4j4SPRQUqpJKbdRRuaJtglptekRnMa3RBM0QNnYd/1OPw7SenLLZXwH2Y4MXMQ60+D0miDTDVIB5yIMhC2M85YzLSZeQCZ3EvH8S5ZGcxZlI36/MNeoOGZYh98gfe8QhceuS0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DjrZqg8e; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DjrZqg8e"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 443A74158C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788796348; bh=6c2w3nkZz8Hi9H065F6d699Zlb1eBVLzI1zMJpuOMes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DjrZqg8eJhvR/S1lg2/j74WtFKkT8MqStPdO3WKI10//hEgZL+VBIDJWLThoihMlh
	 ML3KB+LtR4sGZ8RXdFDJqxFJh8zcKSkeIQqpEhfC8Yq2uNR8IlIwJWtlJLEzrgtVGD
	 NHPHTF7udCGOluRnnfGshw+ECwFpYicHOZPM4YpjfoqrBhUG1cM8ArUWOQo0C6Yt3T
	 uVL+vakLEMnmgkqwLsieLrV3vLsw0nz13nkryqs61TB6PsmQc+w3R7mHq4t0Za0CmO
	 fK9SUQ2kmrUPnAYy1p8DUloWzl01M+d75wf5F+0xRdx9zFMfmfAbFBJDVua13zyn8n
	 o0u6s+jCtQRCw==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 443A74158C;
	Mon,  7 Sep 2026 15:52:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-serial@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] Documentation: rs485: Pull uart_get_rs485_mode() from
 serial_core.c
In-Reply-To: <20260905083648.39026-1-kmehltretter@gmail.com>
References: <20260905083648.39026-1-kmehltretter@gmail.com>
Date: Mon, 07 Sep 2026 09:52:27 -0600
Message-ID: <87ik4hvz2c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karl Mehltretter <kmehltretter@gmail.com> writes:

> serial-rs485.rst asks include/uapi/linux/serial.h for both struct
> serial_rs485 and uart_get_rs485_mode(). The function and its kernel-doc
> comment live in drivers/tty/serial/serial_core.c, so the directive has
> never rendered it and the section shows only the structure.
>
> Add a second directive for serial_core.c.
>
> Fixes: 0f4648a1a6d3 ("Documentation: rs485: Mention uart_get_rs485_mode()")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/driver-api/serial/serial-rs485.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
> index f53043d21071..98d8d83718c6 100644
> --- a/Documentation/driver-api/serial/serial-rs485.rst
> +++ b/Documentation/driver-api/serial/serial-rs485.rst
> @@ -50,7 +50,10 @@ RS485 Serial Communications
>     matching to the current configuration.
>  
>  .. kernel-doc:: include/uapi/linux/serial.h
> -   :identifiers: serial_rs485 uart_get_rs485_mode
> +   :identifiers: serial_rs485
> +
> +.. kernel-doc:: drivers/tty/serial/serial_core.c
> +   :identifiers: uart_get_rs485_mode

Applied, thanks.

jon
