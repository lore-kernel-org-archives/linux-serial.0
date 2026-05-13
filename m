Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605C3D47A0;
	Wed, 13 May 2026 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663081; cv=none; b=IJiiFX/RX1ygEqgUNjHgurxQ3O19YICiUE+H2Ng85wgghHm9tvsaEo8JThiWt+aIYL3XYaBBoImh/nDUzPHJPg65q1SDadI76oNGelrKgsS8WCILM7R+W0etcISrSRggrQYcC8MW9t9g0YdfFnq+lIMZOZaMrqC/zEd6aNcPaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663081; c=relaxed/simple;
	bh=xU2etr7CxsV/jfciNYvXWrg04Ty/Jj2JiMaDD3j/rQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PO/AOeSkmGAY9ZhQG2s0XECj8hw5o2PQNLlt9o9iTYchCSrAfjK7R+ELxnSS/7V1lflTbyhHJFyXLr5BczGXNY//gtUOKDuZXJfPXdH+0Fl68shiKObRBsRGwe1LTOCb2Dv4uGlXaTo6CG8xTmR3X9WW/VGNUoam9hHqa6GMVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 568CF4C2C37D56;
	Wed, 13 May 2026 11:04:04 +0200 (CEST)
Message-ID: <505b56bd-e5fd-4feb-a6e3-1d8269609277@molgen.mpg.de>
Date: Wed, 13 May 2026 11:04:03 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
To: Mingyu Wang <w15303746062@163.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513064547.352601-1-w15303746062@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260513064547.352601-1-w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mingyu,


Thank you for the patch, and your work on the Linux kernel.

Am 13.05.26 um 08:45 schrieb w15303746062@163.com:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> A Use-After-Free (UAF) vulnerability and a subsequent General Protection
> Fault (GPF) were observed in h5_recv() due to a race condition between
> the initialization of the HCI UART line discipline and concurrent TTY
> hangup via TIOCVHANGUP.

Please elaborate, in what setup it was observed, and please add an 
excerpt of the trace.

> The issue arises because the workqueues (init_ready and write_work) are
> only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
> the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
> protocol (e.g., H5) may schedule work (such as sending sync/config
> packets). If a hangup occurs before the setup completes and the READY
> flag is set, hci_uart_tty_close() skips the cancel_work_sync() calls
> and proceeds to free the `hu` struct.
> 
> When the delayed workqueue finally executes, it blindly dereferences
> the freed `hu` struct, causing ODEBUG warnings and kernel panics.
> 
> Fix this by moving the cancel_work_sync() calls outside the
> HCI_UART_PROTO_READY check, ensuring that any pending works are
> unconditionally cancelled before the hci_uart structure is freed.

Please add a Fixes: tag, so it gets backported.

Also, please add a Link: tag with a URL to the test case, or include it 
in the commit message.

> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>   drivers/bluetooth/hci_ldisc.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 275ea865bc29..566e1c525ee2 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,18 @@ static void hci_uart_tty_close(struct tty_struct *tty)
>   	if (hdev)
>   		hci_uart_close(hdev);
>   
> +	/*
> +	 * Always cancel workqueues unconditionally before freeing the hu
> +	 * struct, as they might be active during the PROTO_INIT phase.
> +	 */
> +	cancel_work_sync(&hu->init_ready);
> +	cancel_work_sync(&hu->write_work);
> +
>   	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>   		percpu_down_write(&hu->proto_lock);
>   		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>   		percpu_up_write(&hu->proto_lock);
>   
> -		cancel_work_sync(&hu->init_ready);
> -		cancel_work_sync(&hu->write_work);
> -
>   		if (hdev) {
>   			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
>   				hci_unregister_dev(hdev);


Kind regards,

Paul


PS: If you resend, and don’t know yet (you have commits in the Linux 
kernel already), please add v2 to the tag. (`git format-patch -2 …` or 
an equivalent option to your tooling.

PPS: sashiko.dev did not pick this patch up yet [1].


[1]: https://sashiko.dev/#/?list=org.kernel.vger.linux-bluetooth
