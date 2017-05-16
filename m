From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Tue, 16 May 2017 14:08:12 +0300
Message-ID: <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-serial@vger.kernel.org
Cc: fugang.duan@nxp.com, dongas86@gmail.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

> @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device *pdev)
>  	}
>  	sport->port.line = ret;
>  	sport->lpuart32 = sdata->is_32;
> +	lpuart_is_be = sdata->is_be;

Setting a global variable in per-device routine is quite bad design.
